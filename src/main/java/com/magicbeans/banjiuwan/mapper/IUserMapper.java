package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.ConsumptionStatistics;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.beans.UserAddress;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 *  用户持久层接口
 * Created by Eric Xie on 2017/2/13 0013.
 */
public interface IUserMapper {


    /**
     *  添加用户
     * @param user
     * @return
     */
    Integer addUser(@Param("user") User user);

    /**
     *  根据ID 更新不为空的字段
     * @param user
     * @return
     */
    Integer updateUser(@Param("user") User user);

    /**
     *  通过手机号和密码查询用户
     * @param phoneNumber
     * @param password
     * @return
     */
    User queryByPhoneAndPwd(@Param("phoneNumber") String phoneNumber,@Param("password") String password);


    /**
     *  分页获取用户信息
     * @param phoneNumber
     * @param userName
     * @param limit
     * @param limitSize
     * @return
     */
    List<User> queryByPage(@Param("phoneNumber") String phoneNumber,@Param("userName") String userName,
                           @Param("limit") Integer limit,@Param("limitSize") Integer limitSize);

    /**
     *  统计用户
     * @param phoneNumber
     * @param userName
     * @return
     */
    Integer countByPage(@Param("phoneNumber") String phoneNumber,@Param("userName") String userName);

    /**
     *  通过ID 查询用户 部分字段(积分、余额、token、DeviceToken etc..)
     * @param id
     * @return
     */
    User queryUserById(@Param("id") Integer id);


    /**
     *  统计用户消费行为
     * @param limit
     * @param limitSize
     * @return
     */
    List<ConsumptionStatistics> statisticsUser(@Param("limit") Integer limit, @Param("limitSize") Integer limitSize,
                                               @Param("userName")String userName , @Param("mobile")String mobile,
                                               @Param("startTime") Date startTime,@Param("endTime") Date endTime);


    Integer countStatisticsUser(@Param("userName")String userName ,@Param("mobile")String mobile);


    /**
     * 获取用户详情
     * @param id
     * @return
     */
    User getUserByIdForWeb(@Param("id") Integer id);



    /**
     * 填写备注
     * @param id
     * @param reMarket
     */
    void saveReMarket(@Param("id") Integer id,@Param("reMarket")String reMarket);









}
