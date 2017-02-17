package com.yizhi.test.dao.common;

import com.yizhi.test.sql.SqlModel;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/1/12.
 */
public interface ICommonDao<T> {
    T getById(int id);

    List<T> getByWhere(HashMap<String, Object> map);

    boolean insert(T bean);

    boolean updateById(T bean, Object id);
}
