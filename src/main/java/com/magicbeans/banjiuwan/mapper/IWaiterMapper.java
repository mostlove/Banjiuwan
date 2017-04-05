package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.Waiter;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/17 0017.
 */
public interface IWaiterMapper {


    Integer addWaiter(@Param("waiter") Waiter waiter);

    Integer updateWaiter(@Param("waiter") Waiter waiter);

    List<Waiter> queryWaiter(@Param("name") String name,@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    Integer countWaiter(@Param("name") String name);

}
