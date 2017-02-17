package com.ideabinder.yizhi.base.provider.service.impl.manage;

import com.ideabinder.yizhi.base.api.model.db.manage.UserDb;
import com.ideabinder.yizhi.base.api.model.response.BaseQueryResponseModel;
import com.ideabinder.yizhi.base.api.service.manage.IUserService;
import com.ideabinder.yizhi.base.provider.dao.manage.IUserDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by Wei Hu (J) on 2017/2/13.
 */
@Service("userServiceImpl")
public class UserServiceImpl implements IUserService {

    @Resource
    IUserDao userDao;

    @Override
    public BaseQueryResponseModel<Integer> login(UserDb user) {
        return new BaseQueryResponseModel<>(this.userDao.login(user));
    }
}
