package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.List;

/**
 * 购物车 实体
 * Created by Eric Xie on 2017/2/27 0027.
 */
public class ShopCar implements Serializable {

    /**主键ID*/
    private Integer id;

    /**用户ID*/
    private Integer userId;

    /**菜品ID 或者 婚庆ID*/
    private Integer foodId;

    /**分类ID*/
    private Integer foodCategoryId;

    /**当前列的数量*/
    private Integer number;

    /**婚庆子类ID*/
    private Integer childCategoryId;

    /**婚庆子项ID*/
    private Integer weddingSonId;



    //业务类
    /**子项名称*/
    private String name;

    /**子项单价*/
    private Double price;

    /**子项量词*/
    private String units;

    /**分类图*/
    private String img;

    /**分类名称*/
    private String categoryName;

    /**婚庆名称*/
    private String weddingName;

    private String childCategoryWeddingSonCenterId;

    /**菜品集合*/
    private List<SingleFood> singleFoodList;

    /**起订数量*/
    private Integer leastNumber;

    public Integer getLeastNumber() {
        return leastNumber;
    }

    public void setLeastNumber(Integer leastNumber) {
        this.leastNumber = leastNumber;
    }

    public List<SingleFood> getSingleFoodList() {
        return singleFoodList;
    }

    public void setSingleFoodList(List<SingleFood> singleFoodList) {
        this.singleFoodList = singleFoodList;
    }

    public String getChildCategoryWeddingSonCenterId() {
        return childCategoryWeddingSonCenterId;
    }

    public void setChildCategoryWeddingSonCenterId(String childCategoryWeddingSonCenterId) {
        this.childCategoryWeddingSonCenterId = childCategoryWeddingSonCenterId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getFoodId() {
        return foodId;
    }

    public void setFoodId(Integer foodId) {
        this.foodId = foodId;
    }

    public Integer getFoodCategoryId() {
        return foodCategoryId;
    }

    public void setFoodCategoryId(Integer foodCategoryId) {
        this.foodCategoryId = foodCategoryId;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Integer getChildCategoryId() {
        return childCategoryId;
    }

    public void setChildCategoryId(Integer childCategoryId) {
        this.childCategoryId = childCategoryId;
    }

    public Integer getWeddingSonId() {
        return weddingSonId;
    }

    public void setWeddingSonId(Integer weddingSonId) {
        this.weddingSonId = weddingSonId;
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

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getWeddingName() {
        return weddingName;
    }

    public void setWeddingName(String weddingName) {
        this.weddingName = weddingName;
    }
}
