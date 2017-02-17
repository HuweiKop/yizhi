package com.yizhi.test.db;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class MyBeanFactory {
	
	private AbstractApplicationContext beanFactory;
	
	private final static ThreadLocal<MyBeanFactory> manager = new ThreadLocal<MyBeanFactory>();
	
	public static MyBeanFactory getFactory(){
		MyBeanFactory current = manager.get();
		if(current==null){
			current = new MyBeanFactory();
			manager.set(current);
		}
		
		return current;
	}
	
	private MyBeanFactory(){
		beanFactory = new ClassPathXmlApplicationContext(
				"UserApplicationContext.xml");
	}
	
	public <T> T getBean(String beanId){
		T dao = (T)this.beanFactory.getBean(beanId);
		return dao;
	}
	
	public <T> T getBean(Class<T> daoClass){
		T dao = (T)this.beanFactory.getBean(daoClass);
		return dao;
	}
	
	public void close(){
		this.beanFactory.close();
		manager.remove();
	}
}
