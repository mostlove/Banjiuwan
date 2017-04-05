package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.Log;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * @author lzh
 * @create 2017/3/21 14:44
 */
public interface ILogMapper {


    /**
     * 添加日志
     * @param log
     */
    void save(Log log);

    /**
     * 日志列表
     * @param operateTypes 日志操作类型
     * @param toOperateTypes 被操作的类型
     * @param userName 操作人姓名
     * @param limit
     * @param limitSize
     * @return
     */
    List<Log> list(@Param("operateTypes")Integer[] operateTypes ,@Param("toOperateTypes") Integer[] toOperateTypes ,
                   @Param("userName") String userName , @Param("startTime") Date startTime,@Param("endTime") Date endTime,
                   @Param("limit") Integer limit, @Param("limitSize") Integer limitSize);

    /**
     * 日志列表 (统计条数)
     * @param operateTypes 日志操作类型
     * @param toOperateTypes 被操作的类型
     * @param userName 操作人姓名
     * @return
     */
    Integer listCount(@Param("operateTypes")Integer[] operateTypes ,@Param("toOperateTypes") Integer[] toOperateTypes ,
                   @Param("userName") String userName, @Param("startTime") Date startTime,@Param("endTime") Date endTime);
}
