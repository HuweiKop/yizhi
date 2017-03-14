package com.test.connection;

/**
 * Created by Wei Hu (J) on 2017/3/7.
 */
public interface IMyPool {

    PooledConnection getConnection();

    boolean createConnections(int count);
}
