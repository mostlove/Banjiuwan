package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.FoodCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *
 * 菜品分类 持久层接口
 * Created by Eric Xie on 2017/2/13 0013.
 */
public interface IFoodCategoryMapper {


    Integer addFoodCategory(@Param("foodCategory") FoodCategory foodCategory);

    Integer updateCategory(@Param("category") FoodCategory category);

    List<FoodCategory> queryAll();

    List<FoodCategory> querySingleFoodCategory();


    List<FoodCategory> querySingleFoodCategoryForApp();

    FoodCategory queryCategoryById(@Param("id") Integer id);

    /**
     *  通过 优惠券ID 查询
     * @return
     */
    List<FoodCategory> queryCategoryByIds(@Param("id") Integer id);


    /**
     *  批量更新 大类型 是否在圈内圈外
     * @param bigCategorys
     * @return
     */
    Integer updateBigCategory(@Param("bigCategorys") List<FoodCategory> bigCategorys);

    /**
     *  更新所有在范围外
     * @return
     */
    Integer updateBigCategoryInside();

    /**
     *  查询大类型数据
     * @return
     */
    List<FoodCategory> queryBigCategory();


    /**
     *  更新体提示语
     * @return
     */
    Integer updateBigCategoryMSG(@Param("bigFoodCategory") FoodCategory bigFoodCategory);

}
