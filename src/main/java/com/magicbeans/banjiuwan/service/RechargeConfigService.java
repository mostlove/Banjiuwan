package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.RechargeConfig;
import com.magicbeans.banjiuwan.mapper.IRechargeConfigMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/9 0009.
 */
@Service
public class RechargeConfigService {

    @Resource
    private IRechargeConfigMapper rechargeConfigMapper;

    public void addRechargeConfig(RechargeConfig rechargeConfig){
        rechargeConfigMapper.addRechargeConfig(rechargeConfig);
    }


    public void updateRechargeConfig(RechargeConfig rechargeConfig){
        rechargeConfigMapper.updateRechargeConfig(rechargeConfig);
    }

    public void delRechargeConfig(Integer id){
        rechargeConfigMapper.delRechargeConfig(id);
    }

    public RechargeConfig queryRechargeConfigByBalance(Integer balance){
        return rechargeConfigMapper.queryRechargeConfigByBalance(balance);
    }

    public List<RechargeConfig> queryAllRechargeConfig(){
        return rechargeConfigMapper.queryRechargeConfigAll();
    }


    public RechargeConfig queryRechargeConfigById(Integer id){
        return rechargeConfigMapper.queryRechargeConfigById(id);
    }




}
