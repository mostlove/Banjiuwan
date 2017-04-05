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
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * Created by Eric Xie on 2017/3/9 0009.
 */

@Controller
@RequestMapping("/app/AliPayRecharge")
public class AliPayRechargeController extends BaseController {

    /**日志类*/
    private Logger logger = Logger.getLogger(AliPayController.class);
    @Resource
    private RechargeConfigService rechargeConfigService;
    @Resource
    private RechargeRecordService rechargeRecordService;
    @Resource
    private UserService userService;

    /**
     *  支付宝 签名
     * @param req
     * @return
     */
    @RequestMapping("/sign")
    @ResponseBody
    public ViewData sign(HttpServletRequest req,Integer rechargeId){
        if(null == rechargeId ){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW, ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        RechargeConfig rechargeConfig = rechargeConfigService.queryRechargeConfigById(rechargeId);
        if(null == rechargeConfig){
            return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,ReturnMessage.MSG_OBJECT_NOT_EXIST.toString());
        }
        String subject = "办酒碗会员充值";
        String body = "办酒碗会员充值";
        String total_fee = "0.01";
        if(CommonUtil.isEmpty(subject,body,total_fee)){
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION, "参数异常");
        }
        Map<String,Object> extendParams = new HashMap<String, Object>();
        extendParams.put("rechargeId", rechargeId);
        String localPath = req.getScheme() + "://"+req.getServerName() + ":"+req.getServerPort() + "/Banjiuwan";
        Map<String,String> params = new TreeMap<String,String>();
        params.put("service", AliPayConfig.SERVICE);
        params.put("out_trade_no", AliPayConfig.buildNumber());
        params.put("partner",  AliPayConfig.PARTNER);// 合作者ID
        params.put("_input_charset", "UTF-8");
        params.put("seller_id", AliPayConfig.SELLERID);
        params.put("notify_url", localPath+"/app/AliPayRecharge/aliPayCallBackApi");
        params.put("subject", subject);
        params.put("body", body);
        params.put("payment_type", "1");
        params.put("total_fee", total_fee);
        extendParams.put("out_trade_no",params.get("out_trade_no"));

        try {
            // 新增记录
            RechargeRecord rechargeRecord = new RechargeRecord();
            rechargeRecord.setStatus(0);
            rechargeRecord.setBalance(rechargeConfig.getBalance());
            rechargeRecord.setGiveBalance(rechargeConfig.getGiveBalance());
            rechargeRecord.setUserId(user.getId());
            rechargeRecord.setOutTradeNo(params.get("out_trade_no"));
            rechargeRecord.setPayMethod(PayMethodEnum.AliPay.ordinal());
            Integer rechargeRecordId = rechargeRecordService.addRechargeRecord(rechargeRecord);


            extendParams.put("rechargeRecordId",rechargeRecordId);
            params.put("passback_params", JSONObject.fromObject(extendParams).toString());
            String sign = SignUtils.sign(params, AliPayConfig.PRIVATE_KEY);
            sign = URLEncoder.encode(sign,"UTF-8");
            params.put("sign",sign);

        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE, "获取签名失败");
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, "签名成功", params);
    }

    /**
     *  AliPay支付成功后 回调接口
     * @param req
     * @return
     */
    @RequestMapping("/aliPayCallBackApi")
    @ResponseBody
    public void aliPayCallBack(HttpServletRequest req,HttpServletResponse resp){


        try {
            String payStatus = req.getParameter("trade_status");

            if(!"TRADE_SUCCESS".equals(payStatus)){
                return;
            }
            // 获取订单ID
            JSONObject jsonObj = JSONObject.fromObject(req.getParameter("extra_common_param"));
            Integer rechargeRecordId = Integer.parseInt(jsonObj.getString("rechargeRecordId"));

            RechargeRecord rechargeRecord = rechargeRecordService.queryRechargeRecord(rechargeRecordId);
            if(null == rechargeRecord){
                return;
            }
            // 支付宝回调 业务处理
            userService.updateUserRechargeService(rechargeRecord);
            resp.getWriter().print("success");
        } catch (Exception e) {
            logger.debug("支付宝回调业务处理失败.........",e);
        }
    }

}
