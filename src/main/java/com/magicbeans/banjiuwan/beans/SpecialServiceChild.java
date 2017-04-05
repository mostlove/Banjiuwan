package com.magicbeans.banjiuwan.beans;

import java.io.Serializable;

/**
 *  专业服务之  子类
 * Created by Eric Xie on 2017/3/13 0013.
 */
public class SpecialServiceChild implements Serializable {


    private Integer id;

    private String name;

    private Double price;

    private Integer countNumber;

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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getCountNumber() {
        return countNumber;
    }

    public void setCountNumber(Integer countNumber) {
        this.countNumber = countNumber;
    }
}
