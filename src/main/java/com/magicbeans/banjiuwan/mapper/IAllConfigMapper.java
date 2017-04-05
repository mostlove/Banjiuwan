package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.AllConfig;
import org.apache.ibatis.annotations.Param;


/**
 * Created by Eric Xie on 2017/3/3 0003.
 */
public interface IAllConfigMapper {


    /**
     *  查询配置
     * @return
     */
    AllConfig queryAllConfig();

    /**
     * 更新配置
     * @param allConfig
     * @return
     */
    Integer updateConfig(@Param("allConfig") AllConfig allConfig);

}
