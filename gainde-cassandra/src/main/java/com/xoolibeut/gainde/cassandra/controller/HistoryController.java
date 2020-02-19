package com.xoolibeut.gainde.cassandra.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.xoolibeut.gainde.cassandra.controller.dtos.HistoryDTO;
import com.xoolibeut.gainde.cassandra.repository.HistoryRepository;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/history")
public class HistoryController {
	private static final Logger LOGGER = LoggerFactory.getLogger(HistoryController.class);
	@Autowired
	private HistoryRepository historyRepository;

	@PostMapping
	public ResponseEntity<String> createHistory(@RequestBody HistoryDTO historyDTO) {
		try {
			boolean result = historyRepository.createOrUpdateHistory(historyDTO);
			if (result) {
				return ResponseEntity.status(201).body(buildMessage("message", "create"));
			}
			return ResponseEntity.status(201).body(buildMessage("message", "creation ko"));
		} catch (IOException | NoSuchAlgorithmException ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}
	@DeleteMapping("/{id}")
	public ResponseEntity<String> deleteHistory(@PathVariable("id") String id) {
		try {
			historyRepository.removeHistory(id);			
			return ResponseEntity.status(204).build();
		} catch (IOException ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@GetMapping("/all")
	public ResponseEntity<String> listHistories() {
		try {
			List<HistoryDTO> list = historyRepository.readlAllhystories();
			ObjectMapper mapper = new ObjectMapper();
			return ResponseEntity.status(200).body(mapper.writeValueAsString(list));
		} catch (IOException ioException) {
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
