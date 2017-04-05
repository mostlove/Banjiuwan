package com.magicbeans.banjiuwan.beans;

import com.magicbeans.banjiuwan.enumutil.FoodCategoryEnum;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * 订单实体
 * Created by Eric Xie on 2017/3/1 0001.
 */
public class Order implements Serializable {

    /**主键ID*/
    private Integer id;

    /**订单号*/
    private String orderNumber;

    /**用户ID*/
    private Integer userId;
    /**创建者*/
    private User user;
    /**创建者名字*/
    private String userName;
    /**创建者电话*/
    private String userPhone;

    /**分配者ID*/
    private Integer adminUserId;
    /**调度员*/
    private AdminUser adminUser;
    /**调度员 姓名*/
    private String adminName;
    /**调度员 手机号*/
    private String adminPhone;

    /**订单状态*/
    private Integer status;

    /**地址ID*/
    private Integer addressId;
    /**地址*/
    private String address;
    /**用户地址*/
    private UserAddress userAddress;

    /**服务时间  1970-01-01 19:00*/
    private Date serviceDate;


    /**服务时间  1970-01-01 19:00*/
    private long serviceDateLong;

    /**服务费*/
    private Double serviceCost;


    /** 派单时间 */
    private Date dispatchTime;

    /** 完成时间 */
    private Date overTime;

    /**备注*/
    private String reMarket;

    /**订单总价*/
    private Double price;

    /**交通费用*/
    private Double transportationCost;

    /**溢价费用*/
    private Double premium;

    /**优惠券抵扣金额*/
    private Double coupon;
    /**优惠券ID*/
    private Integer couponId;

    /**现金券抵扣金额*/
    private Double cashCoupon;
    /**现金券ID*/
    private Integer cashCouponId;

    /**积分抵扣金额*/
    private Double accumulate;

    /**被抵扣的积分数量*/
    private Integer accumulateNum;

    /**积分比例*/
    private String accumulateConfig;

    /**余额抵扣金额*/
    private Double balance;

    /**其他方式支付金额*/
    private Double otherPay;

    /**支付方式 0 WeChat 1 AliPay 2 offline*/
    private Integer payMethod;

    /**创建时间*/
    private Date createTime;

    /**订单 详情*/
    private String orderDetail;

    /**厨师集合*/
    private List<Cook> cooks;

    /**主厨*/
    private Cook mainCook;

    /**当前厨师 是否是主厨*/
    private Integer isMain;

    /**支付商号*/
    private String payNumber;

    /** 是否启用 false否 true是 （回收站） */
    private Boolean isEnable;

    /**当订单支付方式为 线下支付时，财务是否确认收款  0:未确认 1:已确认*/
    private Integer isConfirm;

    /** 后台填写备注 */
    private String reMarketAdmin;

    /**服务员数量*/
    private Integer waiterNumber;

    /**退款批次号*/
    private String batchNO;

    private List<FoodCategory> foodCategories;

    /**订单对用户是否有效/可见  0无效 1有效  缺省值 1*/
    private Integer userIsValid;

    /**订单对厨师是否有效/可见  0无效 1有效  缺省值 1*/
    private Integer cookIsValid;

    /**客户经理名字*/
    private String managerUser;

    /**客户经理电话*/
    private String managerPhone;

    public String getManagerUser() {
        return managerUser;
    }

    public void setManagerUser(String managerUser) {
        this.managerUser = managerUser;
    }

    public String getManagerPhone() {
        return managerPhone;
    }

    public void setManagerPhone(String managerPhone) {
        this.managerPhone = managerPhone;
    }

    public Integer getCookIsValid() {
        return cookIsValid;
    }

    public void setCookIsValid(Integer cookIsValid) {
        this.cookIsValid = cookIsValid;
    }

    public Integer getUserIsValid() {
        return userIsValid;
    }

    public void setUserIsValid(Integer userIsValid) {
        this.userIsValid = userIsValid;
    }

    public List<FoodCategory> getFoodCategories() {
        return foodCategories;
    }

    public void setFoodCategories(List<FoodCategory> foodCategories) {
        this.foodCategories = foodCategories;
    }

    public String getBatchNO() {
        return batchNO;
    }

    public void setBatchNO(String batchNO) {
        this.batchNO = batchNO;
    }

    public Integer getWaiterNumber() {
        return waiterNumber;
    }

    public void setWaiterNumber(Integer waiterNumber) {
        this.waiterNumber = waiterNumber;
    }

    public Integer getIsConfirm() {
        return isConfirm;
    }

    public void setIsConfirm(Integer isConfirm) {
        this.isConfirm = isConfirm;
    }

    public String getAccumulateConfig() {
        return accumulateConfig;
    }

    public void setAccumulateConfig(String accumulateConfig) {
        this.accumulateConfig = accumulateConfig;
    }

    public Cook getMainCook() {
        return mainCook;
    }

    public void setMainCook(Cook mainCook) {
        this.mainCook = mainCook;
    }

    public UserAddress getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(UserAddress userAddress) {
        this.userAddress = userAddress;
    }

    public long getServiceDateLong() {
        return serviceDateLong;
    }

    public void setServiceDateLong(long serviceDateLong) {
        this.serviceDateLong = serviceDateLong;
    }

    public String getPayNumber() {
        return payNumber;
    }

    public void setPayNumber(String payNumber) {
        this.payNumber = payNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getIsMain() {
        return isMain;
    }


    public String getUserName() {
        return userName;
    }

    public Date getOverTime() {
        return overTime;
    }

    public void setOverTime(Date overTime) {
        this.overTime = overTime;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminPhone() {
        return adminPhone;
    }

    public void setAdminPhone(String adminPhone) {
        this.adminPhone = adminPhone;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public AdminUser getAdminUser() {
        return adminUser;
    }

    public void setAdminUser(AdminUser adminUser) {
        this.adminUser = adminUser;
    }

    public void setIsMain(Integer isMain) {
        this.isMain = isMain;
    }

    public Double getServiceCost() {
        return serviceCost;
    }

    public void setServiceCost(Double serviceCost) {
        this.serviceCost = serviceCost;
    }

    public List<Cook> getCooks() {
        return cooks;
    }

    public void setCooks(List<Cook> cooks) {
        this.cooks = cooks;
    }

    public Integer getAccumulateNum() {
        return accumulateNum;
    }

    public void setAccumulateNum(Integer accumulateNum) {
        this.accumulateNum = accumulateNum;
    }

    public Integer getCouponId() {
        return couponId;
    }

    public void setCouponId(Integer couponId) {
        this.couponId = couponId;
    }

    public Integer getCashCouponId() {
        return cashCouponId;
    }

    public void setCashCouponId(Integer cashCouponId) {
        this.cashCouponId = cashCouponId;
    }

    public String getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(String orderDetail) {
        this.orderDetail = orderDetail;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getAdminUserId() {
        return adminUserId;
    }

    public void setAdminUserId(Integer adminUserId) {
        this.adminUserId = adminUserId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public Date getServiceDate() {
        return serviceDate;
    }

    public void setServiceDate(Date serviceDate) {
        this.serviceDate = serviceDate;
    }

    public String getReMarket() {
        return reMarket;
    }

    public void setReMarket(String reMarket) {
        this.reMarket = reMarket;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getTransportationCost() {
        return transportationCost;
    }

    public void setTransportationCost(Double transportationCost) {
        this.transportationCost = transportationCost;
    }

    public Double getPremium() {
        return premium;
    }

    public void setPremium(Double premium) {
        this.premium = premium;
    }

    public Double getCoupon() {
        return coupon;
    }

    public void setCoupon(Double coupon) {
        this.coupon = coupon;
    }

    public Double getCashCoupon() {
        return cashCoupon;
    }

    public void setCashCoupon(Double cashCoupon) {
        this.cashCoupon = cashCoupon;
    }

    public Double getAccumulate() {
        return accumulate;
    }

    public void setAccumulate(Double accumulate) {
        this.accumulate = accumulate;
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }

    public Double getOtherPay() {
        return otherPay;
    }

    public void setOtherPay(Double otherPay) {
        this.otherPay = otherPay;
    }

    public Integer getPayMethod() {
        return payMethod;
    }

    public void setPayMethod(Integer payMethod) {
        this.payMethod = payMethod;
    }

    public Boolean getEnable() {
        return isEnable;
    }

    public void setEnable(Boolean enable) {
        isEnable = enable;
    }

    public Date getDispatchTime() {
        return dispatchTime;
    }

    public void setDispatchTime(Date dispatchTime) {
        this.dispatchTime = dispatchTime;
    }

    public String getReMarketAdmin() {
        return reMarketAdmin;
    }

    public void setReMarketAdmin(String reMarketAdmin) {
        this.reMarketAdmin = reMarketAdmin;
    }


    public String getPayMethodMsg(Integer payMethod){
        switch (payMethod) {
            case 0 : return "微信";
            case 1 : return "支付宝";
            case 2 : return "线下支付";
        }
        return "支付方式异常";
    }

    /**
     * 菜品金额
     * @return
     */
    public Double getFoodPrice(){
        if (null == orderDetail){
            return 0.0;
        }
        orderDetail = orderDetail.replaceAll("\\\\","");
        JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
        Iterator it = jsonArray.iterator();
        Double foodPrice = 0.0;
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
            FoodCategory foodCategory = new FoodCategory();
            foodCategory.setId(foodCategoryId);
            if (foodCategories.contains(foodCategory)) {
                foodPrice += number * price;
            }
        }
        return foodPrice;
    }

    /**
     * 菜品名
     * @return
     */
    public String getFoodNameDetail(){
        if (null == orderDetail){
            return "";
        }
        orderDetail = orderDetail.replaceAll("\\\\","");
        JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
        Iterator it = jsonArray.iterator();
        String foodNames = "";
        int i = 0;
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
            FoodCategory foodCategory = new FoodCategory();
            foodCategory.setId(foodCategoryId);
            if (foodCategories.contains(foodCategory)) {
                if (i == 0) {
                    foodNames = j.get("name").toString() + " 数量:" + number + " 单价:" + price ;
                } else {
                    foodNames = foodNames + ",</br>"+ j.get("name").toString() + " 数量:" + number + " 单价:" + price;
                }
                i++;
            }
        }
        return foodNames;
    }
    /**
     * 酒水金额
     * @return
     */
    public Double getWinePrice(){
        if (null == orderDetail){
            return 0.0;
        }
        orderDetail = orderDetail.replaceAll("\\\\","");
        JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
        Iterator it = jsonArray.iterator();
        Double foodPrice = 0.0;
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


            if (FoodCategoryEnum.WINE.ordinal() == foodCategoryId) {
                foodPrice += number * price;
            }
        }
        return foodPrice;
    }

    /**
     * 庆典金额
     * @return
     */
    public Double getSpecialWeddingPrice(){
        if (null == orderDetail){
            return 0.0;
        }
        orderDetail = orderDetail.replaceAll("\\\\","");
        JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
        Iterator it = jsonArray.iterator();
        Double foodPrice = 0.0;
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
            if (FoodCategoryEnum.SPECIAL_WEDDING.ordinal() == foodCategoryId) {
                foodPrice += number * price;
            }
        }
        return foodPrice;
    }

//    /**
//     * 专业服务
//     * @return
//     */
//    public JSONArray getSpecialService(){
//        JSONArray arr = new JSONArray();
//        try {
//            if (null == orderDetail){
//                return arr;
//            }
//
//
//            orderDetail = orderDetail.replaceAll("\\\\","");
//            JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
//            Iterator it = jsonArray.iterator();
//
//            while (it.hasNext()) {
//                JSONObject j = (JSONObject) it.next();
//                //类型编号
//                Integer foodCategoryId = Integer.parseInt(j.get("foodCategoryId").toString());
//                if (FoodCategoryEnum.SPECIAL_SERVICE.ordinal() == foodCategoryId) {
//                    arr.add(j);
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return arr;
//    }
//
//    /**
//     * 获取订单消费明细
//     * @return
//     */
//    public JSONArray getOrderDetailJson(){
//        JSONArray jsonArray = new JSONArray();
//        if (null == orderDetail){
//            return jsonArray;
//        }
//        try {
//            orderDetail = orderDetail.replaceAll("\\\\","");
//            jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
//            return jsonArray;
//        } catch (Exception e) {
//            e.printStackTrace();
//            return jsonArray;
//        }
//    }
    /**
     * 获取庆典详情
     * @return
     */
    public String getSpecialWeddingDetail(){
        if (null == orderDetail){
            return "";
        }
        try {
            if (null == orderDetail){
                return "";
            }
            orderDetail = orderDetail.replaceAll("\\\\","");
            JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
            Iterator it = jsonArray.iterator();
            String specialWeddingDetail = "";
            int i = 0;
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



                if (FoodCategoryEnum.SPECIAL_WEDDING.ordinal() == foodCategoryId) {
                    if (i == 0) {
                        specialWeddingDetail = j.get("name").toString() + " 数量:" + number + " 单价:" + price ;
                    } else {
                        specialWeddingDetail = specialWeddingDetail + ",</br>"+ j.get("name").toString() + " 数量:" + number + " 单价:" + price;
                    }
                    i++;
                }
            }
            return specialWeddingDetail;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }
    /**
     * 获取伴餐详情
     * @return
     */
    public String getSpecialActDetail(){
        if (null == orderDetail){
            return "";
        }
        try {
            if (null == orderDetail){
                return "";
            }
            orderDetail = orderDetail.replaceAll("\\\\","");
            JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
            Iterator it = jsonArray.iterator();
            String specialWeddingDetail = "";
            int i = 0;
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
                if (FoodCategoryEnum.SPECIAL_ACT.ordinal() == foodCategoryId) {
                    if (i == 0) {
                        specialWeddingDetail = j.get("name").toString() + " 数量:" + number + " 单价:" + price ;
                    } else {
                        specialWeddingDetail = specialWeddingDetail + ",</br>"+ j.get("name").toString() + " 数量:" + number + " 单价:" + price;
                    }
                    i++;
                }
            }
            return specialWeddingDetail;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }




    /**
     * 获取坝坝宴详情
     * @return
     */
    public String getBaBaYanDetail(){
        if (null == orderDetail){
            return "";
        }
        try {
            if (null == orderDetail){
                return "";
            }
            orderDetail = orderDetail.replaceAll("\\\\","");
            JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
            Iterator it = jsonArray.iterator();
            String specialWeddingDetail = "";
            int i = 0;
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
                if (FoodCategoryEnum.BA_BA_YAN.ordinal() == foodCategoryId) {
                    JSONArray js = JSONArray.fromObject(j.get("detail"));
                    String foodName = "";
                    for (Object o : js) {
                        foodName += JSONObject.fromObject(o).get("foodName").toString() + ",";
                    }
                    if (i == 0) {
                        specialWeddingDetail = j.get("name").toString() + " 数量:" + number + " 单价:" + price + "菜品:" + foodName;
                    } else {
                        specialWeddingDetail = specialWeddingDetail + "</br>"+ j.get("name").toString() + " 数量:" + number + " 单价:" + price + "菜品:" + foodName;
                    }
                    i++;
                }
            }
            return specialWeddingDetail;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    /**
     * 获取套餐详情
     * @return
     */
    public String getPackageDetail(){
        if (null == orderDetail){
            return "";
        }
        try {
            if (null == orderDetail){
                return "";
            }
            orderDetail = orderDetail.replaceAll("\\\\","");
            JSONArray jsonArray = JSONArray.fromObject(orderDetail.substring(1,orderDetail.length()-1));
            Iterator it = jsonArray.iterator();
            String specialWeddingDetail = "";
            int i = 0;
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
                if (FoodCategoryEnum.PACKAGE.ordinal() == foodCategoryId) {
                    JSONArray js = JSONArray.fromObject(j.get("detail"));
                    String foodName = "";
                    for (Object o : js) {
                        foodName += JSONObject.fromObject(o).get("foodName").toString() + ",";
                    }
                    if (i == 0) {
                        specialWeddingDetail = j.get("name").toString() + " 数量:" + number + " 单价:" + price + "菜品:" + foodName;
                    } else {
                        specialWeddingDetail = specialWeddingDetail + "</br>"+ j.get("name").toString() + " 数量:" + number + " 单价:" + price + "菜品:" + foodName;
                    }
                    i++;
                }
            }
            return specialWeddingDetail;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }
}
