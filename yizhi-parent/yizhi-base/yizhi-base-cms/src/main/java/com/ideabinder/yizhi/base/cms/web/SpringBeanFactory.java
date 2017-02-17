package com.ideabinder.yizhi.base.cms.web;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;

/**
 * Created by Wei Hu (J) on 2017/2/10.
 */
public class SpringBeanFactory implements BeanFactoryAware {

    private static BeanFactory beanFactory;

    @Override
    public void setBeanFactory(BeanFactory beanFactory) throws BeansException {
        System.out.println("-------------bean factory -------------");
        this.beanFactory = beanFactory;
    }

    /**
     * 根据beanName名字取得bean
     *
     * @param beanName
     * @return
     */
    public static <T> T getBean(String beanName) {
        System.out.println("bean factory=========="+beanFactory);
        if (null != beanFactory) {
            return (T) beanFactory.getBean(beanName);
        }
        return null;
    }
}
