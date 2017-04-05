package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 购物车 婚庆相关业务实体
 * Created by Eric Xie on 2017/3/1 0001.
 */
public class ShopCarWedding implements Serializable {

    /**购物车ID*/
    private Integer shopCarId;

    /**婚庆ID*/
    private Integer weddingId;

    /**子类和子项中间表ID*/
    private  Integer childCategoryWeddingSonCenterId;

    public Integer getShopCarId() {
        return shopCarId;
    }

    public void setShopCarId(Integer shopCarId) {
        this.shopCarId = shopCarId;
    }

    public Integer getWeddingId() {
        return weddingId;
    }

    public void setWeddingId(Integer weddingId) {
        this.weddingId = weddingId;
    }

    public Integer getChildCategoryWeddingSonCenterId() {
        return childCategoryWeddingSonCenterId;
    }

    public void setChildCategoryWeddingSonCenterId(Integer childCategoryWeddingSonCenterId) {
        this.childCategoryWeddingSonCenterId = childCategoryWeddingSonCenterId;
    }
}
