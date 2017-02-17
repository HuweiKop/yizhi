package com.ideabinder.yizhi.base.api.model.query.medicine;


import com.ideabinder.yizhi.base.api.model.query.PageQueryModel;

public class MedicinePageQueryModel extends PageQueryModel {

	private static final long serialVersionUID = 6773992861923001513L;
	private String nameValue;
	
	private int status;

	public String getNameValue() {
		return nameValue;
	}

	public void setNameValue(String nameValue) {
		this.nameValue = nameValue;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
