package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.Cook;
import com.magicbeans.banjiuwan.beans.CookTimeConfig;
import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.CookService;
import com.magicbeans.banjiuwan.service.CookTimeConfigService;
import com.magicbeans.banjiuwan.service.LogService;
import com.magicbeans.banjiuwan.util.*;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 厨师管理
 * Created by Eric Xie on 2017/3/6 0006.
 */
@Controller
@RequestMapping("/web/cook")
public class CookController extends BaseController {

    @Resource
    private CookService cookService;
    @Resource
    private CookTimeConfigService cookTimeConfigService;

    @Resource
    private LogService logService;

    /**
     *  后台获取 厨师的经纬度坐标
     * @return
     */
    @RequestMapping("/getCacheCookLatLng")
    public @ResponseBody ViewData getCacheCookLatLng(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                CookCacheUtil.getCacheCooks());
    }



    /**
     *  通过服务时间 获取 当前时间 空闲 可分配的厨师
     * @param serviceDate
     * @return
     */
    @RequestMapping("/getCookByServiceDate")
    public @ResponseBody ViewData getCooksByServiceDate(Long serviceDate){
        if(null == serviceDate){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                cookService.queryCookByServiceDate(new Date(serviceDate)));
    }


    /**
     *  分页获取
     * @param userName
     * @param phoneNumber
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/getCooks")
    public @ResponseBody ViewData getCooks(String userName, String phoneNumber, Integer pageNO, Integer pageSize){

        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        userName = CommonUtil.isEmpty(userName) ? null : userName;
        phoneNumber = CommonUtil.isEmpty(phoneNumber) ? null : phoneNumber;
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                cookService.queryByItem(userName,phoneNumber,pageNO,pageSize));
    }


    /**
     *  新增 厨师
     * @param cook
     * @return
     */
    @RequestMapping("/addCook")
    public @ResponseBody ViewData addCook(Cook cook, HttpServletRequest request){
        try {
            Cook temp = cookService.queryByPhone(cook.getPhoneNumber(),null);
            if(null != temp){
                return buildFailureJson(StatusConstant.Fail_CODE,"该手机号已经存在");
            }
            cookService.add(cook);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(cook.getId());
                log.setToOperateType(LogConstant.LOG_COOK);
                log.setOperateType(LogConstant.LOG_TYPE_SAVE);
                log.setDescribe("对厨师[" + cook.getRealName() + "]进行了添加的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  更新厨师
     * @param cook
     * @return
     */
    @RequestMapping("/updateCook")
    public @ResponseBody ViewData updateCook(Cook cook ,HttpServletRequest request){
        if(null == cook.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            cookService.update(cook);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(cook.getId());
                log.setToOperateType(LogConstant.LOG_COOK);
                log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
                log.setDescribe("对厨师[" + cook.getRealName() + "]进行了更新的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  设置厨师 的排班表
     * @return
     */
    @RequestMapping("/setTimeConfig")
    public @ResponseBody ViewData setCookTime(String times,Integer cookId){

        if(CommonUtil.isEmpty(times) || null == cookId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            JSONArray jsonArray = JSONArray.fromObject(times);
            List<CookTimeConfig> cookTimeConfigs = new ArrayList<CookTimeConfig>();
            for (Object obj : jsonArray){
                CookTimeConfig timeConfig = new CookTimeConfig();
                timeConfig.setCookId(cookId);
                timeConfig.setTimeConfigId(Integer.parseInt(obj.toString()));
                cookTimeConfigs.add(timeConfig);
            }
            if(cookTimeConfigs.size() > 0){
                cookTimeConfigService.batchAddCookConfig(cookTimeConfigs,cookId);
            }else{
                cookTimeConfigService.delCookTimeByCook(cookId);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /***
     * 获取厨师详情
     * @param id
     * @return
     */
    @RequestMapping("/getCookByIdForWeb")
    @ResponseBody
    public ViewData getCookByIdForWeb(Integer id){
        if (null == id) {
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),cookService.getCookByIdForWeb(id));
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }

    }






}
