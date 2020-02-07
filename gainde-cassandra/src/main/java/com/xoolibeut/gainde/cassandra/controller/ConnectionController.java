package com.xoolibeut.gainde.cassandra.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xoolibeut.gainde.cassandra.controller.dtos.ColonneTableDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.ConnectionDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.GaindeMetadataDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.TableInfoDTO;
import com.xoolibeut.gainde.cassandra.repository.ConnectionCassandraRepository;
import com.xoolibeut.gainde.cassandra.repository.ConnectionRepository;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/connection")
public class ConnectionController {
	private static final Logger LOGGER = LoggerFactory.getLogger(ConnectionController.class);
	@Autowired
	private ConnectionRepository connectionRepository;
	@Autowired
	private ConnectionCassandraRepository cassandraRepository;

	@PostMapping
	public ResponseEntity<String> createConnection(@RequestBody ConnectionDTO connectionDTO) {
		try {
			boolean result = connectionRepository.createConnection(connectionDTO);
			if (result) {
				return ResponseEntity.status(201).body("{\"message\":\"create\"}");
			}
			return ResponseEntity.status(401).body("{\"message\":\"création ko\"}");
		} catch (IOException ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}

	@PutMapping
	public ResponseEntity<String> updateConnection(@RequestBody ConnectionDTO connectionDTO) {
		try {
			boolean result = connectionRepository.updateConnection(connectionDTO);
			if (result) {
				cassandraRepository.closeConnectioncassandra(connectionDTO.getName());
				return ResponseEntity.status(200).body("{\"message\":\"maj\"}");
			}
			return ResponseEntity.status(401).body("{\"message\":\"maj ko\"}");
		} catch (Exception exception) {
			LOGGER.error("erreur", exception);
			return ResponseEntity.status(400).body("{\"error\":\"" + exception.getMessage() + "\"}");
		}
	}

	@DeleteMapping("/{name}")
	public ResponseEntity<String> deleteConnection(@PathVariable("name") String name) {
		try {
			boolean result = connectionRepository.removeConnection(new ConnectionDTO(name));
			if (result) {
				return ResponseEntity.status(201).body("{\"message\":\"supprimé\"}");
			}
			return ResponseEntity.status(401).body("{\"message\":\"suppression ko\"}");

		} catch (IOException ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}

	@GetMapping("/all")
	public ResponseEntity<String> listConnections() {
		try {
			List<ConnectionDTO> list = connectionRepository.readlAllConnections();
			ObjectMapper mapper = new ObjectMapper();
			return ResponseEntity.status(200).body(mapper.writeValueAsString(list));
		} catch (IOException ioException) {
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}

	@PostMapping("/connecto")
	public ResponseEntity<String> connectTocassandra(@RequestBody ConnectionDTO connectionDTO) {
		try {
			/*
			 * if (connectionRepository.getConnection(connectionDTO.getName()) == null) {
			 * connectionRepository.createConnection(connectionDTO); } else {
			 * connectionRepository.updateConnection(connectionDTO); }
			 */
			if (connectionDTO == null || connectionDTO.getName() == null || connectionDTO.getName().contains("#")) {
				throw new Exception("Information connection incorrecte ");
			}
			if (connectionDTO.getName().contains("#")) {
				throw new Exception("Le caractère # est réservé,veuillez modifier le nom de votre connection ");
			}
			cassandraRepository.connnectTocassandra(connectionDTO);
			return ResponseEntity.status(200).build();
		} catch (Exception ioException) {
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}

	@GetMapping("/metadata/all/{connectionName}")
	public ResponseEntity<String> connectTocassandra(@PathVariable("connectionName") String connectionName) {
		try {
			List<GaindeMetadataDTO> listGainde = cassandraRepository.getAllMetadatas(connectionName);
			ObjectMapper mapper = new ObjectMapper();
			return ResponseEntity.status(200).body(mapper.writeValueAsString(listGainde));
		} catch (Exception ioException) {
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}

	@GetMapping("/metadata/columns/{name}/{keysp}/{table}")
	public ResponseEntity<String> getAllColumns(@PathVariable("name") String connectionName,
			@PathVariable("keysp") String keyspaceName, @PathVariable("table") String tableName) {
		try {
			List<ColonneTableDTO> colonneTableDTOs = cassandraRepository.getAllColumns(connectionName, keyspaceName,
					tableName);
			ObjectMapper mapper = new ObjectMapper();
			return ResponseEntity.status(200).body(mapper.writeValueAsString(colonneTableDTOs));
		} catch (Exception ioException) {
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}

	@GetMapping("/metadata/table/{name}/{keysp}/{table}")
	public ResponseEntity<String> getTableInfo(@PathVariable("name") String connectionName,
			@PathVariable("keysp") String keyspaceName, @PathVariable("table") String tableName) {
		try {
			TableInfoDTO tableInfo = cassandraRepository.getTableInfo(connectionName, keyspaceName, tableName);
			long rows = cassandraRepository.countAllRows(connectionName, keyspaceName, tableName);
			List<ColonneTableDTO> colonneTableDTOs = cassandraRepository.getAllColumns(connectionName, keyspaceName,
					tableName);
			tableInfo.setColumns(colonneTableDTOs);
			tableInfo.setRows(rows);
			ObjectMapper mapper = new ObjectMapper();
			return ResponseEntity.status(200).body(mapper.writeValueAsString(tableInfo));
		} catch (Exception ioException) {
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}
	@GetMapping("/metadata/table/type/{name}/{keysp}/{table}")
	public ResponseEntity<String> getTableInfoTypeNative(@PathVariable("name") String connectionName,
			@PathVariable("keysp") String keyspaceName, @PathVariable("table") String tableName) {
		try {
			TableInfoDTO tableInfo = cassandraRepository.getTableInfo(connectionName, keyspaceName, tableName);
			long rows = cassandraRepository.countAllRows(connectionName, keyspaceName, tableName);
			List<ColonneTableDTO> colonneTableDTOs = cassandraRepository.getAllColumnsTypeNative(connectionName, keyspaceName,
					tableName);
			tableInfo.setColumns(colonneTableDTOs);
			tableInfo.setRows(rows);
			ObjectMapper mapper = new ObjectMapper();
			return ResponseEntity.status(200).body(mapper.writeValueAsString(tableInfo));
		} catch (Exception ioException) {
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}

	@GetMapping("/table/rows/{name}/{keysp}/{table}")
	public ResponseEntity<String> countAllrows(@PathVariable("name") String connectionName,
			@PathVariable("keysp") String keyspaceName, @PathVariable("table") String tableName) {
		try {
			long rows = cassandraRepository.countAllRows(connectionName, keyspaceName, tableName);
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Long> mapRowCount = new HashMap<>();
			mapRowCount.put("rows", rows);
			return ResponseEntity.status(200).body(mapper.writeValueAsString(mapRowCount));
		} catch (Exception ioException) {
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}

	@GetMapping("/close/{name}")
	public ResponseEntity<String> closeConnection(@PathVariable("name") String connectionName) {
		try {
			cassandraRepository.closeConnectioncassandra(connectionName);

			return ResponseEntity.status(200).build();
		} catch (Exception ioException) {
			return ResponseEntity.status(400).body("{\"error\":\"" + ioException.getMessage() + "\"}");
		}
	}
}
