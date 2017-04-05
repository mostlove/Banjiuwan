package com.magicbeans.banjiuwan.controller.app;


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

import java.net.URLEncoder;
import java.text.MessageFormat;
import java.util.*;


/**
 *  支付宝 签名 回调接口 控制层
 * @author QimouXie
 *
 */
@Controller
@RequestMapping("/app/aliPay")
public class AliPayController extends BaseController {
	
	/**日志类*/
	private Logger logger = Logger.getLogger(AliPayController.class);
	@Resource
	private OrderService orderService;
	@Resource
	private CookTimeConfigService cookTimeConfigService;
	@Resource
	private WaiterService waiterService;
	
	/**
	 *  支付宝 签名 
	 * @param req
	 * @param orderId 订单ID
	 * @return
	 */
	@RequestMapping("/sign")
	@ResponseBody
	public ViewData sign(HttpServletRequest req, Integer orderId){
		if(null == orderId ){
			return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
		}
		Object obj = LoginHelper.getCurrentUser();
		if(null == obj){
			return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
		}
		if(!(obj instanceof User)){
			return buildFailureJson(StatusConstant.NON_ALLOW, ReturnMessage.MSG_NON_ALLOW.toString());
		}
		Order order = orderService.queryOrderById(orderId);
		if(null == order){
			return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,ReturnMessage.MSG_OBJECT_NOT_EXIST.toString());
		}
		if(!OrderConstant.PENDING_PAY.equals(order.getStatus())){
			return buildFailureJson(StatusConstant.ORDER_STATUS_ABNORMITY,ReturnMessage.ORDER_STATUS_ABNORMITY.toString());
		}
//		// 判断预约时间 是否有厨师
//		List<Order> orders = orderService.queryCookByOrderServiceDate(order.getServiceDate());
//		//  获取当前时刻的所有厨师集合
//		List<Cook> cooks = new ArrayList<Cook>();
//		for (Order temp : orders){
//			cooks.addAll(temp.getCooks());
//		}
//		// 查询当前时刻 排班表的所有厨师
//		List<Cook> allCooks = cookTimeConfigService.queryByTimeConfig(DateUtil.DateTime(order.getServiceDate(),"HH:mm"));
//		if(null == allCooks || allCooks.size() == 0){
//			return buildFailureJson(StatusConstant.Fail_CODE,"当前无厨师");
//		}
//		// 查询 当前时刻 排班表中 服务员的数量 够不够
//		Integer waiterCount = waiterService.queryWaiterByTimeConfig(DateUtil.DateTime(order.getServiceDate(),"HH:mm"));
//		if(waiterCount == 0 ){
//			return buildFailureJson(StatusConstant.Fail_CODE,"当前无服务员");
//		}
//		// 此时刻 服务员的数量
//		Integer waiterNumber = orderService.countWaiterByServiceDate(order.getServiceDate());
//
//		if(null != order.getWaiterNumber() && (waiterCount - waiterNumber) < order.getWaiterNumber()){
//			return buildFailureJson(StatusConstant.Fail_CODE,"当前服务员数量不足");
//		}
//		boolean haveCook = false;
//		for (Cook cook : allCooks){
//			if (!cooks.contains(cook)){
//				// 随机设置一个厨师，用来锁定此厨师
//				order.setMainCook(cook);
//				haveCook = true;
//				break;
//			}
//		}
//		if(!haveCook){
//			return buildFailureJson(StatusConstant.Fail_CODE,"当前无厨师");
//		}
		String subject = "办酒碗订单支付";
		String body = "办酒碗订单支付";
		String total_fee = "0.01";
		if(CommonUtil.isEmpty(subject,body,total_fee)){
			return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION, "参数异常");
		}
		Map<String,Object> extendParams = new HashMap<String, Object>();
		extendParams.put("orderId", orderId);
		String localPath = req.getScheme() + "://"+req.getServerName() + ":"+req.getServerPort() + "/Banjiuwan";
		Map<String,String> params = new TreeMap<String,String>();
		params.put("service", AliPayConfig.SERVICE);
		params.put("out_trade_no", AliPayConfig.buildNumber());
		params.put("partner",  AliPayConfig.PARTNER);// 合作者ID
		params.put("_input_charset", "UTF-8");
		params.put("seller_id", AliPayConfig.SELLERID);
		params.put("notify_url", localPath+"/app/aliPay/aliPayCallBackApi");
		params.put("subject", subject);
		params.put("body", body);
		params.put("payment_type", "1");
		params.put("total_fee", total_fee);
		extendParams.put("out_trade_no",params.get("out_trade_no"));
		params.put("passback_params", JSONObject.fromObject(extendParams).toString());
		try {
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

			Integer orderId = jsonObj.getInt("orderId");
			String out_trade_no = req.getParameter("trade_no");
			Order order = orderService.queryOrderById(orderId);
			if(null == order){
				return;
			}
			// 支付宝回调 业务处理
			orderService.updateOrderForOnLinePay(order,PayMethodEnum.AliPay.ordinal(),out_trade_no);
			resp.getWriter().print("success");
		} catch (Exception e) {
			logger.debug("支付宝回调业务处理失败.........",e);
		}
	}
	

}
