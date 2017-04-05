package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.WeddingSonChildCategory;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.WeddingSonChildCategoryService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 子类 和 子项 控制器
 * Created by Eric Xie on 2017/2/23 0023.
 */

@Controller
@RequestMapping("/web/weddingSonChild")
public class WeddingSonChildCategoryController extends BaseController {

    @Resource
    private WeddingSonChildCategoryService weddingSonChildCategoryService;


    /**
     *  分页获取 子类绑定的子项数据
     * @param childCategoryId
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/queryPage")
    public @ResponseBody ViewData queryWeddingSonChildAll(Integer childCategoryId,Integer pageNO,Integer pageSize){

        if(null == pageNO || null == pageSize || null == childCategoryId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                weddingSonChildCategoryService.queryByPage(childCategoryId,pageNO,pageSize));
    }

    /**
     * 根据 中间表ID 删除数据
     * @param id
     * @return
     */
    @RequestMapping("/del")
    public @ResponseBody ViewData delWeddingSonChild(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            weddingSonChildCategoryService.delWeddingSonChildCategory(id);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  绑定子项
     * @param weddingSonChildCategory
     * @return
     */
    @RequestMapping("/bind")
    public @ResponseBody ViewData bindSonChildCategory(WeddingSonChildCategory weddingSonChildCategory){
        try {
            weddingSonChildCategoryService.addWeddingSonChildCategory(weddingSonChildCategory);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


}
