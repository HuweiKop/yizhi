package com.test.rpc;

/**
 * Created by Wei Hu (J) on 2017/2/20.
 */
public class RpcProvider {
    public static void main(String[] args) throws Exception{
        HelloService service = new HelloServiceImpl();
        RpcFramework.publish(service,9999);
    }
}


interface HelloService{
    String hello(String name);
}

class HelloServiceImpl implements HelloService{
    @Override
    public String hello(String name) {
        return "rpc 调用 hello :"+name;
    }
}
