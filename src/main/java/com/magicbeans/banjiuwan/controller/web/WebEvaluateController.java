package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.*;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.exception.InterfaceCommonException;
import com.magicbeans.banjiuwan.service.EvaluateService;
import com.magicbeans.banjiuwan.service.LogService;
import com.magicbeans.banjiuwan.service.OrderService;
import com.magicbeans.banjiuwan.service.SingleFoodService;
import com.magicbeans.banjiuwan.util.*;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 控制器 -- 评价
 * @author lzh
 * @create 2017/3/10 10:45
 */
@Controller
@RequestMapping("/web/evaluate")
public class WebEvaluateController extends BaseController {

    private Logger logger = Logger.getLogger(getClass());

    @Resource
    private EvaluateService evaluateService;

    @Resource
    private LogService logService;

    @Resource
    private OrderService orderService;

    @Resource
    private SingleFoodService singleFoodService;
    /**
     * 评价
     * @param evaluate
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public ViewData save(Evaluate evaluate, HttpServletRequest request){
        AdminUser adminUser = LoginHelper.getCurrentAdmin(request);

        try {

            if (null != evaluate.getImgs() && evaluate.getImgs().trim().length() > 0) {
                evaluate.setImgs(evaluate.getImgs().substring(1,evaluate.getImgs().length()));
            }

            evaluate.setUserId(adminUser.getId());
            //2:管理员
            evaluate.setUserType(2);
            evaluateService.save(evaluate,1);

            {
                //记录日志
                Log log = new Log();
                log.setToOperateId(evaluate.getObjectId());
                log.setOperateType(LogConstant.LOG_TYPE_SAVE);
                if (evaluate.getType() == 1) {
                    Order order = orderService.queryOrderById(evaluate.getObjectId());
                    if (null == order) {
                        return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION, ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
                    }
                    log.setToOperateType(LogConstant.LOG_ORDER);
                    log.setDescribe("对订单[" + order.getOrderNumber() + "]进行了评价的操作");
                } else {
                    SingleFood singleFood =  singleFoodService.queryById(evaluate.getObjectId());
                    if (null == singleFood) {
                        return buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION, ReturnMessage.MSG_ARGUMENTS_EXCEPTION.toString());
                    }
                    log.setToOperateType(LogConstant.LOG_FOOD);
                    log.setDescribe("对菜品[" + singleFood.getFoodName() + "]进行了评价的操作");
                }
                logService.save(log,request);
            }

            return buildFailureJson(StatusConstant.SUCCESS_CODE,"评价成功");
        }catch (InterfaceCommonException e) {
            e.printStackTrace();
            logger.error(e.getMessage(),e);
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            logger.error("服务器超时，评价失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，评价失败");
        }
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
    @RequestMapping("/getFoodListForWeb")
    @ResponseBody
    public ViewData getFoodListForWeb(String objectIds,
                         String foodCategoryIds,
                         Integer isPass,
                         Integer userType,
                         Integer evaluateLevel,
                         Integer pageNO,Integer pageSize){
        try {
            Page<Evaluate> evaluatePage = evaluateService.getFoodListForWeb(objectIds, foodCategoryIds,isPass,
                    userType, evaluateLevel, pageNO, pageSize);
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",evaluatePage);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("服务器超时，获取失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

    /**
     * 订单评价列表 web
     * @param orderNumber
     * @param isPass
     * @param userType
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/getOrderListForWeb")
    @ResponseBody
    public ViewData getOrderListForWeb(String orderNumber,
                                      Integer isPass,
                                      Integer userType,
                                      Integer evaluateLevel,
                                      Integer pageNO,Integer pageSize){
        try {
            Page<Evaluate> evaluatePage = evaluateService.getOrderListForWeb(orderNumber,isPass,
                    userType, evaluateLevel, pageNO, pageSize);
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",evaluatePage);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("服务器超时，获取失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }



    /**
     * 更新 评价是否通过
     * @param isPass
     * @param id
     */
    @RequestMapping("/updateIsPass")
    @ResponseBody
    public ViewData updateIsPass(Integer id, Integer isPass){
        try {
            evaluateService.updateIsPass(isPass,id);
            return buildFailureJson(StatusConstant.SUCCESS_CODE,"更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("服务器超时，更新失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，更新失败");
        }
    }





}
