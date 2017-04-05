package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 *
 * 婚庆 子分类实体
 * Created by Eric Xie on 2017/2/23 0023.
 */
public class WeddingChildCategory implements Serializable {

    /**ID*/
    private Integer id;

    /**子分类名称*/
    private String name;

    /**封面图*/
    private String img;

    /**创建时间*/
    private Date createTime;

    /**大分类ID*/
    private Integer weddingCategoryId;

    /**大分类名称*/
    private String weddingCategoryName;

    /**子类中 包含的 子项数据集合*/
    private List<WeddingSon> weddingSons;


    public List<WeddingSon> getWeddingSons() {
        return weddingSons;
    }

    public void setWeddingSons(List<WeddingSon> weddingSons) {
        this.weddingSons = weddingSons;
    }

    public String getWeddingCategoryName() {
        return weddingCategoryName;
    }

    public void setWeddingCategoryName(String weddingCategoryName) {
        this.weddingCategoryName = weddingCategoryName;
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

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getWeddingCategoryId() {
        return weddingCategoryId;
    }

    public void setWeddingCategoryId(Integer weddingCategoryId) {
        this.weddingCategoryId = weddingCategoryId;
    }
}
