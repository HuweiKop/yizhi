package com.yizhi.test;

import com.yizhi.test.dao.user.UserDaoImpl;
import com.yizhi.test.db.DataBaseManager;
import com.yizhi.test.model.user.UserDb;
import com.yizhi.test.service.user.UserServiceImpl;
import com.yizhi.test.sql.SqlModel;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/1/12.
 */
public class Main {
    public static void main(String[] args){
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"spring-ioc-dao.xml"});
        context.start();

//        UserDaoImpl userDao = (UserDaoImpl) context.getBean("userDao");
//        List<UserDb> result = userDao.getUserPage("xxx");
//        for(UserDb user:result){
//            System.out.println("------------------");
//            System.out.println("id: "+user.getId());
//            System.out.println("name: "+user.getName());
//            System.out.println("age: "+user.getAge1());
//            System.out.println("active: "+user.getIsActive());
//        }

//        UserDb user = new UserDb();
//        user.setName("xx5554443332221166111");
//        user.setAge1(33);

//        UserServiceImpl service = (UserServiceImpl) context.getBean(UserServiceImpl.class);
//        UserDb user = service.getUserById(1);
//        System.out.println(user.getId());
//        System.out.println(user.getName());
//        System.out.println(user.getAge1());
//        user.setAge1(44);
//        service.updateAndInsert(user);

//        UserDb user = userDao.getById(1);
//        System.out.println(user.getId());
//        System.out.println(user.getName());
//
//        HashMap<String, Object> map1 = new HashMap<>();
//        map1.put("name","xxxrrr");
//        map1.put("where","where name = #{name}");
//        List<UserDb> users = userDao.getByWhere(map1);
//        System.out.println(users.size());
//        System.out.println(users.get(0).getName());
//        System.out.println(users.get(0).getId());
//
//        UserDb userI = new UserDb();
//        userI.setId(3);
//        userI.setName("333");


//        System.out.println(userDao.insert(userI));
    }
}
