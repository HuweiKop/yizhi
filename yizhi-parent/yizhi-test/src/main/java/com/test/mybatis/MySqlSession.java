package com.test.mybatis;

import com.test.mybatis.jdbc.JdbcHelper;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by huwei on 2017/3/31.
 */
public class MySqlSession {
    private Connection conn;
    private MyExecutor executor;

    public MySqlSession(){
        try {
            this.conn = JdbcHelper.getConnection();
            this.executor  = new MySimpleExecutor(this.conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public <T> T selectOne(Class<T> resultType, String sql, Object parameter){
        return executor.query(resultType, sql, parameter);
    }

    public <T> T getMapper(Class<T> mapperInterface){
        MyMapperProxyFactory factory = new MyMapperProxyFactory();
        return factory.newInstance(mapperInterface, this);
    }
}
