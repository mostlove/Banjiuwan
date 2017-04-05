package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.AdminUser;
import com.magicbeans.banjiuwan.beans.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *  后台用户持久层接口
 * Created by Eric Xie on 2017/2/13 0013.
 */
public interface IAdminUserMapper {


    /**
     *  添加用户
     * @param user
     * @return
     */
    Integer addAdmin(@Param("user") AdminUser user);

    /**
     *  根据ID 更新不为空的字段
     * @param user
     * @return
     */
    Integer updateAdmin(@Param("user") AdminUser user);

    /**
     *  通过手机号和密码查询用户
     * @param phoneNumber
     * @param password
     * @return
     */
    AdminUser queryByPhoneAndPwd(@Param("phoneNumber") String phoneNumber, @Param("password") String password);


    List<AdminUser> queryAdminUserForWeb(@Param("userName") String userName,@Param("phoneNumber") String phoneNumber,
                                         @Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    Integer countAdminUserForWeb(@Param("userName") String userName,@Param("phoneNumber") String phoneNumber);

    /***
     * 获取管理员详情
     * @param id
     * @return
     */
    AdminUser getAdminUserByIdForWeb(@Param("id") Integer id);


    AdminUser queryAdminUserByCode(@Param("code") String code);

    /**
     *  根据USER  查询 对应的客户经理
     * @param userId
     * @return
     */
    AdminUser queryAdminUserByUser(@Param("userId") Integer userId);


    AdminUser queryAdminUserById(@Param("id") Integer id);

}
