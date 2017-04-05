package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.List;

/**
 *
 *  特色服务之 专业服务
 * Created by Eric Xie on 2017/2/15 0015.
 */
public class SpecialService implements Serializable {

    /**主键ID*/
    private Integer id;

    /**banners*/
    private String banners;

    /**单价*/
    private Double price;

    /**计量单位*/
    private String units;

    /**服务理念 255*/
    private String serviceIdea;

    /**服务流程 text*/
    private String serviceFlow;

    /**服务标准 text*/
    private String serviceStandard;

    private List<SpecialServiceChild> specialServiceChilds;

    /**女服务员单价*/
    private Double womanServicePrice;
    /**男服务员单价*/
    private Double tablewarePrice;
    /**餐具单价*/
    private Double manServicePrice;

    /**分类ID*/
    private Integer foodCategoryId;


    public Double getWomanServicePrice() {
        return womanServicePrice;
    }

    public void setWomanServicePrice(Double womanServicePrice) {
        this.womanServicePrice = womanServicePrice;
    }

    public Double getTablewarePrice() {
        return tablewarePrice;
    }

    public void setTablewarePrice(Double tablewarePrice) {
        this.tablewarePrice = tablewarePrice;
    }

    public Double getManServicePrice() {
        return manServicePrice;
    }

    public void setManServicePrice(Double manServicePrice) {
        this.manServicePrice = manServicePrice;
    }

    public List<SpecialServiceChild> getSpecialServiceChilds() {
        return specialServiceChilds;
    }

    public void setSpecialServiceChilds(List<SpecialServiceChild> specialServiceChilds) {
        this.specialServiceChilds = specialServiceChilds;
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

    public String getServiceIdea() {
        return serviceIdea;
    }

    public void setServiceIdea(String serviceIdea) {
        this.serviceIdea = serviceIdea;
    }

    public String getServiceFlow() {
        return serviceFlow;
    }

    public void setServiceFlow(String serviceFlow) {
        this.serviceFlow = serviceFlow;
    }

    public String getServiceStandard() {
        return serviceStandard;
    }

    public void setServiceStandard(String serviceStandard) {
        this.serviceStandard = serviceStandard;
    }

    public Integer getFoodCategoryId() {
        return foodCategoryId;
    }

    public void setFoodCategoryId(Integer foodCategoryId) {
        this.foodCategoryId = foodCategoryId;
    }
}
