package com.magicbeans.banjiuwan.controller;

import com.magicbeans.banjiuwan.beans.Order;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.service.OrderService;
import com.magicbeans.banjiuwan.service.UserService;
import com.magicbeans.banjiuwan.util.OrderConstant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 支付宝 有密退款 回调API
 * Created by Eric Xie on 2017/3/20 0020.
 */
@Controller
@RequestMapping("/aliPayRefund")
public class AliRefundCallBackApi extends BaseController {

    @Resource
    private OrderService orderService;
    @Resource
    private UserService userService;

    @RequestMapping("/callBackUri")
    public void callBackApi(HttpServletRequest request, HttpServletResponse response){

        logger.debug("支付宝 退款回调开始...");
        String batchNO = request.getParameter("batch_no");
        logger.debug("支付宝 退款回调 batchNO..."+batchNO);
        Order order = orderService.queryOrderByBatchNO(batchNO);
        if(null == order){
            return;
        }
        if(!OrderConstant.ORDER_CANCLE_ING.equals(order.getStatus())){
            return;
        }
        User user = userService.queryUserById(order.getUserId());
        try {
            logger.debug("支付宝 退款回调 业务开始处理...");
            orderService.cancelOrder(user,order);
            logger.debug("支付宝 退款回调 业务处理结束..");
            response.getWriter().print("success");
        }catch (Exception e){
            logger.error("支付宝有密退款 回调失败",e);
        }
    }

}
