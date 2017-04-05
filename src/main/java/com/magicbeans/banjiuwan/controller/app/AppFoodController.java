package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.beans.*;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.enumutil.FoodCategoryEnum;
import com.magicbeans.banjiuwan.service.*;
import com.magicbeans.banjiuwan.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 *
 * Created by Eric Xie on 2017/2/28 0028.
 */

@Controller
@RequestMapping("/app/food")
public class AppFoodController extends BaseController {

    @Resource
    private SingleFoodService singleFoodService;
    @Resource
    private PackageCaterService packageCaterService;
    @Resource
    private SpecialServiceService specialServiceService;
    @Resource
    private SpecialActService specialActService;
    @Resource
    private SpecialWeddingService specialWeddingService;
    @Resource
    private FoodCategoryService foodCategoryService;
    @Resource
    private HomeFontService homeFontService;
    @Resource
    private ShopCarService shopCarService;

//    @RequestMapping("/queryAllSingleFood")
//    public @ResponseBody ViewData queryAllSingleFood(){
////        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
////                singleFoodService.)
//    }

    @RequestMapping("/searchFood")
    public @ResponseBody ViewData searchFood(String foodName,Integer pageNO,Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Object userObj  = LoginHelper.getCurrentUser();
        User user = (User)userObj;
        List<ShopCar> shopCarList = null;
        if(null != user){
            shopCarList = shopCarService.queryShopCarByUserForApp(user.getId());
        }
        List<SingleFood> foods = singleFoodService.searchSingleFood(foodName,pageNO,pageSize);
        if(null != shopCarList && shopCarList.size() > 0){
            for (ShopCar shopCar : shopCarList){
                for (SingleFood singleFood : foods){
                    if(shopCar.getFoodId().equals(singleFood.getId()) &&
                            shopCar.getFoodCategoryId().equals(singleFood.getFoodCategoryId())){
                        singleFood.setCountNumber(shopCar.getNumber());
                        break;
                    }
                }
            }
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),foods);
    }


    /**
     *  请求换一换 菜品接口
     * @param foodId
     * @return
     */
    @RequestMapping("/queryChangeFood")
    public @ResponseBody ViewData queryChangeFood(Integer foodId){
        if(null == foodId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                singleFoodService.querySingleFoodByFoodIdForApp(foodId,user.getId()));
    }

    /**
     *  通过ID  获取 菜品等其他详情
     * @param foodCategoryId 类型ID
     * @param foodId 菜品、坝坝宴等 ID
     * @return
     */
    @RequestMapping("/queryFoodById")
    public @ResponseBody ViewData queryFoodById(Integer foodCategoryId,Integer foodId){
        if(null == foodCategoryId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Object obj = null;
        Integer userId = null;
        Object userObj = LoginHelper.getCurrentUser();
        if(null != userObj){
            if(!(userObj instanceof User)){
                return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
            }
            userId = ((User) userObj).getId();
        }
        List<FoodCategory> foodCategories = foodCategoryService.querySingleFoodCategory();
        FoodCategory foodCategory = new FoodCategory();
        foodCategory.setId(foodCategoryId);
        if(foodCategories.contains(foodCategory)){
            if(null == foodId){
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
            }
            obj = singleFoodService.querySingleFoodById(userId,foodId,foodCategoryId);
        }
        else if(foodCategoryId == FoodCategoryEnum.PACKAGE.ordinal() || foodCategoryId == FoodCategoryEnum.BA_BA_YAN.ordinal()){
            if(null == foodId){
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
            }
            obj = packageCaterService.queryPackageCaterOtherInfo(foodCategoryId,foodId,userId);
        }
        else if(foodCategoryId == FoodCategoryEnum.SPECIAL_SERVICE.ordinal()){
            //
            obj = specialServiceService.querySpecial(userId);
        }
        else if(foodCategoryId == FoodCategoryEnum.SPECIAL_WEDDING.ordinal()){
            if(null == foodId){
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
            }
            // 婚庆
            obj = specialWeddingService.queryWeddingOtherInfo(userId,foodId);
        }
        else if(foodCategoryId == FoodCategoryEnum.SPECIAL_ACT.ordinal()){
            if(null == foodId){
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
            }
            // 半餐演奏
            obj  = specialActService.querySpecialActOtherInfo(userId,foodId);
        }
        else{
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),obj);
    }



    /**
     *  通过类型 获取数据
     * @param foodCategoryId
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/queryByCategory")
    public @ResponseBody ViewData queryByCategory(Integer foodCategoryId, Integer pageNO, Integer pageSize){

        if(null == foodCategoryId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Object userObj  = LoginHelper.getCurrentUser();
        User user = (User)userObj;
        List<ShopCar> shopCarList = null;
        if(null != user){
            shopCarList = shopCarService.queryShopCarByUserForApp(user.getId());
        }
        Object obj = null;
        List<FoodCategory> foodCategories = foodCategoryService.querySingleFoodCategory();
        FoodCategory foodCategory = new FoodCategory();
        foodCategory.setId(foodCategoryId);
        if(foodCategories.contains(foodCategory)){
            List<SingleFood> foods = singleFoodService.queryByCategory(foodCategoryId);
            if(null != shopCarList && shopCarList.size() > 0){
                for (ShopCar shopCar : shopCarList){
                    for (SingleFood singleFood : foods){
                        if(shopCar.getFoodId().equals(singleFood.getId()) &&
                                shopCar.getFoodCategoryId().equals(singleFood.getFoodCategoryId())){
                            singleFood.setCountNumber(shopCar.getNumber());
                            break;
                        }
                    }
                }
            }

            obj = foods;
        }
        else if(foodCategoryId == FoodCategoryEnum.PACKAGE.ordinal() || foodCategoryId == FoodCategoryEnum.BA_BA_YAN.ordinal()){
            List<PackageCater> packageCaters = packageCaterService.queryByCategory(foodCategoryId);

            if(null != shopCarList && shopCarList.size() > 0){
                for (ShopCar shopCar : shopCarList){
                    for (PackageCater packageCater : packageCaters){
                        if(shopCar.getFoodId().equals(packageCater.getId()) &&
                                shopCar.getFoodCategoryId().equals(packageCater.getFoodCategoryId())){
                            packageCater.setCountNumber(shopCar.getNumber());
                            break;
                        }
                    }
                }
            }
            obj = packageCaters;
        }
        else if(foodCategoryId == FoodCategoryEnum.SPECIAL_SERVICE.ordinal()){
            obj = specialServiceService.querySpecial(null);
        }
        else if(foodCategoryId == FoodCategoryEnum.SPECIAL_ACT.ordinal()){
            List<SpecialAct> specialActs = specialActService.queryByAct();

            if(null != shopCarList && shopCarList.size() > 0){
                for (ShopCar shopCar : shopCarList){
                    for (SpecialAct specialAct : specialActs){
                        if(shopCar.getFoodId().equals(specialAct.getId()) &&
                                shopCar.getFoodCategoryId().equals(specialAct.getFoodCategoryId())){
                            specialAct.setCountNumber(shopCar.getNumber());
                            break;
                        }
                    }
                }
            }
            obj = specialActs;
        }
        else if(foodCategoryId == FoodCategoryEnum.SPECIAL_WEDDING.ordinal()){
            if(null == pageNO || null == pageSize){
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
            }
            obj = specialWeddingService.queryAllWedding(pageNO,pageSize);
        }else{
            return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),obj);
    }


    /**
     * 获取单点类菜单的名字和图标
     * @return
     */
    @RequestMapping("/querySingleFoodCategory")
    public @ResponseBody ViewData querySingleFoodCategory(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                foodCategoryService.querySingleFoodCategoryForApp());
    }

    /**
     * 获取首页 字体
     * @return
     */
    @RequestMapping("/queryHomeFont")
    public @ResponseBody ViewData queryHomeFont(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                homeFontService.queryAllHomeFont());
    }

    /**
     * 获取推荐 促销菜品列表
     * @return
     */
    @RequestMapping("/getRecommendationPromotion")
    @ResponseBody
    public ViewData getRecommendationPromotion(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                singleFoodService.getRecommendationPromotion());
    }


}
