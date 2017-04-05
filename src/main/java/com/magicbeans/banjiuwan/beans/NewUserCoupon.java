package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 新用户 赠送的券信息
 * Created by Eric Xie on 2017/2/13 0013.
 */
public class NewUserCoupon implements Serializable {

    /**主键ID*/
    private Integer id;

    /**券ID*/
    private Integer couponId;

    /**有效天数*/
    private Integer days;


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

    public Integer getDays() {
        return days;
    }

    public void setDays(Integer days) {
        this.days = days;
    }
}
