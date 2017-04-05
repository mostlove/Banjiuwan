package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.SpecialWedding;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.SpecialWeddingService;
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
 * 婚庆预约 管理 控制器
 * Created by Eric Xie on 2017/2/22 0022.
 */

@Controller
@RequestMapping("/web/wedding")
public class WeddingController extends BaseController {

    @Resource
    private SpecialWeddingService specialWeddingService;

    /**
     *  新增婚庆
     * @param wedding
     * @return
     */
    @RequestMapping("/addWedding")
    public @ResponseBody ViewData addWedding(SpecialWedding wedding){
        try {
            specialWeddingService.addWedding(wedding);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  获取数据
     * @param name
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/queryList")
    public @ResponseBody ViewData queryList(String name,Integer pageNO,Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        name = CommonUtil.isEmpty(name) ? null : name;
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                specialWeddingService.queryWeddingPage(name,pageNO,pageSize));
    }

    /**
     *  更新
     * @param wedding
     * @return
     */
    @RequestMapping("/updateWedding")
    public @ResponseBody ViewData updateWedding(SpecialWedding wedding){
        if(null == wedding.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            specialWeddingService.updateWedding(wedding);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  删除
     * @param id
     * @return
     */
    @RequestMapping("/delWedding")
    public @ResponseBody ViewData delWedding(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            specialWeddingService.delWedding(id);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }



}
