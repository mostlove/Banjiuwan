package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 服务员
 * Created by Eric Xie on 2017/3/17 0017.
 */
public class Waiter implements Serializable {

    private Integer id;

    private String name;

    private Integer gender;

    private Integer isValid;

    private Date createTime;

    private List<WaiterTimeConfig> waiterTimeConfigs;


    public List<WaiterTimeConfig> getWaiterTimeConfigs() {
        return waiterTimeConfigs;
    }

    public void setWaiterTimeConfigs(List<WaiterTimeConfig> waiterTimeConfigs) {
        this.waiterTimeConfigs = waiterTimeConfigs;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public Integer getIsValid() {
        return isValid;
    }

    public void setIsValid(Integer isValid) {
        this.isValid = isValid;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
