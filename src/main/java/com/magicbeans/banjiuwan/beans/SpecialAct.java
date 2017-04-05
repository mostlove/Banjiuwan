package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * 特色服务 伴餐演奏
 * Created by Eric Xie on 2017/2/15 0015.
 */
public class SpecialAct implements Serializable {

    /**主键ID*/
    private Integer id;

    /**第一张 竖屏banner*/
    private String topBanner;

    /**banners*/
    private String banners;

    /**名称*/
    private String name;

    /**单价*/
    private Double price;

    /**计量词*/
    private String units;

    /**推荐指数*/
    private Integer recommendationIndex;

    /**备注*/
    private String remarks;

    /**擅长节目*/
    private String programmes;

    /**类型ID*/
    private Integer foodCategoryId;

    /**销量*/
    private Integer sales;

    /**创建时间*/
    private Date createTime;

    /** 添加到购物车的数量 */
    private Integer countNumber;


    public Integer getSales() {
        return sales;
    }

    public void setSales(Integer sales) {
        this.sales = sales;
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

    public Integer getRecommendationIndex() {
        return recommendationIndex;
    }

    public void setRecommendationIndex(Integer recommendationIndex) {
        this.recommendationIndex = recommendationIndex;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getProgrammes() {
        return programmes;
    }

    public void setProgrammes(String programmes) {
        this.programmes = programmes;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getFoodCategoryId() {
        return foodCategoryId;
    }

    public void setFoodCategoryId(Integer foodCategoryId) {
        this.foodCategoryId = foodCategoryId;
    }
}
