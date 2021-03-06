package com.xoolibeut.gainde.cassandra.repository;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.ByteBuffer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.ColumnMetadata;
import com.datastax.driver.core.KeyspaceMetadata;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.SocketOptions;
import com.datastax.driver.core.TableMetadata;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.xoolibeut.gainde.cassandra.controller.dtos.KeyspaceDTO;

@Repository
@PropertySource("classpath:gainde.properties")
public class KeyspaceRepositoryImp implements KeyspaceRepository {
	private static final Logger LOGGER = LoggerFactory.getLogger(KeyspaceRepositoryImp.class);
	@Autowired
	private ConnectionCassandraRepository cassandraRepository;
	@Value("${xoolibeut.gainde.connection.folder}")
	private String folderConnection;
	private static String SEPARATOR_DATA = "-----------------------------------------------------------DATA--------------------------------------------------------";

	@Override
	public void createKeyspace(String connectionName, KeyspaceDTO keyspaceDTO) throws Exception {
		LOGGER.info("createKeyspace");
		Session session = getSession(connectionName);
		StringBuilder sb = new StringBuilder("CREATE KEYSPACE IF NOT EXISTS ").append(addQuote(keyspaceDTO.getName()))
				.append(" WITH replication = {").append("'class':'").append(keyspaceDTO.getStrategy());
		if ("SimpleStrategy".equals(keyspaceDTO.getStrategy())) {
			sb.append("','replication_factor':").append(keyspaceDTO.getReplication());
		} else {
			keyspaceDTO.getDataCenters().forEach(dataCenter -> {
				sb.append("','" + dataCenter.getName() + "':").append(dataCenter.getReplication());
			});
		}
		sb.append("} AND DURABLE_WRITES = " + keyspaceDTO.isDurableWrite() + ";");

		String query = sb.toString();
		LOGGER.info("execute Query " + query);
		session.execute(query);

	}

	@Override
	public void alterKeyspace(String connectionName, KeyspaceDTO keyspaceDTO) throws Exception {
		LOGGER.info("alterKeyspace");
		Session session = getSession(connectionName);
		StringBuilder sb = new StringBuilder("ALTER KEYSPACE ").append(addQuote(keyspaceDTO.getName()))
				.append(" WITH replication = {").append("'class':'").append(keyspaceDTO.getStrategy())
				.append("','replication_factor':").append(keyspaceDTO.getReplication())
				.append("} AND DURABLE_WRITES = " + keyspaceDTO.isDurableWrite() + ";");
		String query = sb.toString();
		session.execute(query);

	}

	@Override
	public void dropKeyspace(String connectionName, String keyspace) throws Exception {
		LOGGER.info("dropKeyspace");
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		SocketOptions socketOptions = cluster.getConfiguration().getSocketOptions();
		socketOptions.setReadTimeoutMillis(60000);
		socketOptions.setConnectTimeoutMillis(60000);
		session.execute("DROP KEYSPACE " + keyspace);

	}

	@Override
	public KeyspaceDTO getKeyspace(String connectionName, String keyspaceName) throws Exception {
		LOGGER.info("getKeyspace");
		KeyspaceDTO keyspaceDTO = new KeyspaceDTO();
		Cluster cluster = getCluster(connectionName);
		if (cluster != null) {
			KeyspaceMetadata keyspaceMetadata = cluster.getMetadata().getKeyspace(addQuote(keyspaceName));
			if (keyspaceMetadata != null) {
				Map<String, String> map = keyspaceMetadata.getReplication();
				LOGGER.debug(map.toString());
				keyspaceDTO.setName(keyspaceName);
				keyspaceDTO.setReplication(map.get("replication_factor"));
				keyspaceDTO.setStrategy(map.get("class"));
				keyspaceDTO.setDurableWrite(keyspaceMetadata.isDurableWrites());
				keyspaceMetadata.getTables().forEach(table -> {
					Map<String, String> mapTable = new HashMap<>();
					LOGGER.debug("exportAsString " + table.getName() + "   " + table.exportAsString());
					LOGGER.debug("asCQLQuery " + table.getName() + "   " + table.asCQLQuery());
					mapTable.put("name", table.getName());
					keyspaceDTO.getTables().add(mapTable);
				});
			}
		}
		return keyspaceDTO;
	}

	@Override
	public String dumpKeyspace(String connectionName, String keyspaceName) throws Exception {
		LOGGER.info("dumpKeyspace");
		StringBuilder builder = new StringBuilder();
		Cluster cluster = getCluster(connectionName);
		SocketOptions socketOptions = cluster.getConfiguration().getSocketOptions();
		socketOptions.setReadTimeoutMillis(60000);
		socketOptions.setConnectTimeoutMillis(60000);
		if (cluster != null) {
			KeyspaceMetadata keyspaceMetadata = cluster.getMetadata().getKeyspace(addQuote(keyspaceName));
			if (keyspaceMetadata != null) {
				builder.append(keyspaceMetadata.exportAsString());
			}
		}
		return builder.toString();
	}

	@Override
	public String dumpKeyspaceWithData(String connectionName, String keyspaceName) throws Exception {
		LOGGER.info("dumpKeyspaceWithData");
		StringBuilder builder = new StringBuilder();
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		SocketOptions socketOptions = cluster.getConfiguration().getSocketOptions();
		socketOptions.setReadTimeoutMillis(60000);
		socketOptions.setConnectTimeoutMillis(60000);
		if (cluster != null) {
			KeyspaceMetadata keyspaceMetadata = cluster.getMetadata().getKeyspace(addQuote(keyspaceName));
			if (keyspaceMetadata != null) {
				builder.append(keyspaceMetadata.exportAsString());
				LOGGER.debug("keyspaceMetadata " + keyspaceMetadata.exportAsString());
				Collection<TableMetadata> tables = keyspaceMetadata.getTables();
				builder.append("\n").append(SEPARATOR_DATA);
				tables.forEach(tableMeta -> {
					ResultSet resulSet = session
							.execute(QueryBuilder.select().from(addQuote(keyspaceName), addQuote(tableMeta.getName())));
					Iterator<Row> iter = resulSet.iterator();
					while (iter.hasNext()) {
						Row row = iter.next();
						builder.append(buildRowValue(keyspaceName, tableMeta, row));

					}

				});
			}
		}
		return builder.toString();
	}

	@Override
	public String dumpOnlyDataFromKeyspace(String connectionName, String keyspaceName) throws Exception {
		LOGGER.info("dumpOnlyDataFromKeyspace");
		StringBuilder builder = new StringBuilder();
		Session session = getSession(connectionName);
		Cluster cluster = getCluster(connectionName);
		SocketOptions socketOptions = cluster.getConfiguration().getSocketOptions();
		socketOptions.setReadTimeoutMillis(60000);
		socketOptions.setConnectTimeoutMillis(60000);
		if (cluster != null) {
			KeyspaceMetadata keyspaceMetadata = cluster.getMetadata().getKeyspace(addQuote(keyspaceName));
			if (keyspaceMetadata != null) {
				LOGGER.debug("keyspaceMetadata " + keyspaceMetadata.exportAsString());
				Collection<TableMetadata> tables = keyspaceMetadata.getTables();
				tables.forEach(tableMeta -> {
					ResultSet resulSet = session
							.execute(QueryBuilder.select().from(addQuote(keyspaceName), addQuote(tableMeta.getName())));
					Iterator<Row> iter = resulSet.iterator();
					while (iter.hasNext()) {
						Row row = iter.next();
						builder.append(buildRowValue(keyspaceName, tableMeta, row));

					}

				});
			}
		}
		return builder.toString();
	}

	@Override
	public String importKeyspace(String connectionName, MultipartFile file) throws Exception {
		LOGGER.info("importKeyspace");
		String keyspace = null;
		if (file != null) {
			// String fileName = Calendar.getInstance().getTimeInMillis() + "_temp_" +
			// file.getOriginalFilename();
			LOGGER.debug("importKeyspace file " + file.getName());
			// Files.copy(file.getInputStream(),
			// GaindeFileUtil.createFileTempIfNotExist(folderConnection,
			// fileName),StandardCopyOption.REPLACE_EXISTING);
			List<String> listQuery = new ArrayList<String>();
			try (BufferedReader buffer = new BufferedReader(new InputStreamReader(file.getInputStream()))) {
				Map<String, String> mapQuery = new HashMap<String, String>();
				mapQuery.put("keyQuery", "");
				buffer.lines().forEach(line -> {
					if (!SEPARATOR_DATA.equals(line)) {
						mapQuery.put("keyQuery", mapQuery.get("keyQuery") + line);
						if (line.endsWith(";")) {
							listQuery.add(mapQuery.get("keyQuery"));
							mapQuery.put("keyQuery", "");
						}
					}
				});

				// return buffer.lines().collect(Collectors.joining("\n"));
			}
			LOGGER.debug("----------------------------------------Query-----------------------" + listQuery.size());
			if (!listQuery.isEmpty()) {
				Session session = getSession(connectionName);
				String[] arrayQueryKeyspace = listQuery.get(0).split(" ");
				if (arrayQueryKeyspace.length > 3) {
					keyspace = arrayQueryKeyspace[2];
					if (keyspace != null && keyspace.contains(".")) {
						keyspace = keyspace.split("\\.")[0];
					}
					keyspace = removeQuote(keyspace);
					LOGGER.debug("Cr�ation du Keyspace  " + keyspace);
				}
				listQuery.forEach(query -> {
					session.execute(query);
				});
			}

		}
		return keyspace;
	}

	private String buildRowValue(String keyspaceName, TableMetadata tableMetadata, Row row) {
		StringBuilder builderHead = new StringBuilder("\nINSERT INTO ");
		builderHead.append("\"").append(keyspaceName).append("\".").append("\"").append(tableMetadata.getName())
				.append("\"");
		Map<String, String> columnsInsert = new HashMap<>();
		List<ColumnMetadata> columns = tableMetadata.getColumns();
		columns.forEach(column -> {
			Object object = row.getObject(addQuote(column.getName()));
			if (object != null) {
				switch (column.getType().getName()) {
				case TIMESTAMP: {
					if (object instanceof Date) {
						Date date = (Date) object;
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
						columnsInsert.put(column.getName(), dateFormat.format(date));
					}
					break;
				}
				case BLOB: {
					if (object instanceof ByteBuffer) {
						ByteBuffer byteBuffer = (ByteBuffer) object;
						String value = new String(byteBuffer.array());
						LOGGER.debug(column.getName() + "   BLOB BLOB  " + value);
						columnsInsert.put(column.getName(), value);
					}
					break;
				}
				default:
					if (object != null) {
						String rowValue = object.toString();
						if (rowValue.length() > 1 && rowValue.startsWith("\"")) {
							// rowValue = rowValue.substring(1, rowValue.length() - 1);
						}
						columnsInsert.put(column.getName(), rowValue);
					}
					break;
				}

			}
		});
		StringBuilder builderInsert = new StringBuilder(" (");
		StringBuilder builderValue = new StringBuilder(" (");
		AtomicBoolean firstInsert = new AtomicBoolean(true);
		columnsInsert.forEach((key, value) -> {
			if (firstInsert.get()) {
				builderInsert.append("\"").append(key).append("\"");
				builderValue.append("'").append(value.replaceAll("'", "''")).append("'");

			} else {
				builderInsert.append(",\"").append(key).append("\"");
				builderValue.append(",'").append(value.replaceAll("'", "''")).append("'");
			}
			firstInsert.set(false);
		});
		builderInsert.append(")");
		builderValue.append(");");
		builderHead.append(builderInsert).append(" VALUES").append(builderValue);
		return builderHead.toString();
	}

	private Session getSession(String connectionName) throws Exception {
		return cassandraRepository.getSession(connectionName);
	}

	private Cluster getCluster(String connectionName) throws Exception {
		return cassandraRepository.getCluster(connectionName);
	}

	/**
	 * Pour la gestion des majuscule
	 * 
	 * @param element
	 * @return
	 */
	private String addQuote(String element) {
		return "\"" + element + "\"";
	}

	private String removeQuote(String element) {
		if (element == null || element.length() < 2) {
			return element;
		}
		if (element.startsWith("\"")) {
			return element.substring(1, element.length() - 1);
		}
		return element;
	}
}
