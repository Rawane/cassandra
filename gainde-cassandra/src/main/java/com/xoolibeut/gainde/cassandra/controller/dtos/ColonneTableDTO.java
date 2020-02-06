package com.xoolibeut.gainde.cassandra.controller.dtos;

public class ColonneTableDTO {
	private String name;
	private String type;
	private String typeList;
	private String typeMap;
	private boolean primaraKey;
	private boolean indexed;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public boolean isPrimaraKey() {
		return primaraKey;
	}

	public void setPrimaraKey(boolean primaraKey) {
		this.primaraKey = primaraKey;
	}

	public boolean isIndexed() {
		return indexed;
	}

	public void setIndexed(boolean indexed) {
		this.indexed = indexed;
	}

	public String getTypeList() {
		return typeList;
	}

	public void setTypeList(String typeList) {
		this.typeList = typeList;
	}

	public String getTypeMap() {
		return typeMap;
	}

	public void setTypeMap(String typeMap) {
		this.typeMap = typeMap;
	}

}
