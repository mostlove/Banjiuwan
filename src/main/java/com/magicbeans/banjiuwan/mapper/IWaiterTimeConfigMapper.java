package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.Cook;
import com.magicbeans.banjiuwan.beans.Waiter;
import com.magicbeans.banjiuwan.beans.WaiterTimeConfig;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 服务员排班表   持久层
 * Created by Eric Xie on 2017/3/6 0006.
 */
public interface IWaiterTimeConfigMapper {


    /**
     *  新增服务员排班
     * @return
     */
    Integer addWaiterTimeConfig(@Param("waiterTime") WaiterTimeConfig waiterTimeConfig);

    /**
     *  批量新增 服务员排班
     * @return
     */
    Integer batchAddWaiterTimeConfig(@Param("waiterTimeConfigs") List<WaiterTimeConfig> waiterTimeConfigs);


    Integer delWaiterTimeByWaiter(@Param("waiterId") Integer waiterId);


    /**
     *  根据 时刻  查询 当前时刻 所有排班了的 服务员
     * @param timeConfig "12:00"
     * @return 厨师集合
     */
    List<Waiter> queryByTimeConfig(@Param("timeConfig") String timeConfig);


    List<WaiterTimeConfig> queryByWaiterId(@Param("waiterId") Integer waiterId);




}
