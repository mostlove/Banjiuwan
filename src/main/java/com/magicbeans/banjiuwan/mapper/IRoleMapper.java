package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.Role;
import com.magicbeans.banjiuwan.beans.RoleMenu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 角色 管理 持久层接口
 * Created by Eric Xie on 2017/3/16 0016.
 */
public interface IRoleMapper {


    Role queryRoleById(@Param("id") Integer id);

    /**
     *  根据角色 删除 角色所有的菜单权限
     * @param roleId
     * @return
     */
    Integer delRoleMenu(@Param("roleId") Integer roleId);

    /**
     * 新增 权限
     * @param roleMenus
     * @return
     */
    Integer batchAddRoleMenu(@Param("roleMenus") List<RoleMenu> roleMenus);

}
