package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;

/**
 * 订单销售 提成 实体
 * Created by Eric Xie on 2017/3/16 0016.
 */
public class OrderSales implements Serializable {

    /**订单号*/
    private String orderNumber;

    /**订单总价*/
    private Double price;

    /**配置文件*/
    private String config;

    /**订单创建时间*/
    private Date createTime;

    /**订单创建人*/
    private String userName;

    /**创建人 手机号*/
    private String phoneNumber;

    /**订单所属客户经理*/
    private String managerName;

    /**所属客户经理电话*/
    private String managerPhone;

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getConfig() {
        return config;
    }

    public void setConfig(String config) {
        this.config = config;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

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

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getManagerPhone() {
        return managerPhone;
    }

    public void setManagerPhone(String managerPhone) {
        this.managerPhone = managerPhone;
    }
}
