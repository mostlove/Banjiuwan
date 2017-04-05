package com.magicbeans.banjiuwan.aop;

import com.magicbeans.banjiuwan.beans.AdminUser;
import com.magicbeans.banjiuwan.beans.Log;
import com.magicbeans.banjiuwan.beans.Order;
import com.magicbeans.banjiuwan.mapper.ILogMapper;
import com.magicbeans.banjiuwan.mapper.IOrderMapper;
import com.magicbeans.banjiuwan.util.LogConstant;
import com.magicbeans.banjiuwan.util.LoginHelper;
import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.lang.reflect.Method;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 记录日志 （aop）
 * @author lzh
 * @create 2017/3/20 17:54
 */
public class ServiceAspect {

    private Logger logger = Logger.getLogger(getClass());

    @Resource
    private ILogMapper logMapper;

    @Resource
    private IOrderMapper orderMapper;

    public void log(JoinPoint point) throws Throwable{
//        System.out.println("进入了log().........");
//        HttpServletRequest request = ((ServletRequestAttributes)
//                RequestContextHolder.getRequestAttributes()).getRequest();
//        AdminUser adminUser = LoginHelper.getCurrentAdmin(request);
//        try {
//            ServiceAopLog serviceAopLog = getServiceAspect(point);
//            if (serviceAopLog == null) {
//                return;
//            }
//
//            //被操作类型
//            String toOperateType = serviceAopLog.toOperateType();
//            //被操作类型的id
//            Integer toOperateId = Integer.parseInt(request.getSession().getAttribute("toOperateId").toString());
//            //描述
//            String describe = serviceAopLog.describe();
//            if (toOperateType.equals(LogConstant.LOG_ORDER)) {
//                Order order = orderMapper.queryOrderById(toOperateId);
//                describe = "对订单" + order.getOrderNumber() + "进行了" + describe + "操作";
//            }
//            Log log = new Log();
//            log.setAdminUserId(adminUser.getId());
//            log.setDescribe(describe);
//            log.setIp(request.getRemoteAddr());
//            log.setOperateType(Integer.parseInt(toOperateType));
//            log.setToOperateType(Integer.parseInt(serviceAopLog.toOperateType()));
//            log.setToOperateId(toOperateId);
//            logMapper.save(log);
//            //移除session
//            request.getSession().removeAttribute("toOperateId");
//        } catch (Throwable throwable) {
//            logger.error("记录日志失败");
//            logger.error(throwable.getMessage(), throwable);
//        }




    }





    private ServiceAopLog getServiceAspect(JoinPoint point){
        try {
            MethodSignature methodSignature = (MethodSignature) point.getSignature();
            Method method = methodSignature.getMethod();
            return method.getAnnotation(ServiceAopLog.class);
        } catch (Exception e) {
            logger.info(e.getMessage());
        }
        return null;
    }
}
