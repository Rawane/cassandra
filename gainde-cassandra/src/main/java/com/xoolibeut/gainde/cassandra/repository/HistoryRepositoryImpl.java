package com.xoolibeut.gainde.cassandra.repository;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.xoolibeut.gainde.cassandra.controller.dtos.HistoryDTO;
import com.xoolibeut.gainde.cassandra.util.GaindeFileUtil;

@Repository
@PropertySource("classpath:gainde.properties")
public class HistoryRepositoryImpl implements HistoryRepository {
	private static final Logger LOGGER = LoggerFactory.getLogger(HistoryRepositoryImpl.class);
	@Value("${xoolibeut.gainde.connection.folder}")
	private String folderHistory;

	public boolean createOrUpdateHistory(HistoryDTO historyDTO) throws IOException, NoSuchAlgorithmException {
		LOGGER.info("createHistory History à créé dans le fichier " + folderHistory);

		if (historyDTO != null && historyDTO.getQuery() != null && !historyDTO.getQuery().isEmpty()) {
			Calendar cal = Calendar.getInstance();
			historyDTO.setDate(cal.getTime());
			historyDTO.setCount(1);
			MessageDigest messageDigest = MessageDigest.getInstance("MD5");
			messageDigest.update((historyDTO.getQuery()+historyDTO.getConnectionName()).getBytes());
			byte[] idByte = messageDigest.digest();
			historyDTO.setId(new String(toHexString(idByte)));
			LOGGER.debug("createHistory History à créé dans le fichier " + historyDTO.toString());
			String contentGainde = GaindeFileUtil.readeGaindeHistory(folderHistory);
			ObjectMapper mapper = new ObjectMapper();
			ObjectNode rootNode;
			ArrayNode arrayNode;
			if (contentGainde != null && !contentGainde.isEmpty()) {
				rootNode = (ObjectNode) mapper.readTree(contentGainde);
				arrayNode = (ArrayNode) rootNode.get("histories");

			} else {
				rootNode = mapper.createObjectNode();
				arrayNode = mapper.createArrayNode();
			}
			for (int i = 0; i < arrayNode.size(); i++) {
				HistoryDTO historyTemp = mapper.convertValue(arrayNode.get(i), HistoryDTO.class);
				if (historyTemp.getId().equals(historyDTO.getId())) {
					historyDTO.setCount(historyTemp.getCount() + 1);
					arrayNode.remove(i);
					arrayNode.add(mapper.valueToTree(historyDTO));
					rootNode.set("histories", arrayNode);
					GaindeFileUtil.writeGaindeHistoryAndClose(folderHistory, mapper.writeValueAsString(rootNode));
					return false;
				}
			}

			arrayNode.add(mapper.valueToTree(historyDTO));
			rootNode.set("histories", arrayNode);
			GaindeFileUtil.writeGaindeHistoryAndClose(folderHistory, mapper.writeValueAsString(rootNode));
		} else {
			return false;
		}
		return true;
	}

	public boolean removeHistory(String id) throws IOException {
		LOGGER.info("createHistory History à créé dans le fichier " + folderHistory);
		if (id != null && !id.isEmpty()) {
			LOGGER.debug("Supression History  " + id);
			String contentGainde = GaindeFileUtil.readeGaindeHistory(folderHistory);
			ObjectMapper mapper = new ObjectMapper();
			ObjectNode rootNode;
			ArrayNode arrayNode;
			if (contentGainde != null && !contentGainde.isEmpty()) {
				rootNode = (ObjectNode) mapper.readTree(contentGainde);
				arrayNode = (ArrayNode) rootNode.get("histories");
				for (int i = 0; i < arrayNode.size(); i++) {
					HistoryDTO historyTemp = mapper.convertValue(arrayNode.get(i), HistoryDTO.class);
					if (historyTemp.getId().equals(id)) {
						arrayNode.remove(i);
						GaindeFileUtil.writeGaindeHistoryAndClose(folderHistory, mapper.writeValueAsString(rootNode));
						return true;
					}
				}

			}
		}
		return false;
	}

	public List<HistoryDTO> readlAllHystories() throws IOException {
		LOGGER.info("readlAllHystories History ");
		List<HistoryDTO> histories = new ArrayList<>();
		String contentGainde = GaindeFileUtil.readeGaindeHistory(folderHistory);
		if (contentGainde != null && !contentGainde.isEmpty()) {
			ObjectMapper mapper = new ObjectMapper();
			ObjectNode rootNode = (ObjectNode) mapper.readTree(contentGainde);
			if (rootNode != null) {
				ArrayNode arrayNode = (ArrayNode) rootNode.get("histories");
				arrayNode.forEach(jsonNode -> {
					histories.add(mapper.convertValue(jsonNode, HistoryDTO.class));
				});
			}
		}
		histories.sort((date1, date2) -> date2.getDate().compareTo(date1.getDate()));
		return histories;
	}

	public List<HistoryDTO> listHystoriesByConnection(String connectionName) throws IOException {
		LOGGER.info("listHystoriesByConnection History ");
		List<HistoryDTO> histories = new ArrayList<>();
		if (connectionName != null && !connectionName.isEmpty()) {
			String contentGainde = GaindeFileUtil.readeGaindeHistory(folderHistory);
			if (contentGainde != null && !contentGainde.isEmpty()) {
				ObjectMapper mapper = new ObjectMapper();
				ObjectNode rootNode = (ObjectNode) mapper.readTree(contentGainde);
				if (rootNode != null) {
					ArrayNode arrayNode = (ArrayNode) rootNode.get("histories");
					arrayNode.forEach(jsonNode -> {
						HistoryDTO histo = mapper.convertValue(jsonNode, HistoryDTO.class);
						if (connectionName.equals(histo.getConnectionName())) {
							histories.add(histo);
						}
					});
				}
			}
			histories.sort((date1, date2) -> date2.getDate().compareTo(date1.getDate()));
		}
		return histories;
	}

	private static String toHexString(byte[] bytes) {
		StringBuilder hexString = new StringBuilder();
		for (int i = 0; i < bytes.length; i++) {
			String hex = Integer.toHexString(0xFF & bytes[i]);
			if (hex.length() == 1) {
				hexString.append('0');
			}
			hexString.append(hex);
		}

		return hexString.toString();
	}
}
