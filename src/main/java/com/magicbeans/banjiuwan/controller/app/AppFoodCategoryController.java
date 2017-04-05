package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.beans.FoodCategory;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.FoodCategoryService;
import com.magicbeans.banjiuwan.service.MapListService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * APP分类 配置控制器
 * Created by Eric Xie on 2017/3/16 0016.
 */

@Controller
@RequestMapping("/app/category")
public class AppFoodCategoryController extends BaseController {

    @Resource
    private FoodCategoryService foodCategoryService;
    @Resource
    private MapListService mapListService;


       /**
     *  获取 分类配置
     * @return
     */
    @RequestMapping("/getCategoryConfig")
    public @ResponseBody ViewData getCategoryConfig(){
        Map<String,Object> data = new HashMap<String, Object>();
        data.put("categoryConfig",foodCategoryService.queryBigCategory());
        data.put("mapList",mapListService.queryAllMapList());
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString(),data);
    }






}
