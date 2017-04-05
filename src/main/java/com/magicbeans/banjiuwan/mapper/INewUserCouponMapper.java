package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.NewUserCoupon;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *
 * 新用户 赠送券 持久层接口
 * Created by Eric Xie on 2017/2/13 0013.
 */
public interface INewUserCouponMapper {


    Integer addNewUserCoupon(@Param("newUserCoupon") NewUserCoupon newUserCoupon);


    Integer updateNewUserCoupon(@Param("newUserCoupon") NewUserCoupon newUserCoupon);

    Integer batchAdd(@Param("newUserCoupons") List<NewUserCoupon> newUserCoupons);

    Integer del(@Param("id") Integer id);

    List<NewUserCoupon> queryAll();




}
