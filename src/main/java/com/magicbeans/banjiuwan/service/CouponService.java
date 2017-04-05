package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.*;
import com.magicbeans.banjiuwan.mapper.ICouponFoodCategoryMapper;
import com.magicbeans.banjiuwan.mapper.ICouponMapper;
import com.magicbeans.banjiuwan.mapper.INewUserCouponMapper;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.DateUtil;
import com.magicbeans.banjiuwan.util.ExcelUtil;
import com.magicbeans.banjiuwan.util.Timestamp;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 * 优惠券 业务层
 * Created by Eric Xie on 2017/3/3 0003.
 */

@Service
public class CouponService {



    @Resource
    private ICouponMapper couponMapper;
    @Resource
    private ICouponFoodCategoryMapper couponFoodCategoryMapper;
    @Resource
    private INewUserCouponMapper newUserCouponMapper;


    /**
     *  分页获取 优惠券使用情况
     * @param type
     * @param phoneNumber
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<CouponUseDetail> getCouponUseDetail(Integer type,String phoneNumber,
                                                    Integer isValid,Integer startTimes,Integer endTimes,
                                                    Integer pageNO,Integer pageSize){
        List<CouponUseDetail> dataList = couponMapper.queryCouponUseDetail(phoneNumber,type,isValid,startTimes,endTimes,(pageNO - 1) * pageSize,pageSize);
        Integer count = couponMapper.countCouponUseDetail(phoneNumber,type,isValid,startTimes,endTimes);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<CouponUseDetail>(dataList,count,totalPage);
    }




    /**
     *  导出数据 消费统计
     * @param response
     * @throws Exception
     */
    public void exportCouponUseDetail(HttpServletResponse response, String valueArray, String titleArray,
                                 Integer type,String phoneNumber,
                                 Integer isValid,Integer startTimes,Integer endTimes) throws Exception{

        List<CouponUseDetail> dataList = couponMapper.queryCouponUseDetail(phoneNumber,type,isValid,startTimes,endTimes,null ,null);

        // 拼装数据
        List<String> titles = new ArrayList<String>();
        JSONArray titleJSONArr = JSONArray.fromObject(titleArray);
        for (Object obj : titleJSONArr){
            titles.add(obj.toString());
        }

        JSONArray columnsArrJSONArr = JSONArray.fromObject(valueArray);
        List<List<String>> contents = new ArrayList<List<String>>();  // 数据行集合
        for (CouponUseDetail coupon : dataList){
            List<String> rows = new ArrayList<String>();
            for (Object column : columnsArrJSONArr){


                if (column.toString().equals("userName")) {
                    rows.add(coupon.getUserName()+"("+coupon.getPhoneNumber()+")");
                    continue;
                }
                if (column.toString().equals("type")) {
                    rows.add(coupon.getType() == 0 ? "优惠券" : "现金券");
                    continue;
                }
                if (column.toString().equals("needSpend")) {
                    rows.add(coupon.getNeedSpend() == null ? "暂无" : "消费"+coupon.getNeedSpend()+"才能使用");
                    continue;
                }
                if (column.toString().equals("isValid")) {
                    rows.add(coupon.getIsValid() == 0 ? "已使用" : "未使用");
                    continue;
                }
                if (column.toString().equals("startTime")) {

                    String startTime = Timestamp.TimeStamp2Date(coupon.getStartTime().toString(),"yyyy-MM-dd");

                    String endTime = Timestamp.TimeStamp2Date(coupon.getEndTime().toString(),"yyyy-MM-dd");
                    rows.add(startTime + "到" + endTime);
                    continue;
                }
                Field field = coupon.getClass().getDeclaredField(column.toString());
                field.setAccessible(true);



                rows.add(null == field.get(coupon) || field.get(coupon) == "" ? "" : field.get(coupon).toString());
            }
            contents.add(rows);
        }
        // 生成 并导出 数据
        ExcelUtil.createExcel(response,titles,contents);
    }

    /**
     *  新增优惠券
     * @param coupon
     */
    public void addCoupon(Coupon coupon){

        if(coupon.getType() == 1){
            coupon.setNeedSpend(null);
        }
        couponMapper.addCoupon(coupon);
        if(!CommonUtil.isEmpty(coupon.getUseInterval())){
            List<CouponFoodCategory> couponFoodCategories = new ArrayList<CouponFoodCategory>();
            JSONArray jsonArray = JSONArray.fromObject(coupon.getUseInterval());
            for (Object obj : jsonArray){
                Integer temp = Integer.valueOf(obj.toString());
                CouponFoodCategory cf = new CouponFoodCategory();
                cf.setFoodCategoryId(temp);
                cf.setCouponId(coupon.getId());
                couponFoodCategories.add(cf);
            }
            if(couponFoodCategories.size() > 0){
                couponFoodCategoryMapper.batchAddCouponCategory(couponFoodCategories);
            }
        }

    }


    public void updateCoupon(Coupon coupon){
        couponMapper.updateCoupon(coupon);
    }

    /**
     * 分页获取
     * @param type
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<Coupon> queryAllCouponPage(Integer type,Integer pageNO,Integer pageSize){
        List<Coupon> dataList = couponMapper.queryAllCoupon(type,(pageNO - 1) * pageSize,pageSize);
        // 封装类型
        Integer count = couponMapper.countAllCoupon(type);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<Coupon>(dataList,count,totalPage);
    }

    @Transactional
    public void delCoupon(Integer id){
        couponMapper.delCoupon(id);
        couponFoodCategoryMapper.delConponCategoryByCouponId(id);
    }


    public List<Coupon> queryAllCouponByType(Integer type) {
        return couponMapper.queryAllCoupon(type,null,null);
    }

    public Coupon info (Integer id) {
        return couponMapper.info(id);
    }
}
