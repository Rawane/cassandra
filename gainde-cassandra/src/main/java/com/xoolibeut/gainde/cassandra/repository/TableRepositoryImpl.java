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
import java.util.concurrent.atomic.AtomicBoolean;

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
	@Autowired
	private ConnectionCassandraRepository cassandraRepository;
	private static String SEPARATOR_DATA = "-----------------------------------------------------------DATA--------------------------------------------------------";

	@PostConstruct
	public void init() {
		
	}

	public JsonNode executeQuery(String connectionName, String keyspaceName, String query) throws Exception {
		LOGGER.info("executeQuery " + query);
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		if (query == null || query.isEmpty()) {
			throw new Exception("Veuillez renseigner le query");
		}

		ObjectMapper mapper = new ObjectMapper();
		ObjectNode rootNode = mapper.createObjectNode();
		ArrayNode arrayNode = mapper.createArrayNode();
		rootNode.set("data", arrayNode);
		ResultSet resultSet = session.execute(query);
		if (resultSet != null) {
			Map<String, String> columsQuery = new HashMap<>();
			Map<String, String> mapMeta = new HashMap<>();
			resultSet.getColumnDefinitions().asList().forEach((definition) -> {
				columsQuery.put(definition.getName(), definition.getType().getName().name());
				if (mapMeta.isEmpty()) {
					mapMeta.put("table", definition.getTable());
					mapMeta.put("keyspace", definition.getKeyspace());
				}
			});
			resultSet.all().forEach((row) -> {
				ObjectNode jsonNode = mapper.createObjectNode();
				row.getColumnDefinitions().asList().forEach((definition) -> {
					LOGGER.debug(definition.getName());
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
				TableMetadata table = cluster.getMetadata().getKeyspace(addQuote(mapMeta.get("keyspace")))
						.getTable(addQuote(mapMeta.get("table")));
				rootNode.set("columns", buildColumnArrayNodes(table, columsQuery));
			}

		}

		return rootNode;
	}

	public void createTable(TableDTO tableDTO, String connectionName, String keyspaceName) throws Exception {
		LOGGER.info("createTable in " + keyspaceName);
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
		LOGGER.debug("createTable  " + createTable);
		session.execute(createTable);
		tableDTO.getIndexColumns().forEach(indexColumn -> {
			SchemaStatement createIndex = SchemaBuilder.createIndex(addQuote(indexColumn.getColumName())).ifNotExists()
					.onTable(addQuote(keyspaceName), addQuote(tableDTO.getName()))
					.andColumn(addQuote(indexColumn.getColumName()));
			session.execute(createIndex);
		});

	}

	public void dropTable(String connectionName, String keyspaceName, String tableName) throws Exception {
		LOGGER.info("dropTable " + tableName);
		Session session = getSession(connectionName);
		Drop dropTable = SchemaBuilder.dropTable(addQuote(keyspaceName), addQuote(tableName)).ifExists();
		session.execute(dropTable);

	}

	public void alterTable(TableDTO oldTableDTO, TableDTO tableDTO, String connectionName, String keyspaceName)
			throws Exception {
		LOGGER.info("alterTable ");
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
		// Ex�cution de la requete

		indexColumnRemoved.forEach(indexC -> {
			Drop drop = SchemaBuilder.dropIndex(addQuote(keyspaceName), addQuote(indexC.getName()));
			LOGGER.debug("alterTable drop " + drop);
			session.execute(drop);
		});
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
			LOGGER.debug("alterTable  " + schema);
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
			LOGGER.debug("alterTable added " + schema);
			session.execute(schema);
		});
		colonneRenamed.forEach(column -> {
			// LOGGER.debug("colonne � renommer " + column.getOldName() + " new name " +
			// column.getName());
			Statement schema = SchemaBuilder.alterTable(addQuote(keyspaceName), oldTableDTO.getName())
					.renameColumn(addQuote(column.getOldName())).to(addQuote(column.getName()));
			LOGGER.debug("alterTable renamed " + schema);
			session.execute(schema);
		});

		indexColumnAdded.forEach(indexC -> {
			SchemaStatement createIndex = SchemaBuilder.createIndex(addQuote(indexC.getName()))
					.onTable(addQuote(keyspaceName), addQuote(oldTableDTO.getName()))
					.andColumn(addQuote(indexC.getColumName()));
			LOGGER.debug("alterTable  createIndex " + createIndex);
			session.execute(createIndex);
		});

	}

	public JsonNode getAllDataByTableName(String connectionName, String keyspaceName, String tableName)
			throws Exception {
		LOGGER.info("getAllDataByTableName "+tableName);
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		TableMetadata table = cluster.getMetadata().getKeyspace(addQuote(keyspaceName)).getTable(addQuote(tableName));
		LOGGER.debug("exportAsString " + table.getName() + "   " + table.exportAsString());
		LOGGER.debug("asCQLQuery " + table.getName() + "   " + table.asCQLQuery());

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

	public JsonNode getAllDataPaginateByPage(String connectionName, String keyspaceName, String tableName,
			Map<String, String> mapWhereClause, Pagination pagination) throws Exception {
		LOGGER.info("getAllDataPaginateByPage "+tableName);
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		ObjectMapper mapper = new ObjectMapper();
		ObjectNode rootNode = mapper.createObjectNode();
		ArrayNode arrayNode = mapper.createArrayNode();
		rootNode.set("data", arrayNode);
		if (pagination.getPageSate() == null && pagination.getPageNum() != 1) {
			return rootNode;
		}

		Statement statement = QueryBuilder.select().from(addQuote(keyspaceName), addQuote(tableName));
		List<Clause> clauses = new ArrayList<>();
		if (mapWhereClause != null && !mapWhereClause.isEmpty()) {
			mapWhereClause.forEach((key, value) -> {
				clauses.add(QueryBuilder.eq(addQuote(key), value));

			});
			Select.Where whereClause = QueryBuilder.select().from(addQuote(keyspaceName), addQuote(tableName))
					.where(clauses.get(0));
			if (clauses.size() > 1) {
				for (int i = 1; i < clauses.size(); i++) {
					whereClause = whereClause.and(clauses.get(i));
				}
			}
			statement = whereClause;
		}

		if (pagination.getPageNum() == 1) {
			long rows;
			if (statement instanceof Select) {
				rows = this.cassandraRepository.countAllRows(connectionName, keyspaceName, tableName);
			} else {
				rows = this.cassandraRepository.countAllRows(connectionName, keyspaceName, tableName, clauses);
			}
			rootNode.put("rows", rows);
			pagination.setTotal(rows);
			pagination.setPageCount((int) (rows / pagination.getPageSize()));
		} else {
			rootNode.put("rows", pagination.getTotal());
		}

		statement.setFetchSize(pagination.getPageSize());
		if (pagination.getPageSate() != null && !pagination.getPageSate().isEmpty()) {
			statement.setPagingState(PagingState.fromString(pagination.getPageSate()));
		}
		LOGGER.debug("getAllDataPaginateByPage Query " + statement);
		ResultSet resulSet = session.execute(statement);
		TableMetadata table = cluster.getMetadata().getKeyspace(addQuote(keyspaceName)).getTable(addQuote(tableName));
		List<ColumnMetadata> columns = buildColumns(table, rootNode);
		int countSaut = pagination.getPageNum() - pagination.getPageNumSate();
		LOGGER.debug("getAllDataPaginateByPage  nombre de saut " + countSaut);
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

	public void insertData(String connectionName, String keyspaceName, String tableName, JsonNode map)
			throws Exception {
		LOGGER.info("insertData in "+tableName);
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
		LOGGER.debug("insert Data " + insert);
		session.execute(insert);
	}

	public void updateData(String connectionName, String keyspaceName, String tableName, JsonNode map)
			throws Exception {
		LOGGER.info("updateData on  "+tableName);
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
			throw new Exception("Aucun cl� primaire pour where clause");
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
				LOGGER.debug("updateData   " + where);
				session.execute(where);
			}
		}

	}
	public void removeRowData(String connectionName, String keyspaceName, String tableName, Map<String, Object> map)
			throws Exception {
		LOGGER.info("removeRowData   "+tableName);
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
		LOGGER.debug("removeRowData CQL " + deleteWhere);
		session.execute(deleteWhere);
	}

	public void removeAllData(String connectionName, String keyspaceName, String tableName) throws Exception {
		LOGGER.info("removeAllData   "+tableName);
		Session session = getSession(connectionName);
		Truncate truncate = QueryBuilder.truncate(addQuote(keyspaceName), addQuote(tableName));
		LOGGER.debug("removeAllData CQL " + truncate);
		LOGGER.debug("removeAllData   " + truncate);
		session.execute(truncate);
	}

	@Override
	public String dumpTableSchema(String connectionName, String keyspaceName, String tableName) throws Exception {
		LOGGER.info("dumpTableSchema   "+tableName);
		StringBuilder builder = new StringBuilder();
		Cluster cluster = getCluster(connectionName);
		if (cluster != null) {
			TableMetadata tableMetadata = cluster.getMetadata().getKeyspace(addQuote(keyspaceName))
					.getTable(addQuote(tableName));
			if (tableMetadata != null) {
				builder.append(tableMetadata.exportAsString());
			}
		}
		return builder.toString();
	}

	@Override
	public String dumpTableWithData(String connectionName, String keyspaceName, String tableName) throws Exception {
		LOGGER.info("dumpTableWithData   "+tableName);
		StringBuilder builder = new StringBuilder();
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		if (cluster != null) {
			TableMetadata tableMetadata = cluster.getMetadata().getKeyspace(addQuote(keyspaceName))
					.getTable(addQuote(tableName));
			if (tableMetadata != null) {
				builder.append(tableMetadata.exportAsString());
				LOGGER.debug("keyspaceMetadata " + tableMetadata.exportAsString());
				builder.append("\n").append(SEPARATOR_DATA);
				ResultSet resulSet = session
						.execute(QueryBuilder.select().from(addQuote(keyspaceName), addQuote(tableMetadata.getName())));
				Iterator<Row> iter = resulSet.iterator();
				while (iter.hasNext()) {
					Row row = iter.next();
					builder.append(buildRowValue(keyspaceName, tableMetadata, row));

				}

			}
		}
		return builder.toString();
	}

	@Override
	public String dumpOnlyDataFromTable(String connectionName, String keyspaceName, String tableName) throws Exception {
		LOGGER.info("dumpOnlyDataFromTable   "+tableName);
		StringBuilder builder = new StringBuilder();
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		if (cluster != null) {
			TableMetadata tableMetadata = cluster.getMetadata().getKeyspace(addQuote(keyspaceName))
					.getTable(addQuote(tableName));
			if (tableMetadata != null) {
				ResultSet resulSet = session
						.execute(QueryBuilder.select().from(addQuote(keyspaceName), addQuote(tableMetadata.getName())));
				Iterator<Row> iter = resulSet.iterator();
				while (iter.hasNext()) {
					Row row = iter.next();
					builder.append(buildRowValue(keyspaceName, tableMetadata, row));

				}

			}
		}
		return builder.toString();
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
						LOGGER.debug(column.getName() + "   BLOB BLOB  " + value);
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
			listIndexed.add(removeQuote(columnMeta.getTarget()));
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

	private ArrayNode buildColumnArrayNodes(TableMetadata table, Map<String, String> columsQuery) {

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
			listIndexed.add(removeQuote(columnMeta.getTarget()));
		});
		ObjectMapper mapper = new ObjectMapper();
		List<ObjectNode> columnsNodes = new ArrayList<ObjectNode>();
		ArrayNode listColumnsName = mapper.createArrayNode();

		columsQuery.forEach((columnName, type) -> {
			ObjectNode jsonColumn = mapper.createObjectNode();
			jsonColumn.put("name", columnName);
			jsonColumn.put("partitionKey", partionKeys.contains(columnName));
			jsonColumn.put("clusteredColumn", clusteredColumKeys.contains(columnName));
			jsonColumn.put("indexed", listIndexed.contains(columnName));
			jsonColumn.put("type", type);
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

	

	private String buildRowValue(String keyspaceName, TableMetadata tableMetadata, Row row) {
		StringBuilder builderHead = new StringBuilder("\nINSERT INTO ");
		builderHead.append("\"").append(keyspaceName).append("\".").append("\"").append(tableMetadata.getName())
				.append("\"");
		Map<String, String> columnsInsert = new HashMap<>();
		List<ColumnMetadata> columns = tableMetadata.getColumns();
		columns.forEach(column -> {
			Object object = row.getObject(addQuote(column.getName()));
			if (object != null) {
				switch (column.getType().getName()) {
				case TIMESTAMP: {
					if (object instanceof Date) {
						Date date = (Date) object;
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
						columnsInsert.put(column.getName(), dateFormat.format(date));
					}
					break;
				}
				case BLOB: {
					if (object instanceof ByteBuffer) {
						ByteBuffer byteBuffer = (ByteBuffer) object;
						String value = new String(byteBuffer.array());
						LOGGER.debug(column.getName() + "   BLOB BLOB  " + value);
						columnsInsert.put(column.getName(), value);
					}
					break;
				}
				default:
					if (object != null) {
						String rowValue = object.toString();
						if (rowValue.length() > 1 && rowValue.startsWith("\"")) {
							//rowValue = rowValue.substring(1, rowValue.length() - 1);
						}
						columnsInsert.put(column.getName(), rowValue);
					}
					break;
				}

			}
		});
		StringBuilder builderInsert = new StringBuilder(" (");
		StringBuilder builderValue = new StringBuilder(" (");
		AtomicBoolean firstInsert = new AtomicBoolean(true);
		columnsInsert.forEach((key, value) -> {
			if (firstInsert.get()) {
				builderInsert.append("\"").append(key).append("\"");
				builderValue.append("'").append(value.replaceAll("'", "''")).append("'");

			} else {
				builderInsert.append(",\"").append(key).append("\"");
				builderValue.append(",'").append(value.replaceAll("'", "''")).append("'");
			}
			firstInsert.set(false);
		});
		builderInsert.append(")");
		builderValue.append(");");
		builderHead.append(builderInsert).append(" VALUES").append(builderValue);
		return builderHead.toString();
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

	private String removeQuote(String element) {
		if (element == null || element.length() < 2) {
			return element;
		}
		if (element.startsWith("\"")) {
			return element.substring(1, element.length() - 1);
		}
		return element;
	}

	private Session getSession(String connectionName) throws Exception {
		return cassandraRepository.getSession(connectionName);
	}

	private Cluster getCluster(String connectionName) throws Exception {
		return cassandraRepository.getCluster(connectionName);
	}
}
