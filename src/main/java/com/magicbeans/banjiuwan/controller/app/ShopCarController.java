package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.beans.ShopCar;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.enumutil.FoodCategoryEnum;
import com.magicbeans.banjiuwan.mapper.IServiceConfigMapper;
import com.magicbeans.banjiuwan.service.ServiceConfigService;
import com.magicbeans.banjiuwan.service.ShopCarService;
import com.magicbeans.banjiuwan.util.LoginHelper;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 移动端购物车接口
 * Created by Eric Xie on 2017/3/1 0001.
 */

@Controller
@RequestMapping("/app/shopCar")
public class ShopCarController extends BaseController {

    @Resource
    private ShopCarService shopCarService;
    @Resource
    private ServiceConfigService serviceConfigService;

    private Logger logger = Logger.getLogger(this.getClass());


    /**
     * 获取服务费配置列表
     * @return
     */
    @RequestMapping("/getServiceConfig")
    public @ResponseBody ViewData getServiceConfig(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                serviceConfigService.queryServiceConfig());
    }

    /**
     *  清空购物车
     * @param bigCategoryId   1:单点菜品  2：套餐 3:宴席 4:庆典 5:演艺伴奏 6：服务  可为空
     * @return
     */
    @RequestMapping("/clearShopCar")
    public @ResponseBody ViewData clearShopCar(Integer bigCategoryId){

        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        shopCarService.delClearShopCar(user.getId(),bigCategoryId);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  获取我的购物车
     * @return
     */
    @RequestMapping("/getShopCar")
    public @ResponseBody ViewData queryShopCarByUser(){

        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                shopCarService.queryAllShopCarByUser(user.getId()));
    }

    /**
     *  新增 减去 购物车商品数量
     * @param flag 0:减  1:加
     * @param foodId 商品ID / 婚庆ID
     * @param foodCategoryId 商品分类ID
     * @param childCategoryId 如果是婚庆的分类 则字段必须要有，子分类ID
     * @param weddingSonId 如果是婚庆的分类 则字段必须要有，子项ID
     * @param shopCarId 购物车ID 如果有购物车ID 直接更新数字
     * @return
     */
    @RequestMapping("/updateShop")
    public @ResponseBody ViewData updateShopCar(Integer flag,Integer foodId,Integer foodCategoryId,Integer childCategoryId,
                                  Integer weddingSonId,Integer shopCarId){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN, ReturnMessage.MSG_NOT_LOGIN.toString());
        }
        if(!(obj instanceof User)){
            return buildFailureJson(StatusConstant.NON_ALLOW,ReturnMessage.MSG_NON_ALLOW.toString());
        }
        User user = (User)obj;
        if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
            return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,ReturnMessage.MSG_ACCOUNT_NON_VALID.toString());
        }
        if(null == flag || null == foodId || null == foodCategoryId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }

        ShopCar shopCar = new ShopCar();
        shopCar.setUserId(user.getId());
        shopCar.setFoodId(foodId);
        shopCar.setFoodCategoryId(foodCategoryId);
        shopCar.setId(shopCarId);
        if(FoodCategoryEnum.SPECIAL_WEDDING.ordinal() == foodCategoryId){
            // 如果是婚庆类
            if(null == childCategoryId || null == weddingSonId ){
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
            }
            shopCar.setChildCategoryId(childCategoryId);
            shopCar.setWeddingSonId(weddingSonId);
        }
        try {
            if(0 == flag){
                shopCarService.delToShopCar(shopCar);
            }
            else if(1 == flag){
                shopCarService.addToShopCar(shopCar);
            }
            else{
                return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    /**
     *  换一换 菜品
     * @param shopCarId
     * @param newFoodId
     * @return
     */
    @RequestMapping("/updateChangeFood")
    public @ResponseBody ViewData updateChangeFood(Integer shopCarId,Integer newFoodId,Integer foodCategoryId){

        if(null == shopCarId || null == newFoodId || null == foodCategoryId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            shopCarService.updateShopCar(shopCarId,newFoodId,foodCategoryId);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());

    }

}
