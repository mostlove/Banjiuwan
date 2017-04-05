package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.AccumulateDetailService;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 * Created by Eric Xie on 2017/3/24 0024.
 */

@Controller
@RequestMapping("/web/accumulateDetail")
public class AccumulateDetailController extends BaseController {


    @Resource
    private AccumulateDetailService accumulateDetailService;


    @RequestMapping("/getAccumulateDetail")
    public @ResponseBody ViewData getAccumulateDetail(String phoneNumber, Long startTime, Long endTime, Integer pageNO, Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                accumulateDetailService.getAccumulateDetail(CommonUtil.isEmpty(phoneNumber) ? null : phoneNumber,
                        startTime == null ? null : new Date(startTime),endTime == null ? null : new Date(endTime),pageNO,pageSize));
    }
    /**
     * 导出数据 积分明细
     * @param response
     * @param valueArray
     * @param titleArray
     */
    @RequestMapping("/exportExcel")
    public void exportExcel(HttpServletResponse response, String valueArray, String titleArray,
                            Long startTime ,Long endTime ,String phoneNumber){

        try {
            if(CommonUtil.isEmpty(valueArray,titleArray)){
                response.getWriter().print("字段不能为空");
                return;
            }
            accumulateDetailService.exportExcel(response,valueArray,titleArray,CommonUtil.isEmpty(phoneNumber) ? null : phoneNumber,
                    startTime == null ? null : new Date(startTime),endTime == null ? null : new Date(endTime));
        }catch (Exception e){
            logger.error(e.getMessage(),e);
        }
    }
}
