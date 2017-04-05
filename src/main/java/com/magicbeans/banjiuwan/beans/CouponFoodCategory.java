package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 优惠券 使用区间
 * Created by Eric Xie on 2017/3/3 0003.
 */
public class CouponFoodCategory implements Serializable {


    private Integer id;

    private Integer couponId;

    private Integer foodCategoryId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCouponId() {
        return couponId;
    }

    public void setCouponId(Integer couponId) {
        this.couponId = couponId;
    }

    public Integer getFoodCategoryId() {
        return foodCategoryId;
    }

    public void setFoodCategoryId(Integer foodCategoryId) {
        this.foodCategoryId = foodCategoryId;
    }
}
