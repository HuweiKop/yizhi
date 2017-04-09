package com.huwei.dubbo;

import com.huwei.dubbo.bean.Product;

/**
 * Created by huwei on 2017/3/30.
 */
public interface IProductService {

    Product selectById(int id);
}
