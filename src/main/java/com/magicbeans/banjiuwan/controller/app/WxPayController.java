package com.magicbeans.banjiuwan.controller.app;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.magicbeans.banjiuwan.beans.Cook;
import com.magicbeans.banjiuwan.beans.Order;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.enumutil.PayMethodEnum;
import com.magicbeans.banjiuwan.service.CookTimeConfigService;
import com.magicbeans.banjiuwan.service.OrderService;
import com.magicbeans.banjiuwan.service.WaiterService;
import com.magicbeans.banjiuwan.util.*;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/app/wxPay")
public class WxPayController extends BaseController {


    private Logger logger = Logger.getLogger(this.getClass());
    @Resource
    private OrderService orderService;
    @Resource
    private CookTimeConfigService cookTimeConfigService;
    @Resource
    private WaiterService waiterService;


    /**
     * 微信签名
     * @param req
     * @param orderId 订单ID
     * @param flag  0:APP 1:WeChat
     * @return
     */
    @RequestMapping("/sign")
    @ResponseBody
    public ViewData sign(HttpServletRequest req, Integer orderId,Integer flag,String openid) {
        if (null == orderId || null == flag) {
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
        Order order = orderService.queryOrderById(orderId);
        if (null == order) {
            return buildFailureJson(StatusConstant.Fail_CODE, "订单状态异常");
        }
        if (!OrderConstant.PENDING_PAY.equals(order.getStatus())) {
            return buildFailureJson(StatusConstant.ORDER_STATUS_ABNORMITY, ReturnMessage.ORDER_STATUS_ABNORMITY.toString());
        }
//        // 判断预约时间 是否有厨师
//        List<Order> orders = orderService.queryCookByOrderServiceDate(order.getServiceDate());
//        //  获取当前时刻的所有厨师集合
//        List<Cook> cooks = new ArrayList<Cook>();
//        for (Order temp : orders){
//            cooks.addAll(temp.getCooks());
//        }
//        // 查询当前时刻 排班表的所有厨师
//        List<Cook> allCooks = cookTimeConfigService.queryByTimeConfig(DateUtil.DateTime(order.getServiceDate(),"HH:mm"));
//        if(null == allCooks || allCooks.size() == 0){
//            return buildFailureJson(StatusConstant.Fail_CODE,"当前无厨师");
//        }
//        // 查询 当前时刻 排班表中 服务员的数量 够不够
//        Integer waiterCount = waiterService.queryWaiterByTimeConfig(DateUtil.DateTime(order.getServiceDate(),"HH:mm"));
//        if(waiterCount == 0 ){
//            return buildFailureJson(StatusConstant.Fail_CODE,"当前无服务员");
//        }
//        // 此时刻 服务员的数量
//        Integer waiterNumber = orderService.countWaiterByServiceDate(order.getServiceDate());
//
//        if(null != order.getWaiterNumber() && (waiterCount - waiterNumber) < order.getWaiterNumber()){
//            return buildFailureJson(StatusConstant.Fail_CODE,"当前服务员数量不足");
//        }
//        boolean haveCook = false;
//        for (Cook cook : allCooks){
//            if (!cooks.contains(cook)){
//                // 随机设置一个厨师，用来锁定此厨师
//                order.setMainCook(cook);
//                haveCook = true;
//                break;
//            }
//        }
//        if(!haveCook){
//            return buildFailureJson(StatusConstant.Fail_CODE,"当前无厨师");
//        }
        String body = "办酒碗订单支付";
        Double fee = order.getOtherPay() ;
        Integer total_fee = (int) (fee * 100);
        Map<String, Object> extendsParams = new HashMap<String, Object>();
        extendsParams.put("orderId", orderId);
        try {
            body = URLEncoder.encode(body, "UTF-8");
            String callBack = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + "/Banjiuwan";
            Map<String, Object> map = new TreeMap<String, Object>();
            map.put("appid", WXConfig.APP_ID);
            map.put("mch_id", WXConfig.MCH_ID);
            map.put("attach", JSONObject.fromObject(extendsParams).toString()); // 扩展参数
            map.put("nonce_str", UUID.randomUUID().toString().replaceAll("-", ""));
            map.put("out_trade_no", CommonUtil.buildOrderNumber());
            map.put("body", map.get("out_trade_no"));
            extendsParams.put("out_trade_no",map.get("out_trade_no"));
            map.put("total_fee", 1); // 支付金额   单位：分
            map.put("spbill_create_ip", CommonUtil.getIpAddr(req));
            map.put("notify_url", callBack + "/app/wxPay/wxPayCallBackApi");
            map.put("trade_type", flag == 0 ? "APP" : "JSAPI");
            if(flag == 1){
                map.put("openid",openid);
            }
            map.put("attach", JSONObject.fromObject(extendsParams).toString()); // 扩展参数
            String sign = WXUtil.getSign(map, WXConfig.KEY);
            map.put("sign", sign);
            String result = XMLUtil.toXML(map);
            String content = SendRequestUtil.httpPost(WXConfig.SIGN_URL, result);
            Map<String, Object> obj = XMLUtil.decodeXml(content);
            String prepayId = (String) obj.get("prepay_id");
            Map<String, Object> data = new TreeMap<String, Object>();
            data.put("appid", WXConfig.APP_ID);
            data.put("partnerid", WXConfig.MCH_ID);
            data.put("prepayid", prepayId);
            data.put("noncestr", UUID.randomUUID().toString().replaceAll("-", ""));
            data.put("package", "Sign=WXPay");
            data.put("timestamp", String.valueOf(System.currentTimeMillis() / 1000));
            data.put("sign", WXUtil.getSign(data, WXConfig.KEY));
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
                Integer orderId = obj.getInt("orderId");
                String out_trade_no = obj.getString("out_trade_no");
                Order order = orderService.queryOrderById(orderId);
                if (null == order) {
                    return;
                }
                // 微信回调 业务处理
                orderService.updateOrderForOnLinePay(order,PayMethodEnum.WeChatPAY.ordinal(),out_trade_no);
                resp.getWriter().print(WXUtil.noticeStr("SUCCESS", ""));
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }


}
