package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 交通费用配置
 * Created by Eric Xie on 2017/3/2 0002.
 */
public class TransportationCostConfig implements Serializable {

    private Integer id;

    private Integer distance;

    private Double price;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDistance() {
        return distance;
    }

    public void setDistance(Integer distance) {
        this.distance = distance;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
