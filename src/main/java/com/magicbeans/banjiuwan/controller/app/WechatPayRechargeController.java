package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.beans.Order;
import com.magicbeans.banjiuwan.beans.RechargeConfig;
import com.magicbeans.banjiuwan.beans.RechargeRecord;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.enumutil.PayMethodEnum;
import com.magicbeans.banjiuwan.service.OrderService;
import com.magicbeans.banjiuwan.service.RechargeConfigService;
import com.magicbeans.banjiuwan.service.RechargeRecordService;
import com.magicbeans.banjiuwan.service.UserService;
import com.magicbeans.banjiuwan.util.*;
import com.magicbeans.banjiuwan.wx.WeChatConfig;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

/**
 * Created by Eric Xie on 2017/3/9 0009.
 */

@Controller
@RequestMapping("/app/WeChatPayRecharge")
public class WechatPayRechargeController extends BaseController {


    private Logger logger = Logger.getLogger(this.getClass());
    @Resource
    private RechargeConfigService rechargeConfigService;
    @Resource
    private RechargeRecordService rechargeRecordService;
    @Resource
    private UserService userService;


    /**
     * 微信签名
     * @param req
     * @param flag  0:APP 1:WeChat
     * @return
     */
    @RequestMapping("/sign")
    @ResponseBody
    public ViewData sign(HttpServletRequest req, Integer rechargeId,Integer flag) {
        if (null == rechargeId || null == flag) {
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, "字段不能为空");
        }
        if(flag != 0 && flag != 1){
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        Object obj_ = LoginHelper.getCurrentUser();
        if (null == obj_) {
            return buildFailureJson(StatusConstant.NOTLOGIN, "未登录");
        }
        if (!(obj_ instanceof User)) {
            return buildFailureJson(StatusConstant.NON_ALLOW, "没有权限");
        }
        User user = (User)obj_;
        RechargeConfig rechargeConfig = rechargeConfigService.queryRechargeConfigById(rechargeId);
        if (null == rechargeConfig) {
            return buildFailureJson(StatusConstant.Fail_CODE, "订单状态异常");
        }



        String body = "办酒碗会员充值";
        Integer total_fee = rechargeConfig.getBalance() * 100;
        Map<String, Object> extendsParams = new HashMap<String, Object>();
        try {
            body = URLEncoder.encode(body,"utf-8");
            String callBack = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + "/Banjiuwan";
            Map<String, Object> map = new TreeMap<String, Object>();

            map.put("out_trade_no", CommonUtil.buildOrderNumber());

            // 新增记录
            RechargeRecord rechargeRecord = new RechargeRecord();
            rechargeRecord.setStatus(0);
            rechargeRecord.setBalance(rechargeConfig.getBalance());
            rechargeRecord.setGiveBalance(rechargeConfig.getGiveBalance());
            rechargeRecord.setUserId(user.getId());
            rechargeRecord.setOutTradeNo(String.valueOf(map.get("out_trade_no")));
            rechargeRecord.setPayMethod(PayMethodEnum.WeChatPAY.ordinal());
            Integer rechargeRecordId = rechargeRecordService.addRechargeRecord(rechargeRecord);
            extendsParams.put("rechargeRecordId",rechargeRecordId);
            map.put("appid", WXConfig.APP_ID );
            map.put("mch_id", WXConfig.MCH_ID);
            map.put("attach", JSONObject.fromObject(extendsParams).toString()); // 扩展参数
            map.put("nonce_str", UUID.randomUUID().toString().replaceAll("-", ""));
            map.put("body", map.get("out_trade_no"));

            map.put("total_fee", 1); // 支付金额   单位：分
            map.put("spbill_create_ip", CommonUtil.getIpAddr(req));
            map.put("notify_url", callBack + "/app/WeChatPayRecharge/wxPayCallBackApi");
            map.put("trade_type", "APP");
            logger.debug("请求第一次签名的参数列表： "+map.toString());
            String sign = WXUtil.getSign(map, WXConfig.KEY);
            map.put("sign", sign);
            String result = XMLUtil.toXML(map);
            logger.debug("请求预支付ID的参数列表： "+result);
            String content = SendRequestUtil.httpPost(WXConfig.SIGN_URL, result);
            logger.debug("请求预支付ID： "+content);
            Map<String, Object> obj = XMLUtil.decodeXml(content);
            String prepayId = (String) obj.get("prepay_id");
            Map<String, Object> data = new TreeMap<String, Object>();
            data.put("partnerid", WXConfig.MCH_ID);
            data.put("package", "Sign=WXPay");
            data.put("prepayid", prepayId);
            data.put("timestamp", String.valueOf(System.currentTimeMillis() / 1000));
            data.put("noncestr", UUID.randomUUID().toString().replaceAll("-", ""));
            data.put("appid",  WXConfig.APP_ID);
            data.put("sign", WXUtil.getSign(data,WXConfig.KEY));
            logger.debug("返回客户端参数: "+data.toString());
            return buildSuccessJson(StatusConstant.SUCCESS_CODE, "获取成功", data);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, "获取签名失败");
        }
    }


    /**
     * 微信支付成功后  回调
     *
     * @return
     */
    @RequestMapping("/wxPayCallBackApi")
    @ResponseBody
    public void wxCallBack(HttpServletRequest request, HttpServletResponse resp) {
        try {
            InputStream is = request.getInputStream();
            ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = is.read(buffer)) != -1) {
                outSteam.write(buffer, 0, len);
            }
            outSteam.close();
            is.close();
            String result = new String(outSteam.toByteArray());
            Map<String, Object> map = XMLUtil.decodeXml(result);
            if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
                // 如果返回成功
                JSONObject obj = JSONObject.fromObject(map.get("attach")); //  接收扩展参数
                Integer rechargeRecordId = obj.getInt("rechargeRecordId");
                RechargeRecord rechargeRecord = rechargeRecordService.queryRechargeRecord(rechargeRecordId);
                if (null == rechargeRecord) {
                    return;
                }
                // 微信回调 业务处理
                userService.updateUserRechargeService(rechargeRecord);
                resp.getWriter().print(WXUtil.noticeStr("SUCCESS", ""));
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }
}
