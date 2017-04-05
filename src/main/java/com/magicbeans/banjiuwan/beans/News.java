package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;

/**
 * 资讯实体
 * Created by Eric Xie on 2017/2/27 0027.
 */
public class News implements Serializable {

    /**主键ID*/
    private Integer id;

    /**ICON*/
    private String icon;

    /**image*/
    private String img;

    /**推荐指数*/
    private Integer recommendationIndex;

    /**标题*/
    private String title;

    /**内容*/
    private String content;

    /**创建时间*/
    private Date createTime;

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Integer getRecommendationIndex() {
        return recommendationIndex;
    }

    public void setRecommendationIndex(Integer recommendationIndex) {
        this.recommendationIndex = recommendationIndex;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
