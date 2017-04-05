package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.MapList;
import com.magicbeans.banjiuwan.beans.OrderTimeConfig;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.MapListService;
import com.magicbeans.banjiuwan.util.ReturnMessage;
import com.magicbeans.banjiuwan.util.StatusConstant;
import com.magicbeans.banjiuwan.util.ViewData;
import net.sf.json.JSONArray;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by Eric Xie on 2017/3/2 0002.
 */

@Controller
@RequestMapping("/web/mapList")
public class MapListController extends BaseController {

    @Resource
    private MapListService mapListService;

    private Logger logger = Logger.getLogger(this.getClass());

    @RequestMapping("/addMapList")
    public @ResponseBody ViewData addMapList(MapList mapList){
        try {
//            JSONArray jsonArray = JSONArray.fromObject(mapList.getMapList());
//            if(jsonArray.size() > 50){
//                return buildFailureJson(StatusConstant.Fail_CODE,"最多只能设置50个点");
//            }
            mapListService.addMapList(mapList);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }



    @RequestMapping("/delMapList")
    public @ResponseBody ViewData delMapList(Integer  id){
        if(null == id ){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            mapListService.delMapList(id);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }

    @RequestMapping("/updateMapList")
    public @ResponseBody ViewData updateMapList(MapList mapList){
        if(null == mapList.getId() ){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        try {
            mapListService.updateMapList(mapList);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE, ReturnMessage.MSG_FAIL.toString());
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString());
    }


    @RequestMapping("/queryMapList")
    public @ResponseBody ViewData queryMapList(Integer pageNO,Integer pageSize ){
        if(null == pageNO || null == pageSize ){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,ReturnMessage.MSG_FIELD_NOT_NULL.toString());
        }
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,ReturnMessage.MSG_SUCCESS.toString(),
                mapListService.queryMapListPage(pageNO,pageSize));
    }








}
