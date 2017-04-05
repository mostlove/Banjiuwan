package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.CouponFoodCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/3 0003.
 */
public interface ICouponFoodCategoryMapper {


    Integer addCouponCategory(@Param("couponFoodCategory") CouponFoodCategory couponFoodCategory);

    Integer batchAddCouponCategory(@Param("couponFoodCategories") List<CouponFoodCategory> couponFoodCategories);

    Integer delConponCategoryByCouponId(@Param("couponId") Integer couponId);

    List<CouponFoodCategory> batchQueryByCouponIds(@Param("ids") List<Integer> ids);

}
