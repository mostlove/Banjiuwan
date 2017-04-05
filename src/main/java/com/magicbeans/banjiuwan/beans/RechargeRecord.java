package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;

/**
 * 充值记录实体
 * Created by Eric Xie on 2017/3/9 0009.
 */
public class RechargeRecord implements Serializable {

    /**主键ID*/
    private Integer id;

    /**用户ID*/
    private Integer userId;

    private User user;

    private String userName;

    private String phoneNumber;

    /**充值金额*/
    private Integer balance;

    /**赠送金额*/
    private Integer giveBalance;

    /**充值状态  0：未支付  1:支付成功 */
    private Integer status;

    /**提交充值的时间*/
    private Date createTime;

    /**订单交易号*/
    private String outTradeNo;

    /**支付方式*/
    private Integer payMethod;

    /**备注*/
    private String reMarket;

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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getPayMethod() {
        return payMethod;
    }

    public void setPayMethod(Integer payMethod) {
        this.payMethod = payMethod;
    }

    public String getOutTradeNo() {
        return outTradeNo;
    }

    public void setOutTradeNo(String outTradeNo) {
        this.outTradeNo = outTradeNo;
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

    public Integer getBalance() {
        return balance;
    }

    public void setBalance(Integer balance) {
        this.balance = balance;
    }

    public Integer getGiveBalance() {
        return giveBalance;
    }

    public void setGiveBalance(Integer giveBalance) {
        this.giveBalance = giveBalance;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getReMarket() {
        return reMarket;
    }

    public void setReMarket(String reMarket) {
        this.reMarket = reMarket;
    }
}
