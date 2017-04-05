package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.beans.Evaluate;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.exception.InterfaceCommonException;
import com.magicbeans.banjiuwan.service.EvaluateService;
import com.magicbeans.banjiuwan.util.LoginHelper;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

/**
 * 控制器 -- 评价
 * @author lzh
 * @create 2017/3/10 10:45
 */
@Controller
@RequestMapping("/app/evaluate")
public class EvaluateController extends BaseController {

    private Logger logger = Logger.getLogger(getClass());

    @Resource
    private EvaluateService evaluateService;


    /**
     * 评价
     * @param evaluate
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public ViewData save(Evaluate evaluate){
        Object obj = LoginHelper.getCurrentUser();
        if(null == obj){
            return buildFailureJson(StatusConstant.NOTLOGIN,"未登录");
        }
        try {
            if(obj instanceof User){
                User user = (User)obj;
                if(StatusConstant.ACCOUNT_NON_VALID.equals(user.getIsValid())){
                    return buildFailureJson(StatusConstant.Fail_CODE,"帐号无效");
                }
                evaluate.setUserId(user.getId());
                evaluate.setAvatar(user.getAvatar());
                evaluate.setPhoneNumber(user.getPhoneNumber());
            }
            //1:普通用户
            evaluate.setUserType(1);
            evaluateService.save(evaluate,0);
        }catch (InterfaceCommonException e) {
            e.printStackTrace();
            logger.error(e.getMessage(),e);
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            logger.error("服务器超时，评价失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，评价失败");
        }
        return buildFailureJson(StatusConstant.SUCCESS_CODE,"评价成功");
    }


    /**
     * 评论列表
     * @param type 评论类型
     * @param objectId 被评论的id
     * @param pageNO 页码
     * @param pageSize 条数
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public ViewData list(Integer type, Integer objectId, Integer pageNO,Integer pageSize){
        try {
            Page<Evaluate> evaluatePage = evaluateService.list(type, objectId, pageNO, pageSize);
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",evaluatePage);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("服务器超时，评价失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取失败");
        }
    }

    /**
     * 获取评分
     * @param type
     * @param objectId
     * @return
     */
    @RequestMapping("/getAvgScore")
    @ResponseBody
    public ViewData getAvgScore(Integer type, Integer objectId){
        try {
            Map<String,Object> map = evaluateService.getAvgScore(type, objectId);
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,"评价成功",map);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("服务器超时，评价失败",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，评价失败");
        }
    }



}
