package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 * 菜品分类 实体
 * Created by Eric Xie on 2017/2/13 0013.
 */
public class FoodCategory implements Serializable {


    /**主键ID*/
    private Integer id;

    /**分类名称*/
    private String categoryName;

    /**为选中图标*/
    private String icon;

    /**选中图标*/
    private String selectedIcon;

    /**大类型对象使用 是否在圈内  0:否  1:是*/
    private Integer isInside;

    /**排列序号 越大的在前面*/
    private Integer seriaNumber;

    /**大类型对象使用 不在圈内 提示语*/
    private String msg;

    /**是否显示 0:不显示  1:显示*/
    private Integer isShow;

    public Integer getIsShow() {
        return isShow;
    }

    public void setIsShow(Integer isShow) {
        this.isShow = isShow;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Integer getSeriaNumber() {
        return seriaNumber;
    }

    public void setSeriaNumber(Integer seriaNumber) {
        this.seriaNumber = seriaNumber;
    }

    public Integer getIsInside() {
        return isInside;
    }

    public void setIsInside(Integer isInside) {
        this.isInside = isInside;
    }

    public String getSelectedIcon() {
        return selectedIcon;
    }

    public void setSelectedIcon(String selectedIcon) {
        this.selectedIcon = selectedIcon;
    }

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

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        FoodCategory that = (FoodCategory) o;

        return id.equals(that.id);

    }

    @Override
    public int hashCode() {
        return id.hashCode();
    }
}
