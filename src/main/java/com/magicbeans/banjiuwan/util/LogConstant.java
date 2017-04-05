package com.magicbeans.banjiuwan.util;

import javax.swing.*;

/**
 * 日志类型
 * @author lzh
 * @create 2017/3/21 13:46
 */
public class LogConstant {

    /******* 日志操作类型 --- begin ******/

    /** 插入数据操作 */
    public static final Integer LOG_TYPE_SAVE = 0;

    /** 更新数据操作 */
    public static final Integer LOG_TYPE_UPDATE = 1;

    /** 查询数据操作 */
    public static final Integer LOG_TYPE_SELECT = 2;

    /** 删除数据操作 */
    public static final Integer LOG_TYPE_DELETE = 3;

    /******* 日志操作类型 --- end ******/


    /******* 被操作的类型 --- begin ******/

    /** 厨师 */
    public static final Integer LOG_COOK = 0;

    /** 用户 */
    public static final Integer LOG_USER = 1;

    /** 后台用户 */
    public static final Integer LOG_ADMINUSER = 2;

    /** 菜品 */
    public static final Integer LOG_FOOD = 3;

    /** 菜品类型 */
    public static final Integer LOG_FOOD_CATEGORY = 4;

    /** 套餐/坝坝宴 */
    public static final Integer LOG_FOOD_PACKAGE = 5;

    /** 订单 */
    public static final Integer LOG_ORDER = 6;

    /** banner */
    public static final Integer LOG_BANNER = 7;

    /** 专业服务 */
    public static final Integer LOG_SPECIAL = 8;

    /** 伴餐演奏 */
    public static final Integer LOG_ACT = 9;

    /** 婚庆 */
    public static final Integer LOG_WEDDING = 10;

    /** 婚庆--区域管理 */
    public static final Integer LOG_WEDDING_AREA = 11;

    /** 婚庆--配置管理 */
    public static final Integer LOG_WEDDING_SETTING = 12;

    /** 订单溢价 */
    public static final Integer LOG_ORDER_CONFIG_TIME = 13;

    /** 交通配置 */
    public static final Integer LOG_TRANSPORTATION = 14;

    /** 全局配置 */
    public static final Integer LOG_ALLCONFIG = 15;

    /** 服务费配置 */
    public static final Integer LOG_SERVICE_CONFIG = 16;

    /** 充值参数配置 */
    public static final Integer LOG_RECHARGE_CONFIG = 17;

    /** 权限配置 */
    public static final Integer LOG_POWER_CONFIG = 18;

    /** 首页字体配置 */
    public static final Integer LOG_INDEX_FONT_CONFIG = 19;



    /******* 被操作的类型 --- end ******/




}
