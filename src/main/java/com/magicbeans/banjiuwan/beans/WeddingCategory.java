package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;

/**
 * 婚庆 子项大分类表
 * Created by Eric Xie on 2017/2/23 0023.
 */
public class WeddingCategory implements Serializable {


    /**主键ID*/
    private Integer id;

    /**分类名称*/
    private String categoryName;

    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
