package com.xoolibeut.gainde.cassandra.controller.dtos;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
@JsonInclude(Include.NON_NULL)
public class KeyspaceDTO {
	private String name;
	private String strategy;
	private String replication; 
	private Map<String, String> dataCenter=new HashMap<>(); 
	private boolean durableWrite = true;
	private List<String> tables=new ArrayList<String>();

	public Map<String, String> getDataCenter() {
		return dataCenter;
	}

	public void setDataCenter(Map<String, String> dataCenter) {
		this.dataCenter = dataCenter;
	}

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

	public List<String> getTables() {
		return tables;
	}

	public void setTables(List<String> tables) {
		this.tables = tables;
	}
}
