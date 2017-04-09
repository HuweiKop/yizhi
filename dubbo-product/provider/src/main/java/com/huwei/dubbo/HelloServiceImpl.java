package com.huwei.dubbo;

/**
 * Created by huwei on 2017/3/30.
 */
public class HelloServiceImpl implements IHelloService {
    public String sayHello(String name) {
        return "say hello : "+name;
    }
}
