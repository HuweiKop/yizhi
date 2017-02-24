package com.test.nio;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

/**
 * Created by Wei Hu (J) on 2017/2/23.
 */
public class NIOServer {

    private  ServerSocketChannel server;
    private  int port = 8888;
    private  Selector selector;
    /**
     * 写入
     */
    ByteBuffer rcBuffer = ByteBuffer.allocate(1024);
    /**
     * 写出
     */
    ByteBuffer sendBuffer = ByteBuffer.allocate(1024);
    Map<SelectionKey, String> sessionMsg = new HashMap<>();

    public NIOServer(int port) throws IOException {
        this.port = port;
        server = ServerSocketChannel.open();
        server.socket().bind(new InetSocketAddress(this.port));
        server.configureBlocking(false);
        selector = Selector.open();
        server.register(selector, SelectionKey.OP_ACCEPT);
        System.out.println("NIO服务器已经开启。。。。。坚挺的端口是:" + this.port);
    }

    public void listener() throws IOException {
        while (true) {
            int eventCount = selector.select();
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
        SocketChannel client = null;
        try {
            if (key.isValid() && key.isAcceptable()) {
                client = server.accept();
                client.configureBlocking(false);
                client.register(selector, SelectionKey.OP_READ);
            }else if(key.isValid()&&key.isReadable()){
                rcBuffer.clear();
                client = (SocketChannel)key.channel();
                int len = client.read(rcBuffer);
                if(len>0){
                    String msg = new String(rcBuffer.array(),0,len);
                    System.out.println("服务器端收到消息："+msg);
                    sessionMsg.put(key,msg);
                    client.register(selector,SelectionKey.OP_WRITE);
                }
            }else if(key.isValid()&&key.isWritable()){
                if(!sessionMsg.containsKey(key)){
                    return;
                }
                client = (SocketChannel)key.channel();
                sendBuffer.clear();
                sendBuffer.put(new String(sessionMsg.get(key)+"==========回复").getBytes());
                sendBuffer.flip();
                client.write(sendBuffer);
                client.register(selector,SelectionKey.OP_READ);
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
            new NIOServer(8888).listener();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
