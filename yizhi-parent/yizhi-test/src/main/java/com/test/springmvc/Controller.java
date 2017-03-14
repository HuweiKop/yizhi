package com.test.springmvc;

import java.lang.annotation.*;

/**
 * Created by Wei Hu (J) on 2017/2/27.
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Controller {
}
