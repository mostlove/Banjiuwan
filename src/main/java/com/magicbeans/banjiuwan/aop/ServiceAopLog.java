package com.magicbeans.banjiuwan.aop;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author lzh
 * @create 2017/3/20 18:09
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface ServiceAopLog {

    /** 日志操作类型
     0 插入数据操作
     1 更新数据操作
     2 查询数据操作
     3 删除数据操作 */
    String operateType();

    /** 被操作的类型 */
    String toOperateType();

    /** 操作描述 */
    String describe() default "";
}
