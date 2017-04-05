package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.UserAddress;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *
 * 用户 地址管理 持久层接口
 *
 * Created by Eric Xie on 2017/2/14 0014.
 */
public interface IUserAddressMapper {


    /**
     *  新增地址
     * @param userAddress
     * @return
     */
    Integer addAddress(@Param("userAddress") UserAddress userAddress);


    /**
     * 更新不为空的字段
     * @param userAddress
     * @return
     */
    Integer updateAddress(@Param("userAddress") UserAddress userAddress);


    /**
     *  分页查询 用户的 有效地址
     * @param userId 用户ID
     * @param limit 起始
     * @param limitSize 截至
     * @return
     */
    List<UserAddress> queryAddressByUser(@Param("userId") Integer userId,@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);


    Integer countAddressByUser(@Param("userId") Integer userId);
    /**
     *  通过ID 查询地址
     * @param id
     * @return
     */
    UserAddress queryAddressById(@Param("id") Integer id);

    /**
     * 更新当前ID 以外 所有的默认值为 0
     * @param currentId
     * @return
     */
    Integer updateIsDefaultOtherObj (@Param("currentId") Integer currentId,@Param("userId") Integer userId);


    Integer delUserAddress(@Param("id") Integer id);
}
