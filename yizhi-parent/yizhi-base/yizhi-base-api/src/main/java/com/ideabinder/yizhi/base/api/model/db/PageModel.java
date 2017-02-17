package com.ideabinder.yizhi.base.api.model.db;


import com.ideabinder.yizhi.base.api.model.query.PageQueryModel;

import java.io.Serializable;
import java.util.List;

public class PageModel<T> implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7391171487015689237L;

	private List<T> sourceItems;

	private int totalCount;
	private int totalPage;
	private int indexPage;
	private int startCount;
	private int endCount;
	private int pageSize;

	public PageModel() {
	}

	public PageModel(List<T> sourceItems, int totalCount, int indexPage,
			int pageSize) {
		this(sourceItems);
		this.totalCount = totalCount;
		this.totalPage = (totalCount - 1) / pageSize + 1;
		this.indexPage = indexPage;
		this.startCount = (indexPage - 1) * pageSize + 1;
		this.endCount = indexPage * pageSize;
		this.endCount = this.endCount > this.totalCount ? this.totalCount
				: this.endCount;
		this.pageSize = pageSize;
	}

	public PageModel(List<T> sourceItems, int totalCount, PageQueryModel pageQueryModel){
		this(sourceItems,totalCount,pageQueryModel.getPageIndex(),pageQueryModel.getPageSize());
	}

	public PageModel(List<T> sourceItems) {
		this.sourceItems = sourceItems;
	}

	public void copyPage(PageModel model) {
		this.totalCount = model.totalCount;
		this.totalPage = model.totalPage;
		this.indexPage = model.indexPage;
		this.startCount = model.startCount;
		this.endCount = model.endCount;
		this.pageSize = model.pageSize;
	}

	public List<T> getSourceItems() {
		return sourceItems;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public int getIndexPage() {
		return indexPage;
	}

	public int getStartCount() {
		return startCount;
	}

	public int getEndCount() {
		return endCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setSourceItems(List<T> sourceItems) {
		this.sourceItems = sourceItems;
	}

	public void addSource(T model){
		this.sourceItems.add(model);
	}
}
