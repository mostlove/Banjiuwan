package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.HomeBanner;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.HomeBannerService;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 首页Banner 控制器
 * Created by Eric Xie on 2017/2/16 0016.
 */

@Controller
@RequestMapping("/web/homeBanner")
public class HomeBannerController extends BaseController {

    @Resource
    private HomeBannerService homeBannerService;

    @RequestMapping("/getBanners")
    @ResponseBody
    public ViewData getBanners(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                homeBannerService.queryBannerByPage());
    }


    /**
     *  添加首页Banner
     * @param title title
     * @param type 类型 0: 首页 1：弹出Banner
     * @param banner banner地址
     * @param content 内容
     * @return
     */
    @RequestMapping("/addHomeBanner")
    @ResponseBody
    public ViewData addBanner(String title,Integer type,String banner,String content){
        if(CommonUtil.isEmpty(title,banner,content) || null == type){
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_DATA_FAIL.toString());
        }
        Integer count = homeBannerService.countBanner(type);

        if(type == 0 || type == 2 || type == 3){
            if(count > 10){
                return buildFailureJson(StatusConstant.Fail_CODE,"请删除一些轮播图再添加.");
            }
        }
        else{
            if(count >= 1){
                return buildFailureJson(StatusConstant.Fail_CODE,"首页弹出只允许添加一张.");
            }
        }
        HomeBanner homeBanner = new HomeBanner();
        homeBanner.setBanner(banner);
        homeBanner.setContent(content);
        homeBanner.setTitle(title);
        homeBanner.setType(type);
        homeBanner.setCreateTime(new Date());
        homeBannerService.addHomeBanner(homeBanner);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/delBanner")
    public @ResponseBody ViewData delBanner(Integer id){
        if(null == id){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        homeBannerService.delHomeBanner(id);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    @RequestMapping("/updateHomeBanner")
    public @ResponseBody ViewData updateHomeBanner(HomeBanner homeBanner){
        if(null == homeBanner.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        homeBannerService.updateHomeBanner(homeBanner);
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

}
