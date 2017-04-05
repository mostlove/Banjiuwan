package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.WeddingSon;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.WeddingSonService;
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
 * 婚庆预约 子项管理 控制器
 *
 * Created by Eric Xie on 2017/2/22 0022.
 */

@Controller
@RequestMapping("/web/weddingSon")
public class WeddingSonController extends BaseController {

    @Resource
    private WeddingSonService weddingSonService;


    /**
     *  分页获取数据
     * @param name
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/queryList")
    public @ResponseBody ViewData queryList(String name, Integer pageNO, Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        name = CommonUtil.isEmpty(name) ? null : name;
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                weddingSonService.queryPage(name,pageNO,pageSize));
    }


    /**
     * 新增接口
     * @param son
     * @return
     */
    @RequestMapping("/addWeddingSon")
    public @ResponseBody ViewData addWeddingSon(WeddingSon son){
        try {
            weddingSonService.addWeddingSon(son);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     * 更新不为空的字段
     * @param son
     * @return
     */
    @RequestMapping("/updateWeddingSon")
    public @ResponseBody ViewData updateWeddingSon(WeddingSon son){
        if(null == son.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            weddingSonService.updateWeddingSon(son);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     * 删除数据
     * @param id
     * @return
     */
    @RequestMapping("/delWeddingSon")
    public @ResponseBody ViewData delWeddingSon(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            weddingSonService.delWeddingSon(id);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/queryAllWeddingSon")
    public @ResponseBody ViewData queryAllWeddingSon(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                weddingSonService.queryAllWeddingSon());
    }





}
