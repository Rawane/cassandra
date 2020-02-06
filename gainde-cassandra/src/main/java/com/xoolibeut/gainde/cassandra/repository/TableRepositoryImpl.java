package com.xoolibeut.gainde.cassandra.repository;

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
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.datastax.driver.core.schemabuilder.Create;
import com.datastax.driver.core.schemabuilder.SchemaBuilder;
import com.datastax.driver.core.schemabuilder.SchemaStatement;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
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
			DataType datype = GaindeUtil.getDataType(Integer.parseInt(column.getType()));
			if (column.isPrimaraKey()) {
				createTable.addPartitionKey(column.getName(), datype);
			}
			createTable.addColumn(column.getName(), datype);
		});
		session.execute(createTable);
		tableDTO.getIndexColumns().forEach(indexColumn -> {
			SchemaStatement createIndex = SchemaBuilder.createIndex(indexColumn.getColumName()).ifNotExists()
					.onTable(keyspaceName, tableDTO.getName()).andColumn(indexColumn.getColumName());
			session.execute(createIndex);
		});

	}

	public void alterTable(TableDTO tableDTO, String connectionName, String keyspaceName) throws Exception {

	}

	public JsonNode getAllDataByTableName(String connectionName, String keyspaceName, String tableName)
			throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		Cluster cluster = GaindeSessionConnection.getInstance().getCluster(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		List<ColumnMetadata> columns = cluster.getMetadata().getKeyspace(keyspaceName).getTable(tableName).getColumns();
		ResultSet resulSet = session.execute(QueryBuilder.select().from(keyspaceName, tableName));
		//ResultSet rs = session.execute("SELECT cql_version FROM system.local;");
		//Row rowOne = rs.one();
		//LOGGER.info("rowOne  " + rowOne);
		ObjectMapper mapper = new ObjectMapper();		
		ObjectNode rootNode = mapper.createObjectNode();
		ArrayNode arrayNode = mapper.createArrayNode();
		ArrayNode listColumnsName = mapper.createArrayNode();
		Iterator<Row> iter = resulSet.iterator();
		columns.forEach(column -> {
			listColumnsName.add(column.getName());
		});
		rootNode.set("columns",listColumnsName);
		
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
		rootNode.set("data",arrayNode);
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
