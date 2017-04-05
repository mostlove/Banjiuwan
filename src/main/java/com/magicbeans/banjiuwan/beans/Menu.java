package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 *
 * 菜单权限实体
 *
 * Created by Eric Xie on 2017/2/13 0013.
 */

public class Menu implements Serializable {

    /**主键ID*/
    private Integer id;

    /**菜单名称*/
    private String menuName;

    /**请求URL*/
    private String url;

    /**备注*/
    private String remaker;

    /**排序号  升序排列*/
    private Integer sortNumber;


    public Integer getSortNumber() {
        return sortNumber;
    }

    public void setSortNumber(Integer sortNumber) {
        this.sortNumber = sortNumber;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getRemaker() {
        return remaker;
    }

    public void setRemaker(String remaker) {
        this.remaker = remaker;
    }
}
