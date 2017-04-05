package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.HomeFont;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/1 0001.
 */
public interface IHomeFontMapper {

    Integer updateHomeFont(@Param("homeFont") HomeFont homeFont);


    List<HomeFont> queryHomeFontAll();

}
