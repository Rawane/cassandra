package com.xoolibeut.gainde.cassandra.repository;

import java.nio.ByteBuffer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.ColumnMetadata;
import com.datastax.driver.core.DataType;
import com.datastax.driver.core.IndexMetadata;
import com.datastax.driver.core.PagingState;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.Statement;
import com.datastax.driver.core.TableMetadata;
import com.datastax.driver.core.querybuilder.Clause;
import com.datastax.driver.core.querybuilder.Delete;
import com.datastax.driver.core.querybuilder.Insert;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.querybuilder.Select;
import com.datastax.driver.core.querybuilder.Truncate;
import com.datastax.driver.core.querybuilder.Update.Where;
import com.datastax.driver.core.schemabuilder.Create;
import com.datastax.driver.core.schemabuilder.Drop;
import com.datastax.driver.core.schemabuilder.SchemaBuilder;
import com.datastax.driver.core.schemabuilder.SchemaStatement;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.xoolibeut.gainde.cassandra.controller.dtos.ColonneTableDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.IndexColumn;
import com.xoolibeut.gainde.cassandra.controller.dtos.Pagination;
import com.xoolibeut.gainde.cassandra.controller.dtos.TableDTO;
import com.xoolibeut.gainde.cassandra.util.GaindeUtil;

@Repository
public class TableRepositoryImpl implements TableRepository {
	private static final Logger LOGGER = LoggerFactory.getLogger(TableRepositoryImpl.class);
	private List<String> keyQueryData;
	private List<String> keyQueryStructure;
	@Autowired
	private ConnectionCassandraRepository cassandraRepository;

	@PostConstruct
	public void init() {
		keyQueryData = new ArrayList<String>();
		keyQueryStructure = new ArrayList<String>();
		keyQueryData.add("INSERT");
		keyQueryData.add("UPDATE");
		keyQueryData.add("DELETE");
		keyQueryData.add("TRUNCATE");
		keyQueryData.add("SELECT");
		keyQueryData.add("BATCH");
		keyQueryStructure.add("CREATE");
		keyQueryStructure.add("DROP");
		keyQueryStructure.add("ALTER");
		// keyQueryStructure.add("USE");
	}

	public JsonNode executeQuery(String connectionName, String keyspaceName, String pQuery) throws Exception {
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		if (pQuery == null || pQuery.isEmpty()) {
			throw new Exception("Veuillez renseigner le query");
		}
		String query = pQuery;
		if (!pQuery.contains(keyspaceName)) {
			query = buildQueryAddKeyspace(keyspaceName, pQuery, cluster);
		}

		ObjectMapper mapper = new ObjectMapper();
		ObjectNode rootNode = mapper.createObjectNode();
		ArrayNode arrayNode = mapper.createArrayNode();
		rootNode.set("data", arrayNode);

		LOGGER.info("executeQuery " + query);
		ResultSet resultSet = session.execute(query);
		if (resultSet != null) {

			Map<String, String> mapMeta = new HashMap<>();
			resultSet.all().forEach((row) -> {
				ObjectNode jsonNode = mapper.createObjectNode();
				row.getColumnDefinitions().asList().forEach((definition) -> {
					LOGGER.info(definition.getName());
					if (mapMeta.isEmpty()) {
						mapMeta.put("table", definition.getTable());
						mapMeta.put("keyspace", definition.getKeyspace());
					}
					Object object = row.getObject(addQuote(definition.getName()));
					if (object != null) {
						switch (definition.getType().getName()) {
						case TIMESTAMP: {
							if (object instanceof Date) {
								Date date = (Date) object;
								SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
								jsonNode.put(definition.getName(), dateFormat.format(date));
							}
							break;
						}
						case BLOB: {
							if (object instanceof ByteBuffer) {
								ByteBuffer byteBuffer = (ByteBuffer) object;
								jsonNode.put(definition.getName(), new String(byteBuffer.array()));
							}
							break;
						}
						default:
							if (object != null) {
								String rowValue = object.toString();
								if (rowValue.length() > 1 && rowValue.startsWith("\"")) {
									rowValue = rowValue.substring(1, rowValue.length() - 1);
								}
								jsonNode.put(definition.getName(), rowValue);

							}
							break;
						}
					} else {
						jsonNode.put(definition.getName(), "");
					}

				});
				arrayNode.add(jsonNode);
			});
			if (!mapMeta.isEmpty()) {
				TableMetadata table = cluster.getMetadata().getKeyspace(mapMeta.get("keyspace"))
						.getTable(mapMeta.get("table"));
				rootNode.set("columns", buildColumnArrayNodes(table));
			}

		}

		return rootNode;
	}

	public void createTable(TableDTO tableDTO, String connectionName, String keyspaceName) throws Exception {
		Session session = getSession(connectionName);
		Create createTable = SchemaBuilder.createTable(addQuote(keyspaceName), addQuote(tableDTO.getName()))
				.ifNotExists();
		tableDTO.getColumns().forEach(column -> {
			Integer typeList = null;
			Integer typeMap = null;
			if (column.getTypeList() != null) {
				typeList = Integer.parseInt(column.getTypeList());
			}
			if (column.getTypeMap() != null) {
				typeMap = Integer.parseInt(column.getTypeMap());
			}
			DataType datype = GaindeUtil.getDataType(Integer.parseInt(column.getType()), typeList, typeMap);
			if (column.isPartitionKey()) {
				if (column.isClusteredColumn()) {
					createTable.addClusteringColumn(addQuote(column.getName()), datype);
				} else {
					createTable.addPartitionKey(addQuote(column.getName()), datype);
				}
			} else {
				if (column.isClusteredColumn()) {
					createTable.addClusteringColumn(addQuote(column.getName()), datype);
				} else {
					createTable.addColumn(addQuote(column.getName()), datype);
				}
			}
		});
		LOGGER.info("createTable  " + createTable);
		session.execute(createTable);
		tableDTO.getIndexColumns().forEach(indexColumn -> {
			SchemaStatement createIndex = SchemaBuilder.createIndex(addQuote(indexColumn.getColumName())).ifNotExists()
					.onTable(addQuote(keyspaceName), addQuote(tableDTO.getName()))
					.andColumn(addQuote(indexColumn.getColumName()));
			session.execute(createIndex);
		});

	}

	public void dropTable(String connectionName, String keyspaceName, String tableName) throws Exception {
		Session session = getSession(connectionName);
		Drop dropTable = SchemaBuilder.dropTable(addQuote(keyspaceName), addQuote(tableName)).ifExists();
		session.execute(dropTable);

	}

	public void alterTable(TableDTO oldTableDTO, TableDTO tableDTO, String connectionName, String keyspaceName)
			throws Exception {
		Session session = getSession(connectionName);
		if (!oldTableDTO.getName().equals(tableDTO.getName())) {
			throw new Exception("Vous ne pouvez pas modifier le nom de la table");
		}
		List<ColonneTableDTO> colonneRemoved = new ArrayList<>();
		List<ColonneTableDTO> colonneAdded = new ArrayList<>();
		List<ColonneTableDTO> colonneAlter = new ArrayList<>();
		List<IndexColumn> indexColumnRemoved = new ArrayList<>();
		List<IndexColumn> indexColumnAdded = new ArrayList<>();
		List<ColonneTableDTO> colonneRenamed = new ArrayList<>();
		tableDTO.getColumns().forEach(column -> {
			if (oldTableDTO.getColumns().contains(column)) {
				int index = oldTableDTO.getColumns().indexOf(column);
				ColonneTableDTO oldColum = oldTableDTO.getColumns().get(index);
				Integer typeList = null;
				Integer typeMap = null;
				if (column.getTypeList() != null) {
					typeList = Integer.parseInt(column.getTypeList());
				}
				if (column.getTypeMap() != null) {
					typeMap = Integer.parseInt(column.getTypeMap());
				}
				DataType dataType = GaindeUtil.getDataType(Integer.parseInt(column.getType()), typeList, typeMap);
				Integer oldTypeList = null;
				Integer oldTypeMap = null;
				if (oldColum.getTypeList() != null) {
					oldTypeList = Integer.parseInt(oldColum.getTypeList());
				}
				if (oldColum.getTypeMap() != null) {
					oldTypeMap = Integer.parseInt(oldColum.getTypeMap());
				}
				DataType oldDataType = GaindeUtil.getDataType(Integer.parseInt(oldColum.getType()), oldTypeList,
						oldTypeMap);
				if (!(dataType.getName().name().equals(oldDataType.getName().name()))) {
					colonneAlter.add(column);
				}
			} else {
				if (column.isPartitionKey()) {
					colonneRenamed.add(column);
				} else {
					colonneAdded.add(column);
				}
			}

		});
		oldTableDTO.getColumns().forEach(column -> {
			if (!column.isPartitionKey()) {
				if (!tableDTO.getColumns().contains(column)) {
					colonneRemoved.add(column);
				}
			}
		});

		tableDTO.getIndexColumns().forEach(indexC -> {
			if (!oldTableDTO.getIndexColumns().contains(indexC)) {
				indexColumnAdded.add(indexC);
			}
		});
		oldTableDTO.getIndexColumns().forEach(indexC -> {
			if (!tableDTO.getIndexColumns().contains(indexC)) {
				indexColumnRemoved.add(indexC);
			}
		});
		// Exécution de la requete
		colonneRemoved.forEach(column -> {
			SchemaStatement schema = SchemaBuilder.alterTable(addQuote(keyspaceName), addQuote(oldTableDTO.getName()))
					.dropColumn(addQuote(column.getName()));
			session.execute(schema);
		});
		colonneAlter.forEach(column -> {
			Integer typeList = null;
			Integer typeMap = null;
			if (column.getTypeList() != null) {
				typeList = Integer.parseInt(column.getTypeList());
			}
			if (column.getTypeMap() != null) {
				typeMap = Integer.parseInt(column.getTypeMap());
			}
			Statement schema = SchemaBuilder.alterTable(addQuote(keyspaceName), addQuote(oldTableDTO.getName()))
					.alterColumn(addQuote(column.getName()))
					.type(GaindeUtil.getDataType(Integer.parseInt(column.getType()), typeList, typeMap))
					.enableTracing();
			LOGGER.info("alterTable  " + schema);
			session.execute(schema);
		});
		colonneAdded.forEach(column -> {
			Integer typeList = null;
			Integer typeMap = null;
			if (column.getTypeList() != null) {
				typeList = Integer.parseInt(column.getTypeList());
			}
			if (column.getTypeMap() != null) {
				typeMap = Integer.parseInt(column.getTypeMap());
			}
			SchemaStatement schema = SchemaBuilder.alterTable(addQuote(keyspaceName), addQuote(oldTableDTO.getName()))
					.addColumn(addQuote(column.getName()))
					.type(GaindeUtil.getDataType(Integer.parseInt(column.getType()), typeList, typeMap));
			LOGGER.info("alterTable added " + schema);
			session.execute(schema);
		});
		colonneRenamed.forEach(column -> {
			// LOGGER.debug("colonne à renommer " + column.getOldName() + " new name " +
			// column.getName());
			Statement schema = SchemaBuilder.alterTable(addQuote(keyspaceName), oldTableDTO.getName())
					.renameColumn(addQuote(column.getOldName())).to(addQuote(column.getName()));
			LOGGER.info("alterTable renamed " + schema);
			session.execute(schema);
		});
		indexColumnRemoved.forEach(indexC -> {
			Drop drop = SchemaBuilder.dropIndex(addQuote(keyspaceName), addQuote(indexC.getName()));
			LOGGER.info("alterTable drop " + drop);
			session.execute(drop);
		});
		indexColumnAdded.forEach(indexC -> {
			SchemaStatement createIndex = SchemaBuilder.createIndex(addQuote(indexC.getName()))
					.onTable(addQuote(keyspaceName), addQuote(oldTableDTO.getName()))
					.andColumn(addQuote(indexC.getColumName()));
			LOGGER.info("alterTable  createIndex " + createIndex);
			session.execute(createIndex);
		});

	}

	public JsonNode getAllDataByTableName(String connectionName, String keyspaceName, String tableName)
			throws Exception {
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		TableMetadata table = cluster.getMetadata().getKeyspace(addQuote(keyspaceName)).getTable(addQuote(tableName));
		LOGGER.info("exportAsString " + table.getName() + "   " + table.exportAsString());
		LOGGER.info("asCQLQuery " + table.getName() + "   " + table.asCQLQuery());

		ResultSet resulSet = session.execute(QueryBuilder.select().from(addQuote(keyspaceName), addQuote(tableName)));
		ObjectMapper mapper = new ObjectMapper();
		ObjectNode rootNode = mapper.createObjectNode();
		ArrayNode arrayNode = mapper.createArrayNode();
		List<ColumnMetadata> columns = buildColumns(table, rootNode);
		Iterator<Row> iter = resulSet.iterator();
		while (iter.hasNext()) {
			Row row = iter.next();
			ObjectNode rowNode = buildRowNode(mapper, columns, row);
			arrayNode.add(rowNode);

		}
		rootNode.set("data", arrayNode);
		return rootNode;
	}

	public JsonNode getAllDataPaginateByPage1(String connectionName, String keyspaceName, String tableName, int page)
			throws Exception {
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		TableMetadata table = cluster.getMetadata().getKeyspace(addQuote(keyspaceName)).getTable(tableName);
		Select statement = QueryBuilder.select().from(addQuote(keyspaceName), tableName);
		statement.setFetchSize(page);
		ResultSet resulSet = session.execute(statement);
		ObjectMapper mapper = new ObjectMapper();
		ObjectNode rootNode = mapper.createObjectNode();
		ArrayNode arrayNode = mapper.createArrayNode();

		List<ColumnMetadata> columns = buildColumns(table, rootNode);
		if (resulSet != null) {
			Iterator<Row> iter = resulSet.iterator();
			while (resulSet.getAvailableWithoutFetching() > 0) {
				Row row = iter.next();
				ObjectNode rowNode = buildRowNode(mapper, columns, row);
				// LOGGER.debug("rowNode "+mapper.writeValueAsString(rowNode));
				arrayNode.add(rowNode);

			}
			rootNode.set("data", arrayNode);
			PagingState pagingState = resulSet.getExecutionInfo().getPagingState();
			String pagingStateSt = pagingState.toString();
			rootNode.put("pagingState", pagingStateSt);
		}
		return rootNode;
	}

	public JsonNode getAllDataPaginateByPage(String connectionName, String keyspaceName, String tableName,
			Pagination pagination) throws Exception {
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		ObjectMapper mapper = new ObjectMapper();
		ObjectNode rootNode = mapper.createObjectNode();
		ArrayNode arrayNode = mapper.createArrayNode();
		rootNode.set("data", arrayNode);
		if (pagination.getPageSate() == null && pagination.getPageNum() != 1) {
			return rootNode;
		}
		TableMetadata table = cluster.getMetadata().getKeyspace(addQuote(keyspaceName)).getTable(addQuote(tableName));
		if (pagination.getPageNum() == 1) {
			long rows = this.cassandraRepository.countAllRows(connectionName, keyspaceName, tableName);
			rootNode.put("rows", rows);
			pagination.setTotal(rows);
			pagination.setPageCount((int) (rows / pagination.getPageSize()));
		} else {
			rootNode.put("rows", pagination.getTotal());
		}

		Select statement = QueryBuilder.select().from(addQuote(keyspaceName), addQuote(tableName));
		statement.setFetchSize(pagination.getPageSize());
		if (pagination.getPageSate() != null && !pagination.getPageSate().isEmpty()) {
			statement.setPagingState(PagingState.fromString(pagination.getPageSate()));
		}
		LOGGER.info("getAllDataPaginateByPage Query " + statement);
		ResultSet resulSet = session.execute(statement);
		List<ColumnMetadata> columns = buildColumns(table, rootNode);
		int countSaut = pagination.getPageNum() - pagination.getPageNumSate();
		LOGGER.info("getAllDataPaginateByPage  nombre de saut " + countSaut);
		for (int i = 0; i < countSaut; i++) {
			PagingState pagingState = resulSet.getExecutionInfo().getPagingState();
			statement.setPagingState(pagingState);
			resulSet = session.execute(statement);

		}
		if (resulSet != null) {
			Iterator<Row> iter = resulSet.iterator();
			while (resulSet.getAvailableWithoutFetching() > 0) {
				Row row = iter.next();
				ObjectNode rowNode = buildRowNode(mapper, columns, row);
				arrayNode.add(rowNode);

			}
			PagingState pagingState = resulSet.getExecutionInfo().getPagingState();
			if (pagingState != null) {
				String pagingStateSt = pagingState.toString();
				pagination.setPageSate(pagingStateSt);
				pagination.setPageNumSate(pagination.getPageNum() + 1);

			} else {
				pagination.setPageSate("");
				pagination.setPageNumSate(pagination.getPageNum());
			}
		}
		rootNode.set("pagination", mapper.convertValue(pagination, JsonNode.class));
		return rootNode;
	}

	public JsonNode getAllDataPaginateByPageX(String connectionName, String keyspaceName, String tableName, int page,
			Map<String, Object> mapPrimaryKey) throws Exception {
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		TableMetadata table = cluster.getMetadata().getKeyspace(addQuote(keyspaceName)).getTable(addQuote(tableName));
		List<ColumnMetadata> partionMetaKeys = table.getPartitionKey();
		List<String> partionKeys = new ArrayList<String>();
		partionMetaKeys.forEach(columnMeta -> {
			partionKeys.add(columnMeta.getName());
		});
		List<ColumnMetadata> clusteredColumnMetaKeys = table.getClusteringColumns();
		List<String> clusteredColumKeys = new ArrayList<String>();
		clusteredColumnMetaKeys.forEach(columnMeta -> {
			clusteredColumKeys.add(columnMeta.getName());
		});
		Collection<IndexMetadata> indexes = table.getIndexes();
		List<String> listIndexed = new ArrayList<String>();
		indexes.forEach(columnMeta -> {
			listIndexed.add(columnMeta.getName());
		});
		AtomicInteger atomicInt = new AtomicInteger(0);
		List<Clause> clauses = new ArrayList<>();
		List<String> clauseWhere = new ArrayList<>();
		mapPrimaryKey.forEach((key, value) -> {
			if (atomicInt.get() == 0) {
				clauses.add(QueryBuilder.gt("token(" + key + ")", "token(" + value + ")"));
				clauseWhere.add(" WHERE token(" + key + ") > token('" + value + "')");
			} else {
				clauses.add(QueryBuilder.gt("token(" + key + ")", "token('" + value + "')"));
				clauseWhere.add(" and token(" + key + ") > token('" + value + "')");
			}
			atomicInt.incrementAndGet();
		});
		Select.Where where = QueryBuilder.select().from(addQuote(keyspaceName), addQuote(tableName))
				.where(clauses.get(0));
		String query = "SELECT * FROM " + addQuote(keyspaceName) + "." + addQuote(tableName) + clauseWhere.get(0);
		if (clauses.size() > 1) {
			for (int i = 1; i < clauses.size(); i++) {
				where.and(clauses.get(i));
				query = query + clauseWhere.get(i);
			}
		}
		where.setFetchSize(page);
		LOGGER.info("query  " + query);
		ResultSet resulSet = session.execute(query);
		ObjectMapper mapper = new ObjectMapper();
		ObjectNode rootNode = mapper.createObjectNode();
		ArrayNode arrayNode = mapper.createArrayNode();

		List<ColumnMetadata> columns = buildColumns(table, rootNode);
		Iterator<Row> iter = resulSet.iterator();
		while (resulSet.getAvailableWithoutFetching() > 0) {
			Row row = iter.next();
			ObjectNode rowNode = buildRowNode(mapper, columns, row);
			// LOGGER.info("rowNode "+mapper.writeValueAsString(rowNode));
			arrayNode.add(rowNode);

		}
		rootNode.set("data", arrayNode);
		return rootNode;
	}

	public void insertData(String connectionName, String keyspaceName, String tableName, JsonNode map)
			throws Exception {
		Session session = getSession(connectionName);
		List<String> keys = new ArrayList<String>();
		List<Object> values = new ArrayList<Object>();
		JsonNode dataNode = map.get("data");
		Iterator<String> iterField = dataNode.fieldNames();
		while (iterField.hasNext()) {

			String key = iterField.next();
			if (dataNode.get(key).get("data").asText() != null && !dataNode.get(key).get("data").asText().isEmpty()) {
				keys.add(addQuote(key));
				values.add(GaindeUtil.getData(dataNode.get(key)));
			}
		}
		Insert insert = QueryBuilder.insertInto(addQuote(keyspaceName), addQuote(tableName)).values(keys, values);
		// insert.setConsistencyLevel(ConsistencyLevel.ALL);
		LOGGER.info("insert Data " + insert);
		session.execute(insert);
	}

	public void updateData(String connectionName, String keyspaceName, String tableName, JsonNode map)
			throws Exception {
		Session session = getSession(connectionName);
		JsonNode dataNode = map.get("data");
		ArrayNode arrayNode = (ArrayNode) map.get("partitionKeys");
		List<String> primaryKeys = new ArrayList<String>();
		List<Object> primaryValues = new ArrayList<Object>();
		arrayNode.forEach(node -> {
			primaryKeys.add(node.asText());
			primaryValues.add(GaindeUtil.getData(dataNode.get(node.asText())));
		});

		if (primaryKeys.isEmpty()) {
			throw new Exception("Aucun clé primaire pour where clause");
		}
		Clause clause = QueryBuilder.eq(addQuote(primaryKeys.get(0)), primaryValues.get(0));
		Iterator<String> iterField = dataNode.fieldNames();
		while (iterField.hasNext()) {
			String key = iterField.next();
			if (!primaryKeys.contains(key)) {
				JsonNode columnData = dataNode.get(key);
				Where where = QueryBuilder.update(addQuote(keyspaceName), addQuote(tableName))
						.with(QueryBuilder.set(addQuote(key), GaindeUtil.getData(columnData))).where(clause);
				if (primaryKeys.size() > 1) {
					for (int i = 1; i < primaryKeys.size(); i++) {
						where.and(QueryBuilder.eq(addQuote(primaryKeys.get(i)), primaryValues.get(i)));
					}
				}
				LOGGER.info("updateData   " + where);
				session.execute(where);
			}
		}

	}

	private ObjectNode buildRowNode(ObjectMapper mapper, List<ColumnMetadata> columns, Row row) {
		ObjectNode rowNode = mapper.createObjectNode();
		columns.forEach(column -> {
			Object object = row.getObject(addQuote(column.getName()));
			if (object != null) {
				switch (column.getType().getName()) {
				case TIMESTAMP: {
					if (object instanceof Date) {
						Date date = (Date) object;
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
						rowNode.put(column.getName(), dateFormat.format(date));
					}
					break;
				}
				case BLOB: {
					if (object instanceof ByteBuffer) {
						ByteBuffer byteBuffer = (ByteBuffer) object;
						String value = new String(byteBuffer.array());
						LOGGER.info(column.getName() + "   BLOB BLOB  " + value);
						rowNode.put(column.getName(), value);
					}
					break;
				}
				default:
					if (object != null) {
						String rowValue = object.toString();
						if (rowValue.length() > 1 && rowValue.startsWith("\"")) {
							rowValue = rowValue.substring(1, rowValue.length() - 1);
						}
						rowNode.put(column.getName(), rowValue);
					}
					break;
				}

			} else {
				rowNode.put(column.getName(), "");
			}

		});
		return rowNode;
	}

	private List<ColumnMetadata> buildColumns(TableMetadata table, ObjectNode rootNode) {
		List<ColumnMetadata> columns = table.getColumns();
		ArrayNode listColumnsName = buildColumnArrayNodes(table);
		rootNode.set("columns", listColumnsName);
		return columns;
	}

	private ArrayNode buildColumnArrayNodes(TableMetadata table) {

		List<ColumnMetadata> partionMetaKeys = table.getPartitionKey();
		List<String> partionKeys = new ArrayList<String>();
		partionMetaKeys.forEach(columnMeta -> {
			partionKeys.add(columnMeta.getName());
		});
		List<ColumnMetadata> clusteredColumnMetaKeys = table.getClusteringColumns();
		List<String> clusteredColumKeys = new ArrayList<String>();
		clusteredColumnMetaKeys.forEach(columnMeta -> {
			clusteredColumKeys.add(columnMeta.getName());
		});
		Collection<IndexMetadata> indexes = table.getIndexes();
		List<String> listIndexed = new ArrayList<String>();
		indexes.forEach(columnMeta -> {
			listIndexed.add(columnMeta.getName());
		});
		ObjectMapper mapper = new ObjectMapper();
		List<ObjectNode> columnsNodes = new ArrayList<ObjectNode>();
		ArrayNode listColumnsName = mapper.createArrayNode();
		List<ColumnMetadata> columns = table.getColumns();
		columns.forEach(column -> {
			ObjectNode jsonColumn = mapper.createObjectNode();
			jsonColumn.put("name", column.getName());
			jsonColumn.put("partitionKey", partionKeys.contains(column.getName()));
			jsonColumn.put("clusteredColumn", clusteredColumKeys.contains(column.getName()));
			jsonColumn.put("indexed", listIndexed.contains(column.getName()));
			jsonColumn.put("type", column.getType().getName().name());
			columnsNodes.add(jsonColumn);
		});
		columnsNodes.sort((col1, col2) -> {
			if (col1.get("partitionKey").asBoolean()) {
				if (col2.get("partitionKey").asBoolean()) {
					return 0;
				}
				return -1;
			} else {
				if (col2.get("partitionKey").asBoolean()) {
					return 1;
				}
				return 2;
			}
		});
		columnsNodes.forEach(jsonCol -> {
			listColumnsName.add(jsonCol);
		});
		return listColumnsName;
	}

	public void removeRowData(String connectionName, String keyspaceName, String tableName, Map<String, Object> map)
			throws Exception {
		Session session = getSession(connectionName);
		List<Clause> clauses = new ArrayList<>();
		map.keySet().forEach(key -> {
			clauses.add(QueryBuilder.eq(addQuote(key), map.get(key)));
		});

		Delete.Where deleteWhere = QueryBuilder.delete().from(addQuote(keyspaceName), addQuote(tableName))
				.where(clauses.get(0));
		if (clauses.size() > 1) {
			for (int i = 1; i < clauses.size(); i++) {
				deleteWhere.and(clauses.get(i));
			}
		}
		LOGGER.info("removeRowData CQL " + deleteWhere);
		session.execute(deleteWhere);
	}

	public void removeAllData(String connectionName, String keyspaceName, String tableName) throws Exception {
		Session session = getSession(connectionName);
		Truncate truncate = QueryBuilder.truncate(addQuote(keyspaceName), addQuote(tableName));

		LOGGER.info("removeAllData CQL " + truncate);
		LOGGER.info("removeAllData   " + truncate);
		session.execute(truncate);
	}

	/**
	 * Pour la gestion des majuscule
	 * 
	 * @param element
	 * @return
	 */
	private String addQuote(String element) {
		return "\"" + element + "\"";
	}

	private String buildQueryAddKeyspace(String keyspaceName, String pQuery, Cluster cluster) {
		String query;
		String[] arrayQuery = pQuery.split(" ");
		List<String> listQuery = new ArrayList<String>();
		for (int i = 0; i < arrayQuery.length; i++) {
			String item = arrayQuery[i].trim();
			if (!item.isEmpty()) {
				listQuery.add(item);
			}
		}
		if (keyQueryData.contains(listQuery.get(0).toUpperCase())) {
			Collection<TableMetadata> tables = cluster.getMetadata().getKeyspace(keyspaceName).getTables();
			for (int i = 0; i < listQuery.size(); i++) {
				String item = listQuery.get(i);
				AtomicInteger atomicInteger = new AtomicInteger(i);
				tables.forEach((table) -> {
					if (item.startsWith(table.getName())) {
						listQuery.set(atomicInteger.get(), keyspaceName + "." + item);
					}
				});
			}

		} else {

			if ("CREATE".equalsIgnoreCase(listQuery.get(0))) {
				if ("TABLE".equalsIgnoreCase(listQuery.get(1))) {
					if (listQuery.size() >= 5) {
						if ("IFNOTEXISTS".equalsIgnoreCase(listQuery.get(2) + listQuery.get(3) + listQuery.get(4))) {
							if (!listQuery.get(5).contains(".")) {
								listQuery.set(5, keyspaceName + "." + listQuery.get(5));
							}
						} else {
							if (!listQuery.get(2).contains(".")) {
								listQuery.set(2, keyspaceName + "." + listQuery.get(2));
							}
						}
					}
				} else {
					if ("INDEX".equalsIgnoreCase(listQuery.get(1))) {

					}
				}

			}
		}

		query = String.join(" ", listQuery);
		return query;
	}

	private Session getSession(String connectionName) throws Exception {
		return cassandraRepository.getSession(connectionName);
	}

	private Cluster getCluster(String connectionName) throws Exception {
		return cassandraRepository.getCluster(connectionName);
	}
}
