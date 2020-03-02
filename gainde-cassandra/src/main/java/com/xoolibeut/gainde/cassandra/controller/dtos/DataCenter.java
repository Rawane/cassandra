package com.xoolibeut.gainde.cassandra.controller.dtos;

public class DataCenter {
	private String name;
	private String replication;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getReplication() {
		return replication;
	}

	public void setReplication(String replication) {
		this.replication = replication;
	}

}
