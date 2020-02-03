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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xoolibeut.gainde.cassandra.controller.dtos.KeyspaceDTO;
import com.xoolibeut.gainde.cassandra.repository.KeyspaceRepository;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/keyspace")
public class KeyspaceController {
	private static final Logger LOGGER = LoggerFactory.getLogger(KeyspaceController.class);
	@Autowired
	private KeyspaceRepository keyspaceRepository;

	@PostMapping("/{connectionName}")
	public ResponseEntity<String> createKeyspace(@PathVariable("connectionName") String connectionName,
			@RequestBody KeyspaceDTO keyspaceDTO) {
		try {
			keyspaceRepository.createKeyspace(connectionName, keyspaceDTO);
			return ResponseEntity.status(201).body("{\"message\":\"création kesypace ok\"}");
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}

	@PutMapping("/{connectionName}")
	public ResponseEntity<String> alterKeyspace(@PathVariable("connectionName") String connectionName,
			@RequestBody KeyspaceDTO keyspaceDTO) {
		try {
			keyspaceRepository.alterKeyspace(connectionName, keyspaceDTO);
			return ResponseEntity.status(200).body("{\"message\":\"maj kesypace ok\"}");
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}

	@DeleteMapping("/{connectionName}/{keyspaceName}")
	public ResponseEntity<String> dropKeyspace(@PathVariable("connectionName") String connectionName,
			@PathVariable("keyspaceName") String keyspaceName) {
		try {
			keyspaceRepository.dropKeyspace(connectionName, keyspaceName);
			return ResponseEntity.status(204).build();
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}
	@GetMapping("/{connectionName}/{keyspaceName}")
	public ResponseEntity<String> getKeyspace(@PathVariable("connectionName") String connectionName,
			@PathVariable("keyspaceName") String keyspaceName) {
		try {
			KeyspaceDTO keyspaceDTO = keyspaceRepository.getKeyspace(connectionName, keyspaceName);
			ObjectMapper mapper=new ObjectMapper();
			return ResponseEntity.status(200).body(mapper.writeValueAsString(keyspaceDTO));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}
}
