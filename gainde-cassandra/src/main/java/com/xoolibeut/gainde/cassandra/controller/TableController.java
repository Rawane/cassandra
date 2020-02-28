package com.xoolibeut.gainde.cassandra.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
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
import com.xoolibeut.gainde.cassandra.controller.dtos.Pagination;
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

	@GetMapping("/list/{connectionName}/{kespace}/{tableName}/{total}/{pageSate}/{pageNumSate}/{pageSize}/{pageNum}")
	public ResponseEntity<String> getAllDataByPaginate(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName,@PathVariable("total") Long total,
			@PathVariable("pageSate") String pageSate, @PathVariable("pageNumSate") Integer pageNumSate,
			@PathVariable("pageSize") Integer pageSize, @PathVariable("pageNum") Integer pageNum) {
		try {
			Pagination pagination = new Pagination();
			pagination.setPageSate(pageSate);
			pagination.setPageNum(pageNum);
			pagination.setPageSize(pageSize);
			pagination.setPageNumSate(pageNumSate);
			pagination.setTotal(total);
			
			JsonNode jsonNode = tableRepository.getAllDataPaginateByPage(connectionName, keyspaceName, tableName,null,
					pagination);
			ObjectMapper mapper = new ObjectMapper();
			LOGGER.debug(" Pagination "+mapper.writeValueAsString(pagination));
			LOGGER.debug(" Resultat  "+mapper.writeValueAsString(jsonNode));
			return ResponseEntity.status(200).body(mapper.writeValueAsString(jsonNode));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@GetMapping("/list/{connectionName}/{kespace}/{tableName}/{pageNumSate}/{pageSize}/{pageNum}")
	public ResponseEntity<String> getAllDataByPaginateInitial(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName,
			@PathVariable("pageNumSate") Integer pageNumSate, @PathVariable("pageSize") Integer pageSize,
			@PathVariable("pageNum") Integer pageNum) {
		try {
			Pagination pagination = new Pagination();
			pagination.setPageNum(pageNum);
			pagination.setPageSize(pageSize);
			pagination.setPageNumSate(pageNumSate);
			JsonNode jsonNode = tableRepository.getAllDataPaginateByPage(connectionName, keyspaceName, tableName,null,
					pagination);
			ObjectMapper mapper = new ObjectMapper();
			return ResponseEntity.status(200).body(mapper.writeValueAsString(jsonNode));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}
	@PostMapping("/list/{connectionName}/{kespace}/{tableName}/{total}/{pageSate}/{pageNumSate}/{pageSize}/{pageNum}")
	public ResponseEntity<String> getAllDataByPaginateWhereQuery(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName,@PathVariable("total") Long total,
			@PathVariable("pageSate") String pageSate, @PathVariable("pageNumSate") Integer pageNumSate,
			@PathVariable("pageSize") Integer pageSize, @PathVariable("pageNum") Integer pageNum,@RequestBody Map<String,String> map) {
		try {
			Pagination pagination = new Pagination();
			pagination.setPageSate(pageSate);
			pagination.setPageNum(pageNum);
			pagination.setPageSize(pageSize);
			pagination.setPageNumSate(pageNumSate);
			pagination.setTotal(total);
			
			JsonNode jsonNode = tableRepository.getAllDataPaginateByPage(connectionName, keyspaceName, tableName,map,
					pagination);
			ObjectMapper mapper = new ObjectMapper();
			LOGGER.debug(" Pagination "+mapper.writeValueAsString(pagination));
			LOGGER.debug(" Resultat  "+mapper.writeValueAsString(jsonNode));
			return ResponseEntity.status(200).body(mapper.writeValueAsString(jsonNode));
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).body(buildMessage("error", ioException.getMessage()));
		}
	}

	@PostMapping("/list/{connectionName}/{kespace}/{tableName}/{pageNumSate}/{pageSize}/{pageNum}")
	public ResponseEntity<String> getAllDataByPaginateInitialWhereQuery(@PathVariable("connectionName") String connectionName,
			@PathVariable("kespace") String keyspaceName, @PathVariable("tableName") String tableName,
			@PathVariable("pageNumSate") Integer pageNumSate, @PathVariable("pageSize") Integer pageSize,
			@PathVariable("pageNum") Integer pageNum,@RequestBody Map<String,String> map) {
		try {
			Pagination pagination = new Pagination();
			pagination.setPageNum(pageNum);
			pagination.setPageSize(pageSize);
			pagination.setPageNumSate(pageNumSate);
			JsonNode jsonNode = tableRepository.getAllDataPaginateByPage(connectionName, keyspaceName, tableName,map,
					pagination);
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
	@GetMapping("/dump/schema/{connectionName}/{keyspaceName}/{tableName}")
	public ResponseEntity<Resource> dumpTableSchema(@PathVariable("connectionName") String connectionName,
			@PathVariable("keyspaceName") String keyspaceName, @PathVariable("tableName") String tableName) {
		try {
			String exportSchema = tableRepository.dumpTableSchema(connectionName, keyspaceName, tableName);
			ByteArrayResource resource = new ByteArrayResource(exportSchema.getBytes());
			LOGGER.debug("exportSchema " + exportSchema);
			return ResponseEntity.status(200).contentLength(exportSchema.length())
					.contentType(MediaType.parseMediaType("application/octet-stream")).body(resource);
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).build();
		}
	}

	@GetMapping("/dump/all/{connectionName}/{keyspaceName}/{tableName}")
	public ResponseEntity<Resource> dumpTableWithData(@PathVariable("connectionName") String connectionName,
			@PathVariable("keyspaceName") String keyspaceName, @PathVariable("tableName") String tableName) {
		try {
			String exportSchema = tableRepository.dumpTableWithData(connectionName, keyspaceName, tableName);
			LOGGER.debug("exportSchema " + exportSchema);
			ByteArrayResource resource = new ByteArrayResource(exportSchema.getBytes());
			return ResponseEntity.status(200).contentLength(exportSchema.length())
					.contentType(MediaType.parseMediaType("application/octet-stream")).body(resource);
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).build();
		}
	}
	@GetMapping("/dump/data/{connectionName}/{keyspaceName}/{tableName}")
	public ResponseEntity<Resource> dumpOnlyDataFromTable(@PathVariable("connectionName") String connectionName,
			@PathVariable("keyspaceName") String keyspaceName, @PathVariable("tableName") String tableName) {
		try {
			String exportSchema = tableRepository.dumpOnlyDataFromTable(connectionName, keyspaceName, tableName);
			LOGGER.debug("exportSchema " + exportSchema);
			ByteArrayResource resource = new ByteArrayResource(exportSchema.getBytes());
			return ResponseEntity.status(200).contentLength(exportSchema.length())
					.contentType(MediaType.parseMediaType("application/octet-stream")).body(resource);
		} catch (Exception ioException) {
			LOGGER.error("erreur", ioException);
			return ResponseEntity.status(400).build();
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
