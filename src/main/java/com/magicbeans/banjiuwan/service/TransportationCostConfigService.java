package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.TransportationCostConfig;
import com.magicbeans.banjiuwan.mapper.ITransportationCostConfigMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 交通费用配置管理业务层
 * Created by Eric Xie on 2017/3/2 0002.
 */
@Service
public class TransportationCostConfigService {


    @Resource
    private ITransportationCostConfigMapper transportationCostConfigMapper;


    public void addTransportationCostConfig(TransportationCostConfig costConfig) throws Exception{
        if(transportationCostConfigMapper.queryConfigByDistance(costConfig.getDistance()) != null){
            throw new Exception("不能重复添加相同距离的数据");
        }
        transportationCostConfigMapper.addTransportationgCostConfig(costConfig);
    }


    public void updateTransportationCostConfig(TransportationCostConfig costConfig){
        transportationCostConfigMapper.updateTransportationgCostConfig(costConfig);
    }

    public void delTransportationCostConfig(Integer id){
        transportationCostConfigMapper.delTransportationgCostConfig(id);
    }

    public Page<TransportationCostConfig> queryConfigPage(Integer pageNO,Integer pageSize){
        List<TransportationCostConfig> dataList = transportationCostConfigMapper.queryConfig((pageNO - 1) * pageSize,pageSize);
        Integer count  = transportationCostConfigMapper.countConfig();
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<TransportationCostConfig>(dataList,count,totalPage);
    }


    public List<TransportationCostConfig> queryAllConfig(){
        return transportationCostConfigMapper.queryConfig(null,null);
    }


    public TransportationCostConfig info (Integer id) {
        return transportationCostConfigMapper.info(id);
    }

}
