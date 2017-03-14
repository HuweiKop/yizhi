package com.test.connection;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Vector;

/**
 * Created by Wei Hu (J) on 2017/3/7.
 */
public class MyPool implements IMyPool {

    private static String jdbcDriver = "com.mysql.jdbc.Driver";
    private static String jdbcUrl = "jdbc:mysql://localhost:3306/test?useUnicode=true&amp;characterEncoding=UTF-8";
    private static String userName="root";
    private static String password="password01!";
    private static int initCount=2;
    private static int stepSize=4;
    private static int poolMaxSize=60;

    private Vector<PooledConnection> poolConnects = new Vector<>();

    public MyPool(){
        init();
    }

    public void init() {
        try {
            Driver driver = (Driver) Class.forName(jdbcDriver).newInstance();
            DriverManager.registerDriver(driver);
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        createConnections(initCount);
    }

    @Override
    public PooledConnection getConnection() {
        if(poolConnects.size()<=0){
            System.out.println("连接池内没有对象");
            throw new RuntimeException("获取链接池失败");
        }
        PooledConnection pooledConnection = getRealConnection();
        while (pooledConnection==null){
            createConnections(stepSize);
            pooledConnection = getRealConnection();
        }
        System.out.println(poolConnects.size());
        return pooledConnection;
    }

    private synchronized PooledConnection getRealConnection() {
        for(PooledConnection conn:this.poolConnects){
            if(!conn.getIsBusy()){
                Connection connection = conn.getConnection();
                try {
                    if(!connection.isValid(2000)){
                        Connection validConnection = DriverManager.getConnection(jdbcUrl,userName,password);
                        conn.setConnection(validConnection);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                conn.setIsBusy(true);
                return conn;
            }
        }
        return null;
    }

    @Override
    public synchronized boolean createConnections(int count) {
        if(poolMaxSize>0&&poolConnects.size()+count>poolMaxSize){
            System.out.println("创建管道对象失败");
            throw new RuntimeException("创建管道对象失败");
        }
        for(int i=0;i<count;i++){
            try {
                Connection connection = DriverManager.getConnection(jdbcUrl,userName,password);
                PooledConnection pooledConnection = new PooledConnection(connection,false);
                this.poolConnects.add(pooledConnection);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}
