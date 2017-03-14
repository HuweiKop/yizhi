package com.test.connection;

/**
 * Created by Wei Hu (J) on 2017/3/7.
 */
public class PoolManager {
    private static class CreatePool{
        private static IMyPool pool = new MyPool();
    }

    public static IMyPool getMyPool(){
        return CreatePool.pool;
    }
}
