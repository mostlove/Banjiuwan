package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.*;
import com.magicbeans.banjiuwan.enumutil.FoodCategoryEnum;
import com.magicbeans.banjiuwan.mapper.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

/**
 * 购物车业务层
 * Created by Eric Xie on 2017/2/27 0027.
 */
@Service
public class ShopCarService {


    @Resource
    private IShopCarMapper shopCarMapper;
    @Resource
    private ISingleFoodMapper singleFoodMapper;
    @Resource
    private IPackageCaterMapper packageCaterMapper;
    @Resource
    private ISpecialActMapper specialActMapper;
    @Resource
    private ISpecialServiceChildMapper specialServiceChildMapper;
    @Resource
    private IFoodCategoryMapper foodCategoryMapper;


    public void delClearShopCar(Integer userId,Integer bigCategory){
        List<FoodCategory> foodCategories = null;
        if(null != bigCategory && bigCategory == 1){
            foodCategories = foodCategoryMapper.querySingleFoodCategory();
        }
        shopCarMapper.delClearShopCar(userId,bigCategory,foodCategories);
    }


    /**
     * 向购物车 新增商品
     * @param shopCar
     */
    @Transactional
    public void addToShopCar(ShopCar shopCar){

        if(shopCar.getFoodCategoryId().equals(FoodCategoryEnum.SPECIAL_WEDDING.ordinal())){

            ShopCar shopCar1 = shopCarMapper.queryShopCarForWedding(shopCar.getUserId(),shopCar.getFoodCategoryId(),
                    shopCar.getFoodId(),shopCar.getWeddingSonId(),shopCar.getChildCategoryId());
            if(null == shopCar1){
                shopCarMapper.addToShopCar(shopCar);
            }
            else{
                // 更新字段
                shopCar1.setNumber(shopCar1.getNumber() + 1);
                shopCarMapper.updateShoCarNumber(shopCar1);
            }
        }
        else{
            ShopCar tempShopCar = shopCarMapper.queryShopCarByItem(shopCar.getUserId(),shopCar.getFoodCategoryId(),shopCar.getFoodId());
            if(null != tempShopCar  ){
                // 更新字段
                tempShopCar.setNumber(tempShopCar.getNumber() + 1);
                shopCarMapper.updateShoCarNumber(tempShopCar);
            }else{
                shopCarMapper.addToShopCar(shopCar);
            }
        }
    }

    /**
     *  删除购物车的数据
     */
    public void delToShopCar(ShopCar shopCar){

        if(shopCar.getFoodCategoryId().equals(FoodCategoryEnum.SPECIAL_WEDDING.ordinal())){

            ShopCar shopCar1 = shopCarMapper.queryShopCarForWedding(shopCar.getUserId(),shopCar.getFoodCategoryId(),
                    shopCar.getFoodId(),shopCar.getWeddingSonId(),shopCar.getChildCategoryId());
            if(null == shopCar1){
                return;
            }
            if(shopCar1.getNumber() >= 2){
                // 更新字段
                shopCar1.setNumber(shopCar1.getNumber() - 1);
                shopCarMapper.updateShoCarNumber(shopCar1);
            }
            else{
                shopCarMapper.delShopCarById(shopCar1.getId());
            }
        }else{
            ShopCar tempShopCar = shopCarMapper.queryShopCarByItem(shopCar.getUserId(),shopCar.getFoodCategoryId(),shopCar.getFoodId());
            if(null == tempShopCar){
                return;
            }
            if(tempShopCar.getNumber() >= 2){
                tempShopCar.setNumber(tempShopCar.getNumber() - 1);
                shopCarMapper.updateShoCarNumber(tempShopCar);
            }else{
                shopCarMapper.delShopCarById(tempShopCar.getId());
            }
        }
    }

    /**
     *  通过userId 查询
     * @param userId
     * @return
     */
    public Map<String,List<ShopCar>> queryAllShopCarByUser(Integer userId){
        List<ShopCar> shopCarList = shopCarMapper.queryAllByUser(userId);
        // 把分类分开装
        // 单点类
        List<ShopCar> singleFoodShopCar = new ArrayList<ShopCar>();
        // 套餐、
        List<ShopCar> tempPackageCaterShopCar = new ArrayList<ShopCar>();
        List<ShopCar> packageCaterShopCar = new ArrayList<ShopCar>();
        // 坝坝宴类
        List<ShopCar> babaYanShopCar = new ArrayList<ShopCar>();
        // 专业服务类
        List<ShopCar> specialServiceShopCar = new ArrayList<ShopCar>();
        // 半餐演奏类
        List<ShopCar> specialActShopCar = new ArrayList<ShopCar>();
        // 婚庆类
        List<ShopCar> specialWeddingShopCar = new ArrayList<ShopCar>();

        // 分类装
        for (ShopCar shopCar: shopCarList ) {
            if(shopCar.getFoodCategoryId().equals(FoodCategoryEnum.SPECIAL_WEDDING.ordinal())){
                specialWeddingShopCar.add(shopCar);
            }
            else if(shopCar.getFoodCategoryId().equals(FoodCategoryEnum.SPECIAL_ACT.ordinal())){
                specialActShopCar.add(shopCar);
            }
            else if(shopCar.getFoodCategoryId().equals(FoodCategoryEnum.SPECIAL_SERVICE.ordinal())){
                specialServiceShopCar.add(shopCar);
            }
            else if(shopCar.getFoodCategoryId().equals(FoodCategoryEnum.PACKAGE.ordinal())
                    || shopCar.getFoodCategoryId().equals(FoodCategoryEnum.BA_BA_YAN.ordinal())){
                tempPackageCaterShopCar.add(shopCar);
            }
            else {
                singleFoodShopCar.add(shopCar);
            }
        }
        // 单点食物类
        if(singleFoodShopCar.size() > 0){
            List<Integer> ids = getShopIds(singleFoodShopCar);
            if(ids.size() > 0){
                List<SingleFood> singleFoods =  singleFoodMapper.batchQueryById(ids);
                for (SingleFood singleFood : singleFoods){
                    for (ShopCar shopCar : singleFoodShopCar){
                        if(singleFood.getId().equals(shopCar.getFoodId())){
                            shopCar.setImg(singleFood.getCoverImg());
                            shopCar.setName(singleFood.getFoodName());
                            shopCar.setPrice(singleFood.getPromotionPrice());
                            shopCar.setUnits(singleFood.getUnits());
                            break;
                        }
                    }
                }
            }
        }
        //坝坝宴、套餐类
        if(tempPackageCaterShopCar.size() > 0){
            List<Integer> ids = getShopIds(tempPackageCaterShopCar);
            if(ids.size() > 0){
                List<PackageCater> packageCaters = packageCaterMapper.batchQuery(ids);
                for (PackageCater packageCater : packageCaters){
                    for (ShopCar shopCar : tempPackageCaterShopCar){
                        if(packageCater.getId().equals(shopCar.getFoodId())){
                            shopCar.setImg(packageCater.getTopBanner());
                            shopCar.setUnits(packageCater.getUnits());
                            shopCar.setPrice(packageCater.getPromotionPrice());
                            shopCar.setName(packageCater.getName());
                            shopCar.setLeastNumber(packageCater.getLeastNumber());
                            shopCar.setSingleFoodList(packageCater.getSingleFoodList());
                            break;
                        }
                    }
                }
            }
        }

        for (ShopCar shopCar : tempPackageCaterShopCar){
            if(shopCar.getFoodCategoryId().equals(FoodCategoryEnum.BA_BA_YAN.ordinal())){
                babaYanShopCar.add(shopCar);
            }
            else if(shopCar.getFoodCategoryId().equals(FoodCategoryEnum.PACKAGE.ordinal())){
                packageCaterShopCar.add(shopCar);
            }
        }



        // 专业服务类

        if(specialServiceShopCar.size() > 0){
            List<Integer> ids = getShopIds_(specialServiceShopCar);
            if(ids.size() > 0){
                specialServiceShopCar = specialServiceChildMapper.queryShopCarByShopCarIds(ids);
            }

        }


        // 半餐演奏类
        if(specialActShopCar.size() > 0){
            List<Integer> ids = getShopIds(specialActShopCar);
            if(ids.size() > 0){
                List<SpecialAct> specialActs = specialActMapper.batchQuery(ids);
                for (SpecialAct specialAct : specialActs){
                    for (ShopCar shopCar : specialActShopCar){
                        if(specialAct.getId().equals(shopCar.getFoodId())){
                            shopCar.setImg(specialAct.getTopBanner());
                            shopCar.setUnits(specialAct.getUnits());
                            shopCar.setName(specialAct.getName());
                            shopCar.setPrice(specialAct.getPrice());
                            break;
                        }
                    }
                }
            }
        }
        // 婚庆预约类
        if(specialWeddingShopCar.size() > 0){
            List<Integer> ids = getShopIds_(specialWeddingShopCar);
            if(ids.size() > 0){
                specialWeddingShopCar = shopCarMapper.batchQuery(ids);
            }
        }


        // 餐具组装
        boolean is = false;
        for (ShopCar shopCar : specialServiceShopCar){
            if(shopCar.getFoodId() == 3){
                is = true;
                break;
            }
        }
        if(!is){
            ShopCar shopCar = new ShopCar();
            SpecialServiceChild specialServiceChild = specialServiceChildMapper.queryCJ();
            shopCar.setFoodId(specialServiceChild.getId());
            shopCar.setPrice(specialServiceChild.getPrice());
            shopCar.setName(specialServiceChild.getName());
            shopCar.setFoodCategoryId(FoodCategoryEnum.SPECIAL_SERVICE.ordinal());
            specialServiceShopCar.add(shopCar);
        }
        // 装数据
        Map<String,List<ShopCar>> data = new HashMap<String, List<ShopCar>>();
        data.put("singleFoodShopCar",singleFoodShopCar);
        data.put("packageCaterShopCar",packageCaterShopCar);
        data.put("babaYanShopCar",babaYanShopCar);
        data.put("serviceShopCar",specialServiceShopCar);
        data.put("actShopCar",specialActShopCar);
        data.put("weddingShopCar",specialWeddingShopCar);
        return data;
    }

    private List<Integer> getShopIds(List<ShopCar> shopCars){
        List<Integer> ids = new ArrayList<Integer>();
        if(null != shopCars && shopCars.size() != 0) {
            for (ShopCar shopCar : shopCars) {
                ids.add(shopCar.getFoodId());
            }
        }
        return ids;
    }
    private List<Integer> getShopIds_(List<ShopCar> shopCars){
        List<Integer> ids = new ArrayList<Integer>();
        if(null != shopCars && shopCars.size() != 0) {
            for (ShopCar shopCar : shopCars) {
                ids.add(shopCar.getId());
            }
        }
        return ids;
    }



    public List<ShopCar> queryShopCarByUserForApp(Integer userId){
        return shopCarMapper.queryAllByUser(userId);
    }



    public void updateShopCar(Integer shopCarId,Integer newFoodId,Integer foodCategoryId){
        ShopCar shopCar = new ShopCar();
        shopCar.setId(shopCarId);
        shopCar.setFoodId(newFoodId);
        shopCar.setFoodCategoryId(foodCategoryId);
        shopCarMapper.updateShopCar(shopCar);
    }




}


