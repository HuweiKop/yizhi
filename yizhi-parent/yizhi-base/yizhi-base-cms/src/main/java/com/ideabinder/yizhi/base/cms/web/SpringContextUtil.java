package com.ideabinder.yizhi.base.cms.web;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * Created by Wei Hu (J) on 2017/2/10.
 */
public class SpringContextUtil implements ApplicationContextAware {

    private static ApplicationContext applicationContext;//Spring应用上下文环境

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        SpringContextUtil.applicationContext = applicationContext;
    }
    public static Object getBean(String name){
        return applicationContext.getBean(name);
    }
}
