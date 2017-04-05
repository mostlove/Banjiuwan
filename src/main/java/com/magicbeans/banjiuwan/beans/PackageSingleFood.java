package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 套餐/坝坝宴 与 菜品 中间表实体
 * Created by Eric Xie on 2017/2/21 0021.
 */
public class PackageSingleFood implements Serializable {

    /**主键ID*/
    private Integer id;

    /**套餐、坝坝宴 ID*/
    private Integer packageId;

    /**菜品、酒水 ID*/
    private Integer singleFoodId;

    /**数量*/
    private Integer number;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPackageId() {
        return packageId;
    }

    public void setPackageId(Integer packageId) {
        this.packageId = packageId;
    }

    public Integer getSingleFoodId() {
        return singleFoodId;
    }

    public void setSingleFoodId(Integer singleFoodId) {
        this.singleFoodId = singleFoodId;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }
}
