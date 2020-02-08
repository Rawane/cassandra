package com.xoolibeut.gainde.cassandra.controller.dtos;

public class IndexColumn {
	private String name;
	private String columName;

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((columName == null) ? 0 : columName.hashCode());
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
		IndexColumn other = (IndexColumn) obj;
		if (columName == null) {
			if (other.columName != null)
				return false;
		} else if (!columName.equals(other.columName))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

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
