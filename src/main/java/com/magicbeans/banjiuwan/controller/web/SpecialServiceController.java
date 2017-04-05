package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.SpecialService;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.SpecialServiceService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 *
 * 专业服务控制器
 * Created by Eric Xie on 2017/2/21 0021.
 */

@Controller
@RequestMapping("/web/specialService")
public class SpecialServiceController extends BaseController {


    @Resource
    private SpecialServiceService specialServiceService;


    @RequestMapping("/update")
    public @ResponseBody ViewData updateSpecialService(SpecialService specialService){
        if(null == specialService.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            specialServiceService.updateSpecial(specialService);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

}
