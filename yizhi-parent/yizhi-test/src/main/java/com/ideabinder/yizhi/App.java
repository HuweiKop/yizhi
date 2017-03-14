package com.ideabinder.yizhi;

import com.test.connection.MyPool;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
        List<String> list = Arrays.asList("b","c","a");
        list.sort((o1,o2)->o1.compareTo(o2));

        list.forEach(a-> System.out.println(a));

        MyPool pool = new MyPool();
        Runnable init = pool::init;
    }
}
