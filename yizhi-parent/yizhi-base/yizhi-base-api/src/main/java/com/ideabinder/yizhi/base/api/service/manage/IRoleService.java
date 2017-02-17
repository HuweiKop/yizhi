package com.ideabinder.yizhi.base.api.service.manage;

import com.ideabinder.yizhi.base.api.model.response.BaseQueryResponseModel;

import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/2/10.
 */
public interface IRoleService {

    BaseQueryResponseModel<List<Integer>> getRoleIdsByUserId(int userId);

    BaseQueryResponseModel<List<String>> getAllMoudleNames();

    BaseQueryResponseModel<List<String>> getMoudleNamesByRoleId(int roleId);

    BaseQueryResponseModel<List<String>> getMoudleNamesByRoleIds(List<Integer> roleIds);

    BaseQueryResponseModel<List<String>> getAllFunctionNames();

    BaseQueryResponseModel<List<String>> getFunctionNamesByRoleId(int roleId);

    BaseQueryResponseModel<List<String>> getFunctionNamesByRoleIds(List<Integer> roleIds);
}
