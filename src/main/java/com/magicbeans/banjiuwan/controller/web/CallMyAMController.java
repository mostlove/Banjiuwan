package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.CallMyAM;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.CallMyAMService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 召唤我的AM
 * Created by Eric Xie on 2017/3/15 0015.
 */
@Controller
@RequestMapping("/web/callMyAM")
public class CallMyAMController extends BaseController {

    @Resource
    private CallMyAMService callMyAMService;


    @RequestMapping("/getCallMyAM")
    public @ResponseBody ViewData getCallMyAM(Integer pageNO, Integer pageSize){

        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                callMyAMService.getCallMyAM(pageNO,pageSize));
    }


    /**
     *  更新
     * @param callMyAM
     * @return
     */
    @RequestMapping("/updateCallMyAM")
    public @ResponseBody ViewData updateCallMyAM(CallMyAM callMyAM){

        if(null == callMyAM.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            callMyAMService.updateCallMyAM(callMyAM);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }




}
