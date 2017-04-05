package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.MapList;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/2 0002.
 */
public interface IMapListMapper {


    Integer addMapList(@Param("mapList") MapList mapList);


    MapList queryMapListById(@Param("id") Integer id);

    Integer updateMapList(@Param("mapList") MapList mapList);

    List<MapList> queryMapListPage(@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);


    Integer countMapListPage();

    Integer delMapList(@Param("id") Integer id);

}
