package com.xoolibeut.gainde.cassandra.repository;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.datastax.driver.core.AuthProvider;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Cluster.Builder;
import com.datastax.driver.core.ColumnMetadata;
import com.datastax.driver.core.DataType;
import com.datastax.driver.core.IndexMetadata;
import com.datastax.driver.core.KeyspaceMetadata;
import com.datastax.driver.core.PlainTextAuthProvider;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.TableMetadata;
import com.datastax.driver.core.querybuilder.QueryBuilder;
import com.xoolibeut.gainde.cassandra.controller.dtos.ColonneTableDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.ConnectionDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.GaindeMetadataDTO;
import com.xoolibeut.gainde.cassandra.controller.dtos.IndexColumn;
import com.xoolibeut.gainde.cassandra.controller.dtos.TableInfoDTO;

@Repository
public class ConnectionCassandraRepositoryImpl implements ConnectionCassandraRepository {

	public void connnectTocassandra(ConnectionDTO connectionDTO) throws Exception {

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
				Cluster cluster = clusterBuilder.withoutMetrics().withoutJMXReporting().withoutJMXReporting().build();
				Session session = cluster.connect();
				GaindeSessionConnection.getInstance().addSession(connectionDTO.getName(), cluster, session);
			}
		} else {
			throw new Exception("Erreur de création de la connection");
		}
	}

	public List<GaindeMetadataDTO> getAllMetadatas(String connectionName) {
		List<GaindeMetadataDTO> gaindeMetadatas=new ArrayList<GaindeMetadataDTO>() ;
		Cluster cluster = GaindeSessionConnection.getInstance().getCluster(connectionName);			
		if (cluster != null) {
			List<KeyspaceMetadata> keyspaceMetadatas = cluster.getMetadata().getKeyspaces();
			if (keyspaceMetadatas != null) {
				keyspaceMetadatas.forEach(metadata -> {
					GaindeMetadataDTO gaindeFirstChild = new GaindeMetadataDTO(metadata.getName(),connectionName+"#"+metadata.getName(),1);
					gaindeMetadatas.add(gaindeFirstChild);
					Collection<TableMetadata> tables = metadata.getTables();
					if (tables != null) {
						tables.forEach(table -> {
							gaindeFirstChild.addMeta(new GaindeMetadataDTO(table.getName(),gaindeFirstChild.getId()+"#"+table.getName(),2));
						});

					}
				});
			}
		}
		return gaindeMetadatas;
	}

	public List<ColonneTableDTO> getAllColumns(String connectionName, String keyspaceName, String tableName) {
		List<ColonneTableDTO> listColumDTO = new ArrayList<>();
		Cluster cluster = GaindeSessionConnection.getInstance().getCluster(connectionName);
		if (cluster != null) {
			KeyspaceMetadata keyspaceMetadata = cluster.getMetadata().getKeyspace(keyspaceName);
			if (keyspaceMetadata != null) {
				TableMetadata tableMetadata = keyspaceMetadata.getTable(tableName);
				if (tableMetadata != null) {
					List<ColumnMetadata> columnMetadatas = tableMetadata.getColumns();
					Collection<IndexMetadata> indexMetadatas = tableMetadata.getIndexes();
					List<String> listIndex = new ArrayList<>();
					indexMetadatas.forEach(index -> {
						listIndex.add(index.getTarget());
					});
					List<String> listPrimaryKey = new ArrayList<>();
					List<ColumnMetadata> metadatas = tableMetadata.getPrimaryKey();
					metadatas.forEach(primaryKey -> {
						listPrimaryKey.add(primaryKey.getName());
					});

					columnMetadatas.forEach(columMeta -> {
						DataType dataType = columMeta.getType();
						System.out.println("dataType " + dataType);
						ColonneTableDTO colonneDTO = new ColonneTableDTO();
						colonneDTO.setName(columMeta.getName());
						colonneDTO.setType(columMeta.getType().getName().name());
						colonneDTO.setIndexed(listIndex.contains(columMeta.getName()));
						colonneDTO.setPrimaraKey(listPrimaryKey.contains(columMeta.getName()));
						listColumDTO.add(colonneDTO);

					});
				}

			}

		}
		return listColumDTO;
	}

	public TableInfoDTO getTableInfo(String connectionName, String keyspaceName, String tableName) {
		TableInfoDTO tableInfoDTO = new TableInfoDTO();
		Cluster cluster = GaindeSessionConnection.getInstance().getCluster(connectionName);
		if (cluster != null) {
			KeyspaceMetadata keyspaceMetadata = cluster.getMetadata().getKeyspace(keyspaceName);
			if (keyspaceMetadata != null) {
				TableMetadata tableMetadata = keyspaceMetadata.getTable(tableName);				
				if (tableMetadata != null) {
					tableInfoDTO.setName(tableMetadata.getName());
					Collection<IndexMetadata> indexMetadatas = tableMetadata.getIndexes();
					List<IndexColumn> listIndexColumns = new ArrayList<>();
					indexMetadatas.forEach(index -> {
						IndexColumn indexColumn = new IndexColumn(index.getName(), index.getTarget());
						listIndexColumns.add(indexColumn);
					});
					tableInfoDTO.setIndex(listIndexColumns);
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

	public long countAllRows(String connectionName, String keyspaceName, String tableName) {
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		ResultSet resulset = session.execute(QueryBuilder.select().countAll().from(keyspaceName, tableName));
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
		Cluster cluster = GaindeSessionConnection.getInstance().getCluster(connectionName);
		Session session = GaindeSessionConnection.getInstance().getSession(connectionName);
		if (session != null) {
			session.close();
		}
		if (cluster != null) {
			cluster.close();
		}
		GaindeSessionConnection.getInstance().removeConnection(connectionName);
	}
}
