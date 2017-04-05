package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.Cook;
import com.magicbeans.banjiuwan.beans.OrderCook;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/6 0006.
 */
public interface IOrderCookMapper {


    Integer addOrderCook(@Param("orderCook") OrderCook orderCook);


    Integer batchAddOrderCook(@Param("orderCooks") List<OrderCook> orderCooks);


    Integer batchDelOrderCook(@Param("ids") List<Integer> ids);


    Integer delByOrder(@Param("orderId") Integer orderId);


    /**
     * 通过订单ID集合 查询 厨师
     * @param orderIds
     * @return
     */
    List<Cook> queryOrderCookByOrder(@Param("orderIds") List<Integer> orderIds);


    /**
     *  单个订单查询厨师
     * @param orderId
     * @return
     */
    List<Cook> queryOrderCookBySingleOrder(@Param("orderId") Integer orderId);






}
