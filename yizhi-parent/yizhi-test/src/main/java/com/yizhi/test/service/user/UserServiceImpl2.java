package com.yizhi.test.service.user;

import com.yizhi.test.dao.user.IUserDao;
import com.yizhi.test.model.user.UserDb;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;

/**
 * Created by Wei Hu (J) on 2017/2/9.
 */
@Service
public class UserServiceImpl2 {

    @Resource
    IUserDao userDao;

    @Transactional(Transactional.TxType.REQUIRED)
    public void insert(UserDb user){
        this.userDao.insert(user);
//        throw new RuntimeException();
    }
}
