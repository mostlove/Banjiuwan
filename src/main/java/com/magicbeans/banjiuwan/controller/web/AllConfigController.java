package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.AllConfig;
import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.AllConfigService;
import com.magicbeans.banjiuwan.service.LogService;
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
 * Created by Eric Xie on 2017/3/3 0003.
 */

@Controller
@RequestMapping("/web/config")
public class AllConfigController extends BaseController {

    @Resource
    private AllConfigService allConfigService;

    @Resource
    private LogService logService;

    @RequestMapping("/updateConfig")
    public @ResponseBody ViewData updateConfig(AllConfig config , HttpServletRequest request){

        if(null == config.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            allConfigService.updateConfig(config);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(config.getId());
                log.setToOperateType(LogConstant.LOG_ALLCONFIG);
                log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
                log.setDescribe("对全局配置进行了更新的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString());
    }

}
