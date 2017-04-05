package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.Cook;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 *
 * 厨师管理 持久层接口
 * Created by Eric Xie on 2017/2/13 0013.
 */

public interface ICookMapper {

    /**
     *  添加
     * @param cook
     * @return
     */
    Integer addCook(@Param("cook") Cook cook);

    /**
     *  根据ID 更新不为空的字段
     * @param cook
     * @return
     */
    Integer updateCook(@Param("cook") Cook cook);

    /**
     *  根据 手机号 和 密码查询 厨师
     * @param phoneNumber
     * @param password
     * @return
     */
    Cook queryByPhoneAndPwd(@Param("phoneNumber") String phoneNumber,@Param("password") String password);



    List<Cook> queryCookByItem(@Param("userName") String userName,@Param("phoneNumber") String phoneNumber,
                               @Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    Integer countCookByItem(@Param("userName") String userName,@Param("phoneNumber") String phoneNumber);



    List<Cook> queryCookByServiceDate(@Param("time") String time, @Param("serviceDate") Date serviceDate);

    /**
     *  批量查询厨师的 设备信息 用户推送
     * @param ids
     * @return
     */
    List<Cook> queryCookDeviceToken(@Param("ids") List<Integer> ids);

    /**
     * 获取厨师详情
     * @param id
     * @return
     */
    Cook getCookByIdForWeb(@Param("id") Integer id);


    Integer updatePwdByPhone(@Param("phone") String phone,@Param("pwd") String pwd);

    /**
     * 通过ID 查询
     * @param id
     * @return
     */
    Cook queryCookById(@Param("id") Integer id);
}
