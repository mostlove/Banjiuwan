package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.NewUserCoupon;
import com.magicbeans.banjiuwan.mapper.INewUserCouponMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by Eric Xie on 2017/2/13 0013.
 */
@Service
public class NewUserCouponService {

    @Resource
    private INewUserCouponMapper newUserCouponMapper;


    public void addNewUserCoupon(NewUserCoupon newUserCoupon){
        newUserCouponMapper.addNewUserCoupon(newUserCoupon);
    }

    public void updateNewUserCoupon(NewUserCoupon newUserCoupon){
        newUserCouponMapper.updateNewUserCoupon(newUserCoupon);
    }

    public void delNewUserCoupon(Integer newUserCouponId){
        newUserCouponMapper.del(newUserCouponId);
    }

}
