package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 服务费配置
 * Created by Eric Xie on 2017/3/3 0003.
 */
public class ServiceConfig implements Serializable {

    /**主键ID*/
    private Integer id;

    /**起步单价*/
    private Double price;

    /**增加多少价*/
    private Double addPrice;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getAddPrice() {
        return addPrice;
    }

    public void setAddPrice(Double addPrice) {
        this.addPrice = addPrice;
    }
}
