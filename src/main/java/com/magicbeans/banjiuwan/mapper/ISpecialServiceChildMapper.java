package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.ShopCar;
import com.magicbeans.banjiuwan.beans.SpecialServiceChild;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/13 0013.
 */
public interface ISpecialServiceChildMapper {


    Integer updateSpecialServiceChild(@Param("specialServiceChild") SpecialServiceChild specialServiceChild);


    Integer batchUpdateSpecialServiceChild(@Param("specialServiceChilds") List<SpecialServiceChild> specialServiceChild);


    List<SpecialServiceChild> queryAllSpecialServiceChild(@Param("userId") Integer userId);


    List<ShopCar> queryShopCarByShopCarIds(@Param("ids") List<Integer> ids);

    SpecialServiceChild queryCJ();



}
