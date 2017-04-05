package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.SpecialService;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *
 * 特色服务 之 专业服务 持久层接口
 * Created by Eric Xie on 2017/2/15 0015.
 */
public interface ISpecialServiceMapper {


    Integer addSpecialService(@Param("specialService") SpecialService specialService);


    Integer updateSpecialService(@Param("specialService") SpecialService specialService);

    List<SpecialService> queryAll();



}
