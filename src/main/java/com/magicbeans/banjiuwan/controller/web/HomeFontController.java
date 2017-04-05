package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.HomeFont;
import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.HomeFontService;
import com.magicbeans.banjiuwan.service.LogService;
import com.magicbeans.banjiuwan.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by Eric Xie on 2017/3/1 0001.
 */

@Controller
@RequestMapping("/web/homeFont")
public class HomeFontController extends BaseController {

    @Resource
    private HomeFontService homeFontService;

    @Resource
    private LogService logService;

    @RequestMapping("/queryAll")
    public @ResponseBody ViewData queryAllHomeFont(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString(),
                homeFontService.queryAllHomeFont());
    }


    @RequestMapping("/update")
    public @ResponseBody ViewData updateHomeFont(Integer id, String font , HttpServletRequest request){
        if(null == id || CommonUtil.isEmpty(font)){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        homeFontService.updateHomeFont(new HomeFont(id,font));
        //记录日志
        {
            Log log = new Log();
            log.setToOperateId(id);
            log.setOperateType(LogConstant.LOG_FOOD);
            log.setToOperateType(LogConstant.LOG_INDEX_FONT_CONFIG);
            log.setDescribe("对app首页字体配置[" + font + "]进行了更新的操作");
            logService.save(log,request);
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


}
