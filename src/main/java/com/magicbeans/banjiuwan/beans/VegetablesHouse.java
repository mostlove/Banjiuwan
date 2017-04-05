package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 实时菜价-菜名 仓库
 * Created by Eric Xie on 2017/3/10 0010.
 */
public class VegetablesHouse implements Serializable {

    private Integer id;

    private String dishName;

    private String units;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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
}
