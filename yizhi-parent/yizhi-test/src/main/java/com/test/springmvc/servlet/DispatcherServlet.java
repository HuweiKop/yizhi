package com.test.springmvc.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.io.File;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/2/27.
 */
public class DispatcherServlet extends HttpServlet {
    
    private List<String> packeName = new ArrayList<>();

    @Override
    public void init() throws ServletException {
        String basePackage = "com.test.springmvc.controller";
        
        scanBasePackage(basePackage);
        
        filterAndInstance();
        
        springIoc();
        
        handlerMaps();
    }

    private void handlerMaps() {
    }

    private void springIoc() {
    }

    private void filterAndInstance() {
    }

    private void scanBasePackage(String basePackage) {
        URL url = DispatcherServlet.class.getClassLoader().getResource("/" + basePackage.replaceAll("\\.", "/"));
        String pathFile = url.getFile();
        File file = new File(pathFile);
        String[] files = file.list();
        for(String path:files){
            File eachFile = new File(pathFile+path);
            if(eachFile.isDirectory()){
                scanBasePackage(basePackage+"."+eachFile.getName());
            }else if(eachFile.isFile()){
                System.out.println(basePackage+"."+eachFile.getName());
                packeName.add(basePackage+"."+eachFile.getName());
            }
        }
    }
}
