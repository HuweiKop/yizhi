package com.test.mybatis.mytest;

import com.test.mybatis.MySqlSession;

/**
 * Created by huwei on 2017/3/31.
 */
public class Bootstrap {
    public static void main(String[] args){
        String sql = "select * from t_user where id=#{id}";
        MySqlSession sqlSession = new MySqlSession();
        UserDao mapper = sqlSession.getMapper(UserDao.class);
        User user = mapper.selectById(1);
        System.out.println(user.getId());
        System.out.println(user.getName());
    }
}
