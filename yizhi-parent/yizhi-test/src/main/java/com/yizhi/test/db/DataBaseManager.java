package com.yizhi.test.db;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.io.IOException;

public class DataBaseManager {

	private SqlSession sqlSession;

	private final static ThreadLocal<DataBaseManager> manager = new ThreadLocal<DataBaseManager>();

	public static DataBaseManager getDbManager() throws IOException {
		DataBaseManager current = manager.get();
		if (current == null) {
			current = new DataBaseManager();
			manager.set(current);
		}
		return current;
	}

	private DataBaseManager() throws IOException {
		SqlSessionFactory factory = SqlSessionFactoryManager.getFactory();
		sqlSession = factory.openSession();
	}

	public SqlSession getSqlSession() {
		return sqlSession;
	}
}
