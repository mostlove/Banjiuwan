package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;

/**
 *  后台管理人员实体
 * Created by Eric Xie on 2017/2/13 0013.
 */

public class AdminUser implements Serializable {

    /**主键ID*/
    private Integer id;

    /**用户名*/
    private String userName;

    /**电话号码*/
    private String phoneNumber;

    /**密码*/
    private String password;

    /**角色ID*/
    private Integer roleId;

    /**角色*/
    private Role role;

    /**是否有效 0: 无效 1: 有效 缺省值：1*/
    private Integer isValid;

    /**创建时间*/
    private Date createTime;

    /**分销代表码*/
    private String code;

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getIsValid() {
        return isValid;
    }

    public void setIsValid(Integer isValid) {
        this.isValid = isValid;
    }
}
