package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.AccumulateDetail;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/24 0024.
 */
public interface IAccumulateDetailMapper {


    Integer addAccumulateDetail(@Param("accumulateDetail") AccumulateDetail accumulateDetail);


    List<AccumulateDetail> queryAccumulateDetailByItem(@Param("phoneNumber") String phoneNumber, @Param("startTime") Date startTime,
                                                       @Param("endTime") Date endTime,
                                                       @Param("limit") Integer limit,@Param("limitSize") Integer limitSize);


    Integer countAccumulateDetailByItem(@Param("phoneNumber") String phoneNumber, @Param("startTime") Date startTime,
                                                       @Param("endTime") Date endTime);

}
