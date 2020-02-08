package com.xoolibeut.gainde.cassandra.controller;

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

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
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

	@PostMapping("/{connectionName}/{kespace}")
	public ResponseEntity<String> createTable(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @RequestBody TableDTO tableDTO) {
		try {
			tableRepository.createTable(tableDTO, connectionName, keyspaceName);
			return ResponseEntity.status(201).body("{\"message\":\"création ok\"}");
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}
	@PutMapping("/{connectionName}/{kespace}")
	public ResponseEntity<String> updateTable(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @RequestBody CoupleTableDTO coupleTableDTO) {
		try {
			tableRepository.alterTable(coupleTableDTO.getOldTableDTO(),coupleTableDTO.getTableDTO(), connectionName, keyspaceName);
			return ResponseEntity.status(201).body("{\"message\":\"maj ok\"}");
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}
	@DeleteMapping("/{connectionName}/{kespace}/{tableName}")
	public ResponseEntity<String> dropTable(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName) {
		try {
			tableRepository.dropTable(connectionName, keyspaceName,tableName);
			return ResponseEntity.status(204).build();
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}
	@GetMapping("/all/{connectionName}/{kespace}/{tableName}")
	public ResponseEntity<String> getAllDataByTableName(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName) {
		try {
			JsonNode jsonNode = tableRepository.getAllDataByTableName(connectionName, keyspaceName, tableName);
			ObjectMapper mapper=new ObjectMapper();
			return ResponseEntity.status(200).body(mapper.writeValueAsString(jsonNode));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}
}		
