package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.beans.AdminUser;
import com.magicbeans.banjiuwan.beans.AllConfig;
import com.magicbeans.banjiuwan.beans.Cook;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.AdminUserService;
import com.magicbeans.banjiuwan.service.AllConfigService;
import com.magicbeans.banjiuwan.service.CookService;
import com.magicbeans.banjiuwan.service.UserService;
import com.magicbeans.banjiuwan.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.MessageFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * 用户 控制器
 * Created by Eric Xie on 2017/2/10 0010.
 */

@Controller
@RequestMapping("/app/user")
public class UserController extends BaseController {


    @Resource
    private UserService userService;
    @Resource
    private CookService cookService;
    @Resource
    private AllConfigService allConfigService;
    @Resource
    private AdminUserService adminUserService;




    /**
     *  分销提交接口
     * @param phoneNumber
     * @param code
     * @return
     */
    @RequestMapping("/distribution")
    public @ResponseBody ViewData distribution(String phoneNumber,String code){
        if(CommonUtil.isEmpty(phoneNumber,code)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        AdminUser adminUser = adminUserService.queryAdminUserByCode(code);
        if(null == adminUser || !adminUser.getRoleId().equals(StatusConstant.ACCOUNT_MANAGER)){
            return buildFailureJson(StatusConstant.Fail_CODE,"无效的提交");
        }
        User user = userService.queryByPhone(phoneNumber,null);
        if(null == user){
            User newUser = new User();
            newUser.setPhoneNumber(phoneNumber);
            newUser.setIsValid(StatusConstant.ACCOUNT_VALID);
            newUser.setUserName("用户"+CommonUtil.subMobile(phoneNumber));
            newUser.setAccumulate(0);
            newUser.setLastLogin(new Date());
            newUser.setUpdateTime(new Date());
            newUser.setSignature("这个用户很懒,什么也没有留下~");
            newUser.setBalance(0.00);
            newUser.setAdminUserId(adminUser.getId());
            newUser.setAdminDate(new Date());
            userService.register(newUser);
        }
        else{
            if(null != user.getAdminUserId()){
                return buildFailureJson(StatusConstant.Fail_CODE,"不能绑定");
            }
            User temp = new User();
            temp.setId(user.getId());
            temp.setAdminUserId(adminUser.getId());
            temp.setAdminDate(new Date());
            userService.update(temp);
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/getClientIp")
    public @ResponseBody ViewData getClcnetIp(HttpServletRequest request){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),CommonUtil.getIpAddr(request));
    }


    /**
     * 获取积分 和 配置文件
     * @return
     */
    @RequestMapping("/getAccumulateConfig")
    public @ResponseBody ViewData getAccountInfo(){
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
        AllConfig allConfig = allConfigService.getAllConfig();
        Map<String,Object> data = new HashMap<String, Object>();
        data.put("config",allConfig);
        data.put("accumulate",user.getAccumulate());
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),data);
    }

    /**
     * 发送短信
     * @param phoneNumber
     * @return
     */
    @RequestMapping("/sendCode")
    @ResponseBody
    public ViewData sendCode(String phoneNumber){

        if(null == phoneNumber){
            // 如果没有传参 则查看是否有token
            Object obj = LoginHelper.getCurrentUser();
            if(obj instanceof User){
                // 发送短信给用户
                User user = (User)obj;
                phoneNumber = user.getPhoneNumber();
            }
            else if(obj instanceof Cook){
                // 发送验证码给厨师
                Cook user = (Cook)obj;
                phoneNumber = user.getPhoneNumber();
            }
            else{
                return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,"参数异常");
            }
        }
        String code = SMSCode.createRandomCode();
        boolean isSuccess = SMSCode.sendMessage(MessageFormat.format(StatusConstant.MSG_CODE,code),phoneNumber);
        if(!isSuccess){
            return buildFailureJson(StatusConstant.Fail_CODE,"短信发送频繁");
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),code);
    }

    /**
     *
     * @param phoneNumber
     * @param flag 7: 用户  6: 厨师
     * @param deviceType 设备类型 0: android 1: ios
     * @param deviceToken 设备token
     * @return
     */
    @RequestMapping("/login")
    @ResponseBody
    public ViewData login_register(String phoneNumber,String password,Integer flag,String deviceToken,Integer deviceType){

        if(CommonUtil.isEmpty(phoneNumber) || null == flag){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }

        if(StatusConstant.USER.equals(flag)){
            // 如果是用户
            User user = userService.queryByPhone(phoneNumber,null);
            if(null == user){
                // 注册新用户
                User newUser = new User();
                newUser.setPhoneNumber(phoneNumber);
                newUser.setDeviceType(deviceType);
                newUser.setDeviceToken(deviceToken);
                newUser.setIsValid(StatusConstant.ACCOUNT_VALID);
                newUser.setUserName("用户"+CommonUtil.subMobile(phoneNumber));
                newUser.setAccumulate(0);
                newUser.setLastLogin(new Date());
                newUser.setUpdateTime(new Date());
                newUser.setSignature("这个用户很懒,什么也没有留下~");
                newUser.setBalance(0.00);
                newUser.setId(userService.register(newUser));
                String token = LoginHelper.addToken(newUser);
                newUser.setToken(token);
//                newUser.setBalance(null);
                return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"注册成功",newUser);
            }
            else{
                if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
                    return buildFailureJson(StatusConstant.Fail_CODE,"帐号无效");
                }
                // 登录成功 更新用户信息
                User temp = new User();
                temp.setId(user.getId());
                temp.setLastLogin(new Date());
                temp.setDeviceToken(deviceToken);
                temp.setDeviceType(deviceType);
                if(!CommonUtil.isEmpty(deviceToken) ){
                    temp.setDeviceToken(deviceToken);
                    user.setDeviceToken(deviceToken);
                    temp.setDeviceType(deviceType);
                    user.setDeviceType(deviceType);
                }
                String token = LoginHelper.addToken(user);
                temp.setToken(token);
                user.setToken(token);
                userService.update(temp);
//                user.setBalance(null);
                return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",user);
            }
        }
        else if(StatusConstant.COOK.equals(flag)){
            // 如果是厨师 厨师只有登录入口
            if(CommonUtil.isEmpty(password)){
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
            }
            Cook cook = cookService.queryByPhone(phoneNumber,password);
            if(null == cook){
                return buildFailureJson(StatusConstant.Fail_CODE,"用户名或者密码错误");
            }
            if(StatusConstant.ACCOUNT_NON_VALID.equals(cook.getIsValid())){
                return buildFailureJson(StatusConstant.Fail_CODE,"帐号无效");
            }
            // 更新厨师
            Cook temp = new Cook();
            temp.setId(cook.getId());
            if(!CommonUtil.isEmpty(deviceToken) && null != deviceType){
                temp.setDeviceToken(deviceToken);
                cook.setDeviceToken(deviceToken);
                temp.setDeviceType(deviceType);
                cook.setDeviceType(deviceType);
            }
            String token = LoginHelper.addToken(cook);
            temp.setToken(token);
            cook.setToken(token);
            cookService.update(temp);
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"登录成功",cook);
        }
        else{
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,"参数异常");
        }
    }


    /**
     *  更新用户信息
     * @param avatar 头像
     * @param userName 用户名|真实姓名
     * @param personalTaste 个人口味
     * @param likeCuisine 喜欢菜系
     * @return
     */
    @RequestMapping("/update")
    @ResponseBody
    public ViewData updateInfo(String avatar,String userName,String personalTaste,String likeCuisine,String password
    ,String signature){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
        }

        if(CommonUtil.isEmpty(avatar) && CommonUtil.isEmpty(userName) && CommonUtil.isEmpty(personalTaste)
                && CommonUtil.isEmpty(likeCuisine) && CommonUtil.isEmpty(password) && CommonUtil.isEmpty(signature)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }

        if(obj instanceof User){
            User user = (User)obj;
            if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
                return buildFailureJson(StatusConstant.Fail_CODE,"帐号无效");
            }
            User temp = new User();
            temp.setId(user.getId());
            if(!CommonUtil.isEmpty(avatar)){ temp.setAvatar(avatar);user.setAvatar(avatar);}
            if(!CommonUtil.isEmpty(userName)){temp.setUserName(userName);user.setUserName(userName);}
            if(!CommonUtil.isEmpty(personalTaste)){temp.setPersonalTaste(personalTaste);user.setPersonalTaste(personalTaste);}
            if(!CommonUtil.isEmpty(likeCuisine)){temp.setLikeCuisine(likeCuisine);user.setLikeCuisine(likeCuisine);}
            if(!CommonUtil.isEmpty(signature)){temp.setSignature(signature);user.setSignature(signature);}
            temp.setUpdateTime(new Date());
            user.setUpdateTime(new Date());
            userService.update(temp);
            LoginHelper.replaceToken(user.getToken(),user);
        }
        else if(obj instanceof Cook){
            Cook cook = (Cook)obj;
            if(StatusConstant.ACCOUNT_NON_VALID.equals(cook.getIsValid())){
                return buildFailureJson(StatusConstant.Fail_CODE,"帐号无效");
            }
            Cook temp =  new Cook();
            temp.setId(cook.getId());
            if(!CommonUtil.isEmpty(avatar)){ temp.setAvatar(avatar);cook.setAvatar(avatar);}
            if(!CommonUtil.isEmpty(userName)){temp.setRealName(userName);cook.setRealName(userName);}
            if(!CommonUtil.isEmpty(password)){temp.setPassword(password);cook.setPassword(password);}
            if(!CommonUtil.isEmpty(signature)){temp.setSignature(signature);cook.setSignature(signature);}
            temp.setUpdateTime(new Date());
            cook.setUpdateTime(new Date());
            if (null != cook.getAvatar() && cook.getAvatar().trim().length() > 0) {
                String[] a = cook.getAvatar().split("/");
                cook.setMapIcon(a[0]+"/"+a[1]+"/"+a[2]+"/"+a[3]+"/icon/"+a[4]);
                temp.setMapIcon(a[0]+"/"+a[1]+"/"+a[2]+"/"+a[3]+"/icon/"+a[4]);
            }
            cookService.update(temp);
            LoginHelper.replaceToken(cook.getToken(),cook);
        }
        else{
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,"参数异常");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"更新成功");
    }

    /**
     *  获取用户信息
     * @return
     */
    @RequestMapping("/getInfo")
    @ResponseBody
    public ViewData getInfo(){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
        }

        if(obj instanceof User){
            User user = (User)obj;
            if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
                return buildFailureJson(StatusConstant.Fail_CODE,"帐号无效");
            }
            User temp = new User();
            temp.setId(user.getId());
            temp.setLastLogin(new Date());
            userService.update(temp);
//            user.setBalance(null);
        }
        else if(obj instanceof Cook){
            Cook user = (Cook)obj;
            if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
                return buildFailureJson(StatusConstant.Fail_CODE,"帐号无效");
            }
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),obj);
    }

    /**
     *  登出
     * @return
     */
    @RequestMapping("/logout")
    @ResponseBody
    public ViewData logout(){
        Object obj = LoginHelper.getCurrentUser();
        if(obj instanceof Cook){
            Cook cook = (Cook)obj;
            CookCacheUtil.removedCook(cook);
        }
        LoginHelper.clearToken();
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  分页获取 用户 有效券信息
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/getCoupon")
    @ResponseBody
    public ViewData getCoupon(Integer pageNO,Integer pageSize){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN,ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        if(obj instanceof User){
            User user = (User)obj;
            if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
                return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
            }
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                    userService.queryByPage(pageNO,pageSize,user.getId()));
        }
        else{
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
    }






}
