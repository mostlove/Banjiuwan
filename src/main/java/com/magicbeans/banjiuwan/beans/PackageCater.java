package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 *
 *  套餐、宴席 实体
 * Created by Eric Xie on 2017/2/15 0015.
 */
public class PackageCater implements Serializable {


    /**主键ID*/
    private Integer id;

    /**第一张 卡片banner*/
    private String topBanner;

    /**banner集合 套餐详细页*/
    private String banners;

    /**单价*/
    private Double price;

    /**促销价*/
    private Double promotionPrice;

    /**套餐名称*/
    private String name;

    /**推荐指数*/
    private Integer recommendationIndex;

    /**销量*/
    private Integer sales;

    /**计量单位*/
    private String units;

    /**至少多少起订*/
    private Integer leastNumber;

    /**简介*/
    private String introduction;

    /**分类ID*/
    private Integer foodCategoryId;

    /**创建时间*/
    private Date createTime;

    /**菜品集合*/
    private List<SingleFood> singleFoodList;

    private String singleFoodIds;

    private String numbers;


    /** 添加到购物车的数量 */
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

    public String getTopBanner() {
        return topBanner;
    }

    public void setTopBanner(String topBanner) {
        this.topBanner = topBanner;
    }

    public String getBanners() {
        return banners;
    }

    public void setBanners(String banners) {
        this.banners = banners;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getPromotionPrice() {
        return promotionPrice;
    }

    public void setPromotionPrice(Double promotionPrice) {
        this.promotionPrice = promotionPrice;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getUnits() {
        return units;
    }

    public void setUnits(String units) {
        this.units = units;
    }

    public Integer getLeastNumber() {
        return leastNumber;
    }

    public void setLeastNumber(Integer leastNumber) {
        this.leastNumber = leastNumber;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
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

    public List<SingleFood> getSingleFoodList() {
        return singleFoodList;
    }

    public void setSingleFoodList(List<SingleFood> singleFoodList) {
        this.singleFoodList = singleFoodList;
    }

    public String getSingleFoodIds() {
        return singleFoodIds;
    }

    public void setSingleFoodIds(String singleFoodIds) {
        this.singleFoodIds = singleFoodIds;
    }

    public String getNumbers() {
        return numbers;
    }

    public void setNumbers(String numbers) {
        this.numbers = numbers;
    }
}
