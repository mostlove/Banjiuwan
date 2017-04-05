package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.VegetablesPrice;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * 实时菜价
 * Created by Eric Xie on 2017/3/10 0010.
 */
public interface IVegetablesPriceMapper {


    Integer addVegetablesPrice(@Param("vegetablesPrice") VegetablesPrice vegetablesPrice);


    Integer updateVegetablesPrice(@Param("vegetablesPrice") VegetablesPrice vegetablesPrice);


    Integer delVegetablesPrice(@Param("id") Integer id);


    List<VegetablesPrice> queryVegetablesPriceByItem(@Param("vegetablesId") Integer vegetablesId, @Param("time") Date time);



    List<VegetablesPrice> queryVegetablesPriceByItemForWeb(@Param("vegetablesName") String vegetablesName, @Param("time") Date time,
            @Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    Integer countVegetablesPriceByItemForWeb(@Param("vegetablesName") String vegetablesName, @Param("time") Date time);


}
