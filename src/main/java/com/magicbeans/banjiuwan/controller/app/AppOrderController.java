package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.beans.*;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.enumutil.PayMethodEnum;
import com.magicbeans.banjiuwan.service.*;
import com.magicbeans.banjiuwan.util.*;
import com.sun.org.apache.xpath.internal.operations.Or;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by Eric Xie on 2017/3/3 0003.
 */

@Controller
@RequestMapping("/app/order")
public class AppOrderController extends BaseController {


    @Resource
    private UserCouponService userCouponService;
    @Resource
    private CouponFoodCategoryService couponFoodCategoryService;
    @Resource
    private OrderTimeConfigService orderTimeConfigService;
    @Resource
    private AllConfigService allConfigService;
    @Resource
    private ServiceConfigService serviceConfigService;
    @Resource
    private OrderService orderService;
    @Resource
    private CookTimeConfigService cookTimeConfigService;
    @Resource
    private UserService userService;
    @Resource
    private SpecialServiceService specialServiceService;
    @Resource
    private WaiterService waiterService;


    /**
     *  根据订单ID 查询订单详情 包括 厨师 等
     * @param orderId
     * @return
     */
    @RequestMapping("/queryOrderById")
    public @ResponseBody ViewData queryOrderById(Integer orderId){

        if(null == orderId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                orderService.queryOrderIncludeOtherInfo(orderId));
    }



    /**
     *  用户取消订单接口
     * @param orderId
     * @return
     */
    @RequestMapping("/cancelOrder")
    public @ResponseBody ViewData cancleOrder(Integer orderId){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        if(null == orderId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Order order = orderService.queryOrderById(orderId);
        if(null == order){
            return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,ReturnMessage.MSG_OBJECT_NOT_EXIST.toString());
        }
        if(!OrderConstant.PENDING_PAY.equals(order.getStatus()) && !OrderConstant.PENDING_CONFIRM.equals(order.getStatus())
                && !OrderConstant.PENDING_ORDERS.equals(order.getStatus()) && !OrderConstant.PENDING_SERVICE.equals(order.getStatus())){
            return buildFailureJson(StatusConstant.ORDER_STATUS_ABNORMITY,ReturnMessage.ORDER_STATUS_ABNORMITY.toString());
        }
        try {
            Order temp = new Order();
            temp.setId(orderId);
            temp.setStatus(OrderConstant.ORDER_CANCLE_ING);
            orderService.updateOrder(temp,null);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  厨师端 更新订单状态接口
     * @param orderId 订单ID
     * @param flag 0:确认接单 1:开始服务  2:服务完成
     * @return
     */
    @RequestMapping("/cookUpdateOrder")
    public @ResponseBody ViewData cookUpdateOrderStatus(Integer orderId,Integer flag){

        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof Cook)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        Cook cook = (Cook)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(cook.getIsValid())){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        if(null == orderId || null == flag){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Order order = orderService.queryOrderById(orderId);
        if(null == order){
            return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,ReturnMessage.MSG_OBJECT_NOT_EXIST.toString());
        }
        Order temp = new Order();
        temp.setId(orderId);
        try {
            if(0 == flag){
                // 确认接单操作
                if(!OrderConstant.PENDING_ORDERS.equals(order.getStatus())){
                    return buildFailureJson(StatusConstant.ORDER_STATUS_ABNORMITY,ReturnMessage.ORDER_STATUS_ABNORMITY.toString());
                }
                temp.setStatus(OrderConstant.PENDING_SERVICE);
            }
            else if(1 == flag){
                // 开始服务
                if(!OrderConstant.PENDING_SERVICE.equals(order.getStatus())){
                    return buildFailureJson(StatusConstant.ORDER_STATUS_ABNORMITY,ReturnMessage.ORDER_STATUS_ABNORMITY.toString());
                }
                temp.setStatus(OrderConstant.SERVICEING);
            }
            else if(2 == flag){
                // 服务完成
                if(!OrderConstant.SERVICEING.equals(order.getStatus())){
                    return buildFailureJson(StatusConstant.ORDER_STATUS_ABNORMITY,ReturnMessage.ORDER_STATUS_ABNORMITY.toString());
                }
                temp.setStatus(OrderConstant.FINISHED);
            }
            else{
                return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
            }
            orderService.updateOrder(temp,order);
            if(2 == flag){
                // 服务完成 推送给用户
                User user = userService.queryUserById(order.getUserId());
                SMSCode.sendMessage(StatusConstant.MSG_ORDER_FINISED_USER,user.getPhoneNumber());
                PushMessageUtil.pushMessages(user,StatusConstant.MSG_ORDER_FINISED_USER,null);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }



    /**
     *  线下支付
     * @param orderId
     * @return
     */
    @RequestMapping("/orderOffLinePay")
    public @ResponseBody ViewData offLinePay(Integer orderId){

        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        if(null == orderId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Order order = orderService.queryOrderById(orderId);
        if(null == order){
            return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,ReturnMessage.MSG_OBJECT_NOT_EXIST.toString());
        }
        if(!OrderConstant.PENDING_PAY.equals(order.getStatus())){
            return buildFailureJson(StatusConstant.ORDER_STATUS_ABNORMITY,ReturnMessage.ORDER_STATUS_ABNORMITY.toString());
        }
        Order temp = new Order();
        temp.setId(orderId);
        temp.setPayMethod(PayMethodEnum.Offline.ordinal());
        temp.setStatus(OrderConstant.PENDING_CONFIRM);
        temp.setIsConfirm(0); //  设置财务 未确认收款
        // 更新
        try {
            orderService.updateOrder(temp,order);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  订单创建 | 新增订单
     * @param order
     * @param shopCarIds
     * @return
     */
    @RequestMapping(value = "/addOrder",method = RequestMethod.POST)
    public @ResponseBody ViewData addOrder(Order order,String shopCarIds){

        if(CommonUtil.isEmpty(shopCarIds)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        order.setServiceDate(new Date(order.getServiceDateLong()));
        // 判断预约时间 是否有厨师
        List<Order> orders = orderService.queryCookByOrderServiceDate(order.getServiceDate());
        //  获取当前时刻的所有厨师集合
        List<Cook> cooks = new ArrayList<Cook>();
        for (Order temp : orders){
            cooks.addAll(temp.getCooks());
        }
        // 查询当前时刻 排班表的所有厨师
        List<Cook> allCooks = cookTimeConfigService.queryByTimeConfig(DateUtil.DateTime(order.getServiceDate(),"HH:mm"));
        if(null == allCooks || allCooks.size() == 0){
            return buildFailureJson(StatusConstant.Fail_CODE,"当前无厨师");
        }

        if(null != order.getWaiterNumber() && order.getWaiterNumber() > 0){
            // 查询 当前时刻 排班表中 服务员的数量 够不够
            Integer waiterCount = waiterService.queryWaiterByTimeConfig(DateUtil.DateTime(order.getServiceDate(),"HH:mm"));
            if(waiterCount == 0 ){
                return buildFailureJson(StatusConstant.Fail_CODE,"当前无服务员");
            }
            // 此时刻 服务员的数量
            Integer waiterNumber = orderService.countWaiterByServiceDate(order.getServiceDate());
            if(null != order.getWaiterNumber() && (waiterCount - waiterNumber) < order.getWaiterNumber()){
                return buildFailureJson(StatusConstant.Fail_CODE,"当前服务员数量不足");
            }
        }

        boolean haveCook = false;
        for (Cook cook : allCooks){
            if (!cooks.contains(cook)){
                // 随机设置一个厨师，用来锁定此厨师
                order.setMainCook(cook);
                haveCook = true;
                break;
            }
        }
        if(!haveCook){
            return buildFailureJson(StatusConstant.Fail_CODE,"当前无厨师");
        }
        Integer orderId = null;
        try {
            order.setWaiterNumber(order.getWaiterNumber() == null ? 0 : order.getWaiterNumber());
            orderId = orderService.addOrder(order,shopCarIds,user);
            // 发送短信 和 推送
            SMSCode.sendMessage(StatusConstant.MSG_NEW_ORDER_USER,user.getPhoneNumber());
            // 推送
            PushMessageUtil.pushMessages(user,StatusConstant.MSG_NEW_ORDER_USER,null);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"提交失败");
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,"提交成功",orderId);
    }


    /**
     *  查询 当前用户的优惠券信息 包含优惠券使用的区间信息 适合
     *  溢价、服务费、里程费
     * @return
     */
    @RequestMapping("/getConfigByCoupon")
    public @ResponseBody ViewData getConfigByCoupon(){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        // 装载 溢价、服务费、里程费 类型ID集合
        List<Integer> categoryList = new ArrayList<Integer>();
        categoryList.add(15);
        categoryList.add(16);
        categoryList.add(17);
        // 当前用户的 优惠券集合
        List<UserCoupon> userCoupons =  userCouponService.queryAllCouponByUser(user.getId());
        List<Integer> ids = new ArrayList<Integer>();
        for (UserCoupon userCoupon : userCoupons){
            ids.add(userCoupon.getCouponId());
        }
        Set<UserCoupon> isOkCoupons = new HashSet<UserCoupon>();
        if(ids.size() > 0){
            // 可用可匹配类型
            List<CouponFoodCategory> categorys = couponFoodCategoryService.getCouponFoodCategory(ids);
            for (Integer categoryId : categoryList){
                for (CouponFoodCategory coupon : categorys){
                    if(coupon.getFoodCategoryId().equals(categoryId)){
                        for (UserCoupon userCoupon : userCoupons){
                            // 装载可用的优惠券 以及 现金券
                            if(userCoupon.getCouponId().equals(coupon.getCouponId())) {
                                userCoupon.setFoodCategoryId(coupon.getFoodCategoryId());
                                isOkCoupons.add(userCoupon);
                            }
                        }
                    }
                }
            }
        }
        // 把匹配的券信息 装配完成
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),isOkCoupons);
    }

    /**
     *  填写订单页面 获取的配置信息 包括：
     *   优惠券、现金券、积分、会员卡、服务时间集合
     * @return
     */
    @RequestMapping("/getConfigInfo")
    public @ResponseBody ViewData getConfigInfo(String categoryPriceJsonData){

        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }

        if(CommonUtil.isEmpty(categoryPriceJsonData)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        // 结果集
        Map<String,Object> data = new HashMap<String, Object>();

        try {
            // 客户端的数据集合
            JSONArray jsonArray = JSONArray.fromObject(categoryPriceJsonData.substring(1,categoryPriceJsonData.length() - 1).replaceAll("\\\\",""));
            // 当前用户的 优惠券集合
            List<UserCoupon> userCoupons =  userCouponService.queryAllCouponByUser(user.getId());
            List<Integer> ids = new ArrayList<Integer>();
            for (UserCoupon userCoupon : userCoupons){
                ids.add(userCoupon.getCouponId());
            }
            // 待使用的 优惠券以及现金
//            List<UserCoupon> isOkCoupons = new ArrayList<UserCoupon>();
            Set<UserCoupon> isOkCoupons = new HashSet<UserCoupon>();
            if(ids.size() > 0){
                // 可用可匹配类型
                List<CouponFoodCategory> categorys = couponFoodCategoryService.getCouponFoodCategory(ids);

                for (Object objStr : jsonArray){
                    JSONObject jsonObj = JSONObject.fromObject(objStr);
                    for (CouponFoodCategory coupon : categorys){
                        if(coupon.getFoodCategoryId().equals(jsonObj.getInt("foodCategory"))){
                            for (UserCoupon userCoupon : userCoupons){
                                // 装载可用的优惠券 以及 现金券
                                if(userCoupon.getCouponId().equals(coupon.getCouponId())) {
                                    userCoupon.setFoodCategoryId(coupon.getFoodCategoryId());
                                    isOkCoupons.add(userCoupon);
                                }
                            }

                        }
                    }
                }
            }
            // 排除价格 不匹配的 优惠券
//            List<UserCoupon> okCoupons = new Has<UserCoupon>();
            Set<UserCoupon> okCoupons = new HashSet<UserCoupon>();
            Iterator<UserCoupon> iterator =  isOkCoupons.iterator();
            while (iterator.hasNext()){
                UserCoupon userCoupon = iterator.next();
                if(userCoupon.getType().equals(CouponType.CASH_COUPON.ordinal())){
                    okCoupons.add(userCoupon);
                    continue;
                }
                for (Object objStr : jsonArray){
                    JSONObject jsonObj = JSONObject.fromObject(objStr);
                    if(userCoupon.getNeedSpend() <= jsonObj.getDouble("price") &&
                            userCoupon.getFoodCategoryId().equals(jsonObj.getInt("foodCategory")) ){
                        okCoupons.add(userCoupon);
                        break;
                    }
                }
            }

            // 装载配置项
            Double price = 0.0;
            for (Object obj_ : jsonArray){
                JSONObject jsonObject = JSONObject.fromObject(obj_);
                price  += jsonObject.getDouble("price");
            }
            double servicePrice = 0.0;
//            List<ServiceConfig> serviceConfigs =  serviceConfigService.queryServiceConfig();
//            if(null != serviceConfigs && serviceConfigs.size() > 0){
//                for (int i = 0; i < serviceConfigs.size(); i++) {
//
//                    if(serviceConfigs.get(serviceConfigs.size() - 1).getPrice() < price){
//                        break;
//                    }
//
//                    if(i+1 == serviceConfigs.size()){
//                        break;
//                    }
//
//                    if(price < serviceConfigs.get(i).getPrice()){
//                        servicePrice = serviceConfigs.get(i).getAddPrice();
//                        break;
//                    }
//                    if(i + 1 < serviceConfigs.size()){
//                        if(price > serviceConfigs.get(i).getPrice() && price <= serviceConfigs.get(i+1).getPrice()){
//                            servicePrice = serviceConfigs.get(i+1).getAddPrice();
//                            break;
//                        }
//                    }
//                }
//            }
            // 查询时间配置
            data.put("timeConfig",orderTimeConfigService.queryAllTimeConfig());
            // 装载可用的优惠券以及现金券
            data.put("coupon",okCoupons);
            // 装载积分 配置比例
            data.put("config",allConfigService.getAllConfig());
            // 装载 服务费
            data.put("servicePrice",servicePrice);
            // 服务器时间戳
            data.put("time",System.currentTimeMillis());
            data.put("timeStr",DateUtil.DateTime(new Date(),"HH:mm"));
            // 餐具
            data.put("cj",specialServiceService.getCJ(user.getId()));
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),data);
    }


    /**
     *
     * @param status 3001:待支付状态  3002:已支付  3003:完成   APP/USER端 订单状态请求
     *               2008:待接单 2003:待服务 2004:服务中 2005:完成  APP/COOK 订单状态请求字段
     * @param pageNO 页码
     * @param pageSize 数量
     * @return null
     */
    @RequestMapping("/getOrders")
    public @ResponseBody ViewData getOrdersByUser(Integer status, Integer pageNO,Integer pageSize){

        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }

        if(null == pageNO || null == pageSize || null == status){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Object data = null;
        if(obj instanceof  User){
            User user = (User)obj;
            if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
                return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
            }
            data =  orderService.getOrdersByUser(user.getId(),status,pageNO,pageSize);
        }
        else if(obj instanceof Cook){
            Cook cook = (Cook)obj;
            if(StatusConstant.ACCOUNT_NON_VALID.equals(cook.getIsValid())){
                return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
            }
            data = orderService.getOrdersByCook(cook.getId(),status,pageNO,pageSize);
        }
        else{
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),data);
    }


    /**
     *  厨师 或者 用户 删除订单
     * @param orderId 订单ID  不能为空
     * @return
     */
    @RequestMapping("/delOrder")
    public @ResponseBody ViewData delOrder(Integer orderId){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }

        if(null == orderId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Order order = orderService.queryOrderById(orderId);
        if(null == order){
            return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,ReturnMessage.MSG_OBJECT_NOT_EXIST.toString());
        }
        if(!OrderConstant.FINISHED.equals(order.getStatus()) && !OrderConstant.PENDING_EVALUATE.equals(order.getStatus())
                && !OrderConstant.EVALUATED.equals(order.getStatus()) && !OrderConstant.ORDER_CANCLE.equals(order.getStatus())){
            return buildFailureJson(StatusConstant.ORDER_STATUS_ABNORMITY,ReturnMessage.ORDER_STATUS_ABNORMITY.toString());
        }
        Order temp = new Order();
        temp.setId(orderId);
        if(obj instanceof  User){
            User user = (User)obj;
            if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
                return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
            }
            temp.setUserIsValid(StatusConstant.VALID_NO);
        }
        else if(obj instanceof Cook){
            Cook cook = (Cook)obj;
            if(StatusConstant.ACCOUNT_NON_VALID.equals(cook.getIsValid())){
                return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
            }
            temp.setCookIsValid(StatusConstant.VALID_NO);
        }
        else{
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        orderService.delOrderByUser(temp);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }










}
