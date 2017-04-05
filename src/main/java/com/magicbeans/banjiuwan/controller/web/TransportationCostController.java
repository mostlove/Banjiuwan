package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.beans.TransportationCostConfig;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.LogService;
import com.magicbeans.banjiuwan.service.TransportationCostConfigService;
import com.magicbeans.banjiuwan.util.LogConstant;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 交通费用配置管理
 * Created by Eric Xie on 2017/3/2 0002.
 */

@Controller
@RequestMapping("/web/transportationCost")
public class TransportationCostController extends BaseController {

    @Resource
    private TransportationCostConfigService transportationCostConfigService;

    @Resource
    private LogService logService;
    private Logger logger = Logger.getLogger(this.getClass());


    @RequestMapping("/queryConfig")
    public @ResponseBody ViewData queryConfigPage(Integer pageNO, Integer pageSize){

        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                transportationCostConfigService.queryConfigPage(pageNO,pageSize));
    }


    /**
     *  新增配置
     * @param costConfig
     * @return
     */
    @RequestMapping("/add")
    public @ResponseBody ViewData addConfig(TransportationCostConfig costConfig, HttpServletRequest request){

        try {
            transportationCostConfigService.addTransportationCostConfig(costConfig);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(costConfig.getId());
                log.setToOperateType(LogConstant.LOG_TRANSPORTATION);
                log.setOperateType(LogConstant.LOG_TYPE_SAVE);
                log.setDescribe("对交通费用配置[距离" + costConfig.getDistance() + "千米(以内)]进行了新增的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  修改配置
     * @param costConfig
     * @return
     */
    @RequestMapping("/updateConfig")
    public @ResponseBody ViewData updateConfig(TransportationCostConfig costConfig,HttpServletRequest request){

        if(null == costConfig.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }

        try {
            transportationCostConfigService.updateTransportationCostConfig(costConfig);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(costConfig.getId());
                log.setToOperateType(LogConstant.LOG_TRANSPORTATION);
                log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
                log.setDescribe("对交通费用配置[距离" + costConfig.getDistance() + "千米(以内)]进行了更新的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  删除配置
     * @return
     */
    @RequestMapping("/delConfig")
    public @ResponseBody ViewData delConfig(Integer id ,HttpServletRequest request){

        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            TransportationCostConfig costConfig = transportationCostConfigService.info(id);
            if (null == costConfig) {
                return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
            }
            transportationCostConfigService.delTransportationCostConfig(id);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(id);
                log.setToOperateType(LogConstant.LOG_TRANSPORTATION);
                log.setOperateType(LogConstant.LOG_TYPE_DELETE);
                log.setDescribe("对交通费用配置[距离" + costConfig.getDistance() + "千米(以内)]进行了删除的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

}
