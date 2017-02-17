package com.ideabinder.yizhi.base.api.model.db.medicine;


import com.ideabinder.yizhi.base.api.model.db.BaseDbEntity;

import java.util.Date;

public class ManufacturerDb extends BaseDbEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3244794303411444974L;
	private String name;
	private String pinyinName;
	private String englishName;
	private String address;
	private Date establishTime;
	private int type;
	private String slogen;
	private String logo;
	private String scope;
	private String description;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPinyinName() {
		return pinyinName;
	}

	public void setPinyinName(String pinyinName) {
		this.pinyinName = pinyinName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getSlogen() {
		return slogen;
	}

	public void setSlogen(String slogen) {
		this.slogen = slogen;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getEnglishName() {
		return englishName;
	}

	public void setEnglishName(String englishName) {
		this.englishName = englishName;
	}

	public Date getEstablishTime() {
		return establishTime;
	}

	public void setEstablishTime(Date establishTime) {
		this.establishTime = establishTime;
	}

	public String getScope() {
		return scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
