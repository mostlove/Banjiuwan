package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.beans.OrderTimeConfig;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.LogService;
import com.magicbeans.banjiuwan.service.OrderTimeConfigService;
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
 * 时间配置 后台控制器
 * Created by Eric Xie on 2017/3/2 0002.
 */

@Controller
@RequestMapping("/web/timeConfig")
public class OrderTimeConfigController extends BaseController {


    @Resource
    private OrderTimeConfigService orderTimeConfigService;

    private Logger logger = Logger.getLogger(this.getClass());

    @Resource
    private LogService logService;
    /**
     *
     * @return
     */
    @RequestMapping("/queryAllTimeConfig")
    public @ResponseBody ViewData queryAllTimeConfig(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString(),
                orderTimeConfigService.queryAllTimeConfig());
    }


    @RequestMapping("/updateTimeConfig")
    public @ResponseBody ViewData updateTimeConfig(Integer id, Double price , HttpServletRequest request){
        if(null == id || null == price){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            OrderTimeConfig timeConfig = orderTimeConfigService.info(id);
            if (null == timeConfig) {
                return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
            }
            timeConfig.setId(id);
            timeConfig.setPrice(price);
            orderTimeConfigService.updateTimeConfig(timeConfig);

            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(id);
                log.setToOperateType(LogConstant.LOG_ORDER_CONFIG_TIME);
                log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
                log.setDescribe("对订单溢价配置[时间:" + timeConfig.getTime() + "]进行了更新的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

}
