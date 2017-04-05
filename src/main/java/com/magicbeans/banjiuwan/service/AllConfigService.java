package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.AllConfig;
import com.magicbeans.banjiuwan.mapper.IAllConfigMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by Eric Xie on 2017/3/3 0003.
 */

@Service
public class AllConfigService {


    @Resource
    public IAllConfigMapper allConfigMapper;


    public AllConfig getAllConfig(){
        return allConfigMapper.queryAllConfig();
    }

    public void updateConfig(AllConfig config){
        allConfigMapper.updateConfig(config);
    }

}
