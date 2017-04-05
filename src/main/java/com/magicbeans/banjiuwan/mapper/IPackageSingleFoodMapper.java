package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.PackageSingleFood;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 套餐/坝坝宴 与 菜品 中间表 持久层接口
 * Created by Eric Xie on 2017/2/21 0021.
 */
public interface IPackageSingleFoodMapper {

    /**
     * 批量新增
     * @param pss
     * @return
     */
    Integer batchAdd(@Param("pss") List<PackageSingleFood> pss);

    /**
     *  根据 套餐、坝坝宴ID 删除所有的 菜品
     * @param packageId
     * @return
     */
    Integer delByPackage(@Param("packageId") Integer packageId);



}
