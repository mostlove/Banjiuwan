package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.CountHome;
import com.magicbeans.banjiuwan.beans.Order;
import com.magicbeans.banjiuwan.beans.OrderSales;
import com.magicbeans.banjiuwan.beans.Page;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/2 0002.
 */
public interface IOrderMapper {


    /**
     * 新增订单
     * @param order
     * @return
     */
    Integer addOrder(@Param("order") Order order);

    /**
     * 更新不为空的字段
     * @param order
     * @return
     */
    Integer updateOrder(@Param("order") Order order);

    /**
     *  多条件 分页查询订单
     * @param userId
     * @param status
     * @param limit
     * @param limitSize
     * @return
     */
    List<Order> queryOrderByItem(@Param("userId") Integer userId, @Param("status") Integer status,
                                 @Param("limit") Integer limit,@Param("limitSize") Integer limitSize);


    /**
     *  根据厨师ID 查询订单
     * @param cookId
     * @param status
     * @param limit
     * @param limitSize
     * @return
     */
    List<Order> queryOrderByCook(@Param("cookId") Integer cookId,@Param("status") Integer status,
                                 @Param("limit") Integer limit,@Param("limitSize") Integer limitSize);


    /***
     *  根据服务时间 查询 当前时间的所有订单集合
     * @param serviceDate
     * @return
     */
    List<Order> queryOrdersByServiceDate(@Param("serviceDate") Date serviceDate);

    /**
     *  根据 服务时间 统计当前 服务时间服务员的数量
     * @param serviceDate
     * @return
     */
    Integer countWaiterByServiceDate(@Param("serviceDate") Date serviceDate);

    /**
     *  多条件 分页查询订单
     * @param status
     * @param limit
     * @param limitSize
     * @return
     */
    List<Order> queryOrderByItemForWeb(@Param("status") Integer[] status,
                                       @Param("orderNumber") String orderNumber,
                                       @Param("userPhone")String userPhone,
                                       @Param("payMethod")Integer[] payMethods,
                                       @Param("type")Integer type,
                                       @Param("startTime")Date startTime,
                                       @Param("endTime")Date endTime,
                                       @Param("limit") Integer limit,
                                       @Param("limitSize") Integer limitSize);
    /**
     *  多条件 分页查询订单
     * @param status
     * @return
     */
    Integer countOrderByItemForWeb(@Param("status") Integer[] status,
                                   @Param("orderNumber") String orderNumber,
                                   @Param("userPhone")String userPhone,
                                   @Param("payMethod")Integer[] payMethods,
                                   @Param("type")Integer type,
                                   @Param("startTime")Date startTime,
                                   @Param("endTime")Date endTime);

    /**
     *  通过ID 查询 订单所有字段
     * @param id
     * @return
     */
    Order queryOrderById(@Param("id") Integer id);


    /**
     *  通过ID 查询订单，包括 用户信息、地址、厨师
     * @param id
     * @return
     */
    Order queryOrderIncludeOtherInfo(@Param("id") Integer id);


    /**
     * 订单回收站处理
     * @param id
     * @param isEnable
     */
    void updateIsEnable(@Param("id") Integer id,@Param("isEnable")Boolean isEnable);


    /**
     *  统计查询 客户经理下的订单
     * @param adminUserId
     * @param adminUserName
     * @param limit
     * @param limitSize
     * @return
     */
    List<OrderSales> statisticsOrderByManager(@Param("adminUserId") Integer adminUserId,@Param("adminUserName") String adminUserName,
                                              @Param("limit") Integer limit,@Param("limitSize") Integer limitSize,
                                              @Param("startTime") Date startTime,@Param("endTime") Date endTime);

    Integer countOrderByManager(@Param("adminUserId") Integer adminUserId,@Param("adminUserName") String adminUserName,
                                @Param("startTime") Date startTime,@Param("endTime") Date endTime);


    /**
     * 填写备注 （财务确认收款）
     * @param id
     * @param reMarketAdmin
     * @param type 1：确认收款并填写备注  2：填写备注
     */
    void saveReMarket(@Param("id") Integer id,@Param("reMarketAdmin")String reMarketAdmin ,@Param("type")Integer type);


    Order queryOrderByBatchNO(@Param("batchNO") String batchNO);



    CountHome countHome();

}
