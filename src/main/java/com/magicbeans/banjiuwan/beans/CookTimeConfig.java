package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 厨师排班实体
 * Created by Eric Xie on 2017/3/6 0006.
 */
public class CookTimeConfig implements Serializable{


    private Integer id;

    private Integer cookId;

    private Integer timeConfigId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCookId() {
        return cookId;
    }

    public void setCookId(Integer cookId) {
        this.cookId = cookId;
    }

    public Integer getTimeConfigId() {
        return timeConfigId;
    }

    public void setTimeConfigId(Integer timeConfigId) {
        this.timeConfigId = timeConfigId;
    }
}
