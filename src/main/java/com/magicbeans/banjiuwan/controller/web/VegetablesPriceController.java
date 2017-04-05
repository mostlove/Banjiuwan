package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.VegetablesHouse;
import com.magicbeans.banjiuwan.beans.VegetablesPrice;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.VegetablesPriceService;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by Eric Xie on 2017/3/10 0010.
 */
@Controller
@RequestMapping("/web/vegetablesPrice")
public class VegetablesPriceController extends BaseController {


    @Resource
    private VegetablesPriceService vegetablesPriceService;



    @RequestMapping("/getVegetablesPrice")
    public @ResponseBody  ViewData getVegetablesPrice(String vegetableName, Long time, Integer pageNO, Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        vegetableName = CommonUtil.isEmpty(vegetableName) ? null : vegetableName;
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                vegetablesPriceService.queryVegetablesPriceByItemForWeb(vegetableName,time == null ? null : new Date(time),pageNO,pageSize));
    }


    @RequestMapping("/addVegetablesPrice")
    public @ResponseBody ViewData addVegetablesHouse(VegetablesPrice vegetablesPrice){
        try {
            vegetablesPriceService.addVegetablesPrice(vegetablesPrice);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/updateVegetablesPrice")
    public @ResponseBody ViewData updateVegetablesPrice(VegetablesPrice vegetablesPrice){
        if(null == vegetablesPrice.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            vegetablesPriceService.updateVegetablesPrice(vegetablesPrice);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/delVegetablesPrice")
    public @ResponseBody ViewData delVegetablesPrice(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            vegetablesPriceService.delVegetablesPrice(id);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


}
