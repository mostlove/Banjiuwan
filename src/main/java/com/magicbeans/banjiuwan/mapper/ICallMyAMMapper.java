package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.CallMyAM;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/2/28 0028.
 */
public interface ICallMyAMMapper {


    Integer addCallMyAM(@Param("callMyAM") CallMyAM callMyAM);

    Integer updateCallMyAM(@Param("callMyAM") CallMyAM callMyAM);

    List<CallMyAM> queryCallNyAMPage(@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    Integer countCallMyAM();

}
