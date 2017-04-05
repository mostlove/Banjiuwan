package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.AdminUser;
import com.magicbeans.banjiuwan.beans.RechargeRecord;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.RechargeRecordService;
import com.magicbeans.banjiuwan.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 * Created by Eric Xie on 2017/3/9 0009.
 */

@Controller
@RequestMapping("/web/rechargeRecord")
public class RechargeRecordController extends BaseController {

    @Resource
    private RechargeRecordService rechargeRecordService;


    /**
     *  动态获取 充值记录
     * @param userName
     * @param phoneNumber
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/getRechargeRecords")
    public @ResponseBody ViewData getRechargeRecord(String userName, String phoneNumber, Integer pageNO, Integer pageSize,Integer payMethod,Integer status,
                                                    Long startTime,Long endTime){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        userName = CommonUtil.isEmpty(userName) ? null : userName;
        phoneNumber = CommonUtil.isEmpty(phoneNumber) ? null : phoneNumber;

        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                rechargeRecordService.queryRechargeRecordForWeb(userName,phoneNumber,pageNO,pageSize,payMethod,status,startTime == null ? null : new Date(startTime),
                        endTime == null ? null : new Date(endTime)));
    }


    /**
     *  导出excel 充值记录
     * @param response
     */
    @RequestMapping("/downLoadRechargeRecord")
    public void downLoadRechargeRecordExcelData(HttpServletResponse response,String userName, String phoneNumber,Integer payMethod,Integer status,
                                                Long startTime,Long endTime,String titlesArr,String columnsArr){

        userName = CommonUtil.isEmpty(userName) ? null : userName;
        phoneNumber = CommonUtil.isEmpty(phoneNumber) ? null : phoneNumber;
        Date startDate = startTime == null ? null : new Date(startTime);
        Date endDate = endTime == null ? null : new Date(endTime);
        try {
            rechargeRecordService.exportRechargeRecord(response,userName,phoneNumber,payMethod,status,startDate,endDate,
                    titlesArr,columnsArr);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
        }

    }

    /**
     * 填写备注
     * @param id
     * @param reMarket
     */
    @RequestMapping("/saveReMarket")
    @ResponseBody
    public ViewData saveReMarket(Integer id,String reMarket,HttpServletRequest request){
        if(null == id || null == reMarket){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        AdminUser adminUser = LoginHelper.getCurrentAdmin(request);
        rechargeRecordService.saveReMarket(id, adminUser.getUserName()+":"+reMarket + "; ");
        return buildFailureJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     * 获取详情
     * @param id
     */
    @RequestMapping("/getInfo")
    @ResponseBody
    public ViewData getInfo(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        RechargeRecord rechargeRecord = rechargeRecordService.queryRechargeRecord(id);
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),rechargeRecord);
    }

}
