package com.xoolibeut.gainde.cassandra.repository;

import com.xoolibeut.gainde.cassandra.controller.dtos.TableDTO;

public interface TableRepository {
	void createTable(TableDTO tableDTO, String connectionName, String keyspaceName) throws Exception;
	

}
