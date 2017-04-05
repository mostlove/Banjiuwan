package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.OrderTimeConfig;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/2 0002.
 */
public interface IOrderTimeConfigMapper {


    Integer updateOrderTimeConfig(@Param("orderTimeConfig") OrderTimeConfig orderTimeConfig);


    List<OrderTimeConfig> queryAllTimeConfig();

    /** 获取详情 */
    OrderTimeConfig info(@Param("id")Integer id);
}
