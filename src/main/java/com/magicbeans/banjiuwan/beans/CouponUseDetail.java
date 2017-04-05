package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 优惠券使用 情况
 * Created by Eric Xie on 2017/3/16 0016.
 */
public class CouponUseDetail implements Serializable {

    private Double faceValue;

    private Integer type;

    private Double needSpend;

    private Long startTime;

    private Long endTime;

    private Integer days;

    private Integer isValid;

    private String text;

    private String userName;

    private String phoneNumber;

    public Double getFaceValue() {
        return faceValue;
    }

    public void setFaceValue(Double faceValue) {
        this.faceValue = faceValue;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Double getNeedSpend() {
        return needSpend;
    }

    public void setNeedSpend(Double needSpend) {
        this.needSpend = needSpend;
    }

    public Long getStartTime() {
        return startTime;
    }

    public void setStartTime(Long startTime) {
        this.startTime = startTime;
    }

    public Long getEndTime() {
        return endTime;
    }

    public void setEndTime(Long endTime) {
        this.endTime = endTime;
    }

    public Integer getDays() {
        return days;
    }

    public void setDays(Integer days) {
        this.days = days;
    }

    public Integer getIsValid() {
        return isValid;
    }

    public void setIsValid(Integer isValid) {
        this.isValid = isValid;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}
