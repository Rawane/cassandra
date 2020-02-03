package com.xoolibeut.gainde.cassandra.controller.dtos;

public class IndexColumn {
	private String name;
	private String columName;

	public IndexColumn() {

	}

	public IndexColumn(String name, String columName) {
		this.name = name;
		this.columName = columName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getColumName() {
		return columName;
	}

	public void setColumName(String columName) {
		this.columName = columName;
	}

	

}
