package com.xoolibeut.gainde.cassandra.controller.dtos;

import java.util.ArrayList;
import java.util.List;

public class TableDTO {
private String name;
private List<ColonneTableDTO> columns=new ArrayList<ColonneTableDTO>();
private List<IndexColumn> indexColumns=new ArrayList<IndexColumn>();
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public List<ColonneTableDTO> getColumns() {
	return columns;
}
public void setColumns(List<ColonneTableDTO> columns) {
	this.columns = columns;
}
public List<IndexColumn> getIndexColumns() {
	return indexColumns;
}
public void setIndexColumns(List<IndexColumn> indexColumns) {
	this.indexColumns = indexColumns;
}


}
