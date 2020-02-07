package com.xoolibeut.gainde.cassandra.repository;

import com.fasterxml.jackson.databind.JsonNode;
import com.xoolibeut.gainde.cassandra.controller.dtos.TableDTO;

public interface TableRepository {
	void createTable(TableDTO tableDTO, String connectionName, String keyspaceName) throws Exception;
	JsonNode getAllDataByTableName(String connectionName, String keyspaceName, String tableName) throws Exception;
	void dropTable(String connectionName, String keyspaceName,String tableName) throws Exception ;
	

}
