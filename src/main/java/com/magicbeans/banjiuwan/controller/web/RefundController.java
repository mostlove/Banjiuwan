package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.Order;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.enumutil.PayMethodEnum;
import com.magicbeans.banjiuwan.service.OrderService;
import com.magicbeans.banjiuwan.service.UserService;
import com.magicbeans.banjiuwan.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * 后台退款
 * Created by Eric Xie on 2017/3/20 0020.
 */
@Controller
@RequestMapping("/web/refund")
public class RefundController extends BaseController {



    @Resource
    private OrderService orderService;
    @Resource
    private UserService userService;

    @RequestMapping("/refundSubmit")
    public String refundSubmit(Integer orderId, Model model, HttpServletRequest req){

        if(null == orderId){
            model.addAttribute("sbHtml","参数不能为空");
            return "pay";
        }
        Order order = orderService.queryOrderById(orderId);
        if(null == order){
            model.addAttribute("sbHtml","订单不存在");
            return "pay";
        }
        if(!OrderConstant.ORDER_CANCLE_ING.equals(order.getStatus())){
            model.addAttribute("sbHtml","订单状态异常");
            return "pay";
        }

        String localPath = req.getScheme() + "://"+req.getServerName() + ":"+req.getServerPort() + "/Banjiuwan";

        try {
            if(null == order.getPayMethod() && OrderConstant.ORDER_CANCLE_ING.equals(order.getStatus())){
                User user = userService.queryUserById(order.getUserId());
                orderService.cancelOrder(user,order);
                model.addAttribute("sbHtml","操作成功");
                return "pay";
            }
            if(PayMethodEnum.AliPay.ordinal() == order.getPayMethod()){
                String html = orderService.updateAliPayRefund(order,localPath+"/aliPayRefund/callBackUri");
                model.addAttribute("sbHtml",html);
            }
            else if(PayMethodEnum.WeChatPAY.ordinal() == order.getPayMethod()){
                User user = userService.queryUserById(order.getUserId());
                orderService.updateWeChatPayRefund(order,user);
                model.addAttribute("sbHtml","操作成功");
            }
            else if(PayMethodEnum.WeChatClientPay.ordinal() == order.getPayMethod()){
                User user = userService.queryUserById(order.getUserId());
                orderService.updateWeChatClientPayRefund(order,user);
                model.addAttribute("sbHtml","操作成功");
            }
            else if(PayMethodEnum.Offline.ordinal() == order.getPayMethod()){
                User user = userService.queryUserById(order.getUserId());
                orderService.cancelOrder(user,order);
                model.addAttribute("sbHtml","操作成功");
            }
            else if(4 == order.getPayMethod()){
                User user = userService.queryUserById(order.getUserId());
                orderService.cancelOrder(user,order);
                model.addAttribute("sbHtml","操作成功");
            }
            else{
                model.addAttribute("sbHtml","数据异常");
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            model.addAttribute("sbHtml","数据异常");
        }
        return "pay";
    }







}
