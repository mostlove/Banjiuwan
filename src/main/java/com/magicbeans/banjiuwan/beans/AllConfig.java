package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 全局配置
 * Created by Eric Xie on 2017/3/3 0003.
 */
public class AllConfig implements Serializable {

    /**主键ID*/
    private Integer id;

    /**多少积分 抵扣 一元*/
    private Integer accumulate;

    /**一元 能 兑换多少积分*/
    private Integer yuan;

    /**分销百分比*/
    private Double distribution;

    /**计算时间 起始点的坐标*/
    private String startPoint;

    /**计算时间 起始点的详细地址*/
    private String currentLocation;

    /**配菜需要的时间 单位 小时*/
    private Double garnishTime;

    public String getStartPoint() {
        return startPoint;
    }

    public void setStartPoint(String startPoint) {
        this.startPoint = startPoint;
    }

    public String getCurrentLocation() {
        return currentLocation;
    }

    public void setCurrentLocation(String currentLocation) {
        this.currentLocation = currentLocation;
    }

    public Double getGarnishTime() {
        return garnishTime;
    }

    public void setGarnishTime(Double garnishTime) {
        this.garnishTime = garnishTime;
    }

    public Double getDistribution() {
        return distribution;
    }

    public void setDistribution(Double distribution) {
        this.distribution = distribution;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getAccumulate() {
        return accumulate;
    }

    public void setAccumulate(Integer accumulate) {
        this.accumulate = accumulate;
    }

    public Integer getYuan() {
        return yuan;
    }

    public void setYuan(Integer yuan) {
        this.yuan = yuan;
    }
}
