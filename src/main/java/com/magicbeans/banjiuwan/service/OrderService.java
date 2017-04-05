package com.magicbeans.banjiuwan.service;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradeRefundRequest;
import com.alipay.api.response.AlipayTradeRefundResponse;
import com.magicbeans.banjiuwan.aop.ServiceAopLog;
import com.magicbeans.banjiuwan.beans.*;
import com.magicbeans.banjiuwan.enumutil.FoodCategoryEnum;
import com.magicbeans.banjiuwan.enumutil.PayMethodEnum;
import com.magicbeans.banjiuwan.mapper.*;
import com.magicbeans.banjiuwan.util.*;
import com.magicbeans.banjiuwan.wx.WeChatConfig;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.net.ssl.SSLContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Field;
import java.security.KeyStore;
import java.util.*;

/**
 * 订单业务层
 * Created by Eric Xie on 2017/3/2 0002.
 */
@Service
public class OrderService {


    @Resource
    private IOrderMapper orderMapper;
    @Resource
    private IShopCarMapper shopCarMapper;
    @Resource
    private IUserCouponMapper userCouponMapper;
    @Resource
    private IUserMapper userMapper;
    @Resource
    private IAllConfigMapper allConfigMapper;
    @Resource
    private IOrderCookMapper orderCookMapper;
    @Resource
    private ISingleFoodMapper singleFoodMapper;
    @Resource
    private IPackageCaterMapper packageCaterMapper;
    @Resource
    private ISpecialActMapper specialActMapper;
    @Resource
    private IAdminUserMapper adminUserMapper;
    @Resource
    private IFoodCategoryMapper foodCategoryMapper;
    @Resource
    private ICookMapper cookMapper;
    @Resource
    private IAccumulateDetailMapper accumulateDetailMapper;

    private Logger logger = Logger.getLogger(this.getClass());


    /**
     *  微信客户端支付 后台退款业务逻辑处理
     * @param order
     * @param user
     * @return -1 处理失败   1 处理成功
     */
    @Transactional
    public  void updateWeChatClientPayRefund(Order order,User user) throws Exception{
        if(!OrderConstant.ORDER_CANCLE_ING.equals(order.getStatus())){
            throw new Exception("订单状态异常");
        }
        if(OrderConstant.PENDING_PAY.equals(order.getStatus())){

            cancelOrder(user,order);
            return;
        }
        // 组装数据
        SortedMap<String,Object> parameters = new TreeMap<String,Object>();
        parameters.put("appid",  WeChatConfig.getValue("appId"));
        parameters.put("mch_id",  WeChatConfig.getValue("mchId"));
        parameters.put("nonce_str", UUID.randomUUID().toString().replaceAll("-", ""));
        parameters.put("out_trade_no", order.getPayNumber());
        parameters.put("out_refund_no", CommonUtil.buildOrderNumber());
        parameters.put("total_fee", "1") ;
        parameters.put("refund_fee", "1");
        parameters.put("op_user_id", WeChatConfig.getValue("mchId"));
        String sign = WXUtil.getSign(parameters, (String)WeChatConfig.getValue("payKey"));
        parameters.put("sign", sign);
        String reuqestXml = XMLUtil.toXML(parameters);
        KeyStore keyStore  = KeyStore.getInstance("PKCS12");
        String filePath = OrderService.class.getClassLoader().getResource("").getPath();
        FileInputStream instream = new FileInputStream(new File(filePath+"wx_clientApiclient_cert.p12"));//放退款证书的路径
        try {
            keyStore.load(instream, WeChatConfig.getValue("mchId").toString().toCharArray());
        } finally {
            instream.close();
        }
        SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, WeChatConfig.getValue("mchId").toString().toCharArray()).build();
        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
                sslcontext,
                new String[] { "TLSv1" },
                null,
                SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
        CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
        try {
            HttpPost httpPost = new HttpPost(WXConfig.REFUND_URL);//退款接口

            StringEntity reqEntity  = new StringEntity(reuqestXml);
            // 设置类型
            reqEntity.setContentType("application/x-www-form-urlencoded");
            httpPost.setEntity(reqEntity);
            CloseableHttpResponse response = httpclient.execute(httpPost);
            try {
                HttpEntity entity = response.getEntity();
                if (entity != null) {
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(entity.getContent(),"UTF-8"));
                    StringBuffer sb = new StringBuffer();
                    String text;
                    while ((text = bufferedReader.readLine()) != null) {
                        sb.append(text);
                    }
                    Map<String,Object> content= XMLUtil.decodeXml(sb.toString());
                    if(content.get("result_code").equals("SUCCESS")){
                        // 退款成功  处理业务逻辑
                        cancelOrder(user,order);
                    }else{
                        throw new Exception("业务处理失败..");
                    }
                }
                EntityUtils.consume(entity);
            } finally {
                response.close();
            }
        } finally {
            httpclient.close();
        }
    }

    /**
     *  微信 后台退款业务逻辑处理
     * @param order
     * @param user
     * @return -1 处理失败   1 处理成功
     */
    @Transactional
    public  void updateWeChatPayRefund(Order order,User user) throws Exception{
        if(!OrderConstant.ORDER_CANCLE_ING.equals(order.getStatus())){
            throw new Exception("订单状态异常");
        }

        if(OrderConstant.PENDING_PAY.equals(order.getStatus())){
            cancelOrder(user,order);
            return;
        }
        // 组装数据
        SortedMap<String,Object> parameters = new TreeMap<String,Object>();
        parameters.put("appid", WXConfig.APP_ID);
        parameters.put("mch_id", WXConfig.MCH_ID);
        parameters.put("nonce_str", UUID.randomUUID().toString().replaceAll("-", ""));
        parameters.put("out_trade_no", order.getPayNumber());
        parameters.put("out_refund_no", CommonUtil.buildOrderNumber());
        parameters.put("total_fee", "1") ;
        parameters.put("refund_fee", "1");
        parameters.put("op_user_id", WXConfig.MCH_ID);
        String sign = WXUtil.getSign(parameters, WXConfig.KEY);
        parameters.put("sign", sign);
        String reuqestXml = XMLUtil.toXML(parameters);
        KeyStore keyStore  = KeyStore.getInstance("PKCS12");
        String filePath = OrderService.class.getClassLoader().getResource("").getPath();
        FileInputStream instream = new FileInputStream(new File(filePath+"apiclient_cert.p12"));//放退款证书的路径
        try {
            keyStore.load(instream, WXConfig.MCH_ID.toCharArray());
        } finally {
            instream.close();
        }
        SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, WXConfig.MCH_ID.toCharArray()).build();
        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
                sslcontext,
                new String[] { "TLSv1" },
                null,
                SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
        CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
        try {
            HttpPost httpPost = new HttpPost(WXConfig.REFUND_URL);//退款接口

            StringEntity reqEntity  = new StringEntity(reuqestXml);
            // 设置类型
            reqEntity.setContentType("application/x-www-form-urlencoded");
            httpPost.setEntity(reqEntity);
            CloseableHttpResponse response = httpclient.execute(httpPost);
            try {
                HttpEntity entity = response.getEntity();
                if (entity != null) {
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(entity.getContent(),"UTF-8"));
                    StringBuffer sb = new StringBuffer();
                    String text;
                    while ((text = bufferedReader.readLine()) != null) {
                        sb.append(text);
                    }
                    Map<String,Object> content= XMLUtil.decodeXml(sb.toString());
                    if(content.get("result_code").equals("SUCCESS")){
                        // 退款成功  处理业务逻辑
                        cancelOrder(user,order);
                    }else{
                        throw new Exception("业务处理失败..");
                    }
                }
                EntityUtils.consume(entity);
            } finally {
                response.close();
            }
        } finally {
            httpclient.close();
        }
    }


    /**
     *  支付方式为 支付宝的时候，支付宝退款 业务数据拼装
     *
     * @return
     */
    @Transactional
    public String updateAliPayRefund(Order order,String backCallAPI) throws Exception{

        if(!OrderConstant.ORDER_CANCLE_ING.equals(order.getStatus())){
            return "订单状态异常";
        }

        String batchNO = buildNO();
        Order temp = new Order();
        temp.setBatchNO(batchNO);
        temp.setId(order.getId());
        // 更新订单批次号
        orderMapper.updateOrder(temp);

        // 如果没有支付成功
        if(OrderConstant.PENDING_PAY.equals(order.getStatus())){
            User user = userMapper.queryUserById(order.getUserId());
            cancelOrder(user,order);
            return "操作成功";
        }

        // 拼装数据
//        String detail_data = order.getPayNumber()+"^"+order.getOtherPay()+"^正常退款";
        String detail_data = order.getPayNumber()+"^0.01^正常退款";
        Map<String, String> sParaTemp = new HashMap<String, String>();
        sParaTemp.put("service", AliPayConfig.REFUND_SERVICE);
        sParaTemp.put("partner", AliPayConfig.PARTNER);
        sParaTemp.put("_input_charset", AliPayConfig.CHARACTER);
        sParaTemp.put("notify_url", backCallAPI);
        sParaTemp.put("seller_user_id", AliPayConfig.PARTNER);
        sParaTemp.put("refund_date", DateUtil.DateTime(new Date(),"yyyy-MM-dd HH:mm:ss"));
        sParaTemp.put("batch_no", batchNO);
        sParaTemp.put("batch_num", "1");
        sParaTemp.put("detail_data", detail_data);
        Map<String, String> sPara = buildRequestPara(sParaTemp);
        List<String> keys = new ArrayList<String>(sPara.keySet());
        StringBuffer sbHtml = new StringBuffer();
        sbHtml.append("<form id=\"alipaysubmit\" name=\"alipaysubmit\" action=\"" + AliPayConfig.ALIPAY_GATEWAY_NEW
                + "_input_charset=" + "UTF-8" + "\" method=\"" + "GET"
                + "\">");
        for (int i = 0; i < keys.size(); i++) {
            String name =  keys.get(i);
            String value =  sPara.get(name);
            sbHtml.append("<input type=\"hidden\" name=\"" + name + "\" value=\"" + value + "\"/>");
        }
        String strButtonName = "确认支付";
        sbHtml.append("<input type=\"submit\" value=\"" + strButtonName + "\" style=\"display:none;\"></form>");
        sbHtml.append("<script>document.forms['alipaysubmit'].submit();</script>");
        return sbHtml.toString();
    }




    /**
     *  在线支付成功后的 业务处理
     * @param order
     * @param payMethod
     * @param out_trade_no
     */
    public void updateOrderForOnLinePay(Order order,Integer payMethod,String out_trade_no){
        // 更新订单信息
        Order temp = new Order();
        temp.setId(order.getId());
        temp.setPayMethod(payMethod);
        temp.setStatus(OrderConstant.PENDING_CONFIRM);
        temp.setPayNumber(out_trade_no);
        orderMapper.updateOrder(temp);

//        // 查询积分配置项数据
//        AllConfig allConfig = allConfigMapper.queryAllConfig();
//        // 兑换积分
//        Integer accumulate = (int)((order.getOtherPay() + order.getBalance()) *  allConfig.getYuan());
//        // 更新 用户积分
//        User user = userMapper.queryUserById(order.getUserId());
//        User tempUser = new User();
//        tempUser.setId(user.getId());
//        tempUser.setAccumulate(user.getAccumulate() + accumulate);
//        userMapper.updateUser(tempUser);
        //  锁定厨师
        if(null != order.getOtherPay() && order.getOtherPay() != 0){
            List<Cook> cooks = cookMapper.queryCookByServiceDate(DateUtil.DateTime(order.getServiceDate(),"HH:mm"),order.getServiceDate());
            if(null != cooks && cooks.size() > 0){
                OrderCook orderCook = new OrderCook();
                orderCook.setCookId(cooks.get(0).getId());
                orderCook.setOrderId(order.getId());
                orderCook.setIsLocking(1); // 设置此数据为锁定数据
                orderCookMapper.addOrderCook(orderCook);
            }
        }
        // 更新缓存中的积分
//        user.setAccumulate(tempUser.getAccumulate());
//        Object obj = LoginHelper.getCurrentUser(user.getToken());
//        if(null != obj && (obj instanceof User)){
//            User user1 = (User)obj;
//            user1.setAccumulate(user1.getAccumulate());
//            LoginHelper.replaceToken(user1.getToken(),user1);
//        }
    }



    @Transactional
    public void cancelOrder(User user,Order order) throws Exception{
        
        Order temp = new Order();
        temp.setId(order.getId());
        temp.setStatus(OrderConstant.ORDER_CANCLE);

        updateRollBackOrder(user,order);
        orderMapper.updateOrder(temp);
        // 重置缓存
        LoginHelper.replaceToken(user.getToken(),user);
        // 删除 订单派送的 厨师 同时也删除了 被锁定的厨师
        orderCookMapper.delByOrder(order.getId());
    }

    /**
     *  取消订单之后 回滚订单 里面的 积分、会员卡信息、优惠券、现金券
     */
    private void updateRollBackOrder(User user,Order order) throws Exception{

        if(null != order.getAccumulate() && order.getAccumulate() != 0){
           // 还原 积分
           // 获取积分配置
           JSONObject accumulateJSON = JSONObject.fromObject(order.getAccumulateConfig());
           // 被抵扣的积分
           Integer accumulate = (int)(accumulateJSON.getInt("accumulate") * order.getAccumulate());
           // 还原积分
           user.setAccumulate(user.getAccumulate() + accumulate);
           // 创建积分使用明细
            AccumulateDetail accumulateDetail = new AccumulateDetail();
            accumulateDetail.setUserId(user.getId());
            accumulateDetail.setType(1); // 增加
            accumulateDetail.setReason("取消订单："+order.getOrderNumber()+"退还积分 "+accumulate);
            accumulateDetail.setAccumulate(accumulate);
            accumulateDetailMapper.addAccumulateDetail(accumulateDetail);
        }

        if(null != order.getBalance() && order.getBalance() != 0){
            // 还原会员卡金额
            user.setBalance(user.getBalance() + order.getBalance());
        }

        List<Integer> userCoupons = new ArrayList<Integer>();
        if(null != order.getCashCoupon() && order.getCashCoupon() != 0){
            // 还原现金券
            userCoupons.add(order.getCashCouponId());
        }
        if(null != order.getCoupon() && order.getCoupon() != 0){
            // 还原优惠券
            userCoupons.add(order.getCouponId());
        }
        // 执行还原 券信息
        if(userCoupons.size() > 0){
            userCouponMapper.batchUpdateCouponIsValid(StatusConstant.VALID_YES,userCoupons);
        }
        User temp = new User();
        temp.setId(user.getId());
        temp.setBalance(user.getBalance());
        temp.setAccumulate(user.getAccumulate());
        userMapper.updateUser(temp);
    }




    public Order queryOrderById(Integer id){
        return orderMapper.queryOrderById(id);
    }


    /**
     *  用户 通过状态获取订单列表
     * @param userId
     * @param status
     * @param pageNO
     * @param pageSize
     * @return
     */
    public List<Order> getOrdersByUser(Integer userId,Integer status,Integer pageNO,Integer pageSize){
        return orderMapper.queryOrderByItem(userId,status,(pageNO - 1) * pageSize,pageSize);
    }




    /**
     *  厨师 通过状态获取订单列表
     * @param status
     * @param pageNO
     * @param pageSize
     * @return
     */
    public List<Order> getOrdersByCook(Integer cookId,Integer status,Integer pageNO,Integer pageSize){
        return orderMapper.queryOrderByCook(cookId,status,(pageNO - 1) * pageSize,pageSize);
    }






    /**
     *  新增订单
     * @param order
     */
    @Transactional
    public Integer addOrder(Order order, String shopCarIds, User user) throws Exception{
        // 数据验证
        if(order.getCoupon() != 0){
            if(null== order.getCouponId() || order.getCouponId() == 0){
                throw new Exception("数据验证失败");
            }
        }
        if(order.getCashCoupon() != 0){
            if(null== order.getCashCouponId() || order.getCashCouponId() == 0){
                throw new Exception("数据验证失败");
            }
        }
        User sqlUser = userMapper.queryUserById(user.getId());
        if(null == sqlUser){
            throw new Exception("用户不存在");
        }
        if(null != order.getAccumulateNum() && order.getAccumulateNum() != 0){
            // 检测用户积分是否够
            if(order.getAccumulateNum() > sqlUser.getAccumulate()){
                throw new Exception("积分不够");
            }
        }
        if(null != order.getBalance() && order.getBalance() != 0){
            // 检测用户余额是否够
            if(order.getBalance() > sqlUser.getBalance()){
                throw new Exception("余额不够");
            }
        }
        // 新增order
        // 初始化部分数据
        if(order.getOtherPay() == 0){
            order.setStatus(OrderConstant.PENDING_CONFIRM);
            order.setPayMethod(4);
        }else{
            order.setStatus(OrderConstant.PENDING_PAY);
        }
        order.setOrderNumber(CommonUtil.buildOrderNumber());
        order.setUserId(user.getId());
//        order.setOrderDetail(order.getOrderDetail().replaceAll("\\\\",""));
        orderMapper.addOrder(order);
        // 批量删除购物车 根据ID 集合
        String[] idArr = shopCarIds.split(",");
        List<Integer> ids = new ArrayList<Integer>();
        for (String str : idArr){
            ids.add(Integer.parseInt(str));
        }
        if(ids.size() > 0){
            shopCarMapper.batchDelShopCar(ids);
        }
        // 更新 优惠券、积分 、 余额 等信息
        if(order.getCoupon() != 0){
            // 更新优惠券
            UserCoupon coupon = new UserCoupon();
            coupon.setId(order.getCouponId());
            coupon.setIsValid(StatusConstant.VALID_NO);
            userCouponMapper.updateUserCoupon(coupon);
        }
        if(order.getCashCoupon() != 0){
            // 更新 现金券
            UserCoupon coupon = new UserCoupon();
            coupon.setId(order.getCashCouponId());
            coupon.setIsValid(StatusConstant.VALID_NO);
            userCouponMapper.updateUserCoupon(coupon);
        }
        User pendingUpdate = new User();
        if(null != order.getAccumulateNum() && order.getAccumulateNum() != 0){

            // 创建积分使用明细
            AccumulateDetail accumulateDetail = new AccumulateDetail();
            accumulateDetail.setUserId(user.getId());
            accumulateDetail.setAccumulate(order.getAccumulateNum());
            accumulateDetail.setType(0); // 减
            accumulateDetail.setReason("创建订单 :"+order.getOrderNumber()+"使用了"+order.getAccumulateNum()+"积分");
            accumulateDetailMapper.addAccumulateDetail(accumulateDetail);
            // 更新用户积分
            pendingUpdate.setId(user.getId());
            pendingUpdate.setAccumulate(sqlUser.getAccumulate() - order.getAccumulateNum());
            // 设置缓存数据
            user.setAccumulate(pendingUpdate.getAccumulate());
        }
        if(null != order.getBalance() && order.getBalance() != 0){
            pendingUpdate.setId(user.getId());
            pendingUpdate.setBalance(sqlUser.getBalance() - order.getBalance());
            // 设置缓存数据
            user.setBalance(pendingUpdate.getBalance());
        }
        // 执行更新
        if(null != pendingUpdate.getId()){
            userMapper.updateUser(pendingUpdate);
            // 更新缓存
            LoginHelper.replaceToken(user.getToken(),user);
        }
        // 当没有用支付宝支付时 锁定厨师
        if(null == order.getOtherPay() || order.getOtherPay() == 0){
            // 锁定 一个厨师
            OrderCook orderCook = new OrderCook();
            orderCook.setCookId(order.getMainCook().getId());
            orderCook.setOrderId(order.getId());
            orderCook.setIsLocking(1); // 设置此数据为锁定数据
            orderCookMapper.addOrderCook(orderCook);
            // 锁定厨师成功
        }
        return order.getId();
    }


    /**
     *  根据 订单的服务时间查询 订单集合 包含 此时刻的所有厨师
     * @param orderServiceDate
     * @return
     */
    public List<Order> queryCookByOrderServiceDate(Date orderServiceDate){
        return orderMapper.queryOrdersByServiceDate(orderServiceDate);
    }

    /**
     *  统计当前 时刻 的服务员
     * @param orderServiceDate
     * @return
     */
    public Integer countWaiterByServiceDate(Date orderServiceDate){
        Integer count = orderMapper.countWaiterByServiceDate(orderServiceDate);
        return count == null ? 0 : count;
    }


    /**
     *  后台 查询订单
     * @param status
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<Order> queryOrderForWeb(String status, String orderNumber, String userPhone,
                                        String payMethods,String startTimes,String endTimes,Integer pageNO,Integer pageSize,Integer type){

        Integer[]  statusInt = null;
        if (null != status && status.trim().length() > 0) {
            String[] s = status.split(",");
            statusInt= new Integer[s.length];
            for (int i = 0 ; i < s.length ; i ++) {
                statusInt[i] = Integer.parseInt(s[i]);
            }
        }
        Integer[]  payMethodInt = null;
        if (null != payMethods && payMethods.trim().length() > 0) {
            String[] p = payMethods.split(",");
            payMethodInt= new Integer[p.length];
            for (int i = 0 ; i < p.length ; i ++) {
                payMethodInt[i] = Integer.parseInt(p[i]);
            }
        }

        Date startTime = null;
        Date endTime = null;

        if (null != startTimes && startTimes.trim().length() > 0) {
            startTime = Timestamp.parseDate2(startTimes,"yyyy-MM-dd");
        }

        if (null != endTimes && endTimes.trim().length() > 0) {

            endTime = Timestamp.parseDate2(endTimes,"yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(endTime);
            calendar.add(Calendar.DATE, 1);
            endTime = calendar.getTime();
        }

        List<Order> dataList = orderMapper.queryOrderByItemForWeb(statusInt,orderNumber,userPhone,
                payMethodInt,type,startTime,endTime,(pageNO - 1) * pageSize, pageSize);
        Integer count = orderMapper.countOrderByItemForWeb(statusInt,orderNumber,userPhone,payMethodInt,type,startTime,endTime);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<Order>(dataList,count,totalPage);
    }

    @Transactional
    public void updateOrder(Order order,Order oldOrder){
        orderMapper.updateOrder(order);
        if(OrderConstant.FINISHED.equals(order.getStatus())){
            // 如果订单是完成状态后，更新销量
            if(!CommonUtil.isEmpty(oldOrder.getOrderDetail())){
                List<SingleFood> singleFoods = new ArrayList<SingleFood>();
                List<PackageCater> packages = new ArrayList<PackageCater>();
                List<SpecialAct> specialActs = new ArrayList<SpecialAct>();
                String detail = oldOrder.getOrderDetail().replaceAll("\\\\","");
                JSONArray orderDetailArr = JSONArray.fromObject(detail.substring(1,detail.length() - 1));
                for (Object obj : orderDetailArr){
                    JSONObject jsonObject = JSONObject.fromObject(obj);
                    Integer foodCategoryId = jsonObject.getInt("foodCategoryId");
                    List<FoodCategory> foodCategories = foodCategoryMapper.querySingleFoodCategory();
                    FoodCategory foodCategory = new FoodCategory();
                    foodCategory.setId(foodCategoryId);
                    if(foodCategories.contains(foodCategory)){
                        SingleFood singleFood = new SingleFood();
                        singleFood.setId(jsonObject.getInt("foodId"));
                        singleFood.setSales(jsonObject.getInt("number"));
                        singleFoods.add(singleFood);
                    }
                    else if(foodCategoryId == FoodCategoryEnum.PACKAGE.ordinal() || foodCategoryId == FoodCategoryEnum.BA_BA_YAN.ordinal()){
                        PackageCater packageCater = new PackageCater();
                        packageCater.setSales(jsonObject.getInt("number"));
                        packageCater.setId(jsonObject.getInt("foodId"));
                        packages.add(packageCater);
                    }
                    else if(foodCategoryId == FoodCategoryEnum.SPECIAL_ACT.ordinal()){
                        // 半餐演奏
                        SpecialAct packageCater = new SpecialAct();
                        packageCater.setSales(jsonObject.getInt("number"));
                        packageCater.setId(jsonObject.getInt("foodId"));
                        specialActs.add(packageCater);
                    }
                }
                // 批量更新销量
                if(singleFoods.size() > 0){
                    singleFoodMapper.batchUpdateSales(singleFoods);
                }

                if(packages.size() > 0){
                    packageCaterMapper.batchUpdateSales(packages);
                }
                if(specialActs.size() > 0){
                    specialActMapper.batchUpdateSale(specialActs);
                }
            }
            // 查询积分配置项数据
            AllConfig allConfig = allConfigMapper.queryAllConfig();
            // 兑换积分
            double otherPay = oldOrder.getOtherPay() == null ? 0.0 : oldOrder.getOtherPay();
            Integer accumulate = (int)(((oldOrder.getBalance()) + otherPay) *  allConfig.getYuan());
            // 更新 用户积分
            User user = userMapper.queryUserById(oldOrder.getUserId());
            User tempUser = new User();
            tempUser.setId(user.getId());
            tempUser.setAccumulate(user.getAccumulate() + accumulate);
            userMapper.updateUser(tempUser);
            // 创建积分使用明细
            AccumulateDetail accumulateDetail = new AccumulateDetail();
            accumulateDetail.setUserId(user.getId());
            accumulateDetail.setType(1); // ADD
            accumulateDetail.setAccumulate(accumulate);
            accumulateDetail.setReason("订单："+oldOrder.getOrderNumber()+"交易 使用金额:"+(oldOrder.getBalance() + otherPay)
                    +"兑换积分："+accumulate);
            accumulateDetailMapper.addAccumulateDetail(accumulateDetail);
            // 更新缓存中的积分
            Object obj = LoginHelper.getCurrentUser(user.getToken());
            if(null != obj && obj instanceof User){
                User cacheUser = (User)obj;
                cacheUser.setAccumulate(tempUser.getAccumulate());
                LoginHelper.replaceToken(cacheUser.getToken(),cacheUser);
            }
        }
        // 如果是线下支付
        if(OrderConstant.PENDING_CONFIRM.equals(order.getStatus()) && order.getPayMethod() == PayMethodEnum.Offline.ordinal()){

            //  锁定厨师
            if(null != oldOrder.getOtherPay() && oldOrder.getOtherPay() != 0){
                List<Cook> cooks = cookMapper.queryCookByServiceDate(DateUtil.DateTime(oldOrder.getServiceDate(),"HH:mm"),oldOrder.getServiceDate());
                if(null != cooks && cooks.size() > 0){
                    OrderCook orderCook = new OrderCook();
                    orderCook.setCookId(cooks.get(0).getId());
                    orderCook.setOrderId(oldOrder.getId());
                    orderCook.setIsLocking(1); // 设置此数据为锁定数据
                    orderCookMapper.addOrderCook(orderCook);
                }
            }


        }
    }

    /**
     *  更新订单
     * @param order
     */
    public void delOrderByUser(Order order){
        orderMapper.updateOrder(order);
    }


    /**
     *  查询订单  包括 厨师、用户、地址信息
     * @param id
     * @return
     */
    public Order queryOrderIncludeOtherInfo(Integer id){
        Order order = orderMapper.queryOrderIncludeOtherInfo(id);
        if (null != order.getCooks() && order.getCooks().size() > 0) {
            for (Cook cook : order.getCooks()){
                if(null != cook.getIsMain() && 1 == cook.getIsMain()){
                    order.setMainCook(cook);
                    break;
                }
            }
        }
        order.setCooks(null);
        return order;
    }


    /**
     * 订单回收站处理
     * @param id 订单id
     * @param isEnable false 订单回收站列表  true 订单列表
     */
    public void updateIsEnable(Integer id,Boolean isEnable){
        orderMapper.updateIsEnable(id, isEnable);
    }


    /**
     *  后台分页获取 统计 客户经理销售数据
     * @param managerName
     * @param managerId
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<OrderSales> queryOrderByAccountManager(String managerName,Integer managerId,Integer pageNO,Integer pageSize,
                                                       Date startTime,Date endTime){
        endTime = DateUtil.getNextDay(endTime,1);
       List<OrderSales> dataList = orderMapper.statisticsOrderByManager(managerId,managerName,(pageNO - 1) * pageSize,pageSize,
               startTime,endTime);
       Integer count = orderMapper.countOrderByManager(managerId,managerName,startTime,endTime);
       Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
       return new Page<OrderSales>(dataList,count,totalPage);
    }

    /**
     *  导出数据 客户经理销售数据
     * @param response
     * @param managerName
     * @param managerId
     * @throws Exception
     */
    public void exportOrderSalesExcel(HttpServletResponse response, String valueArray, String titleArray,
                                      String managerName,Integer managerId,Date startTime,Date endTime) throws Exception{
        endTime = DateUtil.getNextDay(endTime,1);
        List<OrderSales> dataList = orderMapper.statisticsOrderByManager(managerId,managerName,null,null,startTime,endTime);
        // 拼装数据
        List<String> titles = new ArrayList<String>();
        JSONArray titleJSONArr = JSONArray.fromObject(titleArray);
        for (Object obj : titleJSONArr){
            titles.add(obj.toString());
        }

        JSONArray columnsArrJSONArr = JSONArray.fromObject(valueArray);
        List<List<String>> contents = new ArrayList<List<String>>();  // 数据行集合
        for (OrderSales order : dataList){
            List<String> rows = new ArrayList<String>();
            for (Object column : columnsArrJSONArr){

                if (column.toString().equals("createTime")) {
                    rows.add(Timestamp.DateTimeStamp(order.getCreateTime(),"yyyy-MM-dd HH:mm:ss"));
                    continue;
                }

                if (column.toString().equals("userName")) {
                    rows.add(order.getUserName()+"("+order.getPhoneNumber()+")");
                    continue;
                }
                if (column.toString().equals("managerName")) {
                    rows.add(order.getManagerName()+"("+order.getManagerPhone()+")");
                    continue;
                }
                if (column.toString().equals("config")) {
                    JSONObject json = JSONObject.fromObject(order.getConfig());
                    rows.add(json.get("distribution").toString());
                    continue;
                }

                if (column.toString().equals("balance")) {
                    JSONObject json = JSONObject.fromObject(order.getConfig());
                    rows.add(String.valueOf(Double.parseDouble(json.get("distribution").toString()) / 100 * order.getPrice()));
                    continue;
                }
                Field field = order.getClass().getDeclaredField(column.toString());
                field.setAccessible(true);
                rows.add(null == field.get(order) || field.get(order) == "" ? "" : field.get(order).toString());
            }
            contents.add(rows);
        }
        // 生成 并导出 数据
        ExcelUtil.createExcel(response,titles,contents);
    }

    /**
     * 填写备注
     * @param id
     * @param reMarketAdmin
     * @param type 1：确认收款并填写备注  2：填写备注
     */
    public void saveReMarket(Integer id, String reMarketAdmin, Integer type){
        orderMapper.saveReMarket(id, reMarketAdmin,type);
    }


    /**
     * 生成要请求给支付宝的参数数组
     * @param sParaTemp 请求前的参数数组
     * @return 要请求的参数数组
     */
    private static Map<String, String> buildRequestPara(Map<String, String> sParaTemp) {
        //除去数组中的空值和签名参数
        Map<String, String> sPara = AlipayCore.paraFilter(sParaTemp);
        //生成签名结果
        String mysign = buildRequestMysign(sPara);

        //签名结果与签名方式加入请求提交参数组中
        sPara.put("sign", mysign);
        sPara.put("sign_type", "RSA");

        return sPara;
    }

    /**
     * 生成签名结果
     * @param sPara 要签名的数组
     * @return 签名结果字符串
     */
    public static String buildRequestMysign(Map<String, String> sPara) {
        String prestr = AlipayCore.createLinkString(sPara); //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
        String mysign = "";
        mysign = RSA.sign(prestr, AliPayConfig.PRIVATE_KEY, "utf-8");
        return mysign;
    }


    private static String buildNO(){
        String ym = DateUtil.DateTime(new Date(),"yyyyMMdd");
        String vcode = "" ;
        for (int i = 0; i < 8; i++) {
            vcode = vcode + (int)(Math.random() * 9);
        }
        return ym+vcode;
    }

    public Order queryOrderByBatchNO(String batchNO){
        return orderMapper.queryOrderByBatchNO(batchNO);
    }


    /***
     * 导出订单列表 export
     * @param response
     * @param valueArray
     * @param titleArray
     * @param status
     * @param orderNumber
     * @param userPhone
     * @param payMethods
     * @param type
     */
    public void exportOrder(HttpServletResponse response,String valueArray, String titleArray,
                            String status,String orderNumber, String userPhone,
                            String payMethods, Integer type ,String startTimes ,String endTimes){
        try {
            Integer[]  statusInt = null;
            if (null != status && status.trim().length() > 0) {
                String[] s = status.split(",");
                statusInt= new Integer[s.length];
                for (int i = 0 ; i < s.length ; i ++) {
                    statusInt[i] = Integer.parseInt(s[i]);
                }
            }
            Integer[]  payMethodInt = null;
            if (null != payMethods && payMethods.trim().length() > 0) {
                String[] p = payMethods.split(",");
                payMethodInt= new Integer[p.length];
                for (int i = 0 ; i < p.length ; i ++) {
                    payMethodInt[i] = Integer.parseInt(p[i]);
                }
            }
            Date startTime = null;
            Date endTime = null;
            if (null != startTimes && startTimes.trim().length() > 0) {
                startTime = Timestamp.parseDate2(startTimes,"yyyy-MM-dd");
            }

            if (null != endTimes && endTimes.trim().length() > 0) {
                endTime = Timestamp.parseDate2(endTimes,"yyyy-MM-dd");
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(endTime);
                calendar.add(Calendar.DATE, 1);
                endTime = calendar.getTime();
            }
            List<Order> dataList = orderMapper.queryOrderByItemForWeb(statusInt,orderNumber,userPhone,
                    payMethodInt,type,startTime,endTime,null,null);
            //标题栏
            List<String> titleList = JSONArray.toList(JSONArray.fromObject(titleArray));

            JSONArray columnsArrJSONArr = JSONArray.fromObject(valueArray);




            List<List<String>> contents = new ArrayList<List<String>>();  // 数据行集合
            for (Order order : dataList) {
                List<String> rows = new ArrayList<String>();
                for (Object obj : columnsArrJSONArr) {
                    //菜品金额
                    if (obj.toString().equals("foodPrice")) {
                        rows.add(order.getFoodPrice().toString());
                        continue;
                    }
                    //酒水金额
                    if (obj.toString().equals("winePrice")) {
                        rows.add(order.getWinePrice().toString());
                        continue;
                    }
                    //庆典金额
                    if (obj.toString().equals("specialWeddingPrice")) {
                        rows.add(order.getSpecialWeddingPrice().toString());
                        continue;
                    }
                    //庆典详情
                    if (obj.toString().equals("specialWeddingDetail")) {
                        rows.add(order.getSpecialWeddingDetail().toString().replaceAll("</br>",""));
                        continue;
                    }
                    //伴餐详情
                    if (obj.toString().equals("specialActDetail")) {
                        rows.add(order.getSpecialActDetail().toString().replaceAll("</br>",""));
                        continue;
                    }
                    //菜品详情
                    if (obj.toString().equals("foodNameDetail")) {
                        rows.add(order.getFoodNameDetail().toString().replaceAll("</br>",""));
                        continue;
                    }
                    //套餐详情
                    if (obj.toString().equals("baBaYanDetail")) {
                        rows.add(order.getBaBaYanDetail().toString().replaceAll("</br>",""));
                        continue;
                    }
                    //坝坝宴详情
                    if (obj.toString().equals("packageDetail")) {
                        rows.add(order.getPackageDetail().toString().replaceAll("</br>",""));
                        continue;
                    }
                    //服务员费
                    if (obj.toString().equals("waiterPrice")) {
                        String orderDetail = order.getOrderDetail().replaceAll("\\\\","");
                        JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
                        Iterator it = jsonArray.iterator();
                        Double waiterPrice = 0.0;
                        while (it.hasNext()) {
                            JSONObject j = (JSONObject) it.next();
                            //价格
                            String p = j.get("price").toString();
                            Double price;
                            if (null == p || p == "null" || p == "") {
                                continue;
                            } else {
                                price = Double.valueOf(p);
                            }
                            //类型编号
                            Integer foodCategoryId = Integer.parseInt(j.get("foodCategoryId").toString());
                            //数量
                            Integer number = Integer.parseInt(j.get("number").toString());

                            Integer foodId = Integer.parseInt(j.get("foodId").toString());

                            if (FoodCategoryEnum.SPECIAL_SERVICE.ordinal() == foodCategoryId) {
                                if (foodId == 1 || foodId == 2) {
                                    waiterPrice += number * price;
                                }
                            }
                        }
                        rows.add(waiterPrice.toString());
                        continue;
                    }

                    //可用餐具费
                    if (obj.toString().equals("tablewarePrice")) {
                        String orderDetail = order.getOrderDetail().replaceAll("\\\\","");
                        JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
                        Iterator it = jsonArray.iterator();
                        Double tablewarePrice = 0.0;
                        while (it.hasNext()) {
                            JSONObject j = (JSONObject) it.next();
                            //价格
                            String p = j.get("price").toString();
                            Double price;
                            if (null == p || p == "null" || p == "") {
                                continue;
                            } else {
                                price = Double.valueOf(p);
                            }
                            //类型编号
                            Integer foodCategoryId = Integer.parseInt(j.get("foodCategoryId").toString());
                            //数量
                            Integer number = Integer.parseInt(j.get("number").toString());

                            Integer foodId = Integer.parseInt(j.get("foodId").toString());

                            if (FoodCategoryEnum.SPECIAL_SERVICE.ordinal() == foodCategoryId) {
                                if (foodId == 3) {
                                    tablewarePrice += number * price;
                                }
                            }
                        }
                        rows.add(tablewarePrice.toString());
                        continue;
                    }
                    //女服务员人数
                    if (obj.toString().equals("waiterManNum")) {
                        String orderDetail = order.getOrderDetail().replaceAll("\\\\","");
                        JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
                        Iterator it = jsonArray.iterator();
                        Integer waiterManNum = 0;
                        while (it.hasNext()) {
                            JSONObject j = (JSONObject) it.next();
                            //类型编号
                            Integer foodCategoryId = Integer.parseInt(j.get("foodCategoryId").toString());
                            //数量
                            Integer number = Integer.parseInt(j.get("number").toString());

                            Integer foodId = Integer.parseInt(j.get("foodId").toString());

                            if (FoodCategoryEnum.SPECIAL_SERVICE.ordinal() == foodCategoryId) {
                                if (foodId == 1) {
                                    waiterManNum = number;
                                }
                            }
                        }
                        rows.add(waiterManNum.toString());
                        continue;
                    }
                    //女服务员人数
                    if (obj.toString().equals("waiterWomanNum")) {
                        String orderDetail = order.getOrderDetail().replaceAll("\\\\","");
                        JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
                        Iterator it = jsonArray.iterator();
                        Integer waiterWomanNum = 0;
                        while (it.hasNext()) {
                            JSONObject j = (JSONObject) it.next();
                            //类型编号
                            Integer foodCategoryId = Integer.parseInt(j.get("foodCategoryId").toString());
                            //数量
                            Integer number = Integer.parseInt(j.get("number").toString());

                            Integer foodId = Integer.parseInt(j.get("foodId").toString());

                            if (FoodCategoryEnum.SPECIAL_SERVICE.ordinal() == foodCategoryId) {
                                if (foodId == 2) {
                                    waiterWomanNum = number;
                                }
                            }
                        }
                        rows.add(waiterWomanNum.toString());
                        continue;
                    }
                    //餐具数量
                    if (obj.toString().equals("tablewareNum")) {
                        String orderDetail = order.getOrderDetail().replaceAll("\\\\","");
                        JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
                        Iterator it = jsonArray.iterator();
                        Integer tablewareNum = 0;
                        while (it.hasNext()) {
                            JSONObject j = (JSONObject) it.next();
                            //类型编号
                            Integer foodCategoryId = Integer.parseInt(j.get("foodCategoryId").toString());
                            //数量
                            Integer number = Integer.parseInt(j.get("number").toString());

                            Integer foodId = Integer.parseInt(j.get("foodId").toString());

                            if (FoodCategoryEnum.SPECIAL_SERVICE.ordinal() == foodCategoryId) {
                                if (foodId == 3) {
                                    tablewareNum = number;
                                }
                            }
                        }
                        rows.add(tablewareNum.toString());
                        continue;
                    }


                    Field field = order.getClass().getDeclaredField(obj.toString());
                    order.getClass().getFields();
                    //使用后 反射值取消
                    field.setAccessible(true);
                    if (field.getName().equals("status")){
                        rows.add(OrderConstant.getText(Integer.parseInt(field.get(order).toString())));
                    } else if (field.getName().equals("payMethod")){
                        String p = null == field.get(order) || field.get(order) == "" ? null : field.get(order).toString() ;
                        String pMsg = "未支付";
                        if (null != p) {
                            pMsg = order.getPayMethodMsg(Integer.parseInt(p));
                        }
                        rows.add(pMsg);
                    } else if(field.getName().equals("createTime")){
                        rows.add(DateUtil.DateTime((Date)field.get(order),"yyyy-MM-dd HH:mm:ss"));
                    } else if(field.getName().equals("serviceDate")){
                        rows.add(DateUtil.DateTime((Date)field.get(order),"yyyy-MM-dd HH:mm:ss"));
                    } else if(field.getName().equals("overTime")){
                        rows.add(DateUtil.DateTime((Date)field.get(order),"yyyy-MM-dd HH:mm:ss"));
                    } else if(field.getName().equals("dispatchTime")){
                        rows.add(DateUtil.DateTime((Date)field.get(order),"yyyy-MM-dd HH:mm:ss"));
                    } else if(field.getName().equals("mainCook")){
                        if (null != field.get(order) && field.get(order) != "") {
                            rows.add(order.getMainCook().getRealName());
                        } else {
                            rows.add("无");
                        }
                    } else {
                        rows.add(null == field.get(order) || field.get(order) == "" ? "" : field.get(order).toString());
                    }
                }
                contents.add(rows);
            }
            ExcelUtil.createExcel(response,titleList,contents);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e);
        }
    }

    public CountHome countHome(){
        return orderMapper.countHome();
    }
}
