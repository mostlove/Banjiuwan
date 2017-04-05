package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.ServiceConfig;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/3 0003.
 */
public interface IServiceConfigMapper {

    Integer addServiceConfig(@Param("config") ServiceConfig config);

    Integer delServiceConfig(@Param("id") Integer id);

    Integer updateServiceConfig(@Param("config") ServiceConfig config);

    List<ServiceConfig> queryAllServiceConfig();


    ServiceConfig info(@Param("id") Integer id);

}
