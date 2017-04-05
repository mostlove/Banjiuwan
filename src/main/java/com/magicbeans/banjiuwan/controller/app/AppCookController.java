package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.beans.Cook;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.CookService;
import com.magicbeans.banjiuwan.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.MessageFormat;

/**
 * 移动端厨师管理
 * Created by Eric Xie on 2017/3/15 0015.
 */

@Controller
@RequestMapping("/app/cook")
public class AppCookController extends BaseController {

    @Resource
    private CookService cookService;

    /**
     *  厨师上线 下线接口
     * @param isOnline 0 下线  1 上线
     * @return
     */
    @RequestMapping("/onLine")
    public @ResponseBody ViewData cookOnline(Integer isOnline){
        if(null == isOnline){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,StatusConstant.FIELD_NOT_NULL.toString());
        }
        if(isOnline != 0 && isOnline != 1){
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN,ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof Cook)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        Cook cook = (Cook)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(cook.getIsValid())){
            return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        try {
            Cook cook1 = new Cook();
            cook1.setId(cook.getId());
            cook1.setIsOnline(isOnline);
            cookService.update(cook1);
            // 更新缓存
            cook.setIsOnline(isOnline);
            LoginHelper.replaceToken(cook.getToken(),cook);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  实时更新 厨师坐标
     * @param latLng
     * @return
     */
    @RequestMapping("/updateCookLatLng")
    public @ResponseBody ViewData updateCookLatLng(String latLng){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof Cook)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        Cook cook = (Cook)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(cook.getIsValid())){
            return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        if(CommonUtil.isEmpty(latLng)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        cook.setLatLng(latLng);
        boolean isSuccess = CookCacheUtil.updateCookLatLng(cook);
        if(isSuccess){
            return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
        }
        return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
    }

    /**
     *  根据手机号修改密码
     * @param phoneNumber
     * @param pwd
     * @return
     */
    @RequestMapping("/forgetPwd")
    public @ResponseBody ViewData forgetPwd(String phoneNumber,String pwd){

        if(CommonUtil.isEmpty(pwd,phoneNumber)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            cookService.updatePwdByPhone(phoneNumber,pwd);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"操作失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     * 查看 厨师是否存在
     * @param phoneNumber
     * @return
     */
    @RequestMapping("/checkCook")
    public @ResponseBody ViewData checkCook(String phoneNumber){
        if(CommonUtil.isEmpty(phoneNumber)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }

        Integer data = cookService.queryByPhone(phoneNumber,null) == null ? 0 : 1;
        if( data == 0){
            return buildFailureJson(StatusConstant.Fail_CODE,"帐号不存在");
        }
        String code = SMSCode.createRandomCode();
        boolean isSuccess = SMSCode.sendMessage(MessageFormat.format(StatusConstant.MSG_CODE,code),phoneNumber);
        if(!isSuccess){
            return buildFailureJson(StatusConstant.Fail_CODE,"短信发送频繁");
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),code);
    }





}
