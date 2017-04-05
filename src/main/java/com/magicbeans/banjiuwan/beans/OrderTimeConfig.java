package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 订单溢价 配置实体
 * Created by Eric Xie on 2017/3/2 0002.
 */
public class OrderTimeConfig implements Serializable {


    private Integer id;

    /**时间段*/
    private String time;

    /**该时间段溢价*/
    private Double price;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
