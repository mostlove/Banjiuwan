package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * Created by Eric Xie on 2017/3/17 0017.
 */
public class WaiterTimeConfig implements Serializable{


    private Integer id;

    private Integer waiterId;

    private Integer timeConfigId;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getWaiterId() {
        return waiterId;
    }

    public void setWaiterId(Integer waiterId) {
        this.waiterId = waiterId;
    }

    public Integer getTimeConfigId() {
        return timeConfigId;
    }

    public void setTimeConfigId(Integer timeConfigId) {
        this.timeConfigId = timeConfigId;
    }
}
