package com.xoolibeut.gainde.cassandra.repository;

import java.util.Map;

import com.fasterxml.jackson.databind.JsonNode;
import com.xoolibeut.gainde.cassandra.controller.dtos.TableDTO;

public interface TableRepository {
	void createTable(TableDTO tableDTO, String connectionName, String keyspaceName) throws Exception;

	JsonNode getAllDataByTableName(String connectionName, String keyspaceName, String tableName) throws Exception;

	void dropTable(String connectionName, String keyspaceName, String tableName) throws Exception;

	void alterTable(TableDTO oldTableDTO, TableDTO tableDTO, String connectionName, String keyspaceName)
			throws Exception;

	void insertData(String connectionName, String keyspaceName, String tableName, JsonNode map) throws Exception;

	void updateData(String connectionName, String keyspaceName, String tableName, JsonNode map) throws Exception;

	JsonNode getAllDataPaginateByPage1(String connectionName, String keyspaceName, String tableName, int page)
			throws Exception;

	JsonNode getAllDataPaginateByPageX(String connectionName, String keyspaceName, String tableName, int page,
			Map<String, Object> mapPrimaryKey) throws Exception;

	void createTableTest(TableDTO tableDTO, String connectionName, String keyspaceName) throws Exception;

	void removeRowData(String connectionName, String keyspaceName, String tableName, Map<String, Object> map) throws Exception;

	void removeAllData(String connectionName, String keyspaceName, String tableName) throws Exception;

}
