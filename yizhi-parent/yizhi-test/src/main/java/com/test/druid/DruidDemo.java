package com.test.druid;

import com.yizhi.test.dao.user.IUserDao;
import com.yizhi.test.model.user.UserDb;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by Wei Hu (J) on 2017/3/9.
 */
public class DruidDemo {
    public static void main(String[] args){

        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"druid-mybatis.xml"});
        context.start();

        IUserDao service = context.getBean(IUserDao.class);
        UserDb user = service.getUserById(1);
        System.out.println(user.getId());
        System.out.println(user.getName());
        System.out.println(user.getAge1());
    }
}
