package com.xoolibeut.gainde.cassandra.controller.dtos;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
@JsonInclude(Include.NON_NULL)
public class GaindeMetadataDTO {
	private String name;
	private String id;
	private int type;
	private List<GaindeMetadataDTO> metas;

	public GaindeMetadataDTO() {

	}

	public GaindeMetadataDTO(String name,String id,int type) {
		this.name = name;
		this.id=id;
		this.type=type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<GaindeMetadataDTO> getMetas() {
		return metas;
	}

	public void setMetas(List<GaindeMetadataDTO> metas) {
		this.metas = metas;
	}

	public void addMeta(GaindeMetadataDTO gaindeMetadataDTO) {
		if (metas == null) {
			metas = new ArrayList<>();
		}
		metas.add(gaindeMetadataDTO);
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
}
