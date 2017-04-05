package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 *
 * 特色服务 婚庆服务 实体
 * Created by Eric Xie on 2017/2/15 0015.
 */
public class SpecialWedding implements Serializable {

    /**主键ID*/
    private Integer id;

    /**封面图*/
    private String coverImg;

    /**banners*/
    private String banners;

    /**名称*/
    private String name;

    /**单价*/
    private Double price;

    /**推荐指数*/
    private Integer recommendationIndex;

    /**销量*/
    private Integer sales;

    /**套餐描述*/
    private String packageDescription;

    /**子分类IDS*/
    private String childCategorys;

    /**子分类集合*/
    private List<WeddingChildCategory> weddingChildCategories;

    /**分类ID*/
    private Integer foodCategoryId;

    private Date createTime;

    private List<WeddingWeddingSon> weddingSons;


    public List<WeddingChildCategory> getWeddingChildCategories() {
        return weddingChildCategories;
    }

    public void setWeddingChildCategories(List<WeddingChildCategory> weddingChildCategories) {
        this.weddingChildCategories = weddingChildCategories;
    }

    public String getChildCategorys() {
        return childCategorys;
    }

    public void setChildCategorys(String childCategorys) {
        this.childCategorys = childCategorys;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCoverImg() {
        return coverImg;
    }

    public void setCoverImg(String coverImg) {
        this.coverImg = coverImg;
    }

    public String getBanners() {
        return banners;
    }

    public void setBanners(String banners) {
        this.banners = banners;
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

    public Integer getRecommendationIndex() {
        return recommendationIndex;
    }

    public void setRecommendationIndex(Integer recommendationIndex) {
        this.recommendationIndex = recommendationIndex;
    }

    public Integer getSales() {
        return sales;
    }

    public void setSales(Integer sales) {
        this.sales = sales;
    }

    public String getPackageDescription() {
        return packageDescription;
    }

    public void setPackageDescription(String packageDescription) {
        this.packageDescription = packageDescription;
    }

    public Integer getFoodCategoryId() {
        return foodCategoryId;
    }

    public void setFoodCategoryId(Integer foodCategoryId) {
        this.foodCategoryId = foodCategoryId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public List<WeddingWeddingSon> getWeddingSons() {
        return weddingSons;
    }

    public void setWeddingSons(List<WeddingWeddingSon> weddingSons) {
        this.weddingSons = weddingSons;
    }
}
