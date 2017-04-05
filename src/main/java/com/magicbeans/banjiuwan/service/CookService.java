package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.Cook;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.mapper.ICookMapper;
import com.magicbeans.banjiuwan.mapper.IOrderCookMapper;
import com.magicbeans.banjiuwan.mapper.IOrderMapper;
import com.magicbeans.banjiuwan.util.DateUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 *
 * 厨师 业务层
 * Created by Eric Xie on 2017/2/13 0013.
 */

@Service
public class CookService {

    @Resource
    private ICookMapper cookMapper;
    @Resource
    private IOrderCookMapper orderCookMapper;
    @Resource
    private IOrderMapper orderMapper;


    public Cook queryCookById(Integer id){
        return cookMapper.queryCookById(id);
    }


    public void updatePwdByPhone(String phone,String pwd){
        cookMapper.updatePwdByPhone(phone,pwd);
    }

    public List<Cook> queryCookDeviceToken(List<Integer> ids){
        return cookMapper.queryCookDeviceToken(ids);
    }

    public void add(Cook cook){
        cookMapper.addCook(cook);
    }

    public void update(Cook cook){
        cookMapper.updateCook(cook);
    }

    /**
     * 根据 手机号 密码 查询用户
     * @param phoneNumber
     * @param password 可为空
     * @return
     */
    public Cook queryByPhone(String phoneNumber,String password){
        return cookMapper.queryByPhoneAndPwd(phoneNumber,password);
    }


    /**
     *  通过 订单ID集合 查询 厨师集合
     * @param orderIds
     * @return
     */
    public List<Cook> queryCookByOrders(List<Integer> orderIds){
        return orderCookMapper.queryOrderCookByOrder(orderIds);
    }


    /**
     *  分页动态查询
     * @param userName
     * @param phoneNumber
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<Cook> queryByItem(String userName,String phoneNumber,Integer pageNO,Integer pageSize){
        List<Cook> dataList = cookMapper.queryCookByItem(userName,phoneNumber, (pageNO - 1) * pageSize, pageSize);
        Integer count = cookMapper.countCookByItem(userName,phoneNumber);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<Cook>(dataList,count,totalPage);
    }

    /**
     *  通过服务时间 获取 当前时间 空闲的厨师集合
     * @param serviceDate
     * @return
     */
    public List<Cook> queryCookByServiceDate(Date serviceDate){
        return cookMapper.queryCookByServiceDate(DateUtil.DateTime(serviceDate,"HH:mm"),serviceDate);
    }

    /**
     * 获取厨师详情
     * @param id
     * @return
     */
    public Cook getCookByIdForWeb(Integer id){
        return cookMapper.getCookByIdForWeb(id);
    }




}
