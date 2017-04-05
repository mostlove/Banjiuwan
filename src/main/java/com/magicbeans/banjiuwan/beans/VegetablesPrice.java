package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;

/**
 * 实时菜价
 * Created by Eric Xie on 2017/3/10 0010.
 */
public class VegetablesPrice implements Serializable {

    private Integer id;

    private Integer  vegetablesId;

    private Double price;

    private Date time;

    private Long timeLong;

    private String dishName;

    private String units;

    public Long getTimeLong() {
        return timeLong;
    }

    public void setTimeLong(Long timeLong) {
        this.timeLong = timeLong;
    }

    public String getDishName() {
        return dishName;
    }

    public void setDishName(String dishName) {
        this.dishName = dishName;
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

    public Integer getVegetablesId() {
        return vegetablesId;
    }

    public void setVegetablesId(Integer vegetablesId) {
        this.vegetablesId = vegetablesId;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}
