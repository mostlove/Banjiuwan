package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.CouponFoodCategory;
import com.magicbeans.banjiuwan.mapper.ICouponFoodCategoryMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/3 0003.
 */
@Service
public class CouponFoodCategoryService {

    @Resource
    private ICouponFoodCategoryMapper couponFoodCategoryMapper;

    /**
     *  通过 优惠券ID 集合查询
     * @param ids
     * @return
     */
    public List<CouponFoodCategory> getCouponFoodCategory(List<Integer> ids){
        return couponFoodCategoryMapper.batchQueryByCouponIds(ids);
    }


}
