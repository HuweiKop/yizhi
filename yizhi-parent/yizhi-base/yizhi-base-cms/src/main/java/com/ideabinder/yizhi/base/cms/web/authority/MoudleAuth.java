package com.ideabinder.yizhi.base.cms.web.authority;

import java.lang.annotation.*;

/**
 * Created by Wei Hu (J) on 2017/2/9.
 */
@Target({ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface MoudleAuth {
    String value() default "";
}
