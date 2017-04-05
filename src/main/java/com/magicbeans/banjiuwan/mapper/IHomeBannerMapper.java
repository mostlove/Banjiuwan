package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.HomeBanner;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/2/16 0016.
 */
public interface IHomeBannerMapper {


    Integer addHomeBanner(@Param("banner") HomeBanner banner);

    /**
     *  更新不为空的字段
     * @param banner
     * @return
     */
    Integer updateHomeBanner(@Param("banner") HomeBanner banner);

    Integer delHomeBanner(@Param("id") Integer id);

    List<HomeBanner> queryAllHomeBanner(@Param("type") Integer type);

    HomeBanner queryHomeBannerById(@Param("id") Integer id);


}
