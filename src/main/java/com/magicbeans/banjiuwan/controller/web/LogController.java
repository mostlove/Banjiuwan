package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.LogService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 日志控制器
 * @author lzh
 * @create 2017/3/22 18:21
 */
@Controller
@RequestMapping("/web/log")
public class LogController extends BaseController {


    private Logger logger = Logger.getLogger(getClass());

    @Resource
    private LogService logService;


    /**
     * 日志列表
     * @param operateTypes
     * @param toOperateTypes
     * @param userName
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public ViewData list(String operateTypes , String toOperateTypes ,
                         String userName , String startTimes,String endTimes,Integer pageNO,Integer pageSize){
        try {
            Page<Log> logPage = logService.list(operateTypes, toOperateTypes, userName,startTimes,endTimes, pageNO, pageSize);
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),logPage);
        } catch (Exception e) {
            logger.error("服务器超时，获取日志列表失败");
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
    }
}
