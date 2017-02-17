package com.ideabinder.yizhi.base.api.model.db.medicine;


import com.ideabinder.yizhi.base.api.model.db.BaseDbEntity;

public class ChemicalDb extends BaseDbEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4121602979301863289L;
	private String name;
	private String pinyinName;

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
}
