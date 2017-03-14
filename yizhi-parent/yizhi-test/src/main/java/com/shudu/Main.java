package com.shudu;

/**
 * Created by Wei Hu (J) on 2017/3/13.
 */
public class Main {
    public static void main(String[] args){
        AbstractMethod method = new SameMethod();
        Map map = new Map();
        map.init();
        map.printMap();
        method.method(map);
        map.printMap();
    }
}
