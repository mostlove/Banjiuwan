package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.FoodCategory;
import com.magicbeans.banjiuwan.mapper.IFoodCategoryMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 菜品分类业务层
 * Created by Eric Xie on 2017/3/1 0001.
 */
@Service
public class FoodCategoryService {

    @Resource
    private IFoodCategoryMapper foodCategoryMapper;


    public void addFoodCategory(FoodCategory foodCategory){
        foodCategoryMapper.addFoodCategory(foodCategory);
    }

    public List<FoodCategory> queryBigCategory(){
        List<FoodCategory> foodCategories = foodCategoryMapper.queryBigCategory();
        for (FoodCategory foodCategory : foodCategories){
            if(7 == foodCategory.getId()){
                foodCategories.remove(foodCategory);
                break;
            }
        }
        return foodCategoryMapper.queryBigCategory();
    }

    /**
     * 更新大类型的 是否在圈内 圈外
     * @param bigCategorys
     */
    @Transactional
    public void batchUpdateBigCategory(List<FoodCategory> bigCategorys){
        foodCategoryMapper.updateBigCategoryInside();
        foodCategoryMapper.updateBigCategory(bigCategorys);
    }


    public void updateFoodCategory(FoodCategory foodCategory){
        foodCategoryMapper.updateCategory(foodCategory);
    }


    public List<FoodCategory> queryAllFoodCategory(){
        return foodCategoryMapper.queryAll();
    }


    public List<FoodCategory> querySingleFoodCategory(){
        return foodCategoryMapper.querySingleFoodCategory();
    }


    public List<FoodCategory> querySingleFoodCategoryForApp(){
        return foodCategoryMapper.querySingleFoodCategoryForApp();
    }

    public FoodCategory queryCategoryById(Integer id){
        return foodCategoryMapper.queryCategoryById(id);
    }

    /**
     * 更新提示语
     * @param bigFoodCategory
     */
    public void updateBigCategoryMSG(FoodCategory bigFoodCategory){
        foodCategoryMapper.updateBigCategoryMSG(bigFoodCategory);
    }

}
