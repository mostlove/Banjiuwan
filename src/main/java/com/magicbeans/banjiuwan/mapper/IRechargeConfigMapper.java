package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.RechargeConfig;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/9 0009.
 */
public interface IRechargeConfigMapper {


    /**
     * 新增配置
     * @param rechargeConfig
     * @return
     */
    Integer addRechargeConfig(@Param("rechargeConfig") RechargeConfig rechargeConfig);

    /**
     *  更新配置
     * @param rechargeConfig
     * @return
     */
    Integer updateRechargeConfig(@Param("rechargeConfig") RechargeConfig rechargeConfig);


    /**
     *  删除配置
     * @param id
     * @return
     */
    Integer delRechargeConfig(@Param("id") Integer id);

    /**
     *  根据充值金额 查询
     * @param balance
     * @return
     */
    RechargeConfig queryRechargeConfigByBalance(@Param("balance") Integer balance);

    /**
     *  查询所有的充值 配置
     * @return
     */
    List<RechargeConfig> queryRechargeConfigAll();

    RechargeConfig queryRechargeConfigById(@Param("id") Integer id);

}
