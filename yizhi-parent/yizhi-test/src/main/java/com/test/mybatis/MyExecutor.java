package com.test.mybatis;

import java.sql.Statement;

/**
 * Created by huwei on 2017/3/31.
 */
public interface MyExecutor {
    <T> T query(Class<T> resultType, String sql, Object parameter);
}
