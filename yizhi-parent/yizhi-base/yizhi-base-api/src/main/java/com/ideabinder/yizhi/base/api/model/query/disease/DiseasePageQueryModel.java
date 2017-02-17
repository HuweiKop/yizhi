package com.ideabinder.yizhi.base.api.model.query.disease;


import com.ideabinder.yizhi.base.api.model.query.PageQueryModel;

public class DiseasePageQueryModel extends PageQueryModel {

	private static final long serialVersionUID = -1985350428459188933L;
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
