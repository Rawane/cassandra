package com.xoolibeut.gainde.cassandra.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.xoolibeut.gainde.cassandra.controller.dtos.CoupleTableDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.TableDTO;
import com.xoolibeut.gainde.cassandra.repository.TableRepository;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/table")
public class TableController {
	private static final Logger LOGGER = LoggerFactory.getLogger(TableController.class);
	@Autowired
	private TableRepository tableRepository;

	@PostMapping("/query/{connectionName}/{kespace}")
	public ResponseEntity<String> executeQuery(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @RequestBody String query) {
		try {
			JsonNode jsonNode = tableRepository.executeQuery(connectionName, keyspaceName, query);
			ObjectMapper mapper = new ObjectMapper();			
			return ResponseEntity.status(200).body(mapper.writeValueAsString(jsonNode));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@PostMapping("/{connectionName}/{kespace}")
	public ResponseEntity<String> createTable(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @RequestBody TableDTO tableDTO) {
		try {
			tableRepository.createTable(tableDTO, connectionName, keyspaceName);
			return ResponseEntity.status(201).body(buildMessage("message", "création ok"));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@PutMapping("/{connectionName}/{kespace}")
	public ResponseEntity<String> updateTable(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @RequestBody CoupleTableDTO coupleTableDTO) {
		try {
			tableRepository.alterTable(coupleTableDTO.getOldTableDTO(), coupleTableDTO.getTableDTO(), connectionName,
					keyspaceName);
			return ResponseEntity.status(200).body(buildMessage("message", "maj ok"));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@DeleteMapping("/{connectionName}/{kespace}/{tableName}")
	public ResponseEntity<String> dropTable(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName) {
		try {
			tableRepository.dropTable(connectionName, keyspaceName, tableName);
			return ResponseEntity.status(204).build();
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@GetMapping("/all/{connectionName}/{kespace}/{tableName}")
	public ResponseEntity<String> getAllDataByTableName(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName) {
		try {
			JsonNode jsonNode = tableRepository.getAllDataByTableName(connectionName, keyspaceName, tableName);
			ObjectMapper mapper = new ObjectMapper();
			return ResponseEntity.status(200).body(mapper.writeValueAsString(jsonNode));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@GetMapping("/all/{connectionName}/{kespace}/{tableName}/{page}")
	public ResponseEntity<String> getAllDataByPaginate1(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName,
			@PathVariable("tableName") int page) {
		try {
			JsonNode jsonNode = tableRepository.getAllDataPaginateByPage1(connectionName, keyspaceName, tableName,
					page);
			ObjectMapper mapper = new ObjectMapper();
			return ResponseEntity.status(200).body(mapper.writeValueAsString(jsonNode));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@PostMapping("/all/{connectionName}/{kespace}/{tableName}/{page}")
	public ResponseEntity<String> getAllDataByPaginateX(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName,
			@PathVariable("tableName") int page, @RequestBody Map<String, Object> mapPrimaryKey) {
		try {
			JsonNode jsonNode = tableRepository.getAllDataPaginateByPageX(connectionName, keyspaceName, tableName, page,
					mapPrimaryKey);
			ObjectMapper mapper = new ObjectMapper();
			return ResponseEntity.status(200).body(mapper.writeValueAsString(jsonNode));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@PostMapping("/insert/{connectionName}/{kespace}/{tableName}")
	public ResponseEntity<String> insertDataTable(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName,
			@RequestBody JsonNode map) {
		try {
			tableRepository.insertData(connectionName, keyspaceName, tableName, map);
			return ResponseEntity.status(201).body(buildMessage("message", "insertion ok"));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@PostMapping("/delete/{connectionName}/{kespace}/{tableName}")
	public ResponseEntity<String> removeRowDataTable(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName,
			@RequestBody Map<String, Object> map) {
		try {
			tableRepository.removeRowData(connectionName, keyspaceName, tableName, map);
			return ResponseEntity.status(204).build();
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@DeleteMapping("/delete/all/{connectionName}/{kespace}/{tableName}")
	public ResponseEntity<String> removeAllDataTable(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName) {
		try {
			tableRepository.removeAllData(connectionName, keyspaceName, tableName);
			return ResponseEntity.status(204).build();
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@PutMapping("/update/{connectionName}/{kespace}/{tableName}")
	public ResponseEntity<String> updateDataTable(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName,
			@RequestBody JsonNode map) {
		try {
			tableRepository.updateData(connectionName, keyspaceName, tableName, map);
			return ResponseEntity.status(200).body(buildMessage("message", "maj ok"));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	private String buildMessage(String code, String message) {
		ObjectMapper mapper = new ObjectMapper();
		ObjectNode node = mapper.createObjectNode();
		try {
			node.put(code, message);
			return mapper.writeValueAsString(node);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return "";
	}

}
