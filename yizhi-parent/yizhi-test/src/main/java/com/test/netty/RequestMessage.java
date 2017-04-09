package com.test.netty;

import java.io.Serializable;

/**
 * Created by huwei on 2017/4/4.
 */
public class RequestMessage implements Serializable {
    private static final long serialVersionUID = -6428310449498996316L;

    private String serverName;
    private String methodName;
    private Object[] parameters;
    private Class<?>[] parameterTypes;

    public String getServerName() {
        return serverName;
    }

    public void setServerName(String serverName) {
        this.serverName = serverName;
    }

    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }

    public Object[] getParameters() {
        return parameters;
    }

    public void setParameters(Object[] parameters) {
        this.parameters = parameters;
    }

    public Class<?>[] getParameterTypes() {
        return parameterTypes;
    }

    public void setParameterTypes(Class<?>[] parameterTypes) {
        this.parameterTypes = parameterTypes;
    }
}
