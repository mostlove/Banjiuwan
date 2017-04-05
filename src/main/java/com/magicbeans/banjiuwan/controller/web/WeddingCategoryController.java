package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.WeddingCategory;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.WeddingCategoryService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 *
 *  婚庆  子项 大分类控制层
 * Created by Eric Xie on 2017/2/23 0023.
 */


@Controller
@RequestMapping("/web/weddingCategory")
public class WeddingCategoryController extends BaseController {

    @Resource
    private WeddingCategoryService weddingCategoryService;

    @RequestMapping("/add")
    public @ResponseBody ViewData addWeddingCategory(WeddingCategory weddingCategory){
        try {
            weddingCategoryService.addWeddingCategory(weddingCategory);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  删除
     * @param id
     * @return
     */
    @RequestMapping("/del")
    public @ResponseBody ViewData delWeddingCategory(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            weddingCategoryService.delWeddingCategory(id);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  查询
     * @return
     */
    @RequestMapping("/queryAll")
    public @ResponseBody ViewData queryAllWeddingCategory(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                weddingCategoryService.queryAllCategory());
    }


    /**
     *  更新
     * @param weddingCategory
     * @return
     */
    @RequestMapping("/update")
    public @ResponseBody ViewData updateWeddingCategory(WeddingCategory weddingCategory){
        if(null == weddingCategory.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            weddingCategoryService.updateWeddingCategory(weddingCategory);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


}
