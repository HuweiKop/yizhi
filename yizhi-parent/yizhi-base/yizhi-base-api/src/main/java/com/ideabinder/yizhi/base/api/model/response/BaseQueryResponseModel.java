package com.ideabinder.yizhi.base.api.model.response;

public class BaseQueryResponseModel<T> extends BaseResponseModel {

	private static final long serialVersionUID = -4806812137137224145L;
	private T data;

	public BaseQueryResponseModel() {
	}

	public BaseQueryResponseModel(T data) {
		super();
		this.data = data;
	}

	public BaseQueryResponseModel(T data, BaseResponseModel responseModel) {
		super(responseModel.getErrorCode(),responseModel.getErrorMessage());
		this.data = data;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}
}
