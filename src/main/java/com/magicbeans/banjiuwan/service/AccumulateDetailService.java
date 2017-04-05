package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.AccumulateDetail;
import com.magicbeans.banjiuwan.beans.OrderSales;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.mapper.IAccumulateDetailMapper;
import com.magicbeans.banjiuwan.util.ExcelUtil;
import com.magicbeans.banjiuwan.util.Timestamp;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/24 0024.
 */
@Service
public class AccumulateDetailService {

    @Resource
    private IAccumulateDetailMapper accumulateDetailMapper;



    public Page<AccumulateDetail> getAccumulateDetail(String phoneNumber, Date startTime,Date endTime,Integer pageNO,Integer pageSize){
        List<AccumulateDetail> dataList = accumulateDetailMapper.queryAccumulateDetailByItem(phoneNumber,startTime,endTime
        ,(pageNO - 1) * pageSize,pageSize);
        Integer count = accumulateDetailMapper.countAccumulateDetailByItem(phoneNumber,startTime,endTime);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<AccumulateDetail>(dataList,count,totalPage);
    }

    /**
     *  导出数据 积分明细
     * @param response
     * @throws Exception
     */
    public void exportExcel(HttpServletResponse response, String valueArray, String titleArray,
                                      String phoneNumber, Date startTime ,Date endTime) throws Exception{

        List<AccumulateDetail> dataList = accumulateDetailMapper.queryAccumulateDetailByItem(phoneNumber,startTime,endTime,
                null,null);
        // 拼装数据
        List<String> titles = new ArrayList<String>();
        JSONArray titleJSONArr = JSONArray.fromObject(titleArray);
        for (Object obj : titleJSONArr){
            titles.add(obj.toString());
        }

        JSONArray columnsArrJSONArr = JSONArray.fromObject(valueArray);
        List<List<String>> contents = new ArrayList<List<String>>();  // 数据行集合
        for (AccumulateDetail a : dataList){
            List<String> rows = new ArrayList<String>();
            for (Object column : columnsArrJSONArr){

                if (column.toString().equals("createTime")) {
                    rows.add(Timestamp.DateTimeStamp(a.getCreateTime(),"yyyy-MM-dd HH:mm:ss"));
                    continue;
                }

                if (column.toString().equals("type")) {
                    rows.add(a.getType() == 0 ? "新增" : "减去");
                    continue;
                }

                Field field = a.getClass().getDeclaredField(column.toString());
                field.setAccessible(true);
                rows.add(null == field.get(a) || field.get(a) == "" ? "" : field.get(a).toString());
            }
            contents.add(rows);
        }
        // 生成 并导出 数据
        ExcelUtil.createExcel(response,titles,contents);
    }

}
