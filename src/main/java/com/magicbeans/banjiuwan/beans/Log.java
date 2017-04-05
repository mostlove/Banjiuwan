package com.magicbeans.banjiuwan.beans;

import java.util.Date;

/**
 * 操作日志
 * @author lzh
 * @create 2017/3/21 14:36
 */
public class Log {

    private Long id;

    /** 日志操作类型
     0 插入数据操作
     1 更新数据操作
     2 查询数据操作
     3 删除数据操作 */
    private Integer operateType;

    /** 被操作的类型 */
    private Integer toOperateType;

    /** 被操作的类型 Id */
    private Integer toOperateId;

    /** 操作人id */
    private Integer adminUserId;

    /** 操作描述 */
    private String describe;

    /** ip地址 */
    private String ip;

    /** 记录时间 */
    private Date createTime;

    /** 操作人姓名 */
    private String userName;
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getOperateType() {
        return operateType;
    }

    public void setOperateType(Integer operateType) {
        this.operateType = operateType;
    }

    public Integer getToOperateType() {
        return toOperateType;
    }

    public void setToOperateType(Integer toOperateType) {
        this.toOperateType = toOperateType;
    }

    public Integer getAdminUserId() {
        return adminUserId;
    }

    public void setAdminUserId(Integer adminUserId) {
        this.adminUserId = adminUserId;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Integer getToOperateId() {
        return toOperateId;
    }

    public void setToOperateId(Integer toOperateId) {
        this.toOperateId = toOperateId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
