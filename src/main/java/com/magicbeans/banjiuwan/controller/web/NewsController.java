package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.News;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.NewsService;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 精品生活 控制器
 * Created by Eric Xie on 2017/2/27 0027.
 */
@Controller
@RequestMapping("/web/news")
public class NewsController extends BaseController {

    @Resource
    private NewsService newsService;


    /**
     *  新增
     * @param news
     * @return
     */
    @RequestMapping("/add")
    public @ResponseBody ViewData addNews(News news){
        try {
            newsService.addNews(news);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString());
    }

    /**
     *  删除
     * @param id
     * @return
     */
    @RequestMapping("/delNews")
    public @ResponseBody ViewData delNews(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            newsService.delNews(id);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString());
    }

    @RequestMapping("/queryList")
    public @ResponseBody ViewData queryList(String title,Integer pageNO,Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        title = CommonUtil.isEmpty(title) ? null : title;
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                newsService.queryByItem(title,pageNO,pageSize));
    }

    @RequestMapping("/updateNews")
    public @ResponseBody ViewData updateNews(News news){
        if(null == news.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            newsService.updateNews(news);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/queryById")
    public @ResponseBody ViewData queryById(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                newsService.queryById(id));
    }
}
