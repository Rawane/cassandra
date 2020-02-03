package com.xoolibeut.gainde.cassandra.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.xoolibeut.gainde.cassandra.controller.dtos.TableDTO;
import com.xoolibeut.gainde.cassandra.repository.TableRepository;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/table")
public class TableController {
	private static final Logger LOGGER = LoggerFactory.getLogger(TableController.class);
	@Autowired
	private TableRepository tableRepository;

	@PostMapping("/create/{connectionName}/{kespace}")
	public ResponseEntity<String> createConnection(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @RequestBody TableDTO tableDTO) {
		try {
			tableRepository.createTable(tableDTO, connectionName, keyspaceName);
			return ResponseEntity.status(201).body("{\"message\":\"création ok\"}");
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}
}
