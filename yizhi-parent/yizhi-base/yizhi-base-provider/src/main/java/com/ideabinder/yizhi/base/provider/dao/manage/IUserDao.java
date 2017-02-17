package com.ideabinder.yizhi.base.provider.dao.manage;

import com.ideabinder.yizhi.base.api.model.db.manage.UserDb;

/**
 * Created by Wei Hu (J) on 2017/2/13.
 */
public interface IUserDao {

    Integer login(UserDb user);
}
