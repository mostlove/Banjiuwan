package com.magicbeans.banjiuwan.beans;


import com.sun.org.apache.xpath.internal.operations.Bool;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 *
 *  菜品
 * 凉菜、热菜、海河鲜、素菜、燕鲍翅、小吃、汤、酒水 实体
 * Created by Eric Xie on 2017/2/14 0014.
 */

public class SingleFood implements Serializable {

    /**主键*/
    private Integer id;

    /**banners*/
    private String banners;

    /**封面图*/
    private String coverImg;

    /**菜品名称*/
    private String foodName;

    /**单价*/
    private Double price;

    /**促销单价*/
    private Double promotionPrice;

    /**推荐指数 最高5 */
    private Integer recommendationIndex;

    /**销量*/
    private Integer sales;

    /**主料*/
    private String marinade;

    /**辅料*/
    private String accessories;

    /**简介*/
    private String introduction;

    /**分类ID 热菜|凉菜 ...*/
    private Integer foodCategoryId;

    /**分类名称*/
    private String foodCategoryName;

    /**计量单位*/
    private String units;

    /**添加时间*/
    private Date createTime;

    /** 添加到购物车的数量 */
    private Integer countNumber;

    /**每一道菜品 的数量 用于坝坝宴*/
    private Integer number;

    /**换一换 的菜品列表*/
    private List<SingleFood> secondFoods;

    /** 是否促销 false否  true是 */
    private Boolean isPromotion;

    /** 是否推荐 false否  true是 */
    private Boolean isRecommendation;

    /**设为促销的时间*/
    private Date promotionTime;

    /**设为推荐的时间*/
    private Date recommendationTime;


    public String getFoodCategoryName() {
        return foodCategoryName;
    }

    public void setFoodCategoryName(String foodCategoryName) {
        this.foodCategoryName = foodCategoryName;
    }

    public List<SingleFood> getSecondFoods() {
        return secondFoods;
    }

    public void setSecondFoods(List<SingleFood> secondFoods) {
        this.secondFoods = secondFoods;
    }

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

    public String getBanners() {
        return banners;
    }

    public void setBanners(String banners) {
        this.banners = banners;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
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

    public String getMarinade() {
        return marinade;
    }

    public void setMarinade(String marinade) {
        this.marinade = marinade;
    }

    public String getAccessories() {
        return accessories;
    }

    public void setAccessories(String accessories) {
        this.accessories = accessories;
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

    public String getUnits() {
        return units;
    }

    public void setUnits(String units) {
        this.units = units;
    }

    public String getCoverImg() {
        return coverImg;
    }

    public void setCoverImg(String coverImg) {
        this.coverImg = coverImg;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }


    public Boolean getPromotion() {
        return isPromotion;
    }

    public void setPromotion(Boolean promotion) {
        isPromotion = promotion;
    }

    public Boolean getRecommendation() {
        return isRecommendation;
    }

    public void setRecommendation(Boolean recommendation) {
        isRecommendation = recommendation;
    }

    public Date getPromotionTime() {
        return promotionTime;
    }

    public void setPromotionTime(Date promotionTime) {
        this.promotionTime = promotionTime;
    }

    public Date getRecommendationTime() {
        return recommendationTime;
    }

    public void setRecommendationTime(Date recommendationTime) {
        this.recommendationTime = recommendationTime;
    }
}
