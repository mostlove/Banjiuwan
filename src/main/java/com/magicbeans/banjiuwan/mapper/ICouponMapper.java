package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.Coupon;
import com.magicbeans.banjiuwan.beans.CouponUseDetail;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *
 *  券 管理 持久层
 * Created by Eric Xie on 2017/2/13 0013.
 */
public interface ICouponMapper {


    Integer addCoupon(@Param("coupon") Coupon coupon);

    Integer updateCoupon(@Param("coupon") Coupon coupon);

    List<Coupon> queryByType(@Param("type") Integer type);

    /**
     * 分页获取
     * @param type
     * @param limit
     * @param limitSize
     * @return
     */
    List<Coupon> queryAllCoupon(@Param("type") Integer type,@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);


    Integer countAllCoupon(@Param("type") Integer type);


    Integer delCoupon(@Param("id") Integer id);


    List<CouponUseDetail> queryCouponUseDetail(@Param("phone") String phone,@Param("type") Integer type,
                                               @Param("isValid")Integer isValid,@Param("startTime")Integer startTime,@Param("endTime")Integer endTime,
                                               @Param("limit") Integer limit,@Param("limitSize") Integer limitSize);


    Integer countCouponUseDetail(@Param("phone") String phone,@Param("type") Integer type,
                                 @Param("isValid")Integer isValid,@Param("startTime")Integer startTime,@Param("endTime")Integer endTime);


    Coupon info (@Param("id") Integer id);
}
