package com.test.mybatis.mytest;

import com.test.mybatis.mapper.ConfigMapper;
import com.test.mybatis.mapper.Mapper;
import com.test.mybatis.mapper.MapperObj;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by huwei on 2017/3/31.
 */
public class UserConfigMapper extends ConfigMapper {

    public UserConfigMapper(){
        this.namespace = "com.test.mybatis.mytest.UserDao";

        String sql = "select * from t_user where id=#{id}";
        MapperObj obj = new MapperObj(sql,"int","com.test.mybatis.mytest.User", "selectOne");
        this.map.put("selectById",obj);
    }
}
