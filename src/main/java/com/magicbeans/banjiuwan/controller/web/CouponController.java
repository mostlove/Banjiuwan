package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.Coupon;
import com.magicbeans.banjiuwan.beans.NewUserCoupon;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.CouponService;
import com.magicbeans.banjiuwan.service.NewUserCouponService;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Eric Xie on 2017/3/3 0003.
 */

@Controller
@RequestMapping("/web/coupon")
public class CouponController extends BaseController {


    @Resource
    private CouponService couponService;
    @Resource
    private NewUserCouponService newUserCouponService;

    /**
     *  设置 新用户注册赠送优惠券
     * @param days
     * @param couponId
     * @return
     */
    @RequestMapping("/setNewUserCoupon")
    public @ResponseBody ViewData setNewUserCoupon(Integer days,Integer couponId){
        if(null == days || null == couponId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        NewUserCoupon newUserCoupon = new NewUserCoupon();
        newUserCoupon.setCouponId(couponId);
        newUserCoupon.setDays(days);
        newUserCouponService.addNewUserCoupon(newUserCoupon);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  删除新用户注册赠送优惠券
     * @param couponId
     * @return
     */
    @RequestMapping("/delNewUserCoupon")
    public @ResponseBody ViewData delNewUserCoupon(Integer couponId){
        if( null == couponId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        newUserCouponService.delNewUserCoupon(couponId);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }




    /**
     *  分页获取 优惠券使用情况
     * @param type
     * @param phoneNumber
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/queryCouponUserDetail")
    public @ResponseBody ViewData queryCouponUserDetail(Integer type,String phoneNumber,
                                                        Integer isValid,Integer startTime,Integer endTime,Integer pageNO,Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        phoneNumber = CommonUtil.isEmpty(phoneNumber) ? null : phoneNumber;
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                couponService.getCouponUseDetail(type,phoneNumber,isValid,startTime,endTime,pageNO,pageSize));
    }

    /**
     * 统计用户优惠券数据导出 接口
     * @param response
     * @param valueArray
     * @param titleArray
     */
    @RequestMapping("/exportCouponUseDetail")
    public void exportCouponUseDetail(HttpServletResponse response, String valueArray, String titleArray,
                            Integer type,String phoneNumber,
                            Integer isValid,Integer startTime,Integer endTime){
        try {
            if(CommonUtil.isEmpty(valueArray,titleArray)){
                response.getWriter().print("字段不能为空");
                return;
            }
            couponService.exportCouponUseDetail(response,valueArray,titleArray,type,phoneNumber,isValid,startTime,endTime);
            //userService.exportStatistics(response,valueArray,titleArray,userName,mobile);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
        }

    }

    @RequestMapping("/addCoupon")
    public @ResponseBody ViewData addCoupon(Coupon coupon){
        try {
            couponService.addCoupon(coupon);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }



    @RequestMapping("/queryAllCoupon")
    public @ResponseBody ViewData queryAllCoupon(Integer type,Integer pageNO,Integer pageSize){

        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                couponService.queryAllCouponPage(type,pageNO,pageSize));
    }


    @RequestMapping("/updateCoupon")
    public @ResponseBody ViewData updateCoupon(Coupon coupon){
        if(null == coupon.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            couponService.updateCoupon(coupon);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    @RequestMapping("/delCoupon")
    public @ResponseBody ViewData deleCoupon(Integer  id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            couponService.delCoupon(id);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/queryAllCouponByType")
    public @ResponseBody ViewData queryAllCouponByType(Integer type){

        if(null == type){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                couponService.queryAllCouponByType(type));
    }




}
