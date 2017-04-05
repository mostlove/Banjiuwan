package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.CookTimeConfig;
import com.magicbeans.banjiuwan.beans.Waiter;
import com.magicbeans.banjiuwan.beans.WaiterTimeConfig;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.WaiterService;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/17 0017.
 */

@Controller
@RequestMapping("/web/waiter")
public class WaiterController extends BaseController {

    @Resource
    private WaiterService waiterService;




    /**
     *  设置服务员 的排班表
     * @return
     */
    @RequestMapping("/setTimeConfig")
    public @ResponseBody ViewData setCookTime(String times,Integer waiterId){

        if(CommonUtil.isEmpty(times) || null == waiterId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            JSONArray jsonArray = JSONArray.fromObject(times);
            List<WaiterTimeConfig> timeConfigs = new ArrayList<WaiterTimeConfig>();
            for (Object obj : jsonArray){
                WaiterTimeConfig timeConfig = new WaiterTimeConfig();
                timeConfig.setWaiterId(waiterId);
                timeConfig.setTimeConfigId(Integer.parseInt(obj.toString()));
                timeConfigs.add(timeConfig);
            }
            if(timeConfigs.size() > 0){
                waiterService.batchAddWaiterConfig(timeConfigs,waiterId);
            }else{
                waiterService.delWaiterTimeByWaiter(waiterId);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }




    @RequestMapping("/addWaiter")
    public @ResponseBody ViewData addWaiter(Waiter waiter){
        try {
            waiterService.addWaiter(waiter);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/updateWaiter")
    public @ResponseBody ViewData updateWaiter(Waiter waiter){
        if(null == waiter.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            waiterService.updateWaiter(waiter);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/getWaiter")
    public @ResponseBody ViewData getWaiter(Integer pageNO,Integer pageSize,String name){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        name = CommonUtil.isEmpty(name) ? null : name;
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                waiterService.queryWaiter(name,pageNO,pageSize));
    }






}
