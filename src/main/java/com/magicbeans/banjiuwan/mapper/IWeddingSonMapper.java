package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.WeddingSon;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *
 * 婚庆 子项目 实体
 * Created by Eric Xie on 2017/2/22 0022.
 */
public interface IWeddingSonMapper {


    Integer addWeddingSon(@Param("son") WeddingSon son);

    List<WeddingSon> queryAllWeddingSon();

    Integer delWeddingSon(@Param("id") Integer id);

    Integer updateWeddingSon(@Param("son") WeddingSon son);

    List<WeddingSon> queryPage(@Param("name") String name,@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    Integer countPage(@Param("name") String name);

    /**
     *
     * @param childCategoryId
     * @return
     */
    List<WeddingSon> queryWeddingSonByChildCategory(@Param("childCategoryId") Integer childCategoryId);




}
