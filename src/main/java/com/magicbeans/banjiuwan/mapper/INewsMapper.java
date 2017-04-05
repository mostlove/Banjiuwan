package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.News;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 资讯 持久层接口
 * Created by Eric Xie on 2017/2/27 0027.
 */
public interface INewsMapper {

    /**
     * Add News
     * @param news
     * @return
     */
    Integer addNews(@Param("news") News news);
    /**
     * Delete News By Id
     * @param id
     * @return
     */
    Integer delNews(@Param("id") Integer id);

    /**
     *  Query News By Items
     * @param title
     * @param limit
     * @param limitSize
     * @return
     */
    List<News> queryByItems(@Param("title") String title,@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    /**
     * Count News
     * @param title
     * @return
     */
    Integer countByItems(@Param("title") String title);

    /**
     * Query News By Id
     * @param id
     * @return
     */
    News queryNewsById(@Param("id") Integer id);

    /**
     * Update
     * @param news
     * @return
     */
    Integer updateNews(@Param("news") News news);

}
