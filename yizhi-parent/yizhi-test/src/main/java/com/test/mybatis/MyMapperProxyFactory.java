package com.test.mybatis;

import com.test.mybatis.mapper.MapperManager;

import java.lang.reflect.Proxy;

/**
 * Created by huwei on 2017/3/31.
 */
public class MyMapperProxyFactory {

    public <T> T newInstance(Class<T> type, MySqlSession sqlSession){
        System.out.println(type.getName());
        MyMapperProxy proxy = new MyMapperProxy(sqlSession, MapperManager.getMapper().getConfigMapper(type.getName()));
        return (T) Proxy.newProxyInstance(type.getClassLoader(),new Class[]{type},proxy);
    }
}
