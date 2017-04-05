package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 首页字体
 * Created by Eric Xie on 2017/3/1 0001.
 */
public class HomeFont implements Serializable {


    private Integer id;

    private String font;

    public HomeFont() {
        super();
    }

    public HomeFont(Integer id, String font) {
        this.id = id;
        this.font = font;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFont() {
        return font;
    }

    public void setFont(String font) {
        this.font = font;
    }
}
