package com.xoolibeut.gainde.cassandra.repository;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.xoolibeut.gainde.cassandra.controller.dtos.ConnectionDTO;

public class TableRepositoryTest {
	private TableRepository tableRepository = new TableRepositoryImpl();

	@Test
	public void testUpdateData() {
		try {
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
		primaryKeys.add("nom");
		ObjectNode columData1 = mapper.createObjectNode();
		columData1.put("data", "hfsytdtyzazddyushshdhdss");
		columData1.put("type", "BLOB");
		data.set("col_blob", columData1);
		
		ObjectNode columDataPr = mapper.createObjectNode();
		columDataPr.put("data", "zzazaza");
		columDataPr.put("type", "TEXT");
		data.set("nom", columDataPr);
		//tableRepository.updateData(connectionName, "x48c95551_20c5_4c4e_kps_rawanex", "table_test", map);
		tableRepository.updateData(connectionName, "keyspace_test_1", "championnat", map);

		cassandraRepository.closeConnectioncassandra(connectionName);
		}catch (Exception e) {
			e.printStackTrace();
		}

	}
	@Test
	public void testUpdateData2()  {
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss.SSS");
		try {
			System.out.println( dateFormat.parse(dateFormat.format(date)).getTime());
			System.out.println( System.currentTimeMillis());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
