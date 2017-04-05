package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.*;
import com.magicbeans.banjiuwan.mapper.INewUserCouponMapper;
import com.magicbeans.banjiuwan.mapper.IRechargeRecordMapper;
import com.magicbeans.banjiuwan.mapper.IUserCouponMapper;
import com.magicbeans.banjiuwan.mapper.IUserMapper;
import com.magicbeans.banjiuwan.util.*;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * 用户管理 业务层
 * Created by Eric Xie on 2017/2/13 0013.
 */

@Service
public class UserService {

    @Resource
    private IUserMapper userMapper;
    @Resource
    private INewUserCouponMapper newUserCouponMapper;
    @Resource
    private IUserCouponMapper userCouponMapper;
    @Resource
    private IRechargeRecordMapper rechargeRecordMapper;


    /**
     *  分页统计 用户
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<ConsumptionStatistics> statisticsUser(Integer pageNO,Integer pageSize,String userName ,String mobile,
                                                      Date startTime,Date endTime){
        List<ConsumptionStatistics> dataList = null;
        Integer count = 0;
        Integer totalPage = 1;
        endTime = DateUtil.getNextDay(endTime,1);
        if(null != pageNO && null != pageSize){
            dataList = userMapper.statisticsUser( (pageNO - 1) * pageSize,pageSize,userName,mobile,startTime,endTime);
            count = userMapper.countStatisticsUser(userName,mobile);
            totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        }
        else{
            dataList = userMapper.statisticsUser(null,null,userName,mobile,startTime,endTime);
            count = userMapper.countStatisticsUser(userName,mobile);
        }
        return new Page<ConsumptionStatistics>(dataList,count,totalPage);
    }

    /**
     *  导出数据 消费统计
     * @param response
     * @param userName
     * @param mobile
     * @throws Exception
     */
    public void exportStatistics(HttpServletResponse response, String valueArray, String titleArray,
                                     String userName ,String mobile,Date startTime,Date endTime) throws Exception{
        endTime = DateUtil.getNextDay(endTime,1);
        List<ConsumptionStatistics> dataList = userMapper.statisticsUser( null,null,userName,mobile,startTime,endTime);
        // 拼装数据
        List<String> titles = new ArrayList<String>();
        JSONArray titleJSONArr = JSONArray.fromObject(titleArray);
        for (Object obj : titleJSONArr){
            titles.add(obj.toString());
        }

        JSONArray columnsArrJSONArr = JSONArray.fromObject(valueArray);
        List<List<String>> contents = new ArrayList<List<String>>();  // 数据行集合
        for (ConsumptionStatistics statistics : dataList){
            List<String> rows = new ArrayList<String>();
            for (Object column : columnsArrJSONArr){
                Field field = statistics.getClass().getDeclaredField(column.toString());
                field.setAccessible(true);
                rows.add(null == field.get(statistics) || field.get(statistics) == "" ? "" : field.get(statistics).toString());
            }
            contents.add(rows);
        }
        // 生成 并导出 数据
        ExcelUtil.createExcel(response,titles,contents);
    }






    /**
     *  新增用户
     * @param user
     * @return 新增用户的ID
     */
    @Transactional
    public Integer register(User user){
        userMapper.addUser(user);
        // 注册之后 发放 新用户优惠券
        List<NewUserCoupon> coupons = newUserCouponMapper.queryAll();
        if(null != coupons && coupons.size() > 0){
            List<UserCoupon> userCoupons = new ArrayList<UserCoupon>();
            for (NewUserCoupon coupon: coupons) {
                UserCoupon temp = new UserCoupon();
                temp.setIsValid(StatusConstant.VALID_YES);
                temp.setCouponId(coupon.getCouponId());
                temp.setDays(coupon.getDays());
                temp.setText("新用户注册抵用券");
                temp.setUserId(user.getId());
                temp.setStartTime(DateUtil.getMill(null));
                temp.setEndTime(DateUtil.getMill(DateUtil.getNextDay(new Date(),coupon.getDays())));
                userCoupons.add(temp);
            }
            if(userCoupons.size() > 0){
                userCouponMapper.batchAddUserCoupon(userCoupons);
            }
        }
        return user.getId();
    }

    /**
     *  根据ID  更新不为空的字段
     * @param user
     */
    public void update(User user){
        userMapper.updateUser(user);
    }

    /**
     *  根据 手机号 和 密码 查询用户
     * @param phoneNumber
     * @param password 可为空
     * @return
     */
    public User queryByPhone(String phoneNumber,String password){
        return userMapper.queryByPhoneAndPwd(phoneNumber,password);
    }


    /**
     *  移动端分页获取 当前用户的 有效券信息
     * @param pageNO
     * @param pageSize
     * @param userId
     * @return
     */
    public List<UserCoupon> queryByPage(Integer pageNO,Integer pageSize,Integer userId){
        return userCouponMapper.queryByUser(DateUtil.getMill(null),userId,(pageNO - 1) * pageSize,pageSize);
    }

    /**
     *  web端 分页条件查询用户信息
     * @param phoneNumber 电话号码
     * @param userName 用户名
     * @param pageNO 页码
     * @param pageSize 页数
     * @return
     */
    public Page<User> queryByWebPage(String phoneNumber,String userName,Integer pageNO,Integer pageSize){
        List<User> users = userMapper.queryByPage(phoneNumber,userName,(pageNO - 1) * pageSize,pageSize);
        Integer count = userMapper.countByPage(phoneNumber,userName);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<User>(users,count,totalPage);
    }


    /**
     *  导出数据 用户管理
     * @param response
     * @param userName
     * @param phoneNumber
     * @throws Exception
     */
    public void exportUserExcel(HttpServletResponse response, String valueArray, String titleArray,
                                 String userName ,String phoneNumber) throws Exception{

        List<User> dataList = userMapper.queryByPage(phoneNumber,userName,null,null);
        // 拼装数据
        List<String> titles = new ArrayList<String>();
        JSONArray titleJSONArr = JSONArray.fromObject(titleArray);
        for (Object obj : titleJSONArr){
            titles.add(obj.toString());
        }

        JSONArray columnsArrJSONArr = JSONArray.fromObject(valueArray);
        List<List<String>> contents = new ArrayList<List<String>>();  // 数据行集合
        for (User user : dataList){
            List<String> rows = new ArrayList<String>();
            for (Object column : columnsArrJSONArr){

                if (column.toString().equals("createTime")) {
                    rows.add(Timestamp.DateTimeStamp(user.getCreateTime(),"yyyy-MM-dd HH:mm:ss"));
                    continue;
                }
                if (column.toString().equals("lastLogin")) {
                    if (user.getLastLogin() != null) {
                        rows.add(Timestamp.DateTimeStamp(user.getLastLogin(),"yyyy-MM-dd HH:mm:ss"));
                    }
                    continue;
                }
                if (column.toString().equals("balance")) {
                    rows.add("￥" + user.getBalance());
                    continue;
                }

                Field field = user.getClass().getDeclaredField(column.toString());
                field.setAccessible(true);
                rows.add(null == field.get(user) || field.get(user) == "" ? "" : field.get(user).toString());
            }
            contents.add(rows);
        }
        // 生成 并导出 数据
        ExcelUtil.createExcel(response,titles,contents);
    }

    public User queryUserById(Integer id){
        return userMapper.queryUserById(id);
    }

    @Transactional
    public void updateUserRechargeService(RechargeRecord rechargeRecord){
        rechargeRecord.setStatus(1);
        rechargeRecordMapper.updateRechargeRecord(rechargeRecord);
        // 添加会员金额
        User user = userMapper.queryUserById(rechargeRecord.getUserId());
        User temp = new User();
        temp.setId(user.getId());
        temp.setBalance(user.getBalance() == null ? 0 : user.getBalance() + rechargeRecord.getBalance() + rechargeRecord.getGiveBalance());
        userMapper.updateUser(temp);
        // 更新缓存
        Object obj = LoginHelper.getCurrentUser(user.getToken());
        if(null != obj && (obj instanceof User)){
            User user1 = (User)obj;
            user1.setBalance(temp.getBalance());
            LoginHelper.replaceToken(user.getToken(),user1);
        }
    }

    /**
     * 获取用户详情
     * @param id
     * @return
     */
    public User getUserByIdForWeb(Integer id) {
        return userMapper.getUserByIdForWeb(id);
    }

    /**
     * 填写备注 （财务确认收款）
     * @param id
     * @param reMarket
     */
    public void saveReMarket(Integer id,String reMarket){
        userMapper.saveReMarket(id, reMarket);
    }

}
