package com.test.connection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by Wei Hu (J) on 2017/3/7.
 */
public class PooledConnection {
    private Connection connection;
    private boolean isBusy;

    public PooledConnection(Connection connection, boolean isBusy){
        this.connection = connection;
        this.isBusy = isBusy;
    }

    public void close(){
//        try {
//            this.connection.close();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
        this.isBusy = false;
    }

    public ResultSet queryBySql(String sql){
        Statement sm = null;
        ResultSet rs = null;
        try {
            sm = this.connection.createStatement();
            rs = sm.executeQuery(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    public Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    public boolean getIsBusy() {
        return isBusy;
    }

    public void setIsBusy(boolean busy) {
        isBusy = busy;
    }
}
