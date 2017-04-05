package com.magicbeans.banjiuwan.controller.app;


import com.magicbeans.banjiuwan.beans.TransportationCostConfig;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.beans.UserAddress;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.TransportationCostConfigService;
import com.magicbeans.banjiuwan.service.UserAddressService;
import com.magicbeans.banjiuwan.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户地址管理 控制器
 * Created by Eric Xie on 2017/2/14 0014.
 */

@Controller
@RequestMapping("/app/address")
public class UserAddressController extends BaseController {

    @Resource
    private UserAddressService userAddressService;
    @Resource
    private TransportationCostConfigService transportationCostConfigService;

    /**
     *  新增用户地址
     * @param contact 联系人
     * @param contactPhone 联系电话
     * @param address 地址
     * @param detailAddress  详细地址
     * @return
     */
    @RequestMapping("/addAddress")
    @ResponseBody
    public ViewData addAddress(Integer gender,Integer isDefault,String lngLat,String contact,String contactPhone,String address,String detailAddress){

        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN,ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.ACCOUNT_NON_VALID,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        if(CommonUtil.isEmpty(contact,contactPhone,address,detailAddress,lngLat)
                || null == gender || null == isDefault){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        UserAddress userAddress = new UserAddress();
        userAddress.setUserId(user.getId());
        userAddress.setAddress(address);
        userAddress.setDetailAddress(detailAddress);
        userAddress.setContact(contact);
        userAddress.setContactPhone(contactPhone);
        userAddress.setLngLat(lngLat);
        userAddress.setIsDefault(isDefault);
        userAddress.setGender(gender);
        userAddress.setIsValid(StatusConstant.VALID_YES);
        userAddressService.add(userAddress);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  更新地址
     * @param addressId 地址ID
     * @param contact 联系人
     * @param contactPhone 联系电话
     * @param address 联系地址
     * @param detailAddress 详细地址
     * @param isDel 是否删除  0:删除  1:不删除
     * @return
     */
    @RequestMapping("/updateAddress")
    @ResponseBody
    public ViewData updateAddress(Integer gender, String lngLat,Integer addressId,String contact,String contactPhone,
                                  String address,String detailAddress,Integer isDel,Integer isDefault){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN,ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.ACCOUNT_NON_VALID,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        if(null == addressId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        if(CommonUtil.isEmpty(contact) && CommonUtil.isEmpty(contactPhone) && CommonUtil.isEmpty(address) &&
                CommonUtil.isEmpty(detailAddress) && null == isDel && CommonUtil.isEmpty(lngLat) && null == gender && null == isDefault){
            return  buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        UserAddress userAddress = new UserAddress();
        userAddress.setId(addressId);
        userAddress.setAddress(address);
        userAddress.setDetailAddress(detailAddress);
        userAddress.setContact(contact);
        userAddress.setLngLat(lngLat);
        userAddress.setGender(gender);
        userAddress.setIsDefault(isDefault);
        userAddress.setContactPhone(contactPhone);
        userAddress.setUserId(user.getId());
        userAddress.setIsValid(isDel);
        userAddressService.updateAddress(userAddress);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS_UPDATE.toString());
    }


    /**
     *  分页获取用户地址
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/getAddress")
    @ResponseBody
    public ViewData getAddress (Integer pageNO,Integer pageSize){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN,ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.ACCOUNT_NON_VALID,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                userAddressService.queryAddress(user.getId(),pageNO,pageSize));
    }

    /**
     *  通过ID 获取地址详情
     * @param id
     * @return
     */
    @RequestMapping("/queryAddressById")
    public @ResponseBody ViewData queryAddress(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                userAddressService.queryAddressById(id));
    }

    /**
     *  获取交通费用
     * @param addressId
     * @return
     */
    @RequestMapping("/getTransportationCost")
    public @ResponseBody ViewData getTransportationCost(Integer addressId){

        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN,ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.ACCOUNT_NON_VALID,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        if(null == addressId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }

        Map<String,Object> data = new HashMap<String, Object>();
        // 返回的状态 极其  距离
        UserAddress userAddress = userAddressService.queryAddressById(addressId);

        Integer distance = userAddressService.calculationTransportationCost(userAddress);
        if(-1 == distance){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        // 计算当前地址坐标 和 全局配置坐标 的 时间
        double pointTime = userAddressService.handlePointTime(userAddress);
        data.put("pointTime",pointTime);
        if(0 == distance){
            data.put("price",distance);
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),data);
        }
        distance = distance / 1000;
        // 交通费用配置集合
        List<TransportationCostConfig> costConfigs = transportationCostConfigService.queryAllConfig();
        if(null == costConfigs || costConfigs.size() == 0){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }

        if(costConfigs.get(0).getDistance() < distance){
            // 在服务范围外
            data.put("price",-1);
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,"服务范围外",data);
        }
        Double price = 0.0;
        for (int i = 0; i < costConfigs.size(); i++) {

            if(i + 1 < costConfigs.size()){
                if(costConfigs.get(i+1).getDistance()  <  distance && distance <= costConfigs.get(i).getDistance()){
                    price = costConfigs.get(i).getPrice();
                    break;
                }
            }
            else if(i + 1 == costConfigs.size()){
                price = costConfigs.get(i).getPrice();
            }

        }
        data.put("price",price);
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),data);
    }


    @RequestMapping("/delAddress")
    public @ResponseBody ViewData delUserAddress(Integer id){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN,ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.ACCOUNT_NON_VALID,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        userAddressService.delUserAddress(id);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  获取交通费用
     * @return
     */
    @RequestMapping("/isRange")
    public @ResponseBody ViewData getTransportationCost(String lngLat){

        if(CommonUtil.isEmpty(lngLat)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        // 返回的状态 极其  距离
        UserAddress userAddress = new UserAddress();
        userAddress.setLngLat(lngLat);
        Integer distance = userAddressService.calculationTransportationCost(userAddress);
        if(-1 == distance){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        if(0 == distance){
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),distance);
        }
        distance = distance / 1000;
        // 交通费用配置集合
        List<TransportationCostConfig> costConfigs = transportationCostConfigService.queryAllConfig();
        if(null == costConfigs || costConfigs.size() == 0){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        if(costConfigs.get(0).getDistance() < distance){
            // 在服务范围外
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,"服务范围外",-1);
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),1);
    }















}
