package com.ideabinder.yizhi.base.api.model.db;

import com.ideabinder.yizhi.base.api.util.DateTimeUtility;

import java.io.Serializable;

public class BaseDbEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -640622460493791869L;
	protected Long createTime;
	protected Long updateTime;
	protected Boolean isActive;

	protected Integer id;
	protected Integer status;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	public Long getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Long updateTime) {
		this.updateTime = updateTime;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public void createNew() {
		this.createTime = DateTimeUtility.newTimeLong();
		this.updateTime = DateTimeUtility.newTimeLong();
		this.isActive = true;
	}
	
	public void logicDelete(){
		this.isActive = false;
		this.updateTime = DateTimeUtility.newTimeLong();
	}
}
