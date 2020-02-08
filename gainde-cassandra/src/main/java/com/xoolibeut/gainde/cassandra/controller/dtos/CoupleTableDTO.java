package com.xoolibeut.gainde.cassandra.controller.dtos;

public class CoupleTableDTO {
private TableDTO oldTableDTO;
public TableDTO getOldTableDTO() {
	return oldTableDTO;
}
public void setOldTableDTO(TableDTO oldTableDTO) {
	this.oldTableDTO = oldTableDTO;
}
public TableDTO getTableDTO() {
	return tableDTO;
}
public void setTableDTO(TableDTO tableDTO) {
	this.tableDTO = tableDTO;
}
private TableDTO tableDTO;
}
