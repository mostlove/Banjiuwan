package com.magicbeans.banjiuwan.util;

/**
 * 订单相关常量
 * Created by Eric Xie on 2017/3/6 0006.
 */
public class OrderConstant {


    /**待支付*/
    public static final Integer PENDING_PAY = 2001;
    /**待确认*/
    public static final Integer PENDING_CONFIRM = 2002;
    /**待接单*/
    public static final Integer PENDING_ORDERS = 2008;
    /**待服务*/
    public static final Integer PENDING_SERVICE = 2003;
    /**服务中*/
    public static final Integer SERVICEING = 2004;
    /**完成*/
    public static final Integer FINISHED = 2005;
    /**待评价*/
    public static final Integer PENDING_EVALUATE = 2006;
    /**评价完成*/
    public static final Integer EVALUATED = 2007;

    /**退款中*/
    public static final Integer ORDER_CANCLE_ING = 2009;

    /**退款成功*/
    public static final Integer ORDER_CANCLE = 2010;




    public static String getText(Integer status) {
        switch (status) {
            case 2001 : return "待支付";
            case 2002 : return "待确认";
            case 2003 : return "待服务";
            case 2004 : return "服务中";
            case 2005 : return "完成";
            case 2006 : return "待评价";
            case 2007 : return "评价完成";
            case 2008 : return "待接单";
            case 2009 : return "退款中";
            case 2010 : return "退款成功";
        }
        return "状态异常";
    }



}
