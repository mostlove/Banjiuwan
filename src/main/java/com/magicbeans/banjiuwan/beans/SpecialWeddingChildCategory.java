package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 婚庆和子分类 中间表
 * Created by Eric Xie on 2017/2/23 0023.
 */
public class SpecialWeddingChildCategory implements Serializable {

    private Integer id;

    private Integer weddingId;

    private Integer childCategoryId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getWeddingId() {
        return weddingId;
    }

    public void setWeddingId(Integer weddingId) {
        this.weddingId = weddingId;
    }

    public Integer getChildCategoryId() {
        return childCategoryId;
    }

    public void setChildCategoryId(Integer childCategoryId) {
        this.childCategoryId = childCategoryId;
    }
}
