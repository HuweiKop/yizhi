package com.test.connection;

/**
 * Created by Wei Hu (J) on 2017/3/7.
 */
public class MyPoolTest {

    private static IMyPool myPool = PoolManager.getMyPool();
    public static void main(String[] args){
        for(int i=0;i<1000;i++){
            new Thread(() -> {
                selectData();
            }).start();
        }
    }

    public static void selectData(){
        PooledConnection connection = myPool.getConnection();
        connection.queryBySql("select * from t_user");
        System.out.println(Thread.currentThread().getName());
        connection.close();
    }
}
