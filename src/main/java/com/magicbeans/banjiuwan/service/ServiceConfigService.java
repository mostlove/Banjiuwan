package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.ServiceConfig;
import com.magicbeans.banjiuwan.mapper.IServiceConfigMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/3 0003.
 */
@Service
public class ServiceConfigService {


    @Resource
    private IServiceConfigMapper serviceConfigMapper;

    /**
     *  新增服务时间配置
     * @param serviceConfig
     */
    public void addServiceConfig(ServiceConfig serviceConfig){
        serviceConfigMapper.addServiceConfig(serviceConfig);
    }

    /**
     *  更新配置
     * @param serviceConfig
     */
    public void updateServiceConfig(ServiceConfig serviceConfig){
        serviceConfigMapper.updateServiceConfig(serviceConfig);
    }

    /**
     *  查询所有配置
     * @return
     */
    public List<ServiceConfig> queryServiceConfig(){
        return serviceConfigMapper.queryAllServiceConfig();
    }

    /**
     *  删除某项配置
     * @param id
     */
    public void delServiceConfig(Integer id){
        serviceConfigMapper.delServiceConfig(id);
    }


    public ServiceConfig info(Integer id){
        return serviceConfigMapper.info(id);
    }
}
