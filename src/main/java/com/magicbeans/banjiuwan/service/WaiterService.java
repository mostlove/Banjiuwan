package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.Waiter;
import com.magicbeans.banjiuwan.beans.WaiterTimeConfig;
import com.magicbeans.banjiuwan.mapper.IWaiterMapper;
import com.magicbeans.banjiuwan.mapper.IWaiterTimeConfigMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/17 0017.
 */
@Service
public class WaiterService {

    @Resource
    private IWaiterMapper waiterMapper;
    @Resource
    private IWaiterTimeConfigMapper waiterTimeConfigMapper;


    @Transactional
    public void batchAddWaiterConfig(List<WaiterTimeConfig> waiterTimeConfigs,Integer waiterId){
        waiterTimeConfigMapper.delWaiterTimeByWaiter(waiterId);
        waiterTimeConfigMapper.batchAddWaiterTimeConfig(waiterTimeConfigs);
    }

    public void delWaiterTimeByWaiter(Integer waiterId){
        waiterTimeConfigMapper.delWaiterTimeByWaiter(waiterId);
    }


    public void addWaiter(Waiter waiter){
        waiterMapper.addWaiter(waiter);
    }



    public void updateWaiter(Waiter waiter){
        waiterMapper.updateWaiter(waiter);
    }


    public Page<Waiter> queryWaiter(String name,Integer pageNO,Integer pageSize){
        List<Waiter> waiters = waiterMapper.queryWaiter(name,(pageNO - 1) * pageSize, pageSize);
        Integer count = waiterMapper.countWaiter(name);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<Waiter>(waiters,count,totalPage);
    }

    /**
     *  统计 当前时刻 还有多少 闲置的服务员
     * @param timeStr
     */
    public Integer  queryWaiterByTimeConfig(String timeStr){
        List<Waiter> waiters = waiterTimeConfigMapper.queryByTimeConfig(timeStr);
        return waiters == null ? 0 : waiters.size();

    }

}
