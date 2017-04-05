package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.beans.Role;
import com.magicbeans.banjiuwan.beans.RoleMenu;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.LogService;
import com.magicbeans.banjiuwan.service.RoleService;
import com.magicbeans.banjiuwan.util.*;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * 权限管理 控制器
 * Created by Eric Xie on 2017/3/16 0016.
 */
@Controller
@RequestMapping("/web/role")
public class RoleController extends BaseController {

    @Resource
    private RoleService roleService;

    @Resource
    private LogService logService;
    /**
     *  根据Role获取菜单
     * @param roleId
     * @return
     */
    @RequestMapping("/getRole")
    public @ResponseBody ViewData getRole(Integer roleId){
        if(null == roleId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        Map<String,Object> data = new HashMap<String, Object>();
        data.put("menus",roleService.getAllMenu());
        data.put("role",roleService.queryRole(roleId));
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),data);
    }


    /**
     * 更新权限
     * @param roleId
     * @return
     */
    @RequestMapping("/updatePower")
    public @ResponseBody ViewData updatePower(Integer roleId, String roleMenusArr, HttpServletRequest request){
        if(null == roleId || CommonUtil.isEmpty(roleMenusArr)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            JSONArray jsonArray = JSONArray.fromObject(roleMenusArr);
            List<RoleMenu> roleMenus = new ArrayList<RoleMenu>();
            for (Object obj : jsonArray){
                RoleMenu roleMenu = new RoleMenu();
                roleMenu.setRoleId(roleId);
                roleMenu.setMenuId(Integer.parseInt(obj.toString()));
                roleMenus.add(roleMenu);
            }
            if(roleMenus.size() > 0){
                roleService.updateRoleMenu(roleMenus,roleId);
                //记录日志
                {
                    Role role = roleService.queryRole(roleId);
                    Log log = new Log();
                    log.setToOperateId(roleId);
                    log.setToOperateType(LogConstant.LOG_POWER_CONFIG);
                    log.setOperateType(LogConstant.LOG_TYPE_SAVE);
                    log.setDescribe("对权限管理[角色" + role.getRoleName() + "]进行了更新的操作");
                    logService.save(log,request);
                }
            }
            else{
                return buildFailureJson(StatusConstant.Fail_CODE,"没有选择菜单");
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }




}
