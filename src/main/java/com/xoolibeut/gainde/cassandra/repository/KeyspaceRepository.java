package com.xoolibeut.gainde.cassandra.repository;

import java.util.List;

import com.xoolibeut.gainde.cassandra.controller.dtos.KeyspaceDTO;

public interface KeyspaceRepository {

	void createKeyspace(String connectionName,KeyspaceDTO keyspaceDTO) throws Exception;

	void alterKeyspace( String connectionName,KeyspaceDTO keyspaceDTO) throws Exception;

	void dropKeyspace(String connectionName, String keyspace) throws Exception;

	List<KeyspaceDTO> getAllKeyspace(String connectioName) throws Exception;

	KeyspaceDTO getKeyspace(String connectioName,String keyspaceName)throws Exception;

}
