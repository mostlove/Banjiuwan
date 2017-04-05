package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.SingleFood;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.LogService;
import com.magicbeans.banjiuwan.service.SingleFoodService;
import com.magicbeans.banjiuwan.util.*;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * 单点菜品 类 后台管理
 * Created by Eric Xie on 2017/2/20 0020.
 */

@Controller
@RequestMapping("/web/food")
public class SingleFoodController extends BaseController {

    @Resource
    private SingleFoodService singleFoodService;

    @Resource
    private LogService logService;

    @RequestMapping("/bindingSecondFood")
    public @ResponseBody ViewData bindingSecondFood(String secondFoodIds,Integer foodId){
        if(CommonUtil.isEmpty(secondFoodIds) || null == foodId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            singleFoodService.bindingFood(secondFoodIds,foodId);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    @RequestMapping("/addFood")
    @ResponseBody
    public ViewData addFood(SingleFood food, HttpServletRequest request){
        try {
            food.setCreateTime(new Date());
            int index = food.getBanners().lastIndexOf(",");
            String banners = food.getBanners().substring(0,index);
            food.setBanners(banners);
            // 压缩封面图
            String[] img = food.getCoverImg().split("\\.");

            ImgCompress.reduceImg(request.getSession().getServletContext().getRealPath("/"+food.getCoverImg()),
                    request.getSession().getServletContext().getRealPath("/"+img[0]+"_thumbnail."+img[1]),0,0,0.5f);
            singleFoodService.addSingleFood(food);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(food.getId());
                log.setToOperateType(LogConstant.LOG_FOOD);
                log.setOperateType(LogConstant.LOG_TYPE_SAVE);
                log.setDescribe("对菜品[" + food.getFoodName() + "]进行了添加的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }



    @RequestMapping("/getFood")
    @ResponseBody
    public ViewData getFood(Integer pageNO,Integer pageSize,
                            String foodName,
                            String categoryIds,
                            Integer isPromotion,
                            Integer isRecommendation,
                            Integer recommendationIndex){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Page<SingleFood> data = singleFoodService.queryFood(foodName,categoryIds,
                isPromotion,isRecommendation,recommendationIndex,pageNO,pageSize);
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),data);
    }


    @RequestMapping("/updateFood")
    public @ResponseBody ViewData updateFood(SingleFood food,HttpServletRequest request){
        if(null == food.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            int index = food.getBanners().lastIndexOf(",");
            String banners = food.getBanners().substring(0,index);
            food.setBanners(banners);
            SingleFood singleFood = singleFoodService.queryById(food.getId());
            if(!singleFood.getCoverImg().equals(food.getCoverImg())){
                // 压缩封面图
                String[] img = food.getCoverImg().split("\\.");
                ImgCompress.reduceImg(request.getSession().getServletContext().getRealPath("/"+food.getCoverImg()),
                        request.getSession().getServletContext().getRealPath("/"+img[0]+"_thumbnail."+img[1]),0,0,0.5f);
            }
            singleFoodService.updateFood(food);
            //记录日志
            {
                Log log = new Log();
                log.setToOperateId(food.getId());
                log.setToOperateType(LogConstant.LOG_FOOD);
                log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
                log.setDescribe("对菜品[" + food.getFoodName() + "]进行了更新的操作");
                logService.save(log,request);
            }
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/del")
    public @ResponseBody ViewData delFood(Integer id,HttpServletRequest request,Integer foodCategoryId){

        if(null == id || null== foodCategoryId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        SingleFood singleFood = singleFoodService.queryById(id);
        if (null == singleFood) {
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        singleFoodService.del(id,foodCategoryId);
        //记录日志
        {
            Log log = new Log();
            log.setToOperateId(id);
            log.setToOperateType(LogConstant.LOG_FOOD);
            log.setOperateType(LogConstant.LOG_TYPE_DELETE);
            log.setDescribe("对菜品[" + singleFood.getFoodName() + "]进行了删除的操作");
            logService.save(log,request);
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  根据类型获取菜品
     * @param category
     * @return
     */
    @RequestMapping("/queryByCategory")
    public @ResponseBody ViewData queryByCategory(Integer category){
        /*if(null == category){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }*/
        List<SingleFood> data = singleFoodService.queryByCategory(category);
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),data);
    }

    /**
     *  获取所有菜品
     * @return
     */
    @RequestMapping("/queryAllSingleFood")
    public @ResponseBody ViewData queryAllSingleFood(Integer id){
        List<SingleFood> data = singleFoodService.queryByCategory(null);
        if(null != id){
            for (SingleFood food : data){
                if(food.getId().equals(id)){
                    data.remove(food);
                    break;
                }
            }
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),data);
    }

    /**
     * 更新是否促销或推荐
     * @return
     */
    @RequestMapping(value = "/updateRecommendationOrPromotion" ,method = RequestMethod.POST)
    @ResponseBody
    public ViewData updateRecommendationOrPromotion(Integer type,Boolean bol,Integer id ,HttpServletRequest request){
        singleFoodService.updateRecommendationOrPromotion(type, bol ,id);

        SingleFood singleFood = singleFoodService.queryById(id);
        if (null == singleFood) {
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        //记录日志
        {
            Log log = new Log();
            log.setToOperateId(id);
            log.setToOperateType(LogConstant.LOG_FOOD);
            log.setOperateType(LogConstant.LOG_TYPE_UPDATE);
            if (bol) {
                if (type == 1) {
                    log.setDescribe("对菜品[" + singleFood.getFoodName() + "]进行了设置为促销的操作");
                } else {
                    log.setDescribe("对菜品[" + singleFood.getFoodName() + "]进行了设置为推荐的操作");
                }
            } else {
                if (type == 1) {
                    log.setDescribe("对菜品[" + singleFood.getFoodName() + "]进行了取消促销的操作");
                } else {
                    log.setDescribe("对菜品[" + singleFood.getFoodName() + "]进行了取消为推荐的操作");
                }
            }
            logService.save(log,request);
        }
        return buildFailureJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

}
