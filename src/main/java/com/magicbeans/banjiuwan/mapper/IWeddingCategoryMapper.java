package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.WeddingCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 婚庆 子项目 大分类 持久层接口
 * Created by Eric Xie on 2017/2/23 0023.
 */
public interface IWeddingCategoryMapper {

    /**
     *  新增
     * @param weddingCategory
     * @return
     */
    Integer addWedingCategory(@Param("weddingCategory") WeddingCategory weddingCategory);

    /**
     *  删除
     * @param id
     * @return
     */
    Integer delWeddingCategory(@Param("id") Integer id);

    /**
     *  查询所有
     * @return
     */
    List<WeddingCategory> queryAllWeddingCategory();

    /**
     *  更新
     * @param weddingCategory
     * @return
     */
    Integer updateWeddingCategory(@Param("weddingCategory") WeddingCategory weddingCategory);




}
