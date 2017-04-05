package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.AdminUser;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.mapper.IAdminUserMapper;
import com.magicbeans.banjiuwan.util.MD5;
import com.magicbeans.banjiuwan.util.StatusConstant;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.management.relation.RoleStatus;
import java.util.List;

/**
 *
 * 后台用户管理 业务层
 * Created by Eric Xie on 2017/2/15 0015.
 */

@Service
public class AdminUserService {


    @Resource
    private IAdminUserMapper adminUserMapper;


    public AdminUser queryAdminUserById(Integer id){
        return adminUserMapper.queryAdminUserById(id);
    }

    public AdminUser queryAdminUserByCode(String code){
        return adminUserMapper.queryAdminUserByCode(code);
    }

    public void addAdminUser(AdminUser user){
        if(StatusConstant.ACCOUNT_MANAGER.equals(user.getRoleId())){
            user.setCode(MD5.MD5Encode(user.getPhoneNumber()));
        }
        user.setIsValid(StatusConstant.VALID_YES);
        adminUserMapper.addAdmin(user);
    }

    public AdminUser queryByPhone(String phoneNumber,String password){
        return adminUserMapper.queryByPhoneAndPwd(phoneNumber,password);
    }

    public Page<AdminUser> queryAdminUserForWeb(String userName,String phoneNumber,Integer pageNO,Integer pageSize){
        List<AdminUser> dataList = adminUserMapper.queryAdminUserForWeb(userName,phoneNumber,(pageNO - 1) * pageSize,pageSize);
        Integer count = adminUserMapper.countAdminUserForWeb(userName,phoneNumber);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<AdminUser>(dataList,count,totalPage);
    }


    public void updateAdminUser(AdminUser adminUser){
        adminUserMapper.updateAdmin(adminUser);
    }

    /***
     * 获取管理员详情
     * @param id
     * @return
     */
    public AdminUser getAdminUserByIdForWeb(Integer id){
        return adminUserMapper.getAdminUserByIdForWeb(id);
    }
}
