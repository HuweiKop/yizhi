package com.test.test;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;

/**
 * Created by Wei Hu (J) on 2017/2/27.
 */
public class Test {
    public static void main(String[] args) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        ArrayList<Integer> arrayList = new ArrayList<>();
        arrayList.add(1);
        arrayList.getClass().getMethod("add", Object.class).invoke(arrayList, "aaa");
        for (int i = 0; i < arrayList.size(); i++) {
            System.out.println(arrayList.get(i));
        }
    }
}
