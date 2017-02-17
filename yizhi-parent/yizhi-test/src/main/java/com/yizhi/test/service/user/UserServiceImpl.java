package com.yizhi.test.service.user;

import com.yizhi.test.dao.user.IUserDao;
import com.yizhi.test.model.user.UserDb;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;

/**
 * Created by Wei Hu (J) on 2017/2/7.
 */
@Service
public class UserServiceImpl {

    @Resource
    IUserDao userDao;

    @Resource
    UserServiceImpl2 userServiceImpl2;

    @Transactional(Transactional.TxType.REQUIRED)
    public void insert(UserDb user){
        this.userDao.insert(user);
        throw new RuntimeException();
    }

//    @Transactional
    public void updateAndInsert(UserDb user){
        this.userDao.updateById(user,1);
//        userServiceImpl2.insert(user);
    }

    public UserDb getUserById(int id){
        return this.userDao.getUserById(id);
    }
}
