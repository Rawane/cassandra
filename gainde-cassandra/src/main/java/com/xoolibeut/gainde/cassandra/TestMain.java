package com.xoolibeut.gainde.cassandra;

import java.io.File;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.xoolibeut.gainde.cassandra.controller.dtos.ConnectionDTO;
import com.xoolibeut.gainde.cassandra.repository.ConnectionCassandraRepositoryImpl;
import com.xoolibeut.gainde.cassandra.repository.GaindeSessionConnection;
import com.xoolibeut.gainde.cassandra.repository.TableRepository;
import com.xoolibeut.gainde.cassandra.repository.TableRepositoryImpl;

public class TestMain {

	public static void main12(String[] args) {
		File tempDirectory = new File(System.getProperty("user.home"));
		System.out.println(tempDirectory.getAbsolutePath());
		ConnectionDTO connectionDTO = new ConnectionDTO("DMZ");
		connectionDTO.setIp("10.223.192.83");
		connectionDTO.setPort(9042);
		ConnectionCassandraRepositoryImpl cassandraRepositoryImpl = new ConnectionCassandraRepositoryImpl();
		try {
			cassandraRepositoryImpl.connnectTocassandra(connectionDTO);

			// List<GaindeMetadataDTO>
			// gaindeMetadataDTO=cassandraRepositoryImpl.getAllMetadatas("DMZ");

			// long count = cassandraRepositoryImpl.countAllRows("DMZ",
			// "xb415c59b_006d_4f39_825e_6efb0c9cce0a_group_2",
			// "api_portal_portalapplicationpermissionstore");

			JsonNode jsonNode = new TableRepositoryImpl().getAllDataByTableName("DMZ",
					"xb415c59b_006d_4f39_825e_6efb0c9cce0a_group_2", "api_portal_portalapplicationpermissionstore");
			GaindeSessionConnection.getInstance().closeGaindeSession("DMZ");
			System.out.println("----------------------GAINDE---------------------------------");
			// System.out.println("count "+count);
			ObjectMapper mapper = new ObjectMapper();

			System.out.println(mapper.writeValueAsString(jsonNode));

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static void main(String[] args) {
		String connectionName = "LOCAL";
		ConnectionCassandraRepositoryImpl cassandraRepository = new ConnectionCassandraRepositoryImpl();
		try {
			
			ConnectionDTO connectionDTO = new ConnectionDTO(connectionName);
			connectionDTO.setIp("127.0.0.1");
			connectionDTO.setPort(9042);
			
			cassandraRepository.connnectTocassandra(connectionDTO);
			
			testUpdateData();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				cassandraRepository.closeConnectioncassandra(connectionName);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public static void testUpdateData() throws Exception {
		TableRepository tableRepository = new TableRepositoryImpl();
		String connectionName = "LOCAL";
		
		ObjectMapper mapper = new ObjectMapper();
		ObjectNode map = mapper.createObjectNode();
		ObjectNode data = mapper.createObjectNode();
		ArrayNode primaryKeys = mapper.createArrayNode();
		map.set("primaryKeys", primaryKeys);
		map.set("data", data);
		primaryKeys.add("col1");
		/*ObjectNode columData = mapper.createObjectNode();
		columData.put("data", 145444);
		columData.put("type", "BIGINT");
		data.set("col3", columData);*/
		ObjectNode columData1 = mapper.createObjectNode();
		columData1.put("data", "2020-02-10");
		columData1.put("type", "DATE");
		data.set("date", columData1);
		
		ObjectNode columDataPr = mapper.createObjectNode();
		columDataPr.put("data", "zzazaza");
		columDataPr.put("type", "TEXT");
		data.set("col1", columDataPr);
		tableRepository.updateData(connectionName, "x48c95551_20c5_4c4e_kps_rawanex", "table_test", map);

		

	}
}
