package com.xoolibeut.gainde.cassandra.repository;

import org.springframework.stereotype.Repository;

import com.datastax.driver.core.DataType;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.schemabuilder.Create;
import com.datastax.driver.core.schemabuilder.SchemaBuilder;
import com.datastax.driver.core.schemabuilder.SchemaStatement;
import com.xoolibeut.gainde.cassandra.controller.dtos.TableDTO;
import com.xoolibeut.gainde.cassandra.util.GaindeUtil;
@Repository
public class TableRepositoryImpl implements TableRepository {

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
}
