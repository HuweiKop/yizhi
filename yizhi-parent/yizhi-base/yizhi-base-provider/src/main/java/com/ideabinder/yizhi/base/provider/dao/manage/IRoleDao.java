package com.ideabinder.yizhi.base.provider.dao.manage;

import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/2/13.
 */
public interface IRoleDao {

    List<Integer> selectRoleIdsByUserId(int userId);
}
