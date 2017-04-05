package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.WeddingChildCategory;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.WeddingChildCategoryService;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 婚庆 子分类 控制器
 * Created by Eric Xie on 2017/2/23 0023.
 */
@Controller
@RequestMapping("/web/weddingChildCategory")
public class WeddingChildCategoryController extends BaseController {


    @Resource
    private WeddingChildCategoryService weddingChildCategoryService;


    /**
     *  分页获取
     * @param name
     * @param categoryId
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/queryPage")
    public @ResponseBody ViewData queryAllChildCategory(String name,Integer categoryId,Integer pageNO,Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        name = CommonUtil.isEmpty(name) ? null : name;
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                weddingChildCategoryService.queryWeddingChildCategory(name,categoryId,pageNO,pageSize));
    }

    /**
     * 新增子分类
     * @param weddingChildCategory
     * @return
     */
    @RequestMapping("/add")
    public @ResponseBody ViewData addWeddingChildCategory(WeddingChildCategory weddingChildCategory){
        try {
            weddingChildCategoryService.addWeddingChildCategory(weddingChildCategory);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  更新
     * @param weddingChildCategory
     * @return
     */
    @RequestMapping("/update")
    public @ResponseBody ViewData updateWeddingChildCategory(WeddingChildCategory weddingChildCategory){
        if(null == weddingChildCategory.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            weddingChildCategoryService.updateWeddingChildCategory(weddingChildCategory);
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
    @RequestMapping("/del")
    public @ResponseBody ViewData delWeddingChildCategory(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            weddingChildCategoryService.delWeddingChildCategory(id);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  获取所有的子分类 通过分类ID 获取
     * @param categoryId
     * @return
     */
    @RequestMapping("/queryAllChildCategory")
    public @ResponseBody ViewData queryAllChildCategory(Integer categoryId){
        if(null == categoryId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                weddingChildCategoryService.queryAllChildCategoryBycategoryId(categoryId));
    }





}
