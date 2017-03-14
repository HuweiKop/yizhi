package com.ideabinder.yizhi.base.provider;

import com.ideabinder.yizhi.base.api.service.disease.IDiseaseService;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;

/**
 * Created by Wei Hu (J) on 2017/1/4.
 */
public class Main {
    public static void  main(String[] args){
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"app-context.xml"});
        context.start();

        IDiseaseService service = context.getBean(IDiseaseService.class);
        service.getDiseaseList();

        try {
            System.in.read(); // 按任意键退出
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
