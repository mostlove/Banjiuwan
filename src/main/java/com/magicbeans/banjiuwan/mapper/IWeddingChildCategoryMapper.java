package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.WeddingChildCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 子分类 持久层
 * Created by Eric Xie on 2017/2/23 0023.
 */
public interface IWeddingChildCategoryMapper {


    /**
     *  新增
     * @param weddingChildCategory
     * @return
     */
    Integer addWeddingChildCategory(@Param("weddingChildCategory") WeddingChildCategory weddingChildCategory);


    /**
     *  删除
     * @param id
     * @return
     */
    Integer delWeddingChildCategory(@Param("id") Integer id);

    /**
     *  通过 分类ID 分页查询 子分类 列表
     * @param name
     * @param weddingCategory
     * @param limit
     * @param limitSize
     * @return
     */
    List<WeddingChildCategory> queryChildCategoryPage(@Param("name") String name,@Param("weddingCategory") Integer weddingCategory,
                                                      @Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    Integer countChildCategoryPage(@Param("name") String name,@Param("weddingCategory") Integer weddingCategory);


    /**
     *  更新
     * @param weddingChildCategory
     * @return
     */
    Integer updateWeddingChildCategory(@Param("weddingChildCategory") WeddingChildCategory weddingChildCategory);


    List<WeddingChildCategory> queryWeddingChildCategoryByWeddingId(@Param("weddingId") Integer weddingId);

}
