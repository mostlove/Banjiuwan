package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.FoodCategory;
import com.magicbeans.banjiuwan.beans.ShopCar;
import com.magicbeans.banjiuwan.beans.WeddingSon;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 购物车 持久层接口
 * Created by Eric Xie on 2017/2/27 0027.
 */
public interface IShopCarMapper {


    Integer addToShopCar(@Param("shopCar") ShopCar shopCar);

    Integer delShopCar(@Param("userId") Integer userId,@Param("foodCategoryId") Integer foodCategoryId,@Param("foodId") Integer foodId);

    List<ShopCar> queryAllByUser(@Param("userId") Integer userId);

    ShopCar queryShopCarByItem(@Param("userId") Integer userId,@Param("foodCategoryId") Integer foodCategoryId,@Param("foodId") Integer foodId);

    Integer updateShoCarNumber(@Param("shopCar") ShopCar shopCar);

    /**
     *  婚庆类 查询购物车
     * @param userId
     * @param foodCategoryId
     * @param foodId
     * @return
     */
    ShopCar queryShopCarForWedding(@Param("userId") Integer userId,@Param("foodCategoryId") Integer foodCategoryId,
                                   @Param("foodId") Integer foodId,@Param("weddingSonId") Integer weddingSonId,
                                   @Param("childCategoryId") Integer childCategoryId);


    /**
     *  根据ID 批量查询 数据
     * @param ids
     * @return
     */
    List<ShopCar> batchQuery(@Param("ids") List<Integer> ids);


    Integer delShopCarById(@Param("id") Integer id);


    /**
     *  批量删除 购物车
     * @param ids
     * @return
     */
    Integer batchDelShopCar(@Param("ids") List<Integer> ids);


    /**
     *  通过ID 集合 多条件 查询购物车里的数量
     * @param sonIds
     * @param weddingId
     * @param userId
     * @return
     */
    List<ShopCar> queryShopCarByItemOtherInfo(@Param("sonIds") List<Integer> sonIds, @Param("weddingId") Integer weddingId,
                                           @Param("userId") Integer userId);


    Integer delClearShopCar(@Param("userId") Integer userId,@Param("bigCategoryId") Integer bigCategoryId,
                            @Param("foodCategories") List<FoodCategory> foodCategories);

    /**
     *  换一换 更新
     * @param shopCar
     * @return
     */
    Integer updateShopCar(@Param("shopCar") ShopCar shopCar);

    /**
     *  后台删除 某菜品时，清空所有购物车中 相关菜品的信息
     * @param userId
     * @param foodId
     * @param foodCategoryId
     * @return
     */
    Integer delShopByItem(@Param("foodId") Integer foodId,@Param("foodCategoryId") Integer foodCategoryId);

}
