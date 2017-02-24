package com.ideabinder.test.activemq_test;

import java.io.Serializable;
import java.lang.reflect.Method;

/** 
* @Header: Receiver.java 
* 类描述： 
* @author: lm 
* @date 2013-7-17 上午10:52:58 
* @Email  
* @company 欢 
* @addr 北京市朝阳区劲松 
*/
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.ObjectMessage;
import javax.jms.Session;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

import com.ideabinder.test.activemq_test.test.UserDb;

public class Receiver2 {
	public static void main(String[] args) {
		// ConnectionFactory ：连接工厂，JMS 用它创建连接
		ActiveMQConnectionFactory connectionFactory;
		// Connection ：JMS 客户端到JMS Provider 的连接
		Connection connection = null;
		// Session： 一个发送或接收消息的线程
		Session session;
		// Destination ：消息的目的地;消息发送给谁.
		Destination destination;
		// 消费者，消息接收者
		MessageConsumer consumer;
		connectionFactory = new ActiveMQConnectionFactory(ActiveMQConnection.DEFAULT_USER,
				ActiveMQConnection.DEFAULT_PASSWORD, "tcp://localhost:61616");
		connectionFactory.setTrustAllPackages(true);
		try {
			// 构造从工厂得到连接对象
			connection = connectionFactory.createConnection();
			// 启动
			connection.start();
			// 获取操作连接
			session = connection.createSession(Boolean.FALSE, Session.AUTO_ACKNOWLEDGE);
			// 获取session注意参数值xingbo.xu-queue是一个服务器的queue，须在在ActiveMq的console配置
			destination = session.createQueue("ObjQueue");
			consumer = session.createConsumer(destination);
			while (true) {
				// 设置接收者接收消息的时间，为了便于测试，这里谁定为100s
				Message m = consumer.receive();
				if (m instanceof ObjectMessage) {
					ObjectMessage message = (ObjectMessage) m;
					MessageObjedt obj = (MessageObjedt) message.getObject();
					System.out.println("收到消息" + obj.getClassName());
					System.out.println("收到消息" + obj.getMethodName());
					System.out.println("收到消息" + obj.getParameter());
					
					Class c1 = Class.forName(obj.getClassName());
					Method method = c1.getMethod(obj.getMethodName(), Integer.class);
					Object o = method.invoke(c1.newInstance(), obj.getParameter());
					UserDb user = (UserDb)o;
					System.out.println(user.getId()+user.getName());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (null != connection)
					connection.close();
			} catch (Throwable ignore) {
			}
		}
	}
}