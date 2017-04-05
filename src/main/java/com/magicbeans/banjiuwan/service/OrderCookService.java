package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.AdminUser;
import com.magicbeans.banjiuwan.beans.Order;
import com.magicbeans.banjiuwan.beans.OrderCook;
import com.magicbeans.banjiuwan.mapper.IOrderCookMapper;
import com.magicbeans.banjiuwan.mapper.IOrderMapper;
import com.magicbeans.banjiuwan.util.LoginHelper;
import com.magicbeans.banjiuwan.util.OrderConstant;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 订单和厨师 关系
 * Created by Eric Xie on 2017/3/6 0006.
 */
@Service
public class OrderCookService {

    @Resource
    private IOrderCookMapper orderCookMapper;
    @Resource
    private IOrderMapper orderMapper;

    /**
     *  分配厨师 给订单
     */
    public void batchAddOrderCook(Integer mainCook, String cooks, Integer orderId, AdminUser adminUser) throws Exception{
        // 组装数据
        List<OrderCook> orderCooks = new ArrayList<OrderCook>();
        if(null != cooks && !"null".equals(cooks)){
            JSONArray jsonArray = JSONArray.fromObject(cooks);
            for (Object obj : jsonArray){
                OrderCook orderCook = new OrderCook();
                orderCook.setCookId(Integer.parseInt(obj.toString()));
                orderCook.setOrderId(orderId);
                orderCook.setIsMain(0);
                orderCooks.add(orderCook);
            }
        }
        OrderCook orderCook = new OrderCook();
        orderCook.setOrderId(orderId);
        orderCook.setCookId(mainCook);
        orderCook.setIsMain(1);
        orderCooks.add(orderCook);


        // 更新订单状态
        Order temp = new Order();
        temp.setId(orderId);
        temp.setStatus(OrderConstant.PENDING_ORDERS);
        temp.setAdminUserId(adminUser.getId());
        orderMapper.updateOrder(temp);
        // 新增厨师
        if(orderCooks.size() > 0){
            // 删除之前锁定的厨师
            orderCookMapper.delByOrder(orderId);
            orderCookMapper.batchAddOrderCook(orderCooks);
        }
    }

}
