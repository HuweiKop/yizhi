package com.test.netty;

import org.jboss.netty.channel.ChannelHandlerContext;
import org.jboss.netty.channel.MessageEvent;
import org.jboss.netty.channel.SimpleChannelHandler;

/**
 * Created by huwei on 2017/4/4.
 */
public class ObjectServerHandler extends SimpleChannelHandler {
    @Override
    public void messageReceived(ChannelHandlerContext ctx, MessageEvent e) throws Exception {
        RequestMessage msg = (RequestMessage) e.getMessage();
        System.out.println(msg.getServerName());
        System.out.println(msg.getMethodName());
    }
}
