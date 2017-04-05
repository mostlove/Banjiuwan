package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.WeddingSonChildCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 婚庆子项 和  子类绑定  持久层接口
 * Created by Eric Xie on 2017/2/23 0023.
 */
public interface IWeddingSonChildCategoryMapper {


    /**
     *  新增
     * @param weddingSonChildCategory
     * @return
     */
    Integer addWeddingSonChildCategory(@Param("weddingSonChildCategory") WeddingSonChildCategory weddingSonChildCategory);

    /**
     *  根据子项ID 删除 中间表数据
     * @param childCategoryId
     * @return
     */
    Integer delWeddingSonChildCategoryByChildCategory(@Param("childCategoryId") Integer childCategoryId);

    /**
     * 根据中间表ID 删除数据
     * @param id
     * @return
     */
    Integer delWeddingSonChildCategoryById(@Param("id") Integer id);

    List<WeddingSonChildCategory> querySonChildCategory(@Param("childCategoryId") Integer childCategoryId,
                                                        @Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    Integer countSonChildCategory(@Param("childCategoryId") Integer childCategoryId);



}
