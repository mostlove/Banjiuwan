package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 会员消费统计
 * Created by Eric Xie on 2017/3/14 0014.
 */
public class ConsumptionStatistics implements Serializable {

    /**用户名*/
    private String userName;

    /**电话*/
    private String phoneNumber;

    /**累计充值金额*/
    private double sumRecharge;

    /**累计赠送金额*/
    private double sumGiveRecharge;

    /**会员卡余额*/
    private double memberBalance;

    /**会员卡 累计消费金额*/
    private double memberSumConsumption;

    /**优惠券余额*/
    private double couponBalance;

    /**优惠券 累计消费*/
    private double couponSumConsumption;

    /**现金券余额*/
    private double cashCouponBalance;

    /**现金券累计消费*/
    private double cashCouponSumConsumption;

    /**总累计消费*/
    private double countSumConsumption;


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public double getSumRecharge() {
        return sumRecharge;
    }

    public void setSumRecharge(double sumRecharge) {
        this.sumRecharge = sumRecharge;
    }

    public double getSumGiveRecharge() {
        return sumGiveRecharge;
    }

    public void setSumGiveRecharge(double sumGiveRecharge) {
        this.sumGiveRecharge = sumGiveRecharge;
    }

    public double getMemberBalance() {
        return memberBalance;
    }

    public void setMemberBalance(double memberBalance) {
        this.memberBalance = memberBalance;
    }

    public double getMemberSumConsumption() {
        return memberSumConsumption;
    }

    public void setMemberSumConsumption(double memberSumConsumption) {
        this.memberSumConsumption = memberSumConsumption;
    }

    public double getCouponBalance() {
        return couponBalance;
    }

    public void setCouponBalance(double couponBalance) {
        this.couponBalance = couponBalance;
    }

    public double getCouponSumConsumption() {
        return couponSumConsumption;
    }

    public void setCouponSumConsumption(double couponSumConsumption) {
        this.couponSumConsumption = couponSumConsumption;
    }

    public double getCashCouponBalance() {
        return cashCouponBalance;
    }

    public void setCashCouponBalance(double cashCouponBalance) {
        this.cashCouponBalance = cashCouponBalance;
    }

    public double getCashCouponSumConsumption() {
        return cashCouponSumConsumption;
    }

    public void setCashCouponSumConsumption(double cashCouponSumConsumption) {
        this.cashCouponSumConsumption = cashCouponSumConsumption;
    }

    public double getCountSumConsumption() {
        return countSumConsumption;
    }

    public void setCountSumConsumption(double countSumConsumption) {
        this.countSumConsumption = countSumConsumption;
    }
}
