package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.Cook;
import com.magicbeans.banjiuwan.beans.CookTimeConfig;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 厨师排班表   持久层
 * Created by Eric Xie on 2017/3/6 0006.
 */
public interface ICookTimeConfigMapper {


    /**
     *  新增厨师排班
     * @param cookTimeConfig
     * @return
     */
    Integer addCookTimeConfig(@Param("cookTime") CookTimeConfig cookTimeConfig);

    /**
     *  批量新增 厨师排班
     * @param cookTimeConfigs
     * @return
     */
    Integer batchAddCookTimeConfig(@Param("cookTimeConfigs") List<CookTimeConfig> cookTimeConfigs);


    Integer delCookTimeByCook(@Param("cookId") Integer cookId);


    /**
     *  根据 时刻  查询 当前时刻 所有排班了的 厨师集合
     * @param timeConfig "12:00"
     * @return 厨师集合
     */
    List<Cook> queryByTimeConfig(@Param("timeConfig") String timeConfig);


    List<CookTimeConfig> queryByCookId(@Param("cookId") Integer cookId);




}
