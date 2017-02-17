package com.yizhi.test.dao.user;

import com.yizhi.test.dao.common.ICommonDao;
import com.yizhi.test.model.user.UserDb;
import com.yizhi.test.sql.SqlModel;

import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/1/12.
 */
public interface IUserDao extends ICommonDao<UserDb> {
    List<UserDb> getUserPage(String username);

    UserDb getUserById(int id);
}
