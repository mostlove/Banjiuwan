package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.beans.RechargeConfig;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.LogService;
import com.magicbeans.banjiuwan.service.RechargeConfigService;
import com.magicbeans.banjiuwan.util.LogConstant;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by Eric Xie on 2017/3/9 0009.
 */

@Controller
@RequestMapping("/web/rechargeConfig")
public class RechargeConfigController extends BaseController {

    @Resource
    private RechargeConfigService rechargeConfigService;

    @Resource
    private LogService logService;
    /**
     *  新增配置
     * @param rechargeConfig
     * @return
     */
    @RequestMapping("/addRechargeConfig")
    public @ResponseBody ViewData addRechargeConfig(RechargeConfig rechargeConfig , HttpServletRequest request){

        if(null == rechargeConfig.getBalance() || 0 == rechargeConfig.getBalance()){
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        if(null != rechargeConfigService.queryRechargeConfigByBalance(rechargeConfig.getBalance())){
            return buildFailureJson(StatusConstant.Fail_CODE,"充值金额已经存在");
        }
        try {
            rechargeConfigService.addRechargeConfig(rechargeConfig);

            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(rechargeConfig.getId());
                log.setToOperateType(LogConstant.LOG_RECHARGE_CONFIG);
                log.setOperateType(LogConstant.LOG_TYPE_SAVE);
                log.setDescribe("对充值参数配置[充值金额" + rechargeConfig.getBalance() + "]进行了新增的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  更新配置
     * @param rechargeConfig
     * @return
     */
    @RequestMapping("/updateRechargeConfig")
    public @ResponseBody ViewData updateRechargeConfig(RechargeConfig rechargeConfig ,HttpServletRequest request){

        if(null == rechargeConfig.getId()){
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        try {
            rechargeConfigService.updateRechargeConfig(rechargeConfig);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(rechargeConfig.getId());
                log.setToOperateType(LogConstant.LOG_RECHARGE_CONFIG);
                log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
                log.setDescribe("对充值参数配置[充值金额" + rechargeConfig.getBalance() + "]进行了更新的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  删除配置
     * @return
     */
    @RequestMapping("/delRechargeConfig")
    public @ResponseBody ViewData delRechargeConfig(Integer id ,HttpServletRequest request){

        if(null == id){
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        try {
            RechargeConfig rechargeConfig = rechargeConfigService.queryRechargeConfigById(id);
            if (null == rechargeConfig) {
                return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
            }
            rechargeConfigService.delRechargeConfig(id);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(rechargeConfig.getId());
                log.setToOperateType(LogConstant.LOG_RECHARGE_CONFIG);
                log.setOperateType(LogConstant.LOG_TYPE_DELETE);
                log.setDescribe("对充值参数配置[充值金额" + rechargeConfig.getBalance() + "]进行了删除的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  获取所有配置列表
     * @return
     */
    @RequestMapping("/getAllRechargeConfig")
    public @ResponseBody ViewData getAllRechargeConfig(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                rechargeConfigService.queryAllRechargeConfig());
    }









}
