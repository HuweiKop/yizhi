package com.shudu;

/**
 * Created by Wei Hu (J) on 2017/3/13.
 */
public class ZongMethod extends AbstractMethod {

    AbstractMethod next = new ScopeMethod();

    @Override
    public int method(Map map) {
        int total = 0;

        return total + next(map, this.next);
    }
}
