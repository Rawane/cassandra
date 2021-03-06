package com.xoolibeut.gainde.cassandra.controller.dtos;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

@JsonInclude(Include.NON_NULL)
public class ColonneTableDTO {
	private String name;
	private String type;
	private String typeList;
	private String typeMap;
	private boolean partitionKey;
	private boolean clusteredColumn;
	private boolean indexed;
	private String oldName;

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ColonneTableDTO other = (ColonneTableDTO) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

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

	public String getOldName() {
		return oldName;
	}

	public void setOldName(String oldName) {
		this.oldName = oldName;
	}

	public boolean isPartitionKey() {
		return partitionKey;
	}

	public void setPartitionKey(boolean partitionKey) {
		this.partitionKey = partitionKey;
	}

	public boolean isClusteredColumn() {
		return clusteredColumn;
	}

	public void setClusteredColumn(boolean clusteredColumn) {
		this.clusteredColumn = clusteredColumn;
	}

}
