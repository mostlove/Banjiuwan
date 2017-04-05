package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.SpecialWeddingChildCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 婚庆和子分类 持久层接口
 * Created by Eric Xie on 2017/2/23 0023.
 */
public interface ISpecialWeddingChildCategoryMapper {

    /**
     *  批量新增
     * @param weddingChildCategorys
     * @return
     */
    Integer batchAddWeddingChildCategory(@Param("weddingChildCategorys") List<SpecialWeddingChildCategory> weddingChildCategorys);

    /**
     * 根据婚庆ID  删除 中间表数据
     * @param weddingId
     * @return
     */
    Integer delWeddingChildCategoryByWedding(@Param("weddingId") Integer weddingId);

}
