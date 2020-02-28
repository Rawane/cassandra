package com.xoolibeut.gainde.cassandra.repository;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.xoolibeut.gainde.cassandra.controller.dtos.ConnectionDTO;
import com.xoolibeut.gainde.cassandra.util.GaindeFileUtil;

@Repository
@PropertySource("classpath:gainde.properties")
public class ConnectionRepositoryImpl implements ConnectionRepository {
	private static final Logger LOGGER = LoggerFactory.getLogger(ConnectionRepositoryImpl.class);
	@Value("${xoolibeut.gainde.connection.folder}")
	private String folderConnection;

	@Override
	public boolean createConnection(ConnectionDTO connectionDTO) throws IOException {
		LOGGER.debug("createConnection Connection à créé dans le fichier " + folderConnection);
		if (connectionDTO != null && connectionDTO.getName() != null && !connectionDTO.getName().isEmpty()
				&& !connectionDTO.getName().contains("#")) {
			LOGGER.debug("createConnection Connection à créé dans le fichier " + connectionDTO.toString());
			String contentGainde = GaindeFileUtil.readeGainde(folderConnection);
			ObjectMapper mapper = new ObjectMapper();
			ObjectNode rootNode;
			ArrayNode arrayNode;
			if (contentGainde != null && !contentGainde.isEmpty()) {
				rootNode = (ObjectNode) mapper.readTree(contentGainde);
				arrayNode = (ArrayNode) rootNode.get("connections");

			} else {
				rootNode = mapper.createObjectNode();
				arrayNode = mapper.createArrayNode();
			}
			for (int i = 0; i < arrayNode.size(); i++) {
				ConnectionDTO connTemp = mapper.convertValue(arrayNode.get(i), ConnectionDTO.class);
				if (connTemp.getName().equals(connectionDTO.getName())) {
					return false;
				}
			}
			connectionDTO.setOrdered(arrayNode.size());
			arrayNode.add(mapper.valueToTree(connectionDTO));
			rootNode.set("connections", arrayNode);
			GaindeFileUtil.writeGaindeAndClose(folderConnection, mapper.writeValueAsString(rootNode));
		} else {
			return false;
		}
		return true;
	}

	@Override
	public boolean updateConnection(ConnectionDTO connectionDTO) throws IOException {
		if (connectionDTO != null && connectionDTO.getName() != null && !connectionDTO.getName().isEmpty()) {
			String contentGainde = GaindeFileUtil.readeGainde(folderConnection);
			if (contentGainde != null && !contentGainde.isEmpty()) {
				ObjectMapper mapper = new ObjectMapper();
				ObjectNode rootNode = (ObjectNode) mapper.readTree(contentGainde);
				if (rootNode != null) {
					ArrayNode arrayNode = (ArrayNode) rootNode.get("connections");
					if (arrayNode != null && !arrayNode.isEmpty()) {
						for (int i = 0; i < arrayNode.size(); i++) {
							ConnectionDTO connTemp = mapper.convertValue(arrayNode.get(i), ConnectionDTO.class);
							if (connTemp.getName().equals(connectionDTO.getName())) {
								arrayNode.remove(i);
								connectionDTO.setOrdered(connTemp.getOrdered());
								arrayNode.add(mapper.valueToTree(connectionDTO));
								rootNode.set("connections", arrayNode);
								GaindeFileUtil.writeGaindeAndClose(folderConnection,
										mapper.writeValueAsString(rootNode));
								return true;
							}
						}
					}
				}
			}
		} else {
			return false;
		}
		return false;
	}

	@Override
	public void updateOrderConnection(List<ConnectionDTO> listConnections) throws IOException {
		String contentGainde = GaindeFileUtil.readeGainde(folderConnection);
		if (listConnections != null && contentGainde != null && !contentGainde.isEmpty()) {
			listConnections.forEach((conn) -> {
				LOGGER.debug("conn  " + conn.getName());
			});
			ObjectMapper mapper = new ObjectMapper();
			ObjectNode rootNode = (ObjectNode) mapper.readTree(contentGainde);
			if (rootNode != null) {
				ArrayNode arrayNode = mapper.createArrayNode();
				for (int i = 0; i < listConnections.size(); i++) {
					ConnectionDTO connUpdate = listConnections.get(i);
					connUpdate.setOrdered(i);
					arrayNode.add(mapper.valueToTree(connUpdate));

				}
				rootNode.set("connections", arrayNode);
				GaindeFileUtil.writeGaindeAndClose(folderConnection, mapper.writeValueAsString(rootNode));

			}
		}

	}

	private void updateOrderConnectionAfterRemove(int index) throws IOException {
		String contentGainde = GaindeFileUtil.readeGainde(folderConnection);
		if (contentGainde != null && !contentGainde.isEmpty()) {
			ObjectMapper mapper = new ObjectMapper();
			ObjectNode rootNode = (ObjectNode) mapper.readTree(contentGainde);
			if (rootNode != null) {
				ArrayNode arrayNode = (ArrayNode) rootNode.get("connections");
				if (arrayNode != null && !arrayNode.isEmpty()) {
					for (int i = index; i < arrayNode.size(); i++) {
						ConnectionDTO connTemp = mapper.convertValue(arrayNode.get(i), ConnectionDTO.class);
						arrayNode.remove(i);
						connTemp.setOrdered(i);
						arrayNode.add(mapper.valueToTree(connTemp));

					}
					rootNode.set("connections", arrayNode);
					GaindeFileUtil.writeGaindeAndClose(folderConnection, mapper.writeValueAsString(rootNode));
				}
			}
		}

	}

	@Override
	public boolean removeConnection(ConnectionDTO connectionDTO) throws IOException {
		String contentGainde = GaindeFileUtil.readeGainde(folderConnection);
		if (contentGainde != null && !contentGainde.isEmpty()) {
			ObjectMapper mapper = new ObjectMapper();
			ObjectNode rootNode = (ObjectNode) mapper.readTree(contentGainde);
			if (rootNode != null) {
				ArrayNode arrayNode = (ArrayNode) rootNode.get("connections");
				if (arrayNode != null && !arrayNode.isEmpty()) {
					for (int i = 0; i < arrayNode.size(); i++) {
						ConnectionDTO connTemp = mapper.convertValue(arrayNode.get(i), ConnectionDTO.class);
						if (connTemp.getName().equals(connectionDTO.getName())) {
							arrayNode.remove(i);
							rootNode.set("connections", arrayNode);
							GaindeFileUtil.writeGaindeAndClose(folderConnection, mapper.writeValueAsString(rootNode));
							updateOrderConnectionAfterRemove(i);
							return true;
						}
					}
				}
			}
		}
		return false;
	}

	@Override
	public List<ConnectionDTO> readlAllConnections() throws IOException {
		List<ConnectionDTO> connections = new ArrayList<>();
		String contentGainde = GaindeFileUtil.readeGainde(folderConnection);
		if (contentGainde != null && !contentGainde.isEmpty()) {
			ObjectMapper mapper = new ObjectMapper();
			ObjectNode rootNode = (ObjectNode) mapper.readTree(contentGainde);
			if (rootNode != null) {
				ArrayNode arrayNode = (ArrayNode) rootNode.get("connections");
				arrayNode.forEach(jsonNode -> {
					connections.add(mapper.convertValue(jsonNode, ConnectionDTO.class));
				});
			}
		}
		connections.sort((conn1, conn2) -> conn1.getOrdered() - conn2.getOrdered());
		return connections;
	}

	@Override
	public ConnectionDTO getConnection(String name) throws IOException {
		String contentGainde = GaindeFileUtil.readeGainde(folderConnection);
		if (contentGainde != null && !contentGainde.isEmpty()) {
			ObjectMapper mapper = new ObjectMapper();
			ObjectNode rootNode = (ObjectNode) mapper.readTree(contentGainde);
			if (rootNode != null) {
				ArrayNode arrayNode = (ArrayNode) rootNode.get("connections");
				if (arrayNode != null && !arrayNode.isEmpty()) {
					for (int i = 0; i < arrayNode.size(); i++) {
						ConnectionDTO connTemp = mapper.convertValue(arrayNode.get(i), ConnectionDTO.class);
						if (connTemp.getName().equals(name)) {
							return connTemp;
						}
					}
				}
			}
		}
		return null;
	}

}
