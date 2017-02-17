package com.ideabinder.yizhi.base.api.model;

public enum ErrorCode {

	NoError(0,""),
	UnkonwnError(1,"[未知错误] "),
	TokenError(2,"[token验证错误] "),
	ArgumentError(3,"[参数错误] "),
	DataNotExist(4,"[数据不存在] "),
	PageInfoError(5,"[页面信息错误] "),
	DataProcessError(6,"[数据执行错误] "),
	SqlExecuteError(7,"[sql执行错误] "),
	DataExist(8,"数据已存在");
	
	private int index;
	private String msg;
	
	ErrorCode(int index, String msg){
		this.index = index;
		this.msg = msg;
	}

	public int getIndex() {
		return index;
	}

	public String getMsg() {
		return msg;
	}
}
