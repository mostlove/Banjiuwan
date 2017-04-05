package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.AdminUser;
import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.mapper.ILogMapper;
import com.magicbeans.banjiuwan.util.LoginHelper;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 日志
 * @author lzh
 * @create 2017/3/22 11:14
 */
@Service
public class LogService {

    private Logger logger = Logger.getLogger(getClass());
    @Resource
    private ILogMapper logMapper;

    /**
     * 记录日志
     * @param log
     */
    public void save(Log log,HttpServletRequest request){
        AdminUser adminUser = LoginHelper.getCurrentAdmin(request);
        try {
            log.setAdminUserId(adminUser.getId());
            log.setIp(request.getRemoteAddr());
            logMapper.save(log);
        } catch (Exception e) {
            logger.error("记录日志错误");
        }
    }


    public Page<Log> list(String operateTypes , String toOperateTypes ,
                          String userName ,String startTimes,String endTimes, Integer pageNO,Integer pageSize){

        try {
            //日志操作类型
            Integer[]  operateTypeInt = null;
            if (null != operateTypes && operateTypes.trim().length() > 0) {
                String[] s = operateTypes.split(",");
                operateTypeInt= new Integer[s.length];
                for (int i = 0 ; i < s.length ; i ++) {
                    operateTypeInt[i] = Integer.parseInt(s[i]);
                }
            }

            //被操作的类型
            Integer[]  toOperateTypeInt = null;
            if (null != toOperateTypes && toOperateTypes.trim().length() > 0) {
                String[] s = toOperateTypes.split(",");
                toOperateTypeInt= new Integer[s.length];
                for (int i = 0 ; i < s.length ; i ++) {
                    toOperateTypeInt[i] = Integer.parseInt(s[i]);
                }
            }
            Date startTime = startTimes!=null && startTimes != ""? new SimpleDateFormat("yyyy-MM-dd").parse(startTimes) : null;
            Date endTime = endTimes != null && endTimes != ""? new SimpleDateFormat("yyyy-MM-dd").parse(endTimes) : null;

            List<Log> list = logMapper.list(operateTypeInt,toOperateTypeInt,userName,
                    startTime, endTime, (pageNO - 1) * pageSize,pageSize);
            Integer count = logMapper.listCount(toOperateTypeInt,toOperateTypeInt,userName,startTime,endTime);
            Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
            return new Page<Log>(list,count,totalPage);
        } catch (Exception e) {
            logger.error("失败");
            return null;
        }


    }
}
