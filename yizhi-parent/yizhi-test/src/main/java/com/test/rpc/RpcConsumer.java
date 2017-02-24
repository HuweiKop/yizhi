package com.test.rpc;

/**
 * Created by Wei Hu (J) on 2017/2/20.
 */
public class RpcConsumer {
    public static void main(String[] args) throws Exception {
        HelloService service = RpcFramework.call(HelloService.class,"127.0.0.1",9999);
        String hello = service.hello("ideabinder");
        System.out.println(hello);
    }
}
