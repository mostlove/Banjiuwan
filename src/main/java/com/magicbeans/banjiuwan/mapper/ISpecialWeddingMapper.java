package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.SpecialWedding;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *
 * 特色服务  婚庆 持久层接口
 *
 * Created by Eric Xie on 2017/2/15 0015.
 */
public interface ISpecialWeddingMapper {


    Integer addSpecialWedding(@Param("specialWedding") SpecialWedding specialWedding);

    Integer updateSpecialWedding(@Param("specialWedding") SpecialWedding specialWedding);

    List<SpecialWedding> queryPage(@Param("name") String name,@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    Integer countPage(@Param("name") String name);

    SpecialWedding queryWeddingById(@Param("id") Integer id);

    Integer delSpecialWedding(@Param("id") Integer id);

    /**
     *  通过婚庆ID的集合  批量查询婚庆的部分字段
     * @param ids
     * @return
     */
    List<SpecialWedding> batchQuery(@Param("ids") List<Integer> ids);


    List<SpecialWedding> queryAllWedding(@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);


    SpecialWedding queryWeddingOtherInfo(@Param("weddingId") Integer weddingId);



}
