package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.Menu;
import com.magicbeans.banjiuwan.beans.Role;
import com.magicbeans.banjiuwan.beans.RoleMenu;
import com.magicbeans.banjiuwan.mapper.IMenuMapper;
import com.magicbeans.banjiuwan.mapper.IRoleMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 角色管理
 * Created by Eric Xie on 2017/3/16 0016.
 */
@Service
public class RoleService {

    @Resource
    private IRoleMapper roleMapper;
    @Resource
    private IMenuMapper menuMapper;

    /**
     *  更新权限
     * @param roleMenus
     * @param roleId
     */
    @Transactional
    public void updateRoleMenu(List<RoleMenu> roleMenus,Integer roleId){
        roleMapper.delRoleMenu(roleId);
        roleMapper.batchAddRoleMenu(roleMenus);
    }


    public Role queryRole(Integer id){
        return roleMapper.queryRoleById(id);
    }

    public List<Menu> getAllMenu(){
        return menuMapper.queryAllMenu();
    }


}
