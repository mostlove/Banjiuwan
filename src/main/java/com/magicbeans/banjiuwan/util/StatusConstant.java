package com.magicbeans.banjiuwan.util;

public class StatusConstant {
	

	/**账户有效*/
	public static final Integer ACCOUNT_VALID = 1;
	/**账户无效*/
	public static final Integer ACCOUNT_NON_VALID = 0;

	
	/**支付方式 之  余额支付*/
	public static final Integer PAYMETHOD_BANLANCE = 0;
	/**支付方式 之 支付宝支付*/
	public static final Integer PAYMETHOD_ALIPAY = 1;
	/**支付方式 之 微信支付*/
	public static final Integer PAYMETHOD_WXPAY = 2;
	/**支付方式 之 优惠券抵扣*/
	public static final Integer PAYMETHOD_COUPON = 3;
	
	
	// 钱包相关 wallet_type
	/** 钱包类型   余额*/
	public static final Integer BALANCE =0;
	/**钱包类型  优惠券  代金券和折扣券*/
	public static final Integer CASH_COUPON =1;
	//该钱包主人的类型  0:乘客  1:车主 2:平台
	/**乘客钱包*/
	public static final Integer PASSENGER_MONEY = 0; 
	/**车主钱包*/
	public static final Integer DRIVER_MONEY = 1;
	/**平台钱包*/
	public static final Integer TERRACE_MONEY = 2;
	/**代理商钱包*/
	public static final Integer AGENT_MONEY = 3;
	
	// 错误代码
	/**获取成功*/
	public static final Integer SUCCESS_CODE = 200;
	/**获取失败*/
	public static final Integer Fail_CODE = 202;
	/**第一次登录*/
	public static final Integer FRTST_LOGIN = 203;
	/**参数异常*/
	public static final Integer ARGUMENTS_EXCEPTION = 204;
	
	/**帐号未通过*/
	public static final Integer ACCOUNT_UNPASS = 205;
	
	
	/**对象不存在*/
	public static final Integer OBJECT_NOT_EXIST = 1002;
	/**字段不能为空*/
	public static final Integer FIELD_NOT_NULL= 1003;
	/**正在审核*/
	public static final Integer PENDING = 1004;
	/**未登录*/
	public static final Integer NOTLOGIN= 1005;
	/**没有数据*/
	public static final Integer  NO_DATA = 1006;
	/**账户被冻结*/
	public static final Integer ACCOUNT_FROZEN = 1007;
	/**订单无效*/
	public static final Integer ORDER_INVALID = 1008;
	/**订单状态异常*/
	public static final Integer ORDER_STATUS_ABNORMITY = 1009;
	/**对象已经存在*/
	public static final Integer OBJECT_EXIST = 1010;
	/**没有权限*/
	public static final Integer NON_ALLOW = 1011;
	/**密码为空*/
	public static final Integer PWD_EMPTY = 1012;
	/**时间无效*/
	public static final Integer TIME_INVALID = 1013;
	/**订单的人数错误*/
	public static final Integer PEOPLE_ERROR = 1019;

	// 设备类型
	/**android*/
	public static final Integer ANDROID=0;
	/**ios*/
	public static final Integer IOS = 1;
	
	
	//角色类型
	/**平台管理员*/
	public static final Integer ADMINUSER = 1;
	/**财务*/
	public static final Integer ACCOUNTANT  = 2;
	/**客服*/
	public static final Integer CUSTOMER = 3;
	/**客户经理*/
	public static final Integer ACCOUNT_MANAGER = 4;
	/**调度员*/
	public static final Integer DISPATCHER = 5;
	/**厨师*/
	public static final Integer COOK = 6;
	/**客户 | 用户*/
	public static final Integer USER = 7;
	/**服务员*/
	public static final Integer WAITER = 8;

	/**无效*/
	public static final Integer VALID_NO = 0;
	/**有效*/
	public static final Integer VALID_YES = 1;


	/**新下单 - 发送给用户*/
	public static final String MSG_NEW_ORDER_USER = "您已经下单,请等待处理";
	/**分配厨师 - 发送给用户*/
	public static final String MSG_ORDER_COOK_USER = "您的订单已经分配{0}厨师";
	/**订单完成 - 发送给用户*/
	public static final String MSG_ORDER_FINISED_USER = "您的订单已经服务完成，感谢您对我们的支持";


	/**订单被取消 - 发送给厨师*/
	public static final String MSG_ORDER_CANCLE_COOK = "有订单被取消.";
	/**有新的订单被分配 - 发送给厨师*/
	public static final String MSG_ORDER_COOK = "您新的订单等待处理";

	/**验证码类*/
	public static final String MSG_CODE = "您的验证码是{0}。如非本人操作，请忽略本短信";






	
	
	
	
	
	
	
	
	
	
	
	
}
