package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 后台围栏配置
 * Created by Eric Xie on 2017/3/2 0002.
 */
public class MapList implements Serializable {


    /**主键ID*/
    private Integer id;

    /**描点集合*/
    private String mapList;

    /**备注*/
    private String reMarket;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMapList() {
        return mapList;
    }

    public void setMapList(String mapList) {
        this.mapList = mapList;
    }

    public String getReMarket() {
        return reMarket;
    }

    public void setReMarket(String reMarket) {
        this.reMarket = reMarket;
    }
}
