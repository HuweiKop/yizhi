package com.ideabinder.yizhi.base.api.model.response;


import com.ideabinder.yizhi.base.api.model.ErrorCode;

import java.io.Serializable;

public class BaseResponseModel implements Serializable {

	private static final long serialVersionUID = 2545725203767362687L;
	private int errorCode;
	private String errorMessage;
	
	public BaseResponseModel(){};
	
	public BaseResponseModel(ErrorCode errorCode, String message){
		this.errorCode = errorCode.getIndex();
		this.errorMessage = message;
	}

	public BaseResponseModel(int errorCode, String message){
		this.errorCode = errorCode;
		this.errorMessage = message;
	}

	public int getErrorCode() {
		return errorCode;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
}
