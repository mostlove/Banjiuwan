package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 充值配置
 * Created by Eric Xie on 2017/3/9 0009.
 */
public class RechargeConfig implements Serializable {

    /**主键ID*/
    private Integer id;

    /**充值金额*/
    private Integer balance;

    /**赠送金额*/
    private Integer giveBalance;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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
}
