package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 协议实体
 * Created by Eric Xie on 2017/3/24 0024.
 */
public class AgreementText implements Serializable {

    /**1：充值协议  2：用户注册协议*/
    private Integer id;

    private String title;

    private String content;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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
