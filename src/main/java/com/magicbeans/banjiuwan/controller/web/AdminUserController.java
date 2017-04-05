package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.*;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.AdminUserService;
import com.magicbeans.banjiuwan.service.CookService;
import com.magicbeans.banjiuwan.service.LogService;
import com.magicbeans.banjiuwan.service.UserService;
import com.magicbeans.banjiuwan.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.InetAddress;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * 后台管理人员 控制器
 * Created by Eric Xie on 2017/2/15 0015.
 */

@Controller
@RequestMapping("/web/user")
public class AdminUserController extends BaseController {

    @Resource
    private AdminUserService adminUserService;

    @Resource
    private UserService userService;
    @Resource
    private CookService cookService;

    @Resource
    private LogService logService;


    /**
     * 修改后台用户的密码
     * @param oldPassword
     * @param newPassword
     * @param userId
     * @return
     */
    @RequestMapping("/updateUserPwd")
    public @ResponseBody ViewData updateUserPwd(String oldPassword,String newPassword,Integer userId){
        if(CommonUtil.isEmpty(oldPassword,newPassword) || null == userId){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        AdminUser admin = adminUserService.queryAdminUserById(userId);
        if(null == admin){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        if(!admin.getPassword().equals(oldPassword)){
            return buildFailureJson(StatusConstant.Fail_CODE,"原始密码不对");
        }
        try {
            AdminUser user = new AdminUser();
            user.setId(userId);
            user.setPassword(newPassword);
            adminUserService.updateAdminUser(user);
            LoginHelper.clearToken();
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"修改失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  解冻 冻结 账户
     * @param id
     * @param isValid
     * @param flag 0:用户 1:后台用户  2:厨师
     * @return
     */
    @RequestMapping("/updateIsValid")
    public @ResponseBody ViewData frozenAccount(Integer id,Integer isValid,Integer flag,HttpServletRequest request){
        if(null == id || null == isValid){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            Log log = new Log();
            log.setToOperateId(id);
            String msg = "冻结";
            if (isValid == 1) {
                msg = "解除冻结";
            }
            if(0 == flag){
                User sqlUser = userService.queryUserById(id);
                if(null == sqlUser){
                    return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,ReturnMessage.MSG_OBJECT_NOT_EXIST.toString());
                }
                User user = new User();
                user.setId(id);
                user.setIsValid(isValid);
                userService.update(user);
                LoginHelper.delObject(sqlUser.getToken());

                {
                    log.setToOperateType(LogConstant.LOG_USER);
                    log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
                    log.setDescribe("对用户[" + sqlUser.getUserName() + "]的账号进行了"+msg+"操作");
                }

            }
            else if(1 == flag){
                AdminUser sqlAdminUser = adminUserService.getAdminUserByIdForWeb(id);
                if(null == sqlAdminUser){
                    return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,ReturnMessage.MSG_OBJECT_NOT_EXIST.toString());
                }
                AdminUser adminUser = new AdminUser();
                adminUser.setId(id);
                adminUser.setIsValid(isValid);
                adminUserService.updateAdminUser(adminUser);
                {
                    log.setToOperateType(LogConstant.LOG_ADMINUSER);
                    log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
                    log.setDescribe("对后台用户[" + sqlAdminUser.getUserName() + "]的账号进行了"+msg+"操作");
                }
            }
            else if(2 == flag){
                Cook sqlCook = cookService.queryCookById(id);
                if(null == sqlCook){
                    return buildFailureJson(StatusConstant.OBJECT_NOT_EXIST,ReturnMessage.MSG_OBJECT_NOT_EXIST.toString());
                }
                Cook cook = new Cook();
                cook.setId(id);
                cook.setIsValid(isValid);
                cookService.update(cook);
                LoginHelper.delObject(sqlCook.getToken());
                {
                    log.setToOperateType(LogConstant.LOG_COOK);
                    log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
                    log.setDescribe("对厨师[" + sqlCook.getRealName() + "]的账号进行了"+msg+"操作");
                }
            }
            else {
                return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
            }
            //记录日志
            logService.save(log,request);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    @RequestMapping("/buildQrCode")
    public @ResponseBody void buildQrCode(String code, HttpServletResponse response,HttpServletRequest request )  {
        Calendar ca = Calendar.getInstance();
        String filePath = "QrCode/" + ca.get(Calendar.YEAR) + "/" + ca.get(Calendar.MONTH) + "/" + ca.get(Calendar.DAY_OF_MONTH);
        String path = filePath+UuidUtil.get32UUID()+".png";
//        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        ServletContext servletContext = request.getSession().getServletContext();
        path = servletContext.getRealPath("/"+path);
        File file = new File(path);
        try {
            if (!file.exists()) {
                if (!file.getParentFile().exists()) {
                    file.getParentFile().mkdirs();
                }
                file.createNewFile();
            }
            StringBuffer picURL = new StringBuffer();
            picURL.append(request.getScheme() + "://");
//            picURL.append(InetAddress.getLocalHost().getHostAddress() + ":");
//            picURL.append(request.getServerPort() + "");
            picURL.append(request.getHeader("Host")+"");
            picURL.append(request.getContextPath() + "/");
            picURL.append("app/page/share?code="+code);
            String url = picURL.toString();
            QrCodeUtil.encodeQRCodeImage(url, null, path.replaceAll("-",""), 300, 300);
            String filename = file.getName();// 获取日志文件名称
            InputStream fis = new BufferedInputStream(new FileInputStream(path));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            response.reset();
            // 先去掉文件名称中的空格,然后转换编码格式为utf-8,保证不出现乱码,这个文件名称用于浏览器的下载框中自动显示的文件名
            response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.replaceAll(" ", "").getBytes("utf-8"),"iso8859-1"));
            response.addHeader("Content-Length", "" + file.length());
            OutputStream os = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            os.write(buffer);// 输出文件
            os.flush();
            os.close();
        }catch (Exception e){
            e.printStackTrace();
            logger.error("二维码生成失败",e);
        }
    }

    /**
     *  统计用户 消费数据
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/getUserConsumptionStatistics")
    public @ResponseBody ViewData getUserConsumptionStatistics(Integer pageNO,Integer pageSize,String userName ,String mobile,
                                                               Long startTime,Long endTime){
        if((null == pageNO && null != pageSize) || (null == pageSize && null != pageNO)){
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                userService.statisticsUser(pageNO,pageSize,userName,mobile,
                        startTime == null ? null : new Date(startTime),endTime == null ? null : new Date(endTime)));
    }


    /**
     *  统计用户 消费数据导出 接口
     * @param response
     * @param valueArray
     * @param titleArray
     */
    @RequestMapping("/exportStatisticsExcel")
    public void exportExcel(HttpServletResponse response, String valueArray, String titleArray,
                            String userName ,String mobile,Long startTime,Long endTime){
        try {
            if(CommonUtil.isEmpty(valueArray,titleArray)){
                response.getWriter().print("字段不能为空");
                return;
            }
            userService.exportStatistics(response,valueArray,titleArray,userName,mobile,
                    startTime == null ? null : new Date(startTime),endTime == null ? null : new Date(endTime));
        }catch (Exception e){
            logger.error(e.getMessage(),e);
        }

    }


    /**
     * 后台登录
     * @param phoneNumber 手机号
     * @param password 密码
     * @param request 请求对象
     * @return
     */
    @RequestMapping("/login")
    @ResponseBody
    public ViewData login(String phoneNumber, String password, HttpServletRequest request){
        if(CommonUtil.isEmpty(phoneNumber,password)){
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL_ACC_PWD_ERROR.toString());
        }
        AdminUser user = adminUserService.queryByPhone(phoneNumber,password);
        if(null == user){
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL_ACC_PWD_ERROR.toString());
        }
        if(user.getIsValid().equals(StatusConstant.ACCOUNT_NON_VALID)){
            return buildFailureJson(StatusConstant.Fail_CODE, "账户被冻结");
        }
        request.getSession().setAttribute(LoginHelper.SESSION_USER,user);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS_LOGIN.toString());
    }


    /**
     *  分页获取 用户信息
     * @param phoneNumber 手机号
     * @param userName 用户名
     * @param pageNO 页码
     * @param pageSize 数量
     * @return
     */
    @RequestMapping("/getUsers")
    @ResponseBody
    public ViewData getUsers(String phoneNumber,String userName,Integer pageNO,Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        if(CommonUtil.isEmpty(phoneNumber)){
            phoneNumber = null;
        }
        if(CommonUtil.isEmpty(userName)){
            userName = null;
        }
        Page<User> data = userService.queryByWebPage(phoneNumber,userName,pageNO,pageSize);
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),data);
    }

    /**
     * 统计用户 数据导出 接口
     * @param response
     * @param valueArray
     * @param titleArray
     */
    @RequestMapping("/exportUserExcel")
    public void exportUserExcel(HttpServletResponse response, String valueArray, String titleArray,
                            String userName ,String phoneNumber){
        try {
            if(CommonUtil.isEmpty(valueArray,titleArray)){
                response.getWriter().print("字段不能为空");
                return;
            }
            userService.exportUserExcel(response,valueArray,titleArray,userName,phoneNumber);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
        }

    }
    /**
     *  获取 后台管理者
     * @param userName
     * @param phoneNumber
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/getAdminUser")
    public @ResponseBody ViewData getAdminUser(String userName,String phoneNumber,Integer pageNO,Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        userName = CommonUtil.isEmpty(userName) ? null : userName;
        phoneNumber = CommonUtil.isEmpty(phoneNumber) ? null : phoneNumber;
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                adminUserService.queryAdminUserForWeb(userName,phoneNumber,pageNO,pageSize));
    }


    /**
     *  新增 后台用户
     * @param adminUser
     * @return
     */
    @RequestMapping("/addAdminUser")
    public @ResponseBody ViewData addAdminUser(AdminUser adminUser,HttpServletRequest request){

        if(null != adminUserService.queryByPhone(adminUser.getPhoneNumber(),null)){
            return buildFailureJson(StatusConstant.Fail_CODE,"该手机号已经被注册");
        }
        try {
            adminUserService.addAdminUser(adminUser);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(adminUser.getId());
                log.setToOperateType(LogConstant.LOG_ADMINUSER);
                log.setOperateType(LogConstant.LOG_TYPE_SAVE);
                log.setDescribe("对后台用户[" + adminUser.getUserName() + "]进行了添加的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  更新 后台用户
     * @param adminUser
     * @return
     */
    @RequestMapping("/updateAdminUser")
    public @ResponseBody ViewData updateAdminUser(AdminUser adminUser ,HttpServletRequest request){

        if(null == adminUser.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            adminUserService.updateAdminUser(adminUser);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(adminUser.getId());
                log.setToOperateType(LogConstant.LOG_ADMINUSER);
                log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
                log.setDescribe("对后台用户[" + adminUser.getUserName() + "]进行了更新的操作");
                logService.save(log,request);
            }

        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

//    /**
//     * 退出登录
//     * @return
//     */
//    @RequestMapping("/logout")
//    public @ResponseBody ViewData logout(){
//        LoginHelper.clearToken();
//        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"退出成功");
//    }


    /***
     * 获取管理员详情
     * @param id
     * @return
     */
    @RequestMapping("/getAdminUserByIdForWeb")
    @ResponseBody
    public ViewData getAdminUserByIdForWeb(Integer id){
        if (null == id) {
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),adminUserService.getAdminUserByIdForWeb(id));
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }

    }

    /***
     * 获取用户详情
     * @param id
     * @return
     */
    @RequestMapping("/queryUserById")
    @ResponseBody
    public ViewData queryUserById(Integer id){
        if (null == id) {
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),userService.getUserByIdForWeb(id));
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }

    }

    /**
     * 填写备注
     * @param id
     * @param reMarket
     */
    @RequestMapping("/saveReMarket")
    @ResponseBody
    public ViewData saveReMarket(Integer id,String reMarket,HttpServletRequest request){
        if(null == id || null == reMarket){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        AdminUser adminUser = LoginHelper.getCurrentAdmin(request);
        userService.saveReMarket(id, adminUser.getUserName()+":"+reMarket + "; ");
        return buildFailureJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


}
