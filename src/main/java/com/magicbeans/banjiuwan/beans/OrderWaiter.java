package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 订单 和 服务员
 * Created by Eric Xie on 2017/3/17 0017.
 */
public class OrderWaiter implements Serializable {


    /**主键ID*/
    private Integer id;

    /**订单ID*/
    private Integer orderId;

    private Integer waiterId;

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

    public Integer getWaiterId() {
        return waiterId;
    }

    public void setWaiterId(Integer waiterId) {
        this.waiterId = waiterId;
    }
}
