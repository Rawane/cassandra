package com.xoolibeut.gainde.cassandra.repository;

import java.util.List;

import com.xoolibeut.gainde.cassandra.controller.dtos.ColonneTableDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.ConnectionDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.GaindeMetadataDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.TableDTO;

public interface ConnectionCassandraRepository {
	void connnectTocassandra(ConnectionDTO connectionDTO) throws Exception;

	List<GaindeMetadataDTO> getAllMetadatas(String connectionName);

	List<ColonneTableDTO> getAllColumns(String connectionName, String keyspaceName, String tableName);
	List<ColonneTableDTO> getAllColumnsTypeNative(String connectionName, String keyspaceName, String tableName);

	TableDTO getTableInfo(String connectionName, String keyspaceName, String tableName);

	long countAllRows(String connectionName, String keyspaceName, String tableName);
	
	void closeConnectioncassandra(String connectionName) throws Exception;
}
