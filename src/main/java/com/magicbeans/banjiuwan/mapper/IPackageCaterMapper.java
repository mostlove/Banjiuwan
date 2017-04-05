package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.PackageCater;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *
 * 套餐、宴席 持久层接口
 * Created by Eric Xie on 2017/2/15 0015.
 */
public interface
IPackageCaterMapper {



    Integer addPackageCater(@Param("packageCater") PackageCater packageCater);

    Integer updatePackageCater(@Param("packageCater") PackageCater packageCater);

    List<PackageCater> queryByCategory(@Param("categoryId") Integer categoryId);

    Integer delPackageCater(@Param("id") Integer id);

    PackageCater queryById(@Param("id") Integer id);

    /**
     *  根据条件分页获取
     * @param name
     * @param categoryId
     * @param limit
     * @param limitSize
     * @return
     */
    List<PackageCater> queryByNameOrCategory(@Param("name") String name,@Param("categoryId") Integer categoryId,@Param("limit") Integer limit
            ,@Param("limitSize") Integer limitSize);

    Integer countByNameOrCategory(@Param("name") String name,@Param("categoryId") Integer categoryId);

    /**
     *  通过ID集合 批量查询 坝坝宴、套餐 部分字段
     * @param ids
     * @return
     */
    List<PackageCater> batchQuery(@Param("ids") List<Integer> ids);


    /**
     *  APP 端 通过 ID 查询坝坝宴
     * @param categoryId
     * @param foodId
     * @param userId
     * @return
     */
    PackageCater queryPackageCaterOtherInfo(@Param("categoryId") Integer categoryId,@Param("foodId") Integer foodId,
                                            @Param("userId") Integer userId);


    Integer batchUpdateSales(@Param("packageCaters") List<PackageCater> packageCaters);
}
