package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.Cook;
import com.magicbeans.banjiuwan.beans.CookTimeConfig;
import com.magicbeans.banjiuwan.mapper.ICookTimeConfigMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 厨师 的排班表 业务层
 * Created by Eric Xie on 2017/3/6 0006.
 */
@Service
public class CookTimeConfigService {

    @Resource
    private ICookTimeConfigMapper cookTimeConfigMapper;


    /**
     *  根据 时刻表 查询出 当前排班的所有 厨师
     * @param timeStr "10:00"
     * @return 厨师集合
     */
    public List<Cook> queryByTimeConfig(String timeStr){
        return cookTimeConfigMapper.queryByTimeConfig(timeStr);
    }

    /**
     *  新增排班表
     * @param cookTimeConfigs
     */
    @Transactional
    public void batchAddCookConfig(List<CookTimeConfig> cookTimeConfigs,Integer cookId){
        cookTimeConfigMapper.delCookTimeByCook(cookId);
        cookTimeConfigMapper.batchAddCookTimeConfig(cookTimeConfigs);
    }

    public void delCookTimeByCook(Integer cookId){
        cookTimeConfigMapper.delCookTimeByCook(cookId);
    }


}
