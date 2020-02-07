package com.xoolibeut.gainde.cassandra.controller.dtos;

import java.util.List;

public class TableInfoDTO {
	private String name;
	private List<String> primaryKey;
	private List<IndexColumn> indexColumns;
	private List<ColonneTableDTO> columns;
	private long rows;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<String> getPrimaryKey() {
		return primaryKey;
	}

	public void setPrimaryKey(List<String> primaryKey) {
		this.primaryKey = primaryKey;
	}

	
	public List<ColonneTableDTO> getColumns() {
		return columns;
	}

	public void setColumns(List<ColonneTableDTO> columns) {
		this.columns = columns;
	}

	public long getRows() {
		return rows;
	}

	public void setRows(long rows) {
		this.rows = rows;
	}

	public List<IndexColumn> getIndexColumns() {
		return indexColumns;
	}

	public void setIndexColumns(List<IndexColumn> indexColumns) {
		this.indexColumns = indexColumns;
	}

}
