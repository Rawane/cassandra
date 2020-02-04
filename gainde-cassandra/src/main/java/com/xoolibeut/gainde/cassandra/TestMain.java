package com.xoolibeut.gainde.cassandra;

import java.io.File;
import java.util.List;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xoolibeut.gainde.cassandra.controller.dtos.ConnectionDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.GaindeMetadataDTO;
import com.xoolibeut.gainde.cassandra.repository.ConnectionCassandraRepositoryImpl;
import com.xoolibeut.gainde.cassandra.repository.GaindeSessionConnection;
import com.xoolibeut.gainde.cassandra.repository.TableRepositoryImpl;

public class TestMain {

	public static void main(String[] args) {
		File tempDirectory = new File(System.getProperty("user.home"));
		System.out.println(tempDirectory.getAbsolutePath());
		ConnectionDTO connectionDTO = new ConnectionDTO("DMZ");
		connectionDTO.setIp("10.223.192.83");
		connectionDTO.setPort(9042);
		ConnectionCassandraRepositoryImpl cassandraRepositoryImpl = new ConnectionCassandraRepositoryImpl();
		try {
			cassandraRepositoryImpl.connnectTocassandra(connectionDTO);
			
			//List<GaindeMetadataDTO> gaindeMetadataDTO=cassandraRepositoryImpl.getAllMetadatas("DMZ");
			
			//long count = cassandraRepositoryImpl.countAllRows("DMZ", "xb415c59b_006d_4f39_825e_6efb0c9cce0a_group_2", "api_portal_portalapplicationpermissionstore");
			
			JsonNode jsonNode = new TableRepositoryImpl().getAllDataByTableName("DMZ", "xb415c59b_006d_4f39_825e_6efb0c9cce0a_group_2", "api_portal_portalapplicationpermissionstore");
			GaindeSessionConnection.getInstance().closeGaindeSession("DMZ");
			System.out.println("----------------------GAINDE---------------------------------");
			//System.out.println("count      "+count);
			ObjectMapper mapper=new ObjectMapper();
			
			
			System.out.println(mapper.writeValueAsString(jsonNode));

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
