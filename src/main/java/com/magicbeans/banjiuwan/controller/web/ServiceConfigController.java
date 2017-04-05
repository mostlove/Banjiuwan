package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.beans.ServiceConfig;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.LogService;
import com.magicbeans.banjiuwan.service.ServiceConfigService;
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
 * 服务价格配置 控制器
 * Created by Eric Xie on 2017/3/3 0003.
 */

@Controller
@RequestMapping("/web/serviceConfig")
public class ServiceConfigController extends BaseController {

    @Resource
    private ServiceConfigService serviceConfigService;

    @Resource
    private LogService logService;

    @RequestMapping("/getServiceConfigList")
    public @ResponseBody ViewData getServiceConfigList(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString(),
                serviceConfigService.queryServiceConfig());
    }

    /**
     *  更新
     * @param serviceConfig
     * @return
     */
    @RequestMapping("/updateServiceConfig")
    public @ResponseBody ViewData updateServiceConfig(ServiceConfig serviceConfig ,HttpServletRequest request){
        if(null == serviceConfig.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            serviceConfigService.updateServiceConfig(serviceConfig);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(serviceConfig.getId());
                log.setToOperateType(LogConstant.LOG_SERVICE_CONFIG);
                log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
                log.setDescribe("对服务费配置[订单总价小于:" + serviceConfig.getPrice() + "]进行了更新的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString().toString());
    }


    @RequestMapping("/delServiceConfig")
    public @ResponseBody ViewData delServiceConfig(Integer id ,HttpServletRequest request){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            ServiceConfig serviceConfig = serviceConfigService.info(id);
            if (null == serviceConfig) {
                return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
            }
            serviceConfigService.delServiceConfig(id);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(id);
                log.setToOperateType(LogConstant.LOG_SERVICE_CONFIG);
                log.setOperateType(LogConstant.LOG_TYPE_DELETE);
                log.setDescribe("对服务费配置[订单总价小于:" + serviceConfig.getPrice() + "]进行了删除的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString().toString());
    }


    /**
     *  新增
     * @param serviceConfig
     * @return
     */
    @RequestMapping("/addServiceConfig")
    public @ResponseBody ViewData addServiceConfig(ServiceConfig serviceConfig , HttpServletRequest request){
        try {
            serviceConfigService.addServiceConfig(serviceConfig);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(serviceConfig.getId());
                log.setToOperateType(LogConstant.LOG_SERVICE_CONFIG);
                log.setOperateType(LogConstant.LOG_TYPE_SAVE);
                log.setDescribe("对服务费配置[订单总价小于:" + serviceConfig.getPrice() + "]进行了新增的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString().toString());
    }
}
