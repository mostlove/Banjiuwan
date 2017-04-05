package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.RechargeRecord;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/9 0009.
 */
public interface IRechargeRecordMapper {


    Integer addRechargeRecord(@Param("rechargeRecord") RechargeRecord rechargeRecord);


    RechargeRecord queryRechargeRecordById(@Param("id") Integer id);


    Integer updateRechargeRecord(@Param("rechargeRecord") RechargeRecord rechargeRecord);


    List<RechargeRecord> queryRechargeRecordForWeb(@Param("userName") String userName, @Param("phoneNumber") String phoneNumber,
                                                   @Param("limit") Integer limit, @Param("limitSize") Integer limitSize,
                                                   @Param("payMethod") Integer payMethod, @Param("status") Integer status,
                                                   @Param("startTime") Date startTime,@Param("endTime") Date endTime);


    Integer countRechargeRecordForWeb(@Param("userName") String userName,@Param("phoneNumber") String phoneNumber,
                                      @Param("payMethod") Integer payMethod, @Param("status") Integer status,
                                      @Param("startTime") Date startTime,@Param("endTime") Date endTime);

    /**
     * 填写备注
     * @param id
     * @param reMarket
     */
    void saveReMarket(@Param("id") Integer id,@Param("reMarket")String reMarket);

}
