package com.ideabinder.yizhi.base.api.service.manage;

import com.ideabinder.yizhi.base.api.model.db.manage.UserDb;
import com.ideabinder.yizhi.base.api.model.response.BaseQueryResponseModel;

/**
 * Created by Wei Hu (J) on 2017/2/13.
 */
public interface IUserService {
    BaseQueryResponseModel<Integer> login(UserDb user);
}
