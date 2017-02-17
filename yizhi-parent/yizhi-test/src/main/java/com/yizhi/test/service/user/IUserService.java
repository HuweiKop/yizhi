package com.yizhi.test.service.user;

import com.yizhi.test.model.user.UserDb;

/**
 * Created by Wei Hu (J) on 2017/2/9.
 */
public interface IUserService {
     void insert(UserDb user);

     void updateAndInsert(UserDb user);
}
