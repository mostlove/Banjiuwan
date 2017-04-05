package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.UserAddressService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 用户地址管理
 * Created by Eric Xie on 2017/3/15 0015.
 */

@Controller
@RequestMapping("/web/userAddress")
public class WebUserAddressController extends BaseController {


    @Resource
    private UserAddressService userAddressService;


    /**
     *  获取用户地址列表
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/getUserAddress")
    public @ResponseBody ViewData getUserAddress(Integer pageNO, Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                userAddressService.queryUserAddress(null,pageNO,pageSize));
    }

}
