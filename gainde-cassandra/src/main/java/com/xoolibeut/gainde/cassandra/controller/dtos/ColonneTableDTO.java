package com.xoolibeut.gainde.cassandra.controller.dtos;

public class ColonneTableDTO {
	private String name;
	private String type;
	private String typeList;
	private String typeMap;
	private boolean primaraKey;
	private boolean indexed;

	
	
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
