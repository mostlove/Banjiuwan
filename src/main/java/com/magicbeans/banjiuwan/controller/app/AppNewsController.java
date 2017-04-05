package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.NewsService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 精品生活 移动端接口
 * Created by Eric Xie on 2017/2/28 0028.
 */

@Controller
@RequestMapping("/app/news")
public class AppNewsController extends BaseController {

    @Resource
    private NewsService newsService;


    /**
     *  分页查询 精品生活页
     * @param pageNO
     * @param pageSize
     * @return
     */
    @RequestMapping("/queryNews")
    public @ResponseBody ViewData queryNews(Integer pageNO, Integer pageSize){
        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                newsService.queryNewsPage(pageNO,pageSize));
    }
    /**
     *  分页查询 精品生活页
     * @return
     */
    @RequestMapping("/queryNewsById")
    public @ResponseBody ViewData queryNewsById(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                newsService.queryById(id));
    }

}
