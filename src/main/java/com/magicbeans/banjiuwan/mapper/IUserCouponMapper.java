package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.UserCoupon;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *
 * 用户券信息 持久层接口
 * Created by Eric Xie on 2017/2/13 0013.
 */
public interface IUserCouponMapper {


    Integer addUserCoupon(@Param("userCoupon") UserCoupon userCoupon);

    /**
     *  批量新增券
     * @param coupons
     * @return
     */
    Integer batchAddUserCoupon(@Param("coupons") List<UserCoupon> coupons);

    /**
     *  更新不为空的字段
     * @param userCoupon
     * @return
     */
    Integer updateUserCoupon(@Param("userCoupon") UserCoupon userCoupon);

    /**
     *  条件查询 券
     * @param userId 用户ID
     * @param timestamp 当前时间戳 / 1000
     * @return
     */
    List<UserCoupon> queryByUser(@Param("timestamp") Integer timestamp,@Param("userId") Integer userId,@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    /**
     *  批量更新优惠券 是否有效
     * @param isValid
     * @param ids
     * @return
     */
    Integer batchUpdateCouponIsValid(@Param("isValid") Integer isValid,@Param("ids") List<Integer> ids);
}
