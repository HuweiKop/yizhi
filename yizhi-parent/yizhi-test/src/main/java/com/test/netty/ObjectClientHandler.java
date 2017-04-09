package com.test.netty;

import org.jboss.netty.channel.ChannelHandlerContext;
import org.jboss.netty.channel.ChannelStateEvent;
import org.jboss.netty.channel.MessageEvent;
import org.jboss.netty.channel.SimpleChannelHandler;

/**
 * Created by huwei on 2017/4/4.
 */
public class ObjectClientHandler extends SimpleChannelHandler {
    @Override
    public void channelConnected(ChannelHandlerContext ctx, ChannelStateEvent e) throws Exception {
        RequestMessage message = new RequestMessage();
        message.setServerName("testService");
        message.setMethodName("say");
        e.getChannel().write(message);
    }
}
