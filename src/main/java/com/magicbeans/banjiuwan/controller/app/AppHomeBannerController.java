package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.HomeBannerService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 首页Banner图
 * Created by Eric Xie on 2017/2/28 0028.
 */
@Controller
@RequestMapping("/app/homeBanner")
public class AppHomeBannerController extends BaseController {


    @Resource
    private HomeBannerService homeBannerService;

    /**
     *
     * @param flag 0:首页的banner 1:未登录时 弹出来的banner 2：发现banner 3:实时菜价banner
     * @return
     */
    @RequestMapping("/getBanner")
    public @ResponseBody ViewData getHomeBanner(Integer flag){
        if(null == flag){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                homeBannerService.queryBannerByType(flag));
    }
}
