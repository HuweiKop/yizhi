package com.yizhi.test.db;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class SqlSessionFactoryManager {
	
	private static String configFileName = "mybatis.xml";

	private static SqlSessionFactoryBuilder builder;
	private static SqlSessionFactory factory;
	
	public static SqlSessionFactory getFactory() throws IOException{
		if(factory==null){
			synchronized (SqlSessionFactoryManager.class) {
				if(factory==null){
					InputStream is = Resources.getResourceAsStream(configFileName);
					builder = new SqlSessionFactoryBuilder();
					factory = builder.build(is);
					is.close();
				}
			}
		}
		
		return factory;
	}
}
