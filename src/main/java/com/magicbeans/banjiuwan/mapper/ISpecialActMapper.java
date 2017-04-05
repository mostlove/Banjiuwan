package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.SpecialAct;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *
 * 特色服务 伴餐演奏 持久层接口
 * Created by Eric Xie on 2017/2/15 0015.
 */
public interface ISpecialActMapper {


    Integer addSpecialAct (@Param("specialAct") SpecialAct specialAct);


    Integer updateSpecialAct(@Param("specialAct") SpecialAct specialAct);

    Integer delSpecialAct(@Param("id") Integer id);

    List<SpecialAct> queryAllAct();

    /**
     *  分页查询
     * @param name
     * @param limit
     * @param limitSize
     * @return
     */
    List<SpecialAct> queryByName(@Param("name") String name,@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    Integer countByName(@Param("name") String name);


    SpecialAct queryActById(@Param("id") Integer id);

    /**
     *  通过ID集合 批量查询 伴餐演奏集合
     * @param ids
     * @return
     */
    List<SpecialAct> batchQuery(@Param("ids") List<Integer> ids);

    /**
     *  根据条件 查询 伴餐演奏 以及 购物车里的数量
     * @param userId
     * @param actId
     * @return
     */
    SpecialAct querySpecialActOtherInfo(@Param("userId") Integer userId,@Param("actId") Integer actId);

    Integer batchUpdateSale(@Param("specialActs") List<SpecialAct> specialActs);


}
