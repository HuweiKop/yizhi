package com.yizhi.test.model;

import java.lang.annotation.*;

/**
 * Created by Wei Hu (J) on 2017/1/12.
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface IdName {
    String value() default "id";
}
