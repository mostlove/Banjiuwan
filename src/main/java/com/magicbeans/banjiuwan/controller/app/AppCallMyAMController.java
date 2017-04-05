package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.beans.CallMyAM;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.CallMyAMService;
import com.magicbeans.banjiuwan.util.*;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by Eric Xie on 2017/2/28 0028.
 */
@Controller
@RequestMapping("/app/callMyAM")
public class AppCallMyAMController extends BaseController {


    @Resource
    private CallMyAMService callMyAMService;

    private Logger logger = Logger.getLogger(this.getClass());


    /**
     *  提交 召唤我的客服经理
     * @return
     */
    @RequestMapping("/application")
    public @ResponseBody ViewData addCallMyAM(String phoneNumber){
        if(CommonUtil.isEmpty(phoneNumber)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            CallMyAM callMyAM = new CallMyAM();
            callMyAM.setPhoneNumber(phoneNumber);
            callMyAM.setIsHandle(0);
            callMyAMService.addCallMyAM(callMyAM);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

}
