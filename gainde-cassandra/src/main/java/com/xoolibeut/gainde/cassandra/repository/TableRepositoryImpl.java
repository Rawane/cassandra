package com.xoolibeut.gainde.cassandra.repository;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.ColumnMetadata;
import com.datastax.driver.core.DataType;
import com.datastax.driver.core.PagingState;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.Statement;
import com.datastax.driver.core.TableMetadata;
import com.datastax.driver.core.querybuilder.QueryBuilder;
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
			if (column.isPrimaraKey()) {
				createTable.addPartitionKey(column.getName(), datype);
			} else {
				createTable.addColumn(column.getName(), datype);
			}
		});
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
		if(!oldTableDTO.getName().equals(tableDTO.getName())) {
			throw new Exception("Vous ne pouvez pas modifier le nom de la table");
		}
		List<ColonneTableDTO> colonneRemoved = new ArrayList<>();
		List<ColonneTableDTO> colonneAdded = new ArrayList<>();
		List<ColonneTableDTO> colonneAlter = new ArrayList<>();
		List<IndexColumn> indexColumnRemoved = new ArrayList<>();
		List<IndexColumn> indexColumnAdded = new ArrayList<>();
		tableDTO.getColumns().forEach(column -> {
			if (!column.isPrimaraKey()) {
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
					colonneAdded.add(column);
				}
			}
		});
		oldTableDTO.getColumns().forEach(column -> {
			if (!column.isPrimaraKey()) {
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
					.type(GaindeUtil.getDataType(Integer.parseInt(column.getType()), typeList, typeMap)).enableTracing();
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
		List<ColumnMetadata> columns = table.getColumns();
		List<ColumnMetadata> partionMetaKeys = table.getPartitionKey();
		List<String> partionKeys = new ArrayList<String>();
		partionMetaKeys.forEach(columnMeta->{
			partionKeys.add(columnMeta.getName());
		});
		ResultSet resulSet = session.execute(QueryBuilder.select().from(keyspaceName, tableName));	
		ObjectMapper mapper = new ObjectMapper();
		ObjectNode rootNode = mapper.createObjectNode();
		ArrayNode arrayNode = mapper.createArrayNode();
		ArrayNode listColumnsName = mapper.createArrayNode();
		
		List<ObjectNode> columnsNodes = new ArrayList<ObjectNode>();
		Iterator<Row> iter = resulSet.iterator();
		columns.forEach(column -> {
			ObjectNode jsonColumn = mapper.createObjectNode();
			jsonColumn.put("name",column.getName());
			jsonColumn.put("primaryKey",partionKeys.contains(column.getName()));	
			jsonColumn.put("type",column.getType().getName().name());	
			columnsNodes.add(jsonColumn);
		});
		columnsNodes.sort((col1,col2)->{
			if(col1.get("primaryKey").asBoolean()) {
				if(col2.get("primaryKey").asBoolean()) {
					return 0;
				}
				return -1;
			}else {
				if(col2.get("primaryKey").asBoolean()) {
					return 1;
				}
				return 2;
			}			
		});
		columnsNodes.forEach(jsonCol -> {			
			listColumnsName.add(jsonCol);
		});
		rootNode.set("columns", listColumnsName);
		while (iter.hasNext()) {
			Row row = iter.next();
			ObjectNode rowNode = mapper.createObjectNode();
			columns.forEach(column -> {
				if (row.getObject(column.getName()) != null) {
					rowNode.put(column.getName(), row.getObject(column.getName()).toString());
				} else {
					rowNode.put(column.getName(), "");
				}
				LOGGER.info("row  " + column.getName() + "   value " + row.getObject(column.getName()));
			});
			arrayNode.add(rowNode);

		}
		rootNode.set("data", arrayNode);
		return rootNode;
	}

	public static void getAllDataByTableNameOld(String connectionName, String keyspaceName, String tableName)
			throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		ResultSet resulSet = session.execute(QueryBuilder.select().from(keyspaceName, tableName).setFetchSize(5));
		PagingState pagingState = resulSet.getExecutionInfo().getPagingState();
		LOGGER.info("pagingState  " + pagingState.toString());
		ResultSet rs = session.execute("SELECT cql_version FROM system.local;");
		Row rowOne = rs.one();
		LOGGER.info("rowOne  " + rowOne);
		Iterator<Row> iter = resulSet.iterator();
		while (resulSet.getAvailableWithoutFetching() > 0) {

			Row row = iter.next();
			LOGGER.info("row  " + row);
		}
	}

}
