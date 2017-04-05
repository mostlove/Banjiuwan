package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * 厨师实体
 * Created by Eric Xie on 2017/2/13 0013.
 */

public class Cook implements Serializable {

    /**主键ID*/
    private Integer id;

    /**姓名*/
    private String realName;

    /**邮箱*/
    private String email;

    /**个性签名*/
    private String signature;

    /**电话*/
    private String phoneNumber;

    /**密码*/
    private String password;

    /**头像*/
    private String avatar;

    /**年龄*/
    private Integer age;

    /**性别 0:男 1:女  缺省值：0*/
    private Integer gender;

    /**是否有效  0: 无效  1: 有效 缺省值: 1*/
    private Integer isValid;

    /** 设备类型 0:android 1:ios*/
    private Integer deviceType;

    /**设备token*/
    private String deviceToken;

    /**请求令牌*/
    private String token;

    /**创建时间*/
    private Date createTime;

    /**更新时间*/
    private Date updateTime;

    /**是否是主厨0:NO 1:YES*/
    private Integer isMain;

    /**当前厨师的排班表*/
    private List<CookTimeConfig> cookTimeConfigs;

    /**厨师经纬度*/
    private String latLng;

    /** 地图icon */
    private String mapIcon;

    /**是否在线  0:否 1:在*/
    private Integer isOnline;

    public Integer getIsOnline() {
        return isOnline;
    }

    public void setIsOnline(Integer isOnline) {
        this.isOnline = isOnline;
    }

    public String getLatLng() {
        return latLng;
    }

    public void setLatLng(String latLng) {
        this.latLng = latLng;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public List<CookTimeConfig> getCookTimeConfigs() {
        return cookTimeConfigs;
    }

    public void setCookTimeConfigs(List<CookTimeConfig> cookTimeConfigs) {
        this.cookTimeConfigs = cookTimeConfigs;
    }

    public Integer getIsMain() {
        return isMain;
    }

    public void setIsMain(Integer isMain) {
        this.isMain = isMain;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
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

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getDeviceType() {
        return deviceType;
    }

    public void setDeviceType(Integer deviceType) {
        this.deviceType = deviceType;
    }

    public String getDeviceToken() {
        return deviceToken;
    }

    public void setDeviceToken(String deviceToken) {
        this.deviceToken = deviceToken;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getMapIcon() {
        return mapIcon;
    }

    public void setMapIcon(String mapIcon) {
        this.mapIcon = mapIcon;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Cook cook = (Cook) o;

        return id.equals(cook.id);

    }

    @Override
    public int hashCode() {
        return id.hashCode();
    }
}
