package com.magicbeans.banjiuwan.beans;

import java.util.Date;

/**
 * 呼叫我的经理
 * Created by Eric Xie on 2017/2/28 0028.
 */

public class CallMyAM {

    /**主键*/
    private Integer id;

    /**用户ID*/
    private Integer userId;

    /**是否处理 0未处理 1：已经处理*/
    private Integer isHandle;

    /**召唤时间*/
    private Date createTime;

    private String phoneNumber;

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getIsHandle() {
        return isHandle;
    }

    public void setIsHandle(Integer isHandle) {
        this.isHandle = isHandle;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
