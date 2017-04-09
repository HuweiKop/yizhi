package com.huwei.dubbo;

import com.huwei.dubbo.bean.Product;

/**
 * Created by huwei on 2017/3/30.
 */
public class ProductServiceImpl implements IProductService {
    public Product selectById(int id) {
        Product product = new Product();
        product.setName("aaaa");
        return product;
    }
}
