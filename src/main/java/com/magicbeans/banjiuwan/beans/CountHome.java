package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * Created by Eric Xie on 2017/3/24 0024.
 */
public class CountHome implements Serializable {

    /**待处理*/
    private Integer pendingCount;

    /**已处理*/
    private Integer pendCount;
    /**召唤客户经理 待处理*/
    private Integer pendingCall;

    /**申请退款的订单数量*/
    private Integer applicationRefund;


    public Integer getApplicationRefund() {
        return applicationRefund;
    }

    public void setApplicationRefund(Integer applicationRefund) {
        this.applicationRefund = applicationRefund;
    }

    public Integer getPendingCount() {
        return pendingCount;
    }

    public void setPendingCount(Integer pendingCount) {
        this.pendingCount = pendingCount;
    }

    public Integer getPendCount() {
        return pendCount;
    }

    public void setPendCount(Integer pendCount) {
        this.pendCount = pendCount;
    }

    public Integer getPendingCall() {
        return pendingCall;
    }

    public void setPendingCall(Integer pendingCall) {
        this.pendingCall = pendingCall;
    }
}
