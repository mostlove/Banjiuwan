package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 订单 和 厨师 之前关系 实体
 * Created by Eric Xie on 2017/3/6 0006.
 */
public class OrderCook implements Serializable {

    /**主键ID*/
    private Integer id;

    /**订单ID*/
    private Integer orderId;

    /**厨师ID*/
    private Integer cookId;

    /**是否是 主厨  0:不是 1:是*/
    private Integer isMain;

    /**锁定数据*/
    private Integer isLocking;

    public Integer getIsLocking() {
        return isLocking;
    }

    public void setIsLocking(Integer isLocking) {
        this.isLocking = isLocking;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getCookId() {
        return cookId;
    }

    public void setCookId(Integer cookId) {
        this.cookId = cookId;
    }

    public Integer getIsMain() {
        return isMain;
    }

    public void setIsMain(Integer isMain) {
        this.isMain = isMain;
    }
}
