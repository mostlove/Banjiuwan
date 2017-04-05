package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.VegetablesHouse;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/10 0010.
 */
public interface IVegetablesHouseMapper {


    Integer addVegetablesHouse(@Param("vegetablesHouse") VegetablesHouse vegetablesHouse);


    Integer updateVegetablesHouse(@Param("vegetablesHouse") VegetablesHouse vegetablesHouse);


    Integer delVegetablesHouse(@Param("id") Integer id);


    List<VegetablesHouse> queryVagetablesByItem(@Param("vegetablesName") String vegetablesName,@Param("limit") Integer limit,
                                                @Param("limitSize") Integer limitSize);

    Integer countVagetablesByItem(@Param("vegetablesName") String vegetablesName);


}
