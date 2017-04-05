package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.aop.ServiceAopLog;
import com.magicbeans.banjiuwan.beans.Evaluate;
import com.magicbeans.banjiuwan.beans.Order;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.exception.InterfaceCommonException;
import com.magicbeans.banjiuwan.mapper.IEvaluateMapper;
import com.magicbeans.banjiuwan.mapper.IOrderMapper;
import com.magicbeans.banjiuwan.util.LogConstant;
import com.magicbeans.banjiuwan.util.OrderConstant;
import com.magicbeans.banjiuwan.util.StatusConstant;
import org.apache.log4j.Logger;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 实现 -- 评价
 * @author lzh
 * @create 2017/3/10 10:30
 */
@Service
public class EvaluateService {


    private Logger logger = Logger.getLogger(getClass());

    @Resource
    private IEvaluateMapper evaluateMapper;
    @Resource
    private IOrderMapper orderMapper;

    /**
     * 评价
     * @param evaluate
     */
    @Transactional
    public void save(Evaluate evaluate,Integer type) throws InterfaceCommonException {

        if (type == 0) {
            if (null != evaluate.getOrderId()) {
                Order o = orderMapper.queryOrderById(evaluate.getOrderId());
                if (null == o) {
                    throw new InterfaceCommonException(StatusConstant.Fail_CODE,"数据错误，订单不存在");
                }
                if (null == o.getStatus() || (!o.getStatus().equals(OrderConstant.PENDING_EVALUATE) && !o.getStatus().equals(OrderConstant.FINISHED))) {
                    throw new InterfaceCommonException(StatusConstant.Fail_CODE,"当前订单状态为非待评价状态，暂不能评论");
                }
                if (null != evaluate.getType() && evaluate.getType().equals(1)) {
                    o.setStatus(OrderConstant.EVALUATED);
                }
                orderMapper.updateOrder(o);
            }
        }
        evaluateMapper.save(evaluate);
    }

    /**
     * 更新 评价是否通过
     * @param isPass
     * @param id
     */
    public void updateIsPass(Integer isPass , Integer id) {
        try {
            evaluateMapper.updateIsPass(isPass,id);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("服务器超时，更新失败",e);
        }
    }

    /**
     * 评论列表
     * @param type 评论类型
     * @param objectId 被评论的id
     * @param pageNO 页码
     * @param pageSize 条数
     * @return
     */
    public Page<Evaluate> list(Integer type, Integer objectId, Integer pageNO,Integer pageSize){
        try {
            List<Evaluate> list = evaluateMapper.list(type,objectId,(pageNO - 1) * pageSize,pageSize);
            List<Evaluate> counts = evaluateMapper.list(type,objectId,null,null);
            Integer count = 0;
            if (counts.size() > 0) {
                count = counts.size();
            }
            Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
            return new Page<Evaluate>(list,count,totalPage);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("服务器超时，查询失败",e);
        }
        return null;
    }

    /**
     *
     * @param type
     * @param objectId
     * @return
     */
    public Map<String ,Object> getAvgScore(Integer type, Integer objectId){
        Map<String,Object> map = new HashMap<String, Object>();
        try {
            Evaluate evaluate = evaluateMapper.getAvgScore(type, objectId);
            //菜品评分
            Double foodScore = 0.0;
            //服务评分
            Double serviceScore = 0.0;
            //厨师评分
            Double cookScore = 0.0;
            if (null != evaluate) {
                foodScore = null == evaluate.getFoodScore() ? foodScore : evaluate.getFoodScore();
                serviceScore = null == evaluate.getServiceScore() ? serviceScore : evaluate.getServiceScore();
                cookScore = null == evaluate.getCookScore() ? cookScore : evaluate.getCookScore();
            }
            map.put("foodScore",foodScore);
            map.put("serviceScore",serviceScore);
            map.put("cookScore",cookScore);
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
        }
        return map;
    }


    /**
     * 菜品评价列表 web
     * @param objectIds
     * @param foodCategoryIds
     * @param isPass
     * @param userType
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<Evaluate> getFoodListForWeb(String objectIds,
                               String foodCategoryIds,
                               Integer isPass,
                               Integer userType,
                               Integer evaluateLevel,
                               Integer pageNO,Integer pageSize){
        try {

            Integer[]  objectIdInt = null;
            if (null != objectIds && objectIds.trim().length() > 0) {
                String[] s = objectIds.split(",");
                objectIdInt= new Integer[s.length];
                for (int i = 0 ; i < s.length ; i ++) {
                    objectIdInt[i] = Integer.parseInt(s[i]);
                }
            }

            Integer[]  foodCategoryIdInt = null;
            if (null != foodCategoryIds && foodCategoryIds.trim().length() > 0) {
                String[] s = foodCategoryIds.split(",");
                foodCategoryIdInt= new Integer[s.length];
                for (int i = 0 ; i < s.length ; i ++) {
                    foodCategoryIdInt[i] = Integer.parseInt(s[i]);
                }
            }

            List<Evaluate> list = evaluateMapper.getFoodListForWeb(objectIdInt,foodCategoryIdInt,
                    isPass,userType,evaluateLevel,(pageNO - 1) * pageSize,pageSize);
            Integer count = evaluateMapper.getFoodListForWebCount(objectIdInt,foodCategoryIdInt,isPass,userType,evaluateLevel);
            Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
            return new Page<Evaluate>(list,count,totalPage);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("服务器超时，查询失败",e);
        }
        return null;
    }



    /**
     * 订单评价列表 web
     * @param isPass
     * @param userType
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<Evaluate> getOrderListForWeb(String orderNumber,
                                            Integer isPass,
                                            Integer userType,
                                            Integer evaluateLevel,
                                            Integer pageNO,Integer pageSize){
        try {
            List<Evaluate> list = evaluateMapper.getOrderListForWeb(orderNumber,
                    isPass,userType,evaluateLevel,(pageNO - 1) * pageSize,pageSize);
            Integer count = evaluateMapper.getOrderListForWebCount(orderNumber,isPass,userType,evaluateLevel);
            Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
            return new Page<Evaluate>(list,count,totalPage);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("服务器超时，查询失败",e);
        }
        return null;
    }
}
