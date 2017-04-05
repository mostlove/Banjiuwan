package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.VegetablesHouse;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.VegetablesHouseService;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by Eric Xie on 2017/3/10 0010.
 */
@Controller
@RequestMapping("/web/vegetablesHouse")
public class VegetablesHouseController extends BaseController {

    @Resource
    private VegetablesHouseService vegetablesHouseService;


    @RequestMapping("/getVegetablesHouse")
    public @ResponseBody ViewData getVegetablesHouse(String vegetableName, Integer pageNO, Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        vegetableName = CommonUtil.isEmpty(vegetableName) ? null : vegetableName;
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                vegetablesHouseService.queryVegetablesHouseByItem(vegetableName,pageNO,pageSize));
    }

    /**
     *  获取所有的
     * @return
     */
    @RequestMapping("/getAllVegetablesHouse")
    public @ResponseBody ViewData getAllVegetablesHouse(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                vegetablesHouseService.getAllVegetablesHouse());
    }


    @RequestMapping("/addVegetablesHouse")
    public @ResponseBody ViewData addVegetablesHouse(VegetablesHouse vegetablesHouse){
        try {
            vegetablesHouseService.addVegetablesHouse(vegetablesHouse);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/updateVegetablesHouse")
    public @ResponseBody ViewData updateVegetablesHouse(VegetablesHouse vegetablesHouse){
        if(null == vegetablesHouse.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            vegetablesHouseService.updateVegetablesHouse(vegetablesHouse);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/delVegetablesHouse")
    public @ResponseBody ViewData delVegetablesHouse(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            vegetablesHouseService.delVegetablesHouse(id);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

}
