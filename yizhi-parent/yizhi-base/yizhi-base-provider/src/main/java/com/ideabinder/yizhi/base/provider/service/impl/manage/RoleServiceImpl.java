package com.ideabinder.yizhi.base.provider.service.impl.manage;

import com.ideabinder.yizhi.base.api.model.response.BaseQueryResponseModel;
import com.ideabinder.yizhi.base.api.service.manage.IRoleService;
import com.ideabinder.yizhi.base.provider.dao.manage.IFunctionDao;
import com.ideabinder.yizhi.base.provider.dao.manage.IMoudleDao;
import com.ideabinder.yizhi.base.provider.dao.manage.IRoleDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/2/10.
 */
@Service("roleServiceImpl")
public class RoleServiceImpl implements IRoleService {

    @Resource
    IRoleDao roleDao;
    @Resource
    IMoudleDao moudleDao;
    @Resource
    IFunctionDao functionDao;

    @Override
    public BaseQueryResponseModel<List<Integer>> getRoleIdsByUserId(int userId) {
        return new BaseQueryResponseModel<>(this.roleDao.selectRoleIdsByUserId(userId));
    }

    @Override
    public BaseQueryResponseModel<List<String>> getAllMoudleNames() {
        return new BaseQueryResponseModel<>(this.moudleDao.selectAllMoudleNames());
    }

    @Override
    public BaseQueryResponseModel<List<String>> getMoudleNamesByRoleId(int roleId) {
        return new BaseQueryResponseModel<>(this.moudleDao.selectMoudleNameByRoleId(roleId));
    }

    @Override
    public BaseQueryResponseModel<List<String>> getMoudleNamesByRoleIds(List<Integer> roleIds) {
        return new BaseQueryResponseModel<>(this.moudleDao.selectMoudleNamesByRoleIds(roleIds));
    }

    @Override
    public BaseQueryResponseModel<List<String>> getAllFunctionNames() {
        return new BaseQueryResponseModel<>(this.functionDao.selectAllFunctionNames());
    }

    @Override
    public BaseQueryResponseModel<List<String>> getFunctionNamesByRoleId(int roleId) {
        return new BaseQueryResponseModel<>(this.functionDao.selectFunctionNameByRoleId(roleId));
    }

    @Override
    public BaseQueryResponseModel<List<String>> getFunctionNamesByRoleIds(List<Integer> roleIds) {
        return new BaseQueryResponseModel<>(this.functionDao.selectFunctionNamesByRoleIds(roleIds));
    }
}
