package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * 子项 和 子类 绑定 中间表
 *
 * Created by Eric Xie on 2017/2/23 0023.
 */
public class WeddingSonChildCategory implements Serializable {

    /**主键ID*/
    private Integer id;

    /**婚庆 子项ID*/
    private Integer weddingSonId;

    /**子类ID*/
    private Integer childCategoryId;

    /**创建时间*/
    private Date createTime;

    // 业务实体
    private String name;

    private Double price;

    private String units;


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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getWeddingSonId() {
        return weddingSonId;
    }

    public void setWeddingSonId(Integer weddingSonId) {
        this.weddingSonId = weddingSonId;
    }

    public Integer getChildCategoryId() {
        return childCategoryId;
    }

    public void setChildCategoryId(Integer childCategoryId) {
        this.childCategoryId = childCategoryId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
