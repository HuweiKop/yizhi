package com.ideabinder.yizhi.base.cms.web;


import com.ideabinder.yizhi.base.api.model.ErrorCode;
import com.ideabinder.yizhi.base.api.model.response.BaseResponseModel;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

public class Operator implements InvocationHandler {

	private Object orgin;
	private Object proxy;

	private ErrorCode errorCode = ErrorCode.NoError;
	private String msg;

	public Operator(Object orgin) {
		this.orgin = orgin;
	}

	public Object createProxy() {
		proxy = Proxy.newProxyInstance(orgin.getClass().getClassLoader(), orgin.getClass().getInterfaces(), this);
		return proxy;
	}

	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		try {
			Object result =  method.invoke(this.orgin, args);
			System.out.println("ok=============");
			return result;
		} catch (Exception ex) {
			System.out.println("error=========");
			ex.printStackTrace();
			errorCode = ErrorCode.UnkonwnError;
			msg = getException(ex);
			return null;
		}
	}

	public BaseResponseModel getErrorResponse(){
		return new BaseResponseModel(this.errorCode,this.msg);
	}

	private String getException(Exception ex) {
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		PrintStream pout = new PrintStream(out);
		ex.printStackTrace(pout);
		String ret = new String(out.toByteArray());
		pout.close();
		try {
			out.close();
		} catch (Exception e) {
		}
		return ret;
	}
}
