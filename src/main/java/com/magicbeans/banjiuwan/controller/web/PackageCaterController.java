package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.PackageCater;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.PackageCaterService;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 *
 *  套餐 坝坝宴 控制
 * Created by Eric Xie on 2017/2/21 0021.
 */

@Controller
@RequestMapping("/web/package")
public class PackageCaterController extends BaseController {


    @Resource
    private PackageCaterService packageCaterService;


    @RequestMapping("/getData")
    public @ResponseBody ViewData getPackageList(Integer pageNO, Integer pageSize, String name, Integer categoryId){

        if(null == pageNO || null == pageSize){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        name = CommonUtil.isEmpty(name) ? null : name;
        Page<PackageCater> data = packageCaterService.queryPage(name,categoryId,pageNO,pageSize);
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),data);
    }

    /**
     *  删除数据
     * @param id
     * @return
     */
    @RequestMapping("/delPackage")
    public @ResponseBody ViewData delPackage(Integer id,Integer foodCategoryId){
        if(null == id || null == foodCategoryId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
       try {
           packageCaterService.delPackageCater(id,foodCategoryId);
       }catch (Exception e){
           e.printStackTrace();
           return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
       }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/addPackage")
    public @ResponseBody ViewData addPackage(PackageCater packageCater){
        try {
            Integer count = packageCaterService.addPackageCenter(packageCater);
            if(count == 0){
                return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
            }
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/updatePackage")
    public @ResponseBody ViewData updatePackage(PackageCater packageCater){
        if(null == packageCater.getId()){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL, ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            packageCaterService.updatePackageCenter(packageCater);
        }catch (Exception e){
            e.printStackTrace();
            return buildFailureJson(StatusConstant.Fail_CODE,ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }



}
