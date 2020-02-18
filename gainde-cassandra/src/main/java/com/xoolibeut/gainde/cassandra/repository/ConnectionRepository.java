package com.xoolibeut.gainde.cassandra.repository;

import java.io.IOException;
import java.util.List;

import com.xoolibeut.gainde.cassandra.controller.dtos.ConnectionDTO;

public interface ConnectionRepository {
	boolean createConnection(ConnectionDTO connectionDTO) throws IOException;

	boolean updateConnection(ConnectionDTO connectionDTO) throws IOException;

	boolean removeConnection(ConnectionDTO connectionDTO) throws IOException;

	List<ConnectionDTO> readlAllConnections() throws IOException;

	ConnectionDTO getConnection(String name) throws IOException;

	void updateOrderConnection(List<ConnectionDTO> listConnections) throws IOException;
}
