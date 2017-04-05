package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.UserCoupon;
import com.magicbeans.banjiuwan.mapper.IUserCouponMapper;
import com.magicbeans.banjiuwan.util.DateUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/3 0003.
 */
@Service
public class UserCouponService {


    @Resource
    private IUserCouponMapper userCouponMapper;

    public void addUserCoupon(UserCoupon userCoupon){
        userCouponMapper.addUserCoupon(userCoupon);
    }


    /**
     *  获取用户的有效 优惠券
     * @param userId
     * @return
     */
    public List<UserCoupon> queryAllCouponByUser(Integer userId){
        return userCouponMapper.queryByUser(DateUtil.getMill(null),userId,null,null);
    }

}
