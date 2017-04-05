package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;
import java.util.List;

/**
 *
 * 角色实体
 * Created by Eric Xie on 2017/2/13 0013.
 */

public class Role implements Serializable {


    /**主键ID*/
    private Integer id;

    /**角色名称*/
    private String roleName;

    /**菜单集合*/
    private List<Menu> menus;

    public List<Menu> getMenus() {
        return menus;
    }

    public void setMenus(List<Menu> menus) {
        this.menus = menus;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
