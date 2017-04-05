package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.VegetablesHouseService;
import com.magicbeans.banjiuwan.service.VegetablesPriceService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 实时菜价
 * Created by Eric Xie on 2017/3/10 0010.
 */

@Controller
@RequestMapping("/app/vegetablesPrice")
public class AppVegetablesPriceController extends BaseController {

    @Resource
    private VegetablesPriceService vegetablesPriceService;
    @Resource
    private VegetablesHouseService vegetablesHouseService;

    /**
     *  获取实时菜价列表
     * @param vegetablesId
     * @param time
     * @return
     */
    @RequestMapping("/getVegetablesPrice")
    public @ResponseBody ViewData getVegetablesPrice(Integer vegetablesId,Long time){
        Date date = time == null ? null : new Date(time * 1000);
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString(),
                vegetablesPriceService.queryVegetablesPriceByItem(vegetablesId,date));

    }

    /**
     *  获取所有的蔬菜
     * @return
     */
    @RequestMapping("/getVegetablesHouse")
    public @ResponseBody ViewData getVegetablesHouse(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE, ReturnMessage.MSG_SUCCESS.toString(),
                vegetablesHouseService.getAllVegetablesHouse());
    }





}
