package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.FoodCategory;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.FoodCategoryService;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import net.sf.json.JSONArray;
import org.apache.commons.logging.Log;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Eric Xie on 2017/3/1 0001.
 */
@Controller
@RequestMapping("/web/foodCategory")
public class FoodCategoryController extends BaseController {

    @Resource
    private FoodCategoryService foodCategoryService;

    private Logger logger = Logger.getLogger(this.getClass());

    /**
     *   分类配置 提示语
     * @return
     */
    @RequestMapping("/updateBigCategoryConfig")
    public @ResponseBody ViewData updateBigCategoryConfig(FoodCategory bigFoodCategory){
        if(null == bigFoodCategory.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            foodCategoryService.updateBigCategoryMSG(bigFoodCategory);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  获取 分类配置 提示标语
     * @return
     */
    @RequestMapping("/getCategoryConfigMSG")
    public @ResponseBody ViewData getCategoryConfigMSG(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString(),
                foodCategoryService.queryBigCategory());
    }


    /**
     * 新增分类
     * @param foodCategory
     * @return
     */
    @RequestMapping("/addFoodCategory")
    public @ResponseBody ViewData addFoodCategory(FoodCategory foodCategory){
        try {
            foodCategoryService.addFoodCategory(foodCategory);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }



    @RequestMapping("/updateBigCategory")
    public @ResponseBody ViewData updateBigCategory(String bigCategoryIds){

        if(CommonUtil.isEmpty(bigCategoryIds)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {

            JSONArray jsonArray = JSONArray.fromObject(bigCategoryIds);
            List<FoodCategory> foodCategories = new ArrayList<FoodCategory>();
            for (Object obj : jsonArray){
                FoodCategory foodCategory = new FoodCategory();
                foodCategory.setId(Integer.parseInt(obj.toString()));
                foodCategory.setIsInside(1);
                foodCategories.add(foodCategory);
            }
            if(foodCategories.size() > 0){
                foodCategoryService.batchUpdateBigCategory(foodCategories);
            }
            else{
                return buildFailureJson(StatusConstant.Fail_CODE,"没有选择任何菜品");
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     * 获取所有 大类型列表
     * @return
     */
    @RequestMapping("/queryAllBigCategory")
    public @ResponseBody ViewData queryAllBigCategory(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString(),
                foodCategoryService.queryBigCategory());
    }


    @RequestMapping("/queryAll")
    public @ResponseBody ViewData queryAllCategory(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString(),
                foodCategoryService.querySingleFoodCategory());
    }


    @RequestMapping("/updateFoodCategory")
    public @ResponseBody ViewData updateFoodCategory(FoodCategory foodCategory){

        if(null == foodCategory.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            foodCategoryService.updateFoodCategory(foodCategory);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

}
