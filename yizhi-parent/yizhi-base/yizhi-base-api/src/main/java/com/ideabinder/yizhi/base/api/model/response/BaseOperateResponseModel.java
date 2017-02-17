package com.ideabinder.yizhi.base.api.model.response;

public class BaseOperateResponseModel extends BaseResponseModel {

	private static final long serialVersionUID = 2039687444651406331L;
	private boolean result;
	
	private Object data;
	
	private int operateId;
	
	public BaseOperateResponseModel(boolean result) {
		super();
		this.result = result;
	}

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public int getOperateId() {
		return operateId;
	}

	public void setOperateId(int operateId) {
		this.operateId = operateId;
	}
}
