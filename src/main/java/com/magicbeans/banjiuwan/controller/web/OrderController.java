package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.*;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.*;
import com.magicbeans.banjiuwan.util.*;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.management.relation.RoleStatus;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.io.Writer;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 订单控制器
 * Created by Eric Xie on 2017/3/7 0007.
 */
@Controller
@RequestMapping("/web/order")
public class OrderController extends BaseController {

    @Resource
    private OrderService orderService;
    @Resource
    private OrderCookService orderCookService;
    @Resource
    private CookService cookService;
    @Resource
    private UserService userService;

    @Resource
    private LogService logService;


    @RequestMapping("/countOrder")
    public @ResponseBody ViewData countOrder(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                orderService.countHome());
    }


    /**
     *  根据客户经理 统计 销售业绩
     * @param req
     * @param managerName
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/getOrdersByAccountManager")
    public @ResponseBody ViewData getOrdersByAccountManager(HttpServletRequest req,String managerName,Integer pageNO,Integer pageSize,
                                                            Long startTime,Long endTime){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        managerName = CommonUtil.isEmpty(managerName) ? null : managerName;
        Integer managerId = null;
        AdminUser adminUser = LoginHelper.getCurrentAdmin(req);
        if(StatusConstant.ACCOUNT_MANAGER.equals(adminUser.getRoleId())){
            managerId = adminUser.getId();
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                orderService.queryOrderByAccountManager(managerName,managerId,pageNO,pageSize,
                        startTime == null ? null : new Date(startTime),endTime == null ? null : new Date(endTime)));
    }
    /**
     *  客户经理销售数据导出
     * @param response
     * @param valueArray
     * @param titleArray
     */
    @RequestMapping("/exportOrderSalesExcel")
    public void exportOrderSalesExcel(HttpServletRequest req,HttpServletResponse response, String valueArray, String titleArray,
                                      String managerName,Long startTime,Long endTime){

        try {
            if(CommonUtil.isEmpty(valueArray,titleArray)){
                response.getWriter().print("字段不能为空");
                return;
            }
            managerName = CommonUtil.isEmpty(managerName) ? null : managerName;
            Integer managerId = null;
            AdminUser adminUser = LoginHelper.getCurrentAdmin(req);
            if(StatusConstant.ACCOUNT_MANAGER.equals(adminUser.getRoleId())){
                managerId = adminUser.getId();
            }
            orderService.exportOrderSalesExcel(response, valueArray, titleArray,
                    managerName, managerId,startTime == null ? null : new Date(startTime),endTime == null ? null : new Date(endTime));
        }catch (Exception e){
            logger.error(e.getMessage(),e);
        }
    }
    /**
     *
     * @param status
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/getOrders")
    public @ResponseBody ViewData getOrderList(String status, String orderNumber, String userPhone,
                                               String payMethods, String startTime,String endTime, Integer pageNO, Integer pageSize, Integer type){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                orderService.queryOrderForWeb(status,orderNumber,userPhone,payMethods,startTime,endTime,pageNO,pageSize,type));
    }

    /**
     * 分配厨师 给订单
     * @param orderId 订单ID
     * @param mainCook 主厨师ID
     * @param cooks 辅助厨师集合
     * @return null
     */
    @RequestMapping("/cookOrder")
    public @ResponseBody ViewData cookOrder(Integer orderId, Integer mainCook, String cooks, HttpServletRequest req){
        if(null == orderId || null == mainCook || CommonUtil.isEmpty(cooks)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Order order = orderService.queryOrderById(orderId);
        if(null == order){
            return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,ReturnMessage.MSG_OBJECT_NOT_EXIST.toString());
        }
        if(!OrderConstant.PENDING_CONFIRM.equals(order.getStatus())){
            return buildFailureJson(StatusConstant.ORDER_STATUS_ABNORMITY,ReturnMessage.ORDER_STATUS_ABNORMITY.toString());
        }
        AdminUser adminUser = LoginHelper.getCurrentAdmin(req);
        if(!StatusConstant.DISPATCHER.equals(adminUser.getRoleId()) && !StatusConstant.ADMINUSER.equals(adminUser.getRoleId())){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        try {
            orderCookService.batchAddOrderCook(mainCook,cooks,orderId,adminUser);
            List<Integer> cookIds = new ArrayList<Integer>();
            if(null != cooks && !"null".equals(cooks)){
                JSONArray jsonArray = JSONArray.fromObject(cooks);
                for (Object obj : jsonArray){
                    cookIds.add(Integer.parseInt(obj.toString()));
                }
            }
            cookIds.add(mainCook);
            // 查询厨师的设备token
            List<Cook> cooks1 =  cookService.queryCookDeviceToken(cookIds);
            // 待发送邮件的邮件列表
            List<String> emails = new ArrayList<String>();
            // 发送邮件、短信 、推送
            // 推送
            String mainCookName = "";
            for (Cook cook : cooks1){
                if(cook.getId().equals(mainCook)){
                    mainCookName = cook.getRealName();
                }
                // 推送
                Cook_PushMessageUtil.pushMessages(cook,StatusConstant.MSG_ORDER_COOK,null);
                // 短信
                SMSCode.sendMessage(StatusConstant.MSG_ORDER_COOK,cook.getPhoneNumber());
                // 装载邮件
                if(null != cook.getEmail()){
                    emails.add(cook.getEmail());
                }
            }
            // 发送邮件
            if(emails.size() > 0){
                new Thread(new SendEmailThread(emails,"您有新的订单等待处理","您有新的订单等待接受,订单号："+order.getOrderNumber())).start();
            }
            // 通知用户
            User user = userService.queryUserById(order.getUserId());
            PushMessageUtil.pushMessages(user, MessageFormat.format(StatusConstant.MSG_ORDER_COOK_USER,mainCookName.substring(0,1)),null);
            SMSCode.sendMessage(MessageFormat.format(StatusConstant.MSG_ORDER_COOK_USER,mainCookName.substring(0,1)),user.getPhoneNumber());
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }



    /**
     * 订单回收站处理
     * @param id 订单id
     * @param isEnable false 订单回收站列表  true 订单列表
     */
    @RequestMapping("/updateIsEnable")
    @ResponseBody
    public ViewData updateIsEnable(Integer id ,Boolean isEnable,HttpServletRequest request){
        try {
            if(null == id || null == isEnable){
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
            }
            Order order = orderService.queryOrderById(id);
            if (null == order) {
                return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
            }
            orderService.updateIsEnable(id, isEnable);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(id);
                log.setToOperateType(LogConstant.LOG_ORDER);
                log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
                if (isEnable) {
                    log.setDescribe("对订单[" + order.getOrderNumber() + "]进行了还原到订单列表的操作");
                } else {
                    log.setDescribe("对订单[" + order.getOrderNumber() + "]进行了放入订单回收站的操作");
                }
                logService.save(log,request);
            }

            return buildFailureJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
        } catch (Exception e) {
            logger.error("订单回收站处理失败");
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
    }


    /**
     * 订单详情
     * @param id 订单id
     */
    @RequestMapping("/info")
    @ResponseBody
    public ViewData info(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                orderService.queryOrderIncludeOtherInfo(id));
    }


    /**
     * 填写备注 （财务确认收款）
     * @param id
     * @param reMarket
     * @param type 1：确认收款并填写备注  2：填写备注
     */
    @RequestMapping("/saveReMarket")
    @ResponseBody
    public ViewData saveReMarket(Integer id,String reMarket,Integer type,HttpServletRequest request){
        if(null == id || null == reMarket || null == type){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        AdminUser adminUser = LoginHelper.getCurrentAdmin(request);

        Order order = orderService.queryOrderById(id);
        if (null == order) {
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }

        orderService.saveReMarket(id, adminUser.getUserName()+":"+reMarket + "; ",type);

        //记录日志
        {
            Log log = new Log();
            log.setToOperateId(id);
            log.setToOperateType(LogConstant.LOG_ORDER);
            log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
            if (type == 1) {
                log.setDescribe("对订单[" + order.getOrderNumber() + "]进行了确认收款并填写备注的操作");
            } else {
                log.setDescribe("对订单[" + order.getOrderNumber() + "]进行了追加备注的操作");
            }
            logService.save(log,request);
        }
        return buildFailureJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  订单导出 接口 2
     * @param response
     * @param valueArray
     * @param titleArray
     */
    @RequestMapping("/exportExcel")
    public void exportExcel(HttpServletResponse response, String valueArray, String titleArray,
                            String status,String orderNumber, String userPhone,
                            String payMethods, Integer type,String startTime,String endTime){

        try {
            if(CommonUtil.isEmpty(valueArray,titleArray)){
                response.getWriter().print("字段不能为空");
                return;
            }
            orderService.exportOrder(response, valueArray, titleArray,
                     status, orderNumber,  userPhone,
                     payMethods,  type ,startTime,endTime);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
        }
    }


}
