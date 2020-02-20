package com.xoolibeut.gainde.cassandra.repository;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.datastax.driver.core.AuthProvider;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Cluster.Builder;
import com.datastax.driver.core.CodecRegistry;
import com.datastax.driver.core.ColumnMetadata;
import com.datastax.driver.core.IndexMetadata;
import com.datastax.driver.core.KeyspaceMetadata;
import com.datastax.driver.core.PlainTextAuthProvider;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.TableMetadata;
import com.datastax.driver.core.TypeCodec;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.xoolibeut.gainde.cassandra.controller.dtos.ColonneTableDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.ConnectionDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.GaindeMetadataDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.IndexColumn;
import com.xoolibeut.gainde.cassandra.controller.dtos.TableDTO;
import com.xoolibeut.gainde.cassandra.util.DateCodec;

@Repository
public class ConnectionCassandraRepositoryImpl implements ConnectionCassandraRepository {
	private static final Logger LOGGER = LoggerFactory.getLogger(ConnectionCassandraRepositoryImpl.class);
	@Autowired
	private ConnectionRepository connectionRepository;

	public void connnectTocassandra(ConnectionDTO connectionDTO) throws Exception {
		LOGGER.info("Start connnectTocassandra");
		if (connectionDTO != null && connectionDTO.getIp() != null && !connectionDTO.getIp().isEmpty()
				&& connectionDTO.getPort() != null) {
			if (GaindeSessionConnection.getInstance().getSession(connectionDTO.getName()) == null) {
				AuthProvider authProvider = new PlainTextAuthProvider(connectionDTO.getUsername(),
						connectionDTO.getPassword());

				Builder clusterBuilder = Cluster.builder().addContactPoint(connectionDTO.getIp())
						.withPort(connectionDTO.getPort());
				if (connectionDTO.getUsername() != null && !connectionDTO.getUsername().isEmpty()
						&& connectionDTO.getPassword() != null && !connectionDTO.getPassword().isEmpty()) {
					clusterBuilder.withAuthProvider(authProvider);
				}
				CodecRegistry codecRegistry = new CodecRegistry();
				codecRegistry.register(new DateCodec(TypeCodec.date(), Date.class));
				Cluster cluster = clusterBuilder.withoutMetrics().withoutJMXReporting().withoutJMXReporting().build();
				Session session = cluster.connect();
				GaindeSessionConnection.getInstance().addSession(connectionDTO.getName(), cluster, session);
			}
		} else {
			throw new Exception("Erreur de création de la connection");
		}
	}

	public List<GaindeMetadataDTO> getAllMetadatas(String connectionName) throws Exception {
		List<GaindeMetadataDTO> gaindeMetadatas = new ArrayList<GaindeMetadataDTO>();
		Cluster cluster = getCluster(connectionName);
		if (cluster != null) {
			List<KeyspaceMetadata> keyspaceMetadatas = cluster.getMetadata().getKeyspaces();
			if (keyspaceMetadatas != null) {
				keyspaceMetadatas.forEach(metadata -> {
					GaindeMetadataDTO gaindeFirstChild = new GaindeMetadataDTO(metadata.getName(),
							connectionName + "#" + metadata.getName(), 1);
					gaindeMetadatas.add(gaindeFirstChild);
					Collection<TableMetadata> tables = metadata.getTables();
					if (tables != null) {
						tables.forEach(table -> {
							// LOGGER.info("exportAsString "+table.getName()+" "+table.exportAsString());
							// LOGGER.info("asCQLQuery "+table.getName()+" "+table.asCQLQuery());
							gaindeFirstChild.addMeta(new GaindeMetadataDTO(table.getName(),
									gaindeFirstChild.getId() + "#" + table.getName(), 2));
						});

					}
				});
			}
		}
		return gaindeMetadatas;
	}

	public List<ColonneTableDTO> getAllColumns(String connectionName, String keyspaceName, String tableName)
			throws Exception {

		return buildAllColumns(connectionName, keyspaceName, tableName, false);
	}

	public List<ColonneTableDTO> getAllColumnsTypeNative(String connectionName, String keyspaceName, String tableName)
			throws Exception {

		return buildAllColumns(connectionName, keyspaceName, tableName, true);
	}

	private List<ColonneTableDTO> buildAllColumns(String connectionName, String keyspaceName, String tableName,
			boolean colNative) throws Exception {
		List<ColonneTableDTO> listColumDTO = new ArrayList<>();
		Cluster cluster = getCluster(connectionName);
		if (cluster != null) {
			KeyspaceMetadata keyspaceMetadata = cluster.getMetadata().getKeyspace(addQuote(keyspaceName));
			if (keyspaceMetadata != null) {
				TableMetadata tableMetadata = keyspaceMetadata.getTable(addQuote(tableName));
				if (tableMetadata != null) {
					List<ColumnMetadata> columnMetadatas = tableMetadata.getColumns();
					Collection<IndexMetadata> indexMetadatas = tableMetadata.getIndexes();
					List<String> listIndex = new ArrayList<>();
					indexMetadatas.forEach(index -> {
						listIndex.add(removeQuote(index.getTarget()));
					});
					List<String> listPartionkey = new ArrayList<>();
					List<String> listClusteredColumn = new ArrayList<>();
					List<ColumnMetadata> metadatas = tableMetadata.getPrimaryKey();
					metadatas.forEach(primaryKey -> {
						listPartionkey.add(primaryKey.getName());
					});
					List<ColumnMetadata> metadataClusteredCols = tableMetadata.getClusteringColumns();
					metadataClusteredCols.forEach(colClustered -> {
						listClusteredColumn.add(colClustered.getName());
					});
					columnMetadatas.forEach(columMeta -> {
						ColonneTableDTO colonneDTO = new ColonneTableDTO();
						colonneDTO.setName(columMeta.getName());
						if (colNative) {
							colonneDTO.setType("" + columMeta.getType().getName().ordinal());
							if (columMeta.getType().getTypeArguments().size() == 1) {
								colonneDTO.setTypeList(
										"" + columMeta.getType().getTypeArguments().get(0).getName().ordinal());
							}
							if (columMeta.getType().getTypeArguments().size() == 2) {
								colonneDTO.setTypeList(
										"" + columMeta.getType().getTypeArguments().get(0).getName().ordinal());
								colonneDTO.setTypeMap(
										"" + columMeta.getType().getTypeArguments().get(1).getName().ordinal());
							}
						} else {
							colonneDTO.setType(columMeta.getType().getName().name());
						}
						colonneDTO.setIndexed(listIndex.contains(columMeta.getName()));
						colonneDTO.setPartitionKey(listPartionkey.contains(columMeta.getName()));
						colonneDTO.setClusteredColumn(listClusteredColumn.contains(columMeta.getName()));
						listColumDTO.add(colonneDTO);

					});
				}

			}

		}
		return listColumDTO;
	}

	public TableDTO getTableInfo(String connectionName, String keyspaceName, String tableName) throws Exception {
		TableDTO tableInfoDTO = new TableDTO();
		Cluster cluster = getCluster(connectionName);
		if (cluster != null) {
			KeyspaceMetadata keyspaceMetadata = cluster.getMetadata().getKeyspace(addQuote(keyspaceName));
			if (keyspaceMetadata != null) {
				TableMetadata tableMetadata = keyspaceMetadata.getTable(addQuote(tableName));
				if (tableMetadata != null) {
					LOGGER.info("exportAsString " + tableMetadata.getName() + "   " + tableMetadata.exportAsString());
					tableInfoDTO.setName(tableMetadata.getName());
					Collection<IndexMetadata> indexMetadatas = tableMetadata.getIndexes();
					List<IndexColumn> listIndexColumns = new ArrayList<>();
					indexMetadatas.forEach(index -> {
						String target = index.getTarget();
						if (target.length() > 1) {
							if (target.startsWith("\"")) {
								target = target.substring(1, target.length() - 1);
							}
						}
						IndexColumn indexColumn = new IndexColumn(index.getName(), target);
						listIndexColumns.add(indexColumn);
					});
					tableInfoDTO.setIndexColumns(listIndexColumns);
					List<String> listPrimaryKey = new ArrayList<>();
					List<ColumnMetadata> metadatas = tableMetadata.getPrimaryKey();
					metadatas.forEach(primaryKey -> {
						listPrimaryKey.add(primaryKey.getName());
					});
					tableInfoDTO.setPrimaryKey(listPrimaryKey);

				}

			}

		}
		return tableInfoDTO;
	}

	public long countAllRows(String connectionName, String keyspaceName, String tableName) throws Exception {
		Session session = getSession(connectionName);
		ResultSet resulset = session
				.execute(QueryBuilder.select().countAll().from(addQuote(keyspaceName), addQuote(tableName)));
		if (resulset != null) {
			Row row = resulset.one();
			if (row != null) {
				return row.getLong(0);

			}
		}
		return 0;
	}

	@Override
	public void closeConnectioncassandra(String connectionName) throws Exception {
		GaindeSession gaindeSession = GaindeSessionConnection.getInstance().removeConnection(connectionName);
		if (gaindeSession != null) {
			Cluster cluster = gaindeSession.getCluster();
			Session session = gaindeSession.getSession();
			if (session != null) {
				session.close();
			}
			if (cluster != null) {
				cluster.close();
			}
		}

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

	public Session getSession(String connectionName) throws Exception {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session == null) {
			ConnectionDTO connectionDTO = connectionRepository.getConnection(connectionName);
			this.connnectTocassandra(connectionDTO);
			session = GaindeSessionConnection.getInstance().getSession(connectionName);
			if (session == null) {
				throw new Exception("aucune session");
			}
		}
		return session;
	}

	public Cluster getCluster(String connectionName) throws Exception {
		Cluster cluster = GaindeSessionConnection.getInstance().getCluster(connectionName);
		if (cluster == null) {
			ConnectionDTO connectionDTO = connectionRepository.getConnection(connectionName);
			this.connnectTocassandra(connectionDTO);
			cluster = GaindeSessionConnection.getInstance().getCluster(connectionName);
			if (cluster == null) {
				throw new Exception("aucune session");
			}
		}
		return cluster;
	}
}
