package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.RechargeConfigService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by Eric Xie on 2017/3/9 0009.
 */

@Controller
@RequestMapping("/app/rechargeConfig")
public class AppRechargeConfigController extends BaseController {

    @Resource
    private RechargeConfigService rechargeConfigService;


    /**
     * 获取所有配置
     * @return
     */
    @RequestMapping("/getAllRechargeConfig")
    public @ResponseBody ViewData getAllRechargeConfig(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString(),
                rechargeConfigService.queryAllRechargeConfig());
    }







}
