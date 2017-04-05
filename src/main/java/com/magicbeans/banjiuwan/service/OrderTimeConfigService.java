package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.OrderTimeConfig;
import com.magicbeans.banjiuwan.mapper.IOrderTimeConfigMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 时间配置
 * Created by Eric Xie on 2017/3/2 0002.
 */
@Service
public class OrderTimeConfigService {

    @Resource
    private IOrderTimeConfigMapper orderTimeConfigMapper;


    public List<OrderTimeConfig> queryAllTimeConfig(){
        return orderTimeConfigMapper.queryAllTimeConfig();
    }


    public void updateTimeConfig(OrderTimeConfig orderTimeConfig){
        orderTimeConfigMapper.updateOrderTimeConfig(orderTimeConfig);
    }

    public OrderTimeConfig info(Integer id){
        return orderTimeConfigMapper.info(id);
    }
}
