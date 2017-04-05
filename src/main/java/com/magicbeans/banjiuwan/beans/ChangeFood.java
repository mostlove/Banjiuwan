package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 菜品 换一换 实体
 * Created by Eric Xie on 2017/3/8 0008.
 */
public class ChangeFood implements Serializable {

    /**id*/
    private Integer id;

    /**菜品ID*/
    private Integer foodId;

    /**被关联的菜品ID*/
    private Integer secondFoodId;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFoodId() {
        return foodId;
    }

    public void setFoodId(Integer foodId) {
        this.foodId = foodId;
    }

    public Integer getSecondFoodId() {
        return secondFoodId;
    }

    public void setSecondFoodId(Integer secondFoodId) {
        this.secondFoodId = secondFoodId;
    }
}
