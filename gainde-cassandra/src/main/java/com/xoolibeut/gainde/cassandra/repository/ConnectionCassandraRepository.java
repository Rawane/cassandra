package com.xoolibeut.gainde.cassandra.repository;

import java.util.List;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Session;
import com.xoolibeut.gainde.cassandra.controller.dtos.ColonneTableDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.ConnectionDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.GaindeMetadataDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.TableDTO;

public interface ConnectionCassandraRepository {
	void connnectTocassandra(ConnectionDTO connectionDTO) throws Exception;

	List<GaindeMetadataDTO> getAllMetadatas(String connectionName) throws Exception;

	List<ColonneTableDTO> getAllColumns(String connectionName, String keyspaceName, String tableName) throws Exception;

	List<ColonneTableDTO> getAllColumnsTypeNative(String connectionName, String keyspaceName, String tableName)
			throws Exception;

	TableDTO getTableInfo(String connectionName, String keyspaceName, String tableName) throws Exception;

	long countAllRows(String connectionName, String keyspaceName, String tableName) throws Exception;

	void closeConnectioncassandra(String connectionName) throws Exception;

	Session getSession(String connectionName) throws Exception;

	Cluster getCluster(String connectionName) throws Exception;
}
