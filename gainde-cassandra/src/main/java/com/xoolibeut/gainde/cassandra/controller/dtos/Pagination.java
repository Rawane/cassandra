package com.xoolibeut.gainde.cassandra.controller.dtos;

public class Pagination {
	private String pageSate;
	private Integer pageSize = 0;
	private Integer pageNum = 1;
	private Integer pageCount = 0;
	private Long total = 0L;
	private Integer pageNumSate = 1;

	public String getPageSate() {
		return pageSate;
	}

	public void setPageSate(String pageSate) {
		this.pageSate = pageSate;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getPageNum() {
		return pageNum;
	}

	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	

	public Integer getPageCount() {
		return pageCount;
	}

	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}

	public Integer getPageNumSate() {
		return pageNumSate;
	}

	public void setPageNumSate(Integer pageNumSate) {
		this.pageNumSate = pageNumSate;
	}
}
