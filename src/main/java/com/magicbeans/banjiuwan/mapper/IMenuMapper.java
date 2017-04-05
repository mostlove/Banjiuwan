package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.Menu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *
 *  菜单管理 持久层接口
 * Created by Eric Xie on 2017/2/13 0013.
 */
public interface IMenuMapper {


    List<Menu> queryMenuByRole(@Param("roleId") Integer roleId);

    List<Menu> queryAllMenu();
}
