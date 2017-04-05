package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 *
 * 婚庆预约 和 婚庆预约子项 中间表实体
 *
 * Created by Eric Xie on 2017/2/22 0022.
 */
public class WeddingWeddingSon implements Serializable {

    /**主键ID*/
    private Integer id;

    /**婚庆预约ID*/
    private Integer weddingId;

    /**婚庆预约子项 ID*/
    private Integer weddingSonId;

    /**婚庆预约子项目 类型*/
    private Integer weddingType;

    private String name;

    private Double price;

    private String units;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getWeddingId() {
        return weddingId;
    }

    public void setWeddingId(Integer weddingId) {
        this.weddingId = weddingId;
    }

    public Integer getWeddingSonId() {
        return weddingSonId;
    }

    public void setWeddingSonId(Integer weddingSonId) {
        this.weddingSonId = weddingSonId;
    }

    public Integer getWeddingType() {
        return weddingType;
    }

    public void setWeddingType(Integer weddingType) {
        this.weddingType = weddingType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getUnits() {
        return units;
    }

    public void setUnits(String units) {
        this.units = units;
    }
}
