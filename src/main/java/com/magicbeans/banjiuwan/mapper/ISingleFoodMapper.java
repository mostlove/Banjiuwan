package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.SingleFood;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/2/14 0014.
 */
public interface ISingleFoodMapper {


    /**
     *  新增酒水 菜品
     * @param singleFood
     * @return
     */
    Integer addSingleFood(@Param("singleFood") SingleFood singleFood);


    /**
     *  更新 酒水菜品 不为空的字段
     * @param singleFood
     * @return
     */
    Integer updateSingleFood(@Param("singleFood") SingleFood singleFood);


    /**
     *  分页 模糊匹配 或者 按类型 查询 酒水菜品
     * @param foodName 模糊搜索的 词
     * @param foodCategoryId 分类ID
     * @param limit 起始
     * @param limitSize 截至
     * @return
     */
    List<SingleFood> queryByCategory(@Param("foodName") String foodName,@Param("foodCategoryId") Integer foodCategoryId,
                                     @Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    /**
     *  分页 模糊匹配 或者 按类型 查询 酒水菜品
     * @param foodName 模糊搜索的 词
     * @param foodCategoryIds 分类ID
     * @param limit 起始
     * @param limitSize 截至
     * @return
     */
    List<SingleFood> queryByCategoryForWeb(@Param("foodName") String foodName,
                                           @Param("foodCategoryIds") Integer[] foodCategoryIds,
                                           @Param("isPromotion") Integer isPromotion,
                                           @Param("isRecommendation") Integer isRecommendation,
                                           @Param("recommendationIndex") Integer recommendationIndex,
                                           @Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    Integer countByCategory(@Param("foodName") String foodName,
                            @Param("foodCategoryIds") Integer[] foodCategoryIds,
                            @Param("isPromotion") Integer isPromotion,
                            @Param("isRecommendation") Integer isRecommendation,
                            @Param("recommendationIndex") Integer recommendationIndex);

    /**
     *  通过ID 查询单个 酒水菜品
     * @param id
     * @return
     */
    SingleFood queryById(@Param("id") Integer id);

    /**
     *  根据ID 删除菜品
     * @param id
     * @return
     */
    Integer delSingleFood(@Param("id") Integer id);

    /**
     *  根据 菜品ID 查询单个菜品属性
     * @param userId
     * @param foodId
     * @return
     */
    SingleFood querySingleFoodById(@Param("userId") Integer userId,@Param("foodId") Integer foodId,@Param("foodCategoryId") Integer foodCategoryId);


    /**
     *  根据 套餐 坝坝宴 查询 菜品集合
     * @param packageId 套餐、坝坝宴ID
     * @return
     */
    List<SingleFood> queryByPackage(@Param("packageId") Integer packageId);

    /**
     * 通过ID集合 批量查询 封面图、单价、名称、量词 字段
     * @param ids
     * @return
     */
    List<SingleFood> batchQueryById(@Param("ids") List<Integer> ids);


    /**
     *  分页 模糊匹配 或者 按类型 查询 酒水菜品
     * @param foodName 模糊搜索的 词
     * @param foodCategoryId 分类ID
     * @param limit 起始
     * @param limitSize 截至
     * @return
     */
//    List<SingleFood> queryByCategoryAndUser(@Param("foodName") String foodName,@Param("foodCategoryId") Integer foodCategoryId,
//                                     @Param("userId") Integer userId);


    /**
     * 获取推荐 促销菜品列表
     * @param type 1促销 2推荐
     * @return
     */
    List<SingleFood> getRecommendationPromotion(@Param("type")Integer type);

    /**
     * 更新是否促销或推荐
     * @param type
     * @param bol
     */
    void updateRecommendationOrPromotion(@Param("type")Integer type,@Param("bol")Boolean bol,@Param("id")Integer id);


    Integer batchUpdateSales(@Param("singleFoods") List<SingleFood> singleFoods);
}
