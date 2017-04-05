package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.Coupon;
import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.beans.UserCoupon;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.CouponService;
import com.magicbeans.banjiuwan.service.LogService;
import com.magicbeans.banjiuwan.service.UserCouponService;
import com.magicbeans.banjiuwan.service.UserService;
import com.magicbeans.banjiuwan.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * Created by Eric Xie on 2017/3/3 0003.
 */
@Controller
@RequestMapping("/web/userCoupon")
public class UserCouponController extends BaseController {


    @Resource
    private UserCouponService userCouponService;

    @Resource
    private LogService logService;

    @Resource
    private CouponService couponService;

    @Resource
    private UserService userService;
    @RequestMapping("/sendCoupon")
    public @ResponseBody ViewData addUserCoupon(Integer userId, Integer days, Integer couponId, String text , HttpServletRequest request){

        if(null == userId || null == days || null == couponId || CommonUtil.isEmpty(text)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        UserCoupon temp = new UserCoupon();
        temp.setIsValid(StatusConstant.VALID_YES);
        temp.setCouponId(couponId);
        temp.setDays(days);
        temp.setText(text);
        temp.setUserId(userId);
        temp.setStartTime(DateUtil.getMill(null));
        temp.setEndTime(DateUtil.getMill(DateUtil.getNextDay(new Date(),days)));
        userCouponService.addUserCoupon(temp);


        //记录日志
        {
            //获取劵信息
            Coupon coupon = couponService.info(couponId);

            User user = userService.queryUserById(userId);
            Log log = new Log();
            log.setToOperateId(userId);
            log.setToOperateType(LogConstant.LOG_FOOD);
            log.setOperateType(LogConstant.LOG_TYPE_DELETE);
            String typeMsg = "优惠券";
            if (coupon.getType() == 1) {
                typeMsg = "现金券";
            }
            log.setDescribe("对用户[" + user.getUserName() + "]进行了发放["+typeMsg+"(面值:"+coupon.getFaceValue()+"元，有效天数:"+days+"天)]的操作");
            logService.save(log,request);
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }



}
