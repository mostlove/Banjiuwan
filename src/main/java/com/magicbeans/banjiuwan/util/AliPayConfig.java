package com.magicbeans.banjiuwan.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;


/**
 *  支付宝 配置类
 * @author QimouXie
 *
 */
public class AliPayConfig {
	
	/**支付宝私钥*/
//	public static final String PRIVATE_KEY = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMcvjYKK1RnT9KmXsRkILIk34MiaPKpHjMyjkglVMPntSQuTwNIJZtzcEgXyDobVmj8MlXoIFtI4znP1UxvXNti3/0MEy2mBLQwwxaQfxiK2HNWTJWPgeghxKxeXrbXeDjtbfdTqEPYdQk/51qZ3CBOQXesrQvnOnpzq6U36XX9NAgMBAAECgYEAti2LCzu5nq7aloaURuXP/gzqfe97zu40HDL67ahKbDyX04vnDvPkbdqmbWOv36jcNBBpYrylSs8EHNDjm5IiqUWpvDv9hYScKI9CrHAspKjuLGv3u3Kp0/ep2V7rdoaeGVv/xEqha41cU/z1jnrSULxMr1wQuWShrSQ7LFSMlCECQQDnLJIRTqW3IZO0CSgf59TYuro2GRmdDxW7AoerLKuCdS8G7Gr7rJpPZ8p9DFr+yBxDuQbJGkaViuHi+8XIYa7FAkEA3JOPSPlcYwDEYyYEzfVsThisD1A1OS7/4GTR2Hy6sE/kgQxuOvPrMfNNxL06dQ5ezjQMermCqWRbYqPEebaW6QJBAJw2tCXZ3YWYvPTF00VsJZqm47o2z+YgEXEjzoXPU75+bV7iV5DmHAhYfK5vsPXGR8NDvuAaT2QyS15VAFveFnkCQBVMSjGJoloM4OmR6jTY1bRUvYhc/kafOyW3lmuI353WmQG86YfXtYYFMCUnAFX9JTpT3ECdWPhyMEC9/2KhNsECQDl4eDNMlC0niUggjRhyRmh3epVgtOq5Crvf/kALnpasFmOstgTIazLDcGO9/G603xoFicHXgKlzngO6tB7TTS4=";
	public static final String PRIVATE_KEY = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAK+bgYUjoCr42+Q+Ke3V26YiqdIeYb/QLN9/DYGlaY2OVN6b7WQt9+cpR6RHmwiWa8d9N/o59zU+XwRxEI2aC7G3cH9Ib5CRiRssk5/+wudGJnqGo5hgVzF8R55ILzFKGMxvZ0TAUE4agtz9I/3iEnNOZuYG3M/xtZHN6oPHe4oZAgMBAAECgYEAre94JXh4/7dIjdUo0KM/kVnKHQ3swgGfQKvmo+BEIWq2E1wckVqarkML6+Lk42eiT5BurpFVk0447PxUaf0H0JYEgLd49Y8Ryo5YBkhHS3u3a8AVkPWGtRO7f3Wq63I/6piqrWGSkOvAdRDdq/PClg7Smzpp5dCRqYySGpYcvdECQQDYj8CCDwcRsXLXSBt27XgqLQD1X3Wxi5T/VNIHPuz0+xR/cdzr0OOeGWrLQVTx7IhtGNl8Nq44MtG1tupG2UGdAkEAz5ZyOh2FYMi5XZwsL4j5RjNU5odQH0iySpGekZgr1FDoqvc7ObK/6wAyPe051VUe75QfBJfEikVPdNpsU3oPrQJAH+rX6ZNDbHUlwtrqyVVof3bQjFl8ZCV5WURsDAtXKygSNlJWyB6qXXPLjJddaKZ+2O1vqGH6vWeoBsslrjl49QJBAKbL+N5vaANbZW4tFWfghIL+reJJqXxpmjDGjwXnopgHptvwqVr0ILc/wh72JTkgGypf9whmthpwFKcM9mugsUUCQH0fPbycJ/1PXVMDhpeAR7aBVm+raj02mkm7boMOG/sSCgEMZGWHttAIftrsBBpKENXenDtfx/LPQ/V1g1U4DcE=";
	/**支付宝公钥*/
	public static final String PUBLIC_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHL42CitUZ0/Spl7EZCCyJN+DImjyqR4zMo5IJVTD57UkLk8DSCWbc3BIF8g6G1Zo/DJV6CBbSOM5z9VMb1zbYt/9DBMtpgS0MMMWkH8YithzVkyVj4HoIcSsXl6213g47W33U6hD2HUJP+damdwgTkF3rK0L5zp6c6ulN+l1/TQIDAQAB";
	
	public static final String SERVICE = "mobile.securitypay.pay"; // 固定值
	
//	public static final String PARTNER = "2088711458041988"; // 合作者ID
	public static final String PARTNER = "2088421737281711"; // 合作者ID 客户

//	public static final String SELLERID = "2088711458041988"; // 商户账户
	public static final String SELLERID = "2088421737281711"; // 商户账户 客户

//	public static final String APPID = "2014121700020326"; // APPID
	public static final String APPID = "2016090101834622"; // APPID 客户

	public static final String CHARACTER = "utf-8";

	public static final String REFUND_SERVICE = "refund_fastpay_by_platform_pwd"; // 退款请求URL

	/**
	 * 支付宝提供给商户的服务接入网关URL(新)
	 */
	public static final String ALIPAY_GATEWAY_NEW = "https://mapi.alipay.com/gateway.do?";


	public static String buildNumber(){
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String code = simpleDateFormat.format(new Date()) + SMSCode.createRandomCode();
		return code;
	}


	/**
	 * 生成签名结果
	 * @param sPara 要签名的数组
	 * @return 签名结果字符串
	 */
	public static String buildRequestMysign(Map<String, String> sPara) {
		String prestr = AlipayCore.createLinkString(sPara); //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
		String mysign = "";
		mysign = RSA.sign(prestr, PRIVATE_KEY, "utf-8");
		return mysign;
	}

}
