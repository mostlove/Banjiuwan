package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.SpecialAct;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.SpecialActService;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 *
 * 伴餐演奏 控制器
 * Created by Eric Xie on 2017/2/22 0022.
 */
@Controller
@RequestMapping("/web/act")
public class ActController extends BaseController {

    @Resource
    private SpecialActService specialActService;

    @RequestMapping("/addAct")
    public @ResponseBody ViewData addAct(SpecialAct act){

        try {
            specialActService.addAct(act);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());

    }

    @RequestMapping("/queryList")
    public @ResponseBody ViewData queryList(String name,Integer pageNO,Integer pageSize){

        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        name = CommonUtil.isEmpty(name) ? null : name;
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                specialActService.queryPage(name,pageNO,pageSize));
    }


    @RequestMapping("/updateAct")
    public @ResponseBody ViewData updateAct(SpecialAct act){

        if(null == act.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            specialActService.updateAct(act);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/delAct")
    public @ResponseBody ViewData delAct(Integer id){

        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            specialActService.delAct(id);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());

    }

















}
