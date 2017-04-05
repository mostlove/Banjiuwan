package com.magicbeans.banjiuwan.util;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * 支付宝 退款
 * Created by Eric Xie on 2017/3/14 0014.
 */
public class AliPayRefund {


    public static void main(String[] args) {


        String detail_data = "201703131521478375"+"^0.01^正常退款";

        //把请求参数打包成数组
        Map<String, String> sParaTemp = new HashMap<String, String>();
        sParaTemp.put("service", AliPayConfig.REFUND_SERVICE);
        sParaTemp.put("partner", AliPayConfig.PARTNER);
        sParaTemp.put("_input_charset", "utf-8");
        sParaTemp.put("notify_url", "http://192.168.1.110");
        sParaTemp.put("seller_user_id", AliPayConfig.PARTNER);
        sParaTemp.put("refund_date", DateUtil.DateTime(new Date(),"yyyy-MM-dd HH:mm:ss"));
        sParaTemp.put("batch_no", CommonUtil.buildOrderNumber());
        sParaTemp.put("batch_num", "1");
        sParaTemp.put("detail_data", detail_data);

        //除去数组中的空值和签名参数
        Map<String, String> sPara = AlipayCore.paraFilter(sParaTemp);
        //生成签名结果
        String mysign = AliPayConfig.buildRequestMysign(sPara);

        //签名结果与签名方式加入请求提交参数组中
        sPara.put("sign", mysign);
        sPara.put("sign_type", "RSA");

        String url = SendRequestUtil.geturl(sPara,"https://mapi.alipay.com/gateway.do?");

        try {
            String result = SendRequestUtil.sendRequest(url,"GET");
            System.out.println(result);
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

}
