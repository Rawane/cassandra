package com.xoolibeut.gainde.cassandra.controller.dtos;

public class KeyspaceDTO {
	private String name;
	private String strategy;
	private String replication;
	private boolean durableWrite = true;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStrategy() {
		return strategy;
	}

	public void setStrategy(String strategy) {
		this.strategy = strategy;
	}

	public String getReplication() {
		return replication;
	}

	public void setReplication(String replication) {
		this.replication = replication;
	}

	public boolean isDurableWrite() {
		return durableWrite;
	}

	public void setDurableWrite(boolean durableWrite) {
		this.durableWrite = durableWrite;
	}
}
