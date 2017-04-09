package com.test.mybatis.mapper;

import com.test.mybatis.mytest.UserConfigMapper;
import jdk.nashorn.internal.runtime.regexp.joni.Config;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by huwei on 2017/3/31.
 */
public class Mapper {
    private Map<String, ConfigMapper> map = new HashMap<>();

    public Mapper(){
        map.put("com.test.mybatis.mytest.UserDao",new UserConfigMapper());
    }

    public ConfigMapper getConfigMapper(String key){
        return map.get(key);
    }
}
