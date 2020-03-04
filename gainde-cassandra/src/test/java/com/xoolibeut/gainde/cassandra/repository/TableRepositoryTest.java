package com.xoolibeut.gainde.cassandra.repository;

import static org.junit.Assert.fail;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.datastax.driver.core.DataType;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.schemabuilder.SchemaBuilder;
import com.datastax.driver.core.schemabuilder.SchemaStatement;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.xoolibeut.gainde.cassandra.controller.dtos.ColonneTableDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.ConnectionDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.Pagination;
import com.xoolibeut.gainde.cassandra.controller.dtos.TableDTO;

@RunWith(SpringRunner.class)
@SpringBootTest
@Ignore
public class TableRepositoryTest {
	private static final Logger LOGGER = LoggerFactory.getLogger(TableRepositoryTest.class);
	@Autowired
	private TableRepository tableRepository;
	@Autowired
	private ConnectionCassandraRepository cassandraRepository;

	// @Before
	public void setUp() {
		String connectionName = "LOCAL";
		ConnectionDTO connectionDTO = new ConnectionDTO(connectionName);
		connectionDTO.setIp("127.0.0.1");
		connectionDTO.setPort(9042);		
		try {
			cassandraRepository.connnectTocassandra(connectionDTO);
		} catch (Exception e) {			
			e.printStackTrace();
		}
	}

	// @After
	public void closeConnection() {
		try {
			cassandraRepository.closeConnectioncassandra("LOCAL");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testUpdateData() {
		try {
			String connectionName = "LOCAL";
			ObjectMapper mapper = new ObjectMapper();
			ObjectNode map = mapper.createObjectNode();
			ObjectNode data = mapper.createObjectNode();
			ArrayNode primaryKeys = mapper.createArrayNode();
			map.set("primaryKeys", primaryKeys);
			map.set("data", data);
			primaryKeys.add("id");
			ObjectNode columData1 = mapper.createObjectNode();

			columData1.put("data", Calendar.getInstance().getTimeInMillis());
			columData1.put("type", "TIME");
			data.set("col_time", columData1);

			ObjectNode columDataPr = mapper.createObjectNode();
			columDataPr.put("data", "zzazaza");
			columDataPr.put("type", "TEXT");
			data.set("id", columDataPr);
			TableDTO tableDTO = new TableDTO();
			TableDTO oldTableDTO = new TableDTO();
			// tableRepository.updateData(connectionName, "x48c95551_20c5_4c4e_kps_rawanex",
			// "personne", map);
			// tableRepository.updateData(connectionName, "keyspace_test_1", "championnat",
			// map);
			oldTableDTO.setPrimaryKey(new ArrayList<String>());
			oldTableDTO.getPrimaryKey().add("col_pr");
			ColonneTableDTO dto = new ColonneTableDTO();
			dto.setName("col1");
			dto.setType("10");
			oldTableDTO.getColumns().add(dto);
			ColonneTableDTO dto1 = new ColonneTableDTO();
			dto1.setName("col_pr");
			dto1.setType("10");
			dto1.setPartitionKey(true);
			oldTableDTO.getColumns().add(dto1);

			tableDTO.setPrimaryKey(new ArrayList<String>());
			tableDTO.getPrimaryKey().add("col_pr");
			ColonneTableDTO dto4 = new ColonneTableDTO();
			dto4.setName("col4");
			dto4.setType("10");
			tableDTO.getColumns().add(dto4);
			ColonneTableDTO dto3 = new ColonneTableDTO();
			dto3.setName("col_pr");
			dto3.setType("10");
			dto3.setPartitionKey(true);
			tableDTO.getColumns().add(dto3);

			oldTableDTO.setName("test_table");
			tableDTO.setName("test_table");
			tableRepository.alterTable(oldTableDTO, tableDTO, connectionName, "keyspace_test_1");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Test
	public void testRenameColumn() {
		Session session = GaindeSessionConnection.getInstance().getSession("LOCAL");
		if (session == null) {
			throw new RuntimeException("aucune session");
		}
		LOGGER.info("start testRenameColumn");
		SchemaStatement schema = SchemaBuilder.alterTable("x48c95551_20c5_4c4e_kps_rawanex", "matiere")
				.renameColumn("description").to("desc2");
		LOGGER.info("schéma " + schema);
		session.execute(schema);
		LOGGER.info("end testRenameColumn");
	}

	@Test
	public void testAlterType() {
		Session session = GaindeSessionConnection.getInstance().getSession("LOCAL");
		if (session == null) {
			throw new RuntimeException("aucune session");
		}
		LOGGER.info("start testAlterType");
		SchemaStatement schema = SchemaBuilder.alterTable("x48c95551_20c5_4c4e_kps_rawanex", "matiere")
				.alterColumn("nom1").type(DataType.blob());
		LOGGER.info("query " + schema);
		session.execute(schema);
		LOGGER.info("end testAlterType");
	}

	@Test
	public void testInsertData() {
		LOGGER.info("start testInsertData");

		try {
			for (int i = 1; i < 2000; i++) {
				ObjectMapper mapper = new ObjectMapper();
				ObjectNode map = mapper.createObjectNode();
				ObjectNode data = mapper.createObjectNode();
				ObjectNode columData = mapper.createObjectNode();
				map.set("data", data);
				String uuid = UUID.randomUUID().toString();
				columData.put("data", "GAYE " + i + uuid.substring(0, 4));
				columData.put("type", "TEXT");
				data.set("nom", columData);

				columData = mapper.createObjectNode();
				columData.put("data",
						Math.random() > 0.5 ? "Maguiba" + uuid.substring(4, 8) : "Iba" + uuid.substring(4, 8));
				columData.put("type", "TEXT");
				data.set("prenom", columData);
				columData = mapper.createObjectNode();
				columData.put("data", "Francis" + uuid.substring(4, 8));
				columData.put("type", "12/08/1988");
				data.set("date_naissance", columData);
				columData = mapper.createObjectNode();
				columData.put("data", Math.random() > 0.5 ? "M" : "F");
				columData.put("type", "12/08/1988");
				data.set("sexe", columData);
				tableRepository.insertData("LOCAL", "x48c95551_20c5_4c4e_kps_rawanex", "aa_personne", map);
			}
		} catch (Exception e) {

			e.printStackTrace();
		}

	}
	@Test
	public void testgetAllPaginateSaut() {
		LOGGER.info("start testgetAllPaginate");

		try {
			setUp();
			ObjectMapper mapper = new ObjectMapper();
			Pagination pagination = new Pagination();
			pagination.setPageNum(1);
			pagination.setPageSize(3);
			List<String> personnes=new ArrayList<String>();
			JsonNode jsonNode = tableRepository.getAllDataPaginateByPage("LOCAL", "x48c95551_20c5_4c4e_kps_rawanex",
					"personne",null, pagination);
			ArrayNode array=(ArrayNode) jsonNode.get("data");
			array.forEach(node->{
				personnes.add(node.get("name").asText());
			});
			LOGGER.info("----------------------------------------------------------------------------------------");
			LOGGER.info(mapper.writeValueAsString(jsonNode));
			pagination = mapper.treeToValue(jsonNode.get("pagination"), Pagination.class);			
			pagination.setPageNum(8);
			jsonNode = tableRepository.getAllDataPaginateByPage("LOCAL", "x48c95551_20c5_4c4e_kps_rawanex",
					"personne",null, pagination);
			LOGGER.info(mapper.writeValueAsString(jsonNode));
			 array=(ArrayNode) jsonNode.get("data");
				array.forEach(node->{
					personnes.add(node.get("name").asText());
				});
			LOGGER.info("----------------------------------------------------------------------------------------");
			personnes.forEach(System.out::println);
			LOGGER.info("----------------------------------------------------------------------------------------");
			
			closeConnection();
		} catch (Exception e) {

			e.printStackTrace();
		}

	}
	@Test
	public void testgetAllPaginate() {
		LOGGER.info("start testgetAllPaginate");

		try {
			setUp();
			ObjectMapper mapper = new ObjectMapper();
			Pagination pagination = new Pagination();
			pagination.setPageNum(1);
			pagination.setPageSize(3);
			List<String> personnes=new ArrayList<String>();
			JsonNode jsonNode = tableRepository.getAllDataPaginateByPage("LOCAL", "x48c95551_20c5_4c4e_kps_rawanex",
					"personne",null, pagination);
			ArrayNode array=(ArrayNode) jsonNode.get("data");
			array.forEach(node->{
				personnes.add(node.get("name").asText());
			});
			LOGGER.info("----------------------------------------------------------------------------------------");
			LOGGER.info(mapper.writeValueAsString(jsonNode));
			pagination = mapper.treeToValue(jsonNode.get("pagination"), Pagination.class);
			pagination.setPageNum(2);
			jsonNode = tableRepository.getAllDataPaginateByPage("LOCAL", "x48c95551_20c5_4c4e_kps_rawanex",
					"personne",null, pagination);
			LOGGER.info(mapper.writeValueAsString(jsonNode));
			 array=(ArrayNode) jsonNode.get("data");
			array.forEach(node->{
				personnes.add(node.get("name").asText());
			});
			pagination.setPageNum(3);
			jsonNode = tableRepository.getAllDataPaginateByPage("LOCAL", "x48c95551_20c5_4c4e_kps_rawanex",
					"personne",null, pagination);
			LOGGER.info(mapper.writeValueAsString(jsonNode));
			 array=(ArrayNode) jsonNode.get("data");
			array.forEach(node->{
				personnes.add(node.get("name").asText());
			});
			pagination.setPageNum(4);
			jsonNode = tableRepository.getAllDataPaginateByPage("LOCAL", "x48c95551_20c5_4c4e_kps_rawanex",
					"personne",null, pagination);
			LOGGER.info(mapper.writeValueAsString(jsonNode));
			 array=(ArrayNode) jsonNode.get("data");
				array.forEach(node->{
					personnes.add(node.get("name").asText());
				});
			LOGGER.info("----------------------------------------------------------------------------------------");
			personnes.forEach(System.out::println);
			LOGGER.info("----------------------------------------------------------------------------------------");
			
			closeConnection();
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	@Test
	public void testCreateTable() {
		try {
			TableDTO tableDTO = new TableDTO();
			tableDTO.setName("ww_table_" + (int) (Math.random() * 5000));
			ColonneTableDTO column = new ColonneTableDTO();
			column.setName("col_pr_" + (int) (Math.random() * 200));
			column.setPartitionKey(true);
			column.setType("10");
			tableDTO.getColumns().add(column);

			column = new ColonneTableDTO();
			column.setName("col_second_pr" + (int) (Math.random() * 500));
			column.setClusteredColumn(true);
			column.setType("10");
			tableDTO.getColumns().add(column);

			column = new ColonneTableDTO();
			column.setName("col_simple" + (int) (Math.random() * 500));
			column.setPartitionKey(false);
			column.setType("10");
			tableDTO.getColumns().add(column);
			tableRepository.createTable(tableDTO, "LOCAL", "x48c95551_20c5_4c4e_kps_rawanex");
		} catch (Exception e) {
			e.printStackTrace();
			fail("Exception non attendu");
		}
	}

	@Test
	public void testCreateTableClustering() {
		try {
			TableDTO tableDTO = new TableDTO();
			tableDTO.setName("cc_table_" + (int) (Math.random() * 5000));
			ColonneTableDTO column = new ColonneTableDTO();
			column.setName("col_pr_" + (int) (Math.random() * 200));
			column.setPartitionKey(true);
			column.setType("10");
			tableDTO.getColumns().add(column);

			column = new ColonneTableDTO();
			column.setName("col_second_pr" + (int) (Math.random() * 500));
			column.setPartitionKey(true);
			column.setType("10");
			tableDTO.getColumns().add(column);

			column = new ColonneTableDTO();
			column.setName("col_third_pr" + (int) (Math.random() * 500));
			column.setPartitionKey(true);
			column.setType("10");
			tableDTO.getColumns().add(column);

			column = new ColonneTableDTO();
			column.setName("col_simple" + (int) (Math.random() * 500));
			column.setPartitionKey(false);
			column.setType("10");
			tableDTO.getColumns().add(column);
			tableRepository.createTable(tableDTO, "LOCAL", "x48c95551_20c5_4c4e_kps_rawanex");
		} catch (Exception e) {
			e.printStackTrace();
			fail("Exception non attendu");
		}
	}

	@Test
	public void testDropTable() {
		try {
			tableRepository.dropTable("LOCAL", "x48c95551_20c5_4c4e_kps_rawanex", "aa_table_");
		} catch (Exception e) {
			e.printStackTrace();
			fail("Exception non attendu");
		}
	}

	@Test
	public void testGetTableInfo() {
		try {
			cassandraRepository.getTableInfo("LOCAL", "x48c95551_20c5_4c4e_kps_rawanex", "ww_table_2178");
		} catch (Exception e) {
			e.printStackTrace();
			fail("Exception non attendu");
		}
	}

	@Test
	public void testMethode() {
		String query = "Select * from       personne  ";
		String[] arrayQuery = query.split(" ");
		System.out.println(arrayQuery.length);
		List<String> listQuery = new ArrayList<String>();
		for (int i = 0; i < arrayQuery.length; i++) {
			String item = arrayQuery[i].trim();
			System.out.println("@@@" + item + "@@@");
			if (!item.isEmpty()) {
				listQuery.add(item);
			}
		}
		System.out.println(listQuery.size());
		System.out.println("-------------------------");
		for (int i = 0; i < listQuery.size(); i++) {
			listQuery.set(i, listQuery.get(i).trim());
			System.out.println("@@@" + listQuery.get(i) + "@@@" + listQuery.get(i).length());
		}
		System.out.println(String.join(" ", listQuery));

	}
}
