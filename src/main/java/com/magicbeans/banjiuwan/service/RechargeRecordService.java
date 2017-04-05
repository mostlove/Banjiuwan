package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.RechargeRecord;
import com.magicbeans.banjiuwan.mapper.IRechargeRecordMapper;
import com.magicbeans.banjiuwan.util.DateUtil;
import com.magicbeans.banjiuwan.util.ExcelUtil;
import net.sf.json.JSONArray;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/9 0009.
 */
@Service
public class RechargeRecordService {

    @Resource
    private IRechargeRecordMapper rechargeRecordMapper;

    @Transactional
    public Integer  addRechargeRecord(RechargeRecord rechargeRecord){
        rechargeRecordMapper.addRechargeRecord(rechargeRecord);
        return rechargeRecord.getId();
    }


    public void updateRechargeRecord(RechargeRecord rechargeRecord){
        rechargeRecordMapper.updateRechargeRecord(rechargeRecord);
    }

    public RechargeRecord queryRechargeRecord(Integer id){
        return rechargeRecordMapper.queryRechargeRecordById(id);
    }


    public Page<RechargeRecord> queryRechargeRecordForWeb(String userName, String phoneNumber, Integer pageNO, Integer pageSize,
                                                          Integer payMethod, Integer status, Date startTime,Date endTime){
        List<RechargeRecord> dataList = rechargeRecordMapper.queryRechargeRecordForWeb(userName,phoneNumber,(pageNO - 1) * pageSize,
                pageSize,payMethod,status,startTime,endTime);
        Integer count = rechargeRecordMapper.countRechargeRecordForWeb(userName,phoneNumber,payMethod,status,startTime,endTime);
        Integer totalPage = count % pageSize == 0 ?  count / pageSize : count / pageSize + 1;
        return new Page<RechargeRecord>(dataList,count,totalPage);
    }


    /**
     *  导出数据
     * @param response
     * @param userName
     * @param phoneNumber
     * @param payMethod
     * @param status
     * @param startTime
     * @param endTime
     * @param titlesArr
     * @param columnsArr
     * @throws Exception
     */
    public void exportRechargeRecord(HttpServletResponse response, String userName, String phoneNumber, Integer payMethod, Integer status,
                                     Date startTime, Date endTime,String titlesArr,String columnsArr) throws Exception{

        List<RechargeRecord> dataList = rechargeRecordMapper.queryRechargeRecordForWeb(userName,phoneNumber,null,
                null,payMethod,status,startTime,endTime);
        for (RechargeRecord rechargeRecord : dataList){
            if(null != rechargeRecord.getUser()){
                rechargeRecord.setUserName(rechargeRecord.getUser().getUserName());
                rechargeRecord.setPhoneNumber(rechargeRecord.getUser().getPhoneNumber());
            }
        }
        // 拼装数据
        List<String> titles = new ArrayList<String>();
        JSONArray titleJSONArr = JSONArray.fromObject(titlesArr);
        for (Object obj : titleJSONArr){
            titles.add(obj.toString());
        }

        JSONArray columnsArrJSONArr = JSONArray.fromObject(columnsArr);
        List<List<String>> contents = new ArrayList<List<String>>();  // 数据行集合
        for (RechargeRecord rechargeRecord : dataList){
            List<String> rows = new ArrayList<String>();
            for (Object column : columnsArrJSONArr){
                Field field = rechargeRecord.getClass().getDeclaredField(column.toString());
                field.setAccessible(true);
                if(field.getName().equals("status")){
                    rows.add(Integer.parseInt(field.get(rechargeRecord).toString()) == 0 ? "未支付" : "支付成功");
                }
                else if(field.getName().equals("payMethod")){
                    rows.add(Integer.parseInt(field.get(rechargeRecord).toString()) == 0 ? "微信支付" : "支付宝支付");
                }
                else if(field.getName().equals("createTime")){
                    rows.add(DateUtil.DateTime((Date)field.get(rechargeRecord),"yyyy-MM-dd HH:mm:ss"));
                }
                else {
                    rows.add(field.get(rechargeRecord).toString());
                }
            }
            contents.add(rows);
        }
        // 生成 并导出 数据
        ExcelUtil.createExcel(response,titles,contents);
    }


    /**
     * 填写备注 （财务确认收款）
     * @param id
     * @param reMarket
     */
    public void saveReMarket(Integer id,String reMarket){
        rechargeRecordMapper.saveReMarket(id, reMarket);
    }
}
