package com.xoolibeut.gainde.cassandra.repository;

import org.junit.Test;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.xoolibeut.gainde.cassandra.controller.dtos.ConnectionDTO;

public class TableRepositoryTest {
	private TableRepository tableRepository = new TableRepositoryImpl();

	@Test
	public void testUpdateData() throws Exception {
		String connectionName = "LOCAL";
		ConnectionDTO connectionDTO = new ConnectionDTO(connectionName);
		connectionDTO.setIp("127.0.0.1");
		connectionDTO.setPort(9042);
		ConnectionCassandraRepositoryImpl cassandraRepository = new ConnectionCassandraRepositoryImpl();
		cassandraRepository.connnectTocassandra(connectionDTO);
		ObjectMapper mapper = new ObjectMapper();
		ObjectNode map = mapper.createObjectNode();
		ObjectNode data = mapper.createObjectNode();
		ArrayNode primaryKeys = mapper.createArrayNode();
		map.set("primaryKeys", primaryKeys);
		map.set("data", data);
		primaryKeys.add("name");
		data.put("age", 10);
		data.put("id", "zaazza");
		tableRepository.updateData(connectionName, "x48c95551_20c5_4c4e_kps_rawanex", "personne", map);

		cassandraRepository.closeConnectioncassandra(connectionName);

	}
}
