package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.List;

/**
 *
 * 券 实体
 * Created by Eric Xie on 2017/2/13 0013.
 */
public class Coupon implements Serializable {

    /**主键ID*/
    private Integer id;

    /**面值*/
    private Integer faceValue;

    /**如果是 优惠券 需要消费多少 才能使用优惠券*/
    private Integer needSpend;

    /**类型 0: 优惠券 1: 现金券*/
    private Integer type;

    /**使用区间 (id,id2,id3)*/
    private String useInterval;

    /**使用区间 集合对象*/
    private List<FoodCategory> categories;

    /**是否是 注册时 赠送优惠券  0 :否  1:是*/
    private Integer isNewUserCoupon;

    /**赠送天数*/
    private Integer days;

    public Integer getDays() {
        return days;
    }

    public void setDays(Integer days) {
        this.days = days;
    }

    public Integer getIsNewUserCoupon() {
        return isNewUserCoupon;
    }

    public void setIsNewUserCoupon(Integer isNewUserCoupon) {
        this.isNewUserCoupon = isNewUserCoupon;
    }

    public List<FoodCategory> getCategories() {
        return categories;
    }

    public void setCategories(List<FoodCategory> categories) {
        this.categories = categories;
    }

    public String getUseInterval() {
        return useInterval;
    }

    public void setUseInterval(String useInterval) {
        this.useInterval = useInterval;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFaceValue() {
        return faceValue;
    }

    public void setFaceValue(Integer faceValue) {
        this.faceValue = faceValue;
    }

    public Integer getNeedSpend() {
        return needSpend;
    }

    public void setNeedSpend(Integer needSpend) {
        this.needSpend = needSpend;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }


}
