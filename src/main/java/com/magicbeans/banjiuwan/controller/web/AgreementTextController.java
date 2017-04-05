package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.AgreementText;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.AgreementTextService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by Eric Xie on 2017/3/24 0024.
 */

@Controller
@RequestMapping("/web/agreementText")
public class AgreementTextController extends BaseController {

    @Resource
    private AgreementTextService agreementTextService;


    @RequestMapping("/getAgreementTextList")
    public @ResponseBody ViewData getAgreementTextList(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString(),
                agreementTextService.queryAgreementTextList());
    }


    @RequestMapping("/getAgreementTextById")
    public @ResponseBody ViewData getAgreementTextById(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString(),
                agreementTextService.queryAgreementTextById(id));
    }


    @RequestMapping("/update")
    public @ResponseBody ViewData updateAgreementText(AgreementText agreementText){
        if(null == agreementText.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            agreementTextService.updateAgreementText(agreementText);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"更新失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


}
