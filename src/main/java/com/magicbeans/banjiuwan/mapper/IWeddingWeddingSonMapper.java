package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.WeddingWeddingSon;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/2/22 0022.
 */
public interface IWeddingWeddingSonMapper {


    Integer addWeddingWeddingSon(@Param("weddingSon") WeddingWeddingSon weddingSon);

    Integer batchAddWeddingWeddingSon(@Param("weddingSons") List<WeddingWeddingSon> weddingSons);

    /**
     *  通过婚庆预约 删除数据
     * @param weddingId
     * @return
     */
    Integer delByWedding(@Param("weddingId") Integer weddingId);

    /**
     *  通过婚庆 查询 子项集合
     * @param weddingId
     * @return
     */
    List<WeddingWeddingSon> queryByWedding(@Param("weddingId") Integer weddingId);
}
