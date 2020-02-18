package com.xoolibeut.gainde.cassandra.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.KeyspaceMetadata;
import com.datastax.driver.core.Session;
import com.xoolibeut.gainde.cassandra.controller.dtos.KeyspaceDTO;

@Repository
public class KeyspaceRepositoryImp implements KeyspaceRepository {
	private static final Logger LOGGER = LoggerFactory.getLogger(KeyspaceRepositoryImp.class);
	@Override
	public void createKeyspace(String connectionName,KeyspaceDTO keyspaceDTO) throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		StringBuilder sb = new StringBuilder("CREATE KEYSPACE IF NOT EXISTS ").append(keyspaceDTO.getName())
				.append(" WITH replication = {").append("'class':'").append(keyspaceDTO.getStrategy());
				if("SimpleStrategy".equals(keyspaceDTO.getStrategy())){
					sb.append("','replication_factor':").append(keyspaceDTO.getReplication());
				}else {
					keyspaceDTO.getDataCenter().forEach((key,value)->{
						sb.append("','"+key+"':").append(value);
					});					
				}				
				sb.append("} AND DURABLE_WRITES = " + keyspaceDTO.isDurableWrite() + ";");

		String query = sb.toString();
		session.execute(query);

	}

	@Override
	public void alterKeyspace(String connectionName,KeyspaceDTO keyspaceDTO ) throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		StringBuilder sb = new StringBuilder("ALTER KEYSPACE ").append(keyspaceDTO.getName())
				.append(" WITH replication = {").append("'class':'").append(keyspaceDTO.getStrategy())
				.append("','replication_factor':").append(keyspaceDTO.getReplication())
				.append("} AND DURABLE_WRITES = " + keyspaceDTO.isDurableWrite() + ";");

		String query = sb.toString();
		session.execute(query);

	}

	@Override
	public void dropKeyspace(String connectionName, String keyspace) throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		session.execute("DROP KEYSPACE " + keyspace);

	}

	@Override
	public List<KeyspaceDTO> getAllKeyspace(String connectionName) throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			throw new Exception("aucune session");
		}
		return null;
	}

	@Override
	public KeyspaceDTO getKeyspace(String connectionName, String keyspaceName) throws Exception {
		KeyspaceDTO keyspaceDTO=new KeyspaceDTO();
		Cluster cluster = GaindeSessionConnection.getInstance().getCluster(connectionName);
		if (cluster != null) {
			KeyspaceMetadata keyspaceMetadata = cluster.getMetadata().getKeyspace(keyspaceName);
			if (keyspaceMetadata != null) {
				Map<String, String> map = keyspaceMetadata.getReplication();
				LOGGER.info(map.toString());
				keyspaceDTO.setName(keyspaceName);
				keyspaceDTO.setReplication(map.get("replication_factor"));
				keyspaceDTO.setStrategy(map.get("class"));
				keyspaceDTO.setDurableWrite(keyspaceMetadata.isDurableWrites());
				keyspaceMetadata.getTables().forEach(table->{
					Map<String,String> mapTable=new HashMap<>();
					LOGGER.info("exportAsString "+table.getName()+"   "+table.exportAsString());
					LOGGER.info("asCQLQuery "+table.getName()+"   "+table.asCQLQuery());
					mapTable.put("name", table.getName());
					keyspaceDTO.getTables().add(mapTable);
				});
			}
		}
		return keyspaceDTO;
	}

}
