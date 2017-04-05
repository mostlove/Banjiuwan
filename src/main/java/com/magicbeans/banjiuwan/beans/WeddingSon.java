package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * 婚庆预约 子项实体
 *
 * Created by Eric Xie on 2017/2/22 0022.
 */
public class WeddingSon implements Serializable {


    private Integer id;

    private String name;

    private Double price;

    private String units;

    private Date createTime;

    private Integer countNumber;

    public Integer getCountNumber() {
        return countNumber;
    }

    public void setCountNumber(Integer countNumber) {
        this.countNumber = countNumber;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
