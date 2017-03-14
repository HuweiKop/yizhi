package com.test.rpc;

/**
 * Created by Wei Hu (J) on 2017/2/20.
 */
public class RpcConsumer {
    public static void main(String[] args) throws Exception {
        HelloService service = RpcFramework.call(HelloService.class, "127.0.0.1", 9999);
        for (int i = 0; i < 100; i++) {
            new Thread(() -> {
                String hello = service.hello("ideabinder");
                System.out.println(hello);
            }).start();
        }
    }
}
