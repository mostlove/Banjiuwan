package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * 用户 地址管理实体
 * Created by Eric Xie on 2017/2/14 0014.
 */
public class UserAddress implements Serializable {

    /**主键ID*/
    private Integer id;

    /**联系人*/
    private String contact;

    /**性别  0：先生 1：女士*/
    private Integer gender;

    /**是否默认地址 0：否  1：是*/
    private Integer isDefault;

    /**联系人电话*/
    private String contactPhone;

    /**联系地址*/
    private String address;

    /**详细地址*/
    private String detailAddress;

    /**用户ID*/
    private Integer userId;

    /**地址是否有效 0:无效 1:有效 缺省值: 1*/
    private Integer isValid;

    /**经纬度 经度,纬度*/
    private String lngLat;

    /**创建时间*/
    private Date createTime;


    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public Integer getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(Integer isDefault) {
        this.isDefault = isDefault;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getLngLat() {
        return lngLat;
    }

    public void setLngLat(String lngLat) {
        this.lngLat = lngLat;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDetailAddress() {
        return detailAddress;
    }

    public void setDetailAddress(String detailAddress) {
        this.detailAddress = detailAddress;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getIsValid() {
        return isValid;
    }

    public void setIsValid(Integer isValid) {
        this.isValid = isValid;
    }
}
