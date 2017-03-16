package com.shudu;

/**
 * Created by Wei Hu (J) on 2017/3/13.
 */
public abstract class AbstractMethod {
    public abstract int method(Map map);

    public int next(Map map, AbstractMethod next) {
        if(next!=null)
            return next.method(map);
        return 0;
    }
}
