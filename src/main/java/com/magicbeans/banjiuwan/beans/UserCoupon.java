package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户 券信息 实体
 * Created by Eric Xie on 2017/2/13 0013.
 */
public class UserCoupon implements Serializable {

    /**主键ID*/
    private Integer id;

    /**用户ID*/
    private Integer userId;

    /**券ID*/
    private Integer couponId;

    /**开始时间(从发放时起)*/
    private Integer startTime;

    /**结束时间(截至到当前 23:59分)*/
    private Integer endTime;

    /**券说明*/
    private String text;

    /**券是否有效  0:无效 1:有效 缺省值: 1*/
    private Integer isValid;

    /**有效天数*/
    private Integer days;

    private Integer type;

    /**面值*/
    private Integer faceValue;

    /**如果是 优惠券 需要消费多少 才能使用优惠券*/
    private Integer needSpend;


    /**业务需求*/
    private Integer foodCategoryId;

    public Integer getFoodCategoryId() {
        return foodCategoryId;
    }

    public void setFoodCategoryId(Integer foodCategoryId) {
        this.foodCategoryId = foodCategoryId;
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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getCouponId() {
        return couponId;
    }

    public void setCouponId(Integer couponId) {
        this.couponId = couponId;
    }

    public Integer getStartTime() {
        return startTime;
    }

    public void setStartTime(Integer startTime) {
        this.startTime = startTime;
    }

    public Integer getEndTime() {
        return endTime;
    }

    public void setEndTime(Integer endTime) {
        this.endTime = endTime;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Integer getIsValid() {
        return isValid;
    }

    public void setIsValid(Integer isValid) {
        this.isValid = isValid;
    }

    public Integer getDays() {
        return days;
    }

    public void setDays(Integer days) {
        this.days = days;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserCoupon that = (UserCoupon) o;

        return id.equals(that.id);

    }

    @Override
    public int hashCode() {
        return id.hashCode();
    }
}
