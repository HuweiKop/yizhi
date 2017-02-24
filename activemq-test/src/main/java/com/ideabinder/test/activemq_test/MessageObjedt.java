package com.ideabinder.test.activemq_test;

import java.io.Serializable;

public class MessageObjedt implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1773600970679424411L;

	private String className;
	private String methodName;
	private Object parameter;

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getMethodName() {
		return methodName;
	}

	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}

	public Object getParameter() {
		return parameter;
	}

	public void setParameter(Object parameter) {
		this.parameter = parameter;
	}
}
