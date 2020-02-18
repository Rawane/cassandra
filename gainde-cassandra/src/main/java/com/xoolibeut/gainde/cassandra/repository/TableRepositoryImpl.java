package com.xoolibeut.gainde.cassandra.repository;

import java.nio.ByteBuffer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.ColumnMetadata;
import com.datastax.driver.core.ConsistencyLevel;
import com.datastax.driver.core.DataType;
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
import com.xoolibeut.gainde.cassandra.controller.dtos.TableDTO;
import com.xoolibeut.gainde.cassandra.util.GaindeUtil;

@Repository
public class TableRepositoryImpl implements TableRepository {
	private static final Logger LOGGER = LoggerFactory.getLogger(TableRepositoryImpl.class);

	public JsonNode executeQuery(String connectionName, String keyspaceName, String query) throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		Cluster cluster = GaindeSessionConnection.getInstance().getCluster(connectionName);
		if (session == null || cluster == null) {
			throw new Exception("aucune session");
		}
		if (query == null || query.isEmpty()) {
			throw new Exception("Veuillez renseigner le query");
		}
		String[] arrayQuery = query.split(" ");
		List<String> listQuery = new ArrayList<String>();
		for (int i = 0; i < arrayQuery.length; i++) {
			String item = arrayQuery[i].trim();
			if (!item.isEmpty()) {
				listQuery.add(item);
			}
		}
		Collection<TableMetadata> tables = cluster.getMetadata().getKeyspace(keyspaceName).getTables();
		for(int i=0;i<listQuery.size();i++) {
			String item = listQuery.get(i);			
			tables.forEach((table)->{
				if(table.getName().equals(item)){
					//listQuery.set(index, element)
				}
			});
		}
		ObjectMapper mapper = new ObjectMapper();
		ObjectNode rootNode = mapper.createObjectNode();
		ArrayNode arrayNode = mapper.createArrayNode();
		rootNode.set("data", arrayNode);
		ResultSet resultSet = session.execute(String.join(" ", listQuery));
		if (resultSet != null) {
			resultSet.all().forEach((row) -> {
				ObjectNode jsonNode = mapper.createObjectNode();
				row.getColumnDefinitions().asList().forEach((definition) -> {
					LOGGER.info(definition.getName());
					switch (definition.getType().getName()) {
					case TIMESTAMP: {
						if (row.getObject(definition.getName()) instanceof Date) {
							Date date = (Date) row.getObject(definition.getName());
							SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
							jsonNode.put(definition.getName(), dateFormat.format(date));
						}
						break;
					}
					case BLOB: {
						if (row.getObject(definition.getName()) instanceof ByteBuffer) {
							ByteBuffer byteBuffer = (ByteBuffer) row.getObject(definition.getName());
							jsonNode.put(definition.getName(), new String(byteBuffer.array()));
						}
						break;
					}
					default:
						if (row.getObject(definition.getName()) != null) {
							String rowValue = row.getObject(definition.getName()).toString();
							if (rowValue.length() > 1 && rowValue.startsWith("\"")) {
								rowValue = rowValue.substring(1, rowValue.length() - 1);
							}
							jsonNode.put(definition.getName(), rowValue);
						}
						break;
					}

				});
				arrayNode.add(jsonNode);
			});

		}

		return rootNode;
	}

	public void createTable(TableDTO tableDTO, String connectionName, String keyspaceName) throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		Create createTable = SchemaBuilder.createTable(keyspaceName, tableDTO.getName()).ifNotExists();
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
					createTable.addClusteringColumn(column.getName(), datype);
				} else {
					createTable.addPartitionKey(column.getName(), datype);
				}
			} else {
				if (column.isClusteredColumn()) {
					createTable.addClusteringColumn(column.getName(), datype);
				} else {
					createTable.addColumn(column.getName(), datype);
				}
			}
		});
		LOGGER.info("createTable  " + createTable);
		session.execute(createTable);
		tableDTO.getIndexColumns().forEach(indexColumn -> {
			SchemaStatement createIndex = SchemaBuilder.createIndex(indexColumn.getColumName()).ifNotExists()
					.onTable(keyspaceName, tableDTO.getName()).andColumn(indexColumn.getColumName());
			session.execute(createIndex);
		});

	}

	public void createTableTest(TableDTO tableDTO, String connectionName, String keyspaceName) throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		Create createTable = SchemaBuilder.createTable(keyspaceName, tableDTO.getName()).ifNotExists();
		AtomicInteger count = new AtomicInteger();
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

			if (column.isPartitionKey() && count.get() < 1) {
				createTable.addPartitionKey(column.getName(), datype);
				count.incrementAndGet();
			} else {
				if (column.isPartitionKey()) {
					createTable.addClusteringColumn(column.getName(), datype);
					count.incrementAndGet();
				} else {
					createTable.addColumn(column.getName(), datype);
				}
			}
		});
		LOGGER.info("createTable  " + createTable);
		session.execute(createTable);
		tableDTO.getIndexColumns().forEach(indexColumn -> {
			SchemaStatement createIndex = SchemaBuilder.createIndex(indexColumn.getColumName()).ifNotExists()
					.onTable(keyspaceName, tableDTO.getName()).andColumn(indexColumn.getColumName());
			session.execute(createIndex);
		});

	}

	public void dropTable(String connectionName, String keyspaceName, String tableName) throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		Drop dropTable = SchemaBuilder.dropTable(keyspaceName, tableName).ifExists();
		session.execute(dropTable);

	}

	public void alterTable(TableDTO oldTableDTO, TableDTO tableDTO, String connectionName, String keyspaceName)
			throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
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
			SchemaStatement schema = SchemaBuilder.alterTable(keyspaceName, oldTableDTO.getName())
					.dropColumn(column.getName());
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
			Statement schema = SchemaBuilder.alterTable(keyspaceName, oldTableDTO.getName())
					.alterColumn(column.getName())
					.type(GaindeUtil.getDataType(Integer.parseInt(column.getType()), typeList, typeMap))
					.enableTracing();
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
			SchemaStatement schema = SchemaBuilder.alterTable(keyspaceName, oldTableDTO.getName())
					.addColumn(column.getName())
					.type(GaindeUtil.getDataType(Integer.parseInt(column.getType()), typeList, typeMap));
			session.execute(schema);
		});
		colonneRenamed.forEach(column -> {
			// LOGGER.debug("colonne à renommer " + column.getOldName() + " new name " +
			// column.getName());
			Statement schema = SchemaBuilder.alterTable(keyspaceName, oldTableDTO.getName())
					.renameColumn(column.getOldName()).to(column.getName());
			session.execute(schema);
		});
		indexColumnRemoved.forEach(indexC -> {
			Drop drop = SchemaBuilder.dropIndex(keyspaceName, indexC.getName());
			session.execute(drop);
		});
		indexColumnAdded.forEach(indexC -> {
			SchemaStatement createIndex = SchemaBuilder.createIndex(indexC.getName())
					.onTable(keyspaceName, oldTableDTO.getName()).andColumn(indexC.getColumName());
			session.execute(createIndex);
		});

	}

	public JsonNode getAllDataByTableName(String connectionName, String keyspaceName, String tableName)
			throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		Cluster cluster = GaindeSessionConnection.getInstance().getCluster(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		TableMetadata table = cluster.getMetadata().getKeyspace(keyspaceName).getTable(tableName);
		LOGGER.info("exportAsString " + table.getName() + "   " + table.exportAsString());
		LOGGER.info("asCQLQuery " + table.getName() + "   " + table.asCQLQuery());
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
		ResultSet resulSet = session.execute(QueryBuilder.select().from(keyspaceName, tableName));
		ObjectMapper mapper = new ObjectMapper();
		ObjectNode rootNode = mapper.createObjectNode();
		ArrayNode arrayNode = mapper.createArrayNode();

		List<ColumnMetadata> columns = buildColumns(table, partionKeys, clusteredColumKeys, mapper, rootNode);
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
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		Cluster cluster = GaindeSessionConnection.getInstance().getCluster(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		TableMetadata table = cluster.getMetadata().getKeyspace(keyspaceName).getTable(tableName);
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
		Select statement = QueryBuilder.select().from(keyspaceName, tableName);
		statement.setFetchSize(page);
		ResultSet resulSet = session.execute(statement);
		ObjectMapper mapper = new ObjectMapper();
		ObjectNode rootNode = mapper.createObjectNode();
		ArrayNode arrayNode = mapper.createArrayNode();

		List<ColumnMetadata> columns = buildColumns(table, partionKeys, clusteredColumKeys, mapper, rootNode);
		Iterator<Row> iter = resulSet.iterator();
		while (resulSet.getAvailableWithoutFetching() > 0) {
			Row row = iter.next();
			ObjectNode rowNode = buildRowNode(mapper, columns, row);
			// LOGGER.debug("rowNode "+mapper.writeValueAsString(rowNode));
			arrayNode.add(rowNode);

		}
		rootNode.set("data", arrayNode);
		return rootNode;
	}

	public JsonNode getAllDataPaginateByPageX(String connectionName, String keyspaceName, String tableName, int page,
			Map<String, Object> mapPrimaryKey) throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		Cluster cluster = GaindeSessionConnection.getInstance().getCluster(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		TableMetadata table = cluster.getMetadata().getKeyspace(keyspaceName).getTable(tableName);
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
		Select.Where where = QueryBuilder.select().from(keyspaceName, tableName).where(clauses.get(0));
		String query = "SELECT * FROM " + keyspaceName + "." + tableName + clauseWhere.get(0);
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

		List<ColumnMetadata> columns = buildColumns(table, partionKeys, clusteredColumKeys, mapper, rootNode);
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
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		List<String> keys = new ArrayList<String>();
		List<Object> values = new ArrayList<Object>();
		JsonNode dataNode = map.get("data");
		Iterator<String> iterField = dataNode.fieldNames();
		while (iterField.hasNext()) {

			String key = iterField.next();
			if (dataNode.get(key).get("data").asText() != null && !dataNode.get(key).get("data").asText().isEmpty()) {
				keys.add(key);
				values.add(GaindeUtil.getData(dataNode.get(key)));
			}
		}
		Insert insert = QueryBuilder.insertInto(keyspaceName, tableName).values(keys, values);
		insert.setConsistencyLevel(ConsistencyLevel.ALL);
		session.execute(insert);
	}

	public void updateData(String connectionName, String keyspaceName, String tableName, JsonNode map)
			throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
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
		Clause clause = QueryBuilder.eq(primaryKeys.get(0), primaryValues.get(0));
		Iterator<String> iterField = dataNode.fieldNames();
		while (iterField.hasNext()) {
			String key = iterField.next();
			if (!primaryKeys.contains(key)) {
				JsonNode columnData = dataNode.get(key);
				Where where = QueryBuilder.update(keyspaceName, tableName)
						.with(QueryBuilder.set(key, GaindeUtil.getData(columnData))).where(clause);
				if (primaryKeys.size() > 1) {
					for (int i = 1; i < primaryKeys.size(); i++) {
						where.and(QueryBuilder.eq(primaryKeys.get(i), primaryValues.get(i)));
					}
				}

				session.execute(where);
			}
		}

	}

	private ObjectNode buildRowNode(ObjectMapper mapper, List<ColumnMetadata> columns, Row row) {
		ObjectNode rowNode = mapper.createObjectNode();
		columns.forEach(column -> {
			if (row.getObject(column.getName()) != null) {
				// LOGGER.debug( "classs row " + row.getObject(column.getName()).getClass() + "
				// col name " + column.getName());
				switch (column.getType().getName()) {
				case TIMESTAMP: {
					if (row.getObject(column.getName()) instanceof Date) {
						Date date = (Date) row.getObject(column.getName());
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
						rowNode.put(column.getName(), dateFormat.format(date));
					}
					break;
				}
				case BLOB: {
					if (row.getObject(column.getName()) instanceof ByteBuffer) {
						ByteBuffer byteBuffer = (ByteBuffer) row.getObject(column.getName());
						rowNode.put(column.getName(), new String(byteBuffer.array()));
					}
					break;
				}
				default:
					String rowValue = row.getObject(column.getName()).toString();
					if (rowValue.length() > 1 && rowValue.startsWith("\"")) {
						rowValue = rowValue.substring(1, rowValue.length() - 1);
					}
					rowNode.put(column.getName(), rowValue);
					break;
				}

			} else {
				rowNode.put(column.getName(), "");
			}
			// LOGGER.debug("row " + column.getName() + " value " +
			// row.getObject(column.getName()));
		});
		return rowNode;
	}

	private List<ColumnMetadata> buildColumns(TableMetadata table, List<String> partionKeys,
			List<String> clusteredColumKeys, ObjectMapper mapper, ObjectNode rootNode) {
		ArrayNode listColumnsName = mapper.createArrayNode();
		List<ObjectNode> columnsNodes = new ArrayList<ObjectNode>();
		List<ColumnMetadata> columns = table.getColumns();
		columns.forEach(column -> {
			ObjectNode jsonColumn = mapper.createObjectNode();
			jsonColumn.put("name", column.getName());
			jsonColumn.put("partitionKey", partionKeys.contains(column.getName()));
			jsonColumn.put("clusteredColumn", clusteredColumKeys.contains(column.getName()));
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

		rootNode.set("columns", listColumnsName);
		return columns;
	}

	public void removeRowData(String connectionName, String keyspaceName, String tableName, Map<String, Object> map)
			throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		List<Clause> clauses = new ArrayList<>();
		map.keySet().forEach(key -> {
			clauses.add(QueryBuilder.eq(key, map.get(key)));
		});

		Delete.Where deleteWhere = QueryBuilder.delete().from(keyspaceName, tableName).where(clauses.get(0));
		if (clauses.size() > 1) {
			for (int i = 1; i < clauses.size(); i++) {
				deleteWhere.and(clauses.get(i));
			}
		}
		LOGGER.info("removeRowData CQL " + deleteWhere);
		session.execute(deleteWhere);
	}

	public void removeAllData(String connectionName, String keyspaceName, String tableName) throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		Truncate truncate = QueryBuilder.truncate(keyspaceName, tableName);

		LOGGER.info("removeAllData CQL " + truncate);
		session.execute(truncate);
	}

}
