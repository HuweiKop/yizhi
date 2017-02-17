package com.ideabinder.yizhi.base.provider.dao.manage;

import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/2/10.
 */
public interface IMoudleDao {

    List<String> selectAllMoudleNames();

    List<String> selectMoudleNameByRoleId(int id);

    List<String> selectMoudleNamesByRoleIds(List<Integer> items);
}
