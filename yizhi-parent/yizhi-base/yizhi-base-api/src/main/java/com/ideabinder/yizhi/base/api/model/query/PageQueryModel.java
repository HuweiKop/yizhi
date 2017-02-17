package com.ideabinder.yizhi.base.api.model.query;

public class PageQueryModel extends QueryModel {

	private static final long serialVersionUID = 7056113781316261272L;
	private int pageSize;
	private int pageIndex;
	private int offset;
	private String orderBy;
	
	public PageQueryModel() {
		// TODO Auto-generated constructor stub
		this(20,1,0);
	}

	public int getPageSize() {
		return pageSize;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getOffset() {
		return offset;
	}

	public PageQueryModel(int pageSize, int pageIndex, int skip) {
		this.pageSize = pageSize;
		this.pageIndex = pageIndex;
		this.offset = (pageIndex - 1) * pageSize + skip;
	}
	
	public void init(){
		this.offset = (pageIndex - 1) * pageSize;
	}

//	public PageQueryModel(RequestPageModel requestModel) {
//		this(requestModel.getPageSize(), requestModel.getPageIndex(), requestModel.getSkip());
//		this.orderBy = requestModel.getOrderBy();
//	}
}
