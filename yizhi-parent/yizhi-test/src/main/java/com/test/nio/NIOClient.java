package com.test.nio;

import com.test.netty.HelloClient;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.util.Iterator;
import java.util.Scanner;
import java.util.Set;

/**
 * Created by Wei Hu (J) on 2017/2/24.
 */
public class NIOClient {

    int port;
    SocketChannel client;
    Selector selector;

    ByteBuffer rcBuf = ByteBuffer.allocate(1024);
    ByteBuffer sendBuf = ByteBuffer.allocate(1024);

    public NIOClient(int port) throws IOException {
        this.port = port;
        this.client = SocketChannel.open();
        this.client.configureBlocking(false);
        selector = Selector.open();
        client.register(selector, SelectionKey.OP_CONNECT);
        this.client.connect(new InetSocketAddress("127.0.0.1",8888));
        System.out.println("客户端已连接服务器。。。。。。");
    }

    public void sendMsg() throws IOException {
//        this.client.register(this.selector,SelectionKey.OP_WRITE);
        while (true) {
            int eventCount = selector.select();
//            System.out.println("eventcount:"+eventCount);
            if (eventCount <= 0)
                continue;
            Set<SelectionKey> selectionKeys = selector.selectedKeys();
            Iterator<SelectionKey> iterator = selectionKeys.iterator();
            while (iterator.hasNext()) {
                SelectionKey key = iterator.next();
                process(key);
                iterator.remove();
            }
        }
    }


    private void process(SelectionKey key) {
        try {
            if (key.isValid() && (key.isConnectable()||key.isWritable())) {
                System.out.println("isWritable======");
                if(client.finishConnect())
                    client.register(selector, SelectionKey.OP_READ);

                Scanner sc = new Scanner(System.in);
                String msg = sc.nextLine();
                System.out.println("发送消息："+msg);
                sendBuf.clear();
                sendBuf.put(msg.getBytes());
                sendBuf.flip();
                this.client.write(sendBuf);
            }else if(key.isValid()&&key.isReadable()){
                System.out.println("isReadable======");
                rcBuf.clear();
                int len = client.read(rcBuf);
                if(len>0){
                    rcBuf.flip();
                    String msg = new String(rcBuf.array(),0,len);
                    System.out.println("服务器端反馈消息："+msg);
                    client.register(selector,SelectionKey.OP_WRITE);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            key.cancel();
            try {
                client.socket().close();
                client.close();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

    public static void main(String[] args){
        try {
            new NIOClient(8888).sendMsg();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
