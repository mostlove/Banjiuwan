package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.TransportationCostConfig;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/2 0002.
 */
public interface ITransportationCostConfigMapper {


    Integer addTransportationgCostConfig(@Param("config") TransportationCostConfig config);


    Integer updateTransportationgCostConfig(@Param("config") TransportationCostConfig config);

    List<TransportationCostConfig> queryConfig(@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    Integer countConfig();

    Integer delTransportationgCostConfig(@Param("id") Integer id);


    TransportationCostConfig queryConfigByDistance(@Param("distance") Integer distance);

    TransportationCostConfig info(@Param("id") Integer id);
}
