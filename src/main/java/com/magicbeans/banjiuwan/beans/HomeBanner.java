package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.Date;

/**
 * 首页Banner
 * Created by Eric Xie on 2017/2/16 0016.
 */
public class HomeBanner implements Serializable {

    /**主键ID*/
    private Integer id;

    /**banner地址*/
    private String banner;

    /**title*/
    private String title;

    /**文本内容*/
    private String content;

    /**创建时间*/
    private Date createTime;

    /**类型 0:首页banner 1:未登录时 弹出的banner 2:发现*/
    private Integer type;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBanner() {
        return banner;
    }

    public void setBanner(String banner) {
        this.banner = banner;
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}
