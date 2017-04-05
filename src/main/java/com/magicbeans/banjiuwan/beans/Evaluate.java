package com.magicbeans.banjiuwan.beans;


import java.io.Serializable;
import java.util.Date;

/**
 * 实体 -- 评价
 * @author lzh
 * @create 2017/3/9 15:36
 */
public class Evaluate implements Serializable {



    private Integer id;

    /** 评价等级 1：好评  2：中评   3：差评 */
    private Integer evaluateLevel;

    /** 评价类型 1：订单  2：菜品 3：套餐 4：坝坝宴 5：服务*/
    private Integer type;

    /** 菜品评分 */
    private Double foodScore;

    /** 服务评分 */
    private Double serviceScore;

    /** 厨师评分 */
    private Double cookScore;

    /** 评论内容 */
    private String content;

    /** 上传的图片 逗号隔开 */
    private String imgs;

    /** 根据type 存放相应的id */
    private Integer objectId;

    /** 根据user_type 存放相应的id */
    private Integer userId;

    /** 用户类型 1：普通用户  2：管理员用户 */
    private Integer userType;

    /** 创建时间 */
    private Date createTime;

    /** 更新时间 */
    private Date updateTime;

    /** 是否通过 0：未通过  1：通过 */
    private Boolean isPass;

    /** 坝坝宴/套餐id */
    private Integer packageCaterId;

    /** 订单id */
    private Integer orderId;

    /** 菜品ids */
    private String foodIds;

    /******  附加参数  *****/

    /**用户名*/
    private String userName;

    /**头像*/
    private String avatar;

    /**电话号码*/
    private String phoneNumber;

    /** 菜品名 */
    private String foodName;

    /** 菜品类型 */
    private Integer foodCategoryId;

    /** 订单列表 */
    private String orderNumber;

    /**分类名称*/
    private String categoryName;



    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getEvaluateLevel() {
        return evaluateLevel;
    }

    public void setEvaluateLevel(Integer evaluateLevel) {
        this.evaluateLevel = evaluateLevel;
    }

    public Integer getType() {
        return type;
    }
    public void setType(Integer type) {
        this.type = type;
    }

    public Double getFoodScore() {
        return foodScore;
    }

    public void setFoodScore(Double foodScore) {
        this.foodScore = foodScore;
    }

    public Double getServiceScore() {
        return serviceScore;
    }

    public void setServiceScore(Double serviceScore) {
        this.serviceScore = serviceScore;
    }

    public Double getCookScore() {
        return cookScore;
    }

    public void setCookScore(Double cookScore) {
        this.cookScore = cookScore;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImgs() {
        return imgs;
    }

    public void setImgs(String imgs) {
        this.imgs = imgs;
    }

    public Integer getObjectId() {
        return objectId;
    }

    public void setObjectId(Integer objectId) {
        this.objectId = objectId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Boolean getPass() {
        return isPass;
    }

    public void setPass(Boolean pass) {
        isPass = pass;
    }

    public Integer getPackageCaterId() {
        return packageCaterId;
    }

    public void setPackageCaterId(Integer packageCaterId) {
        this.packageCaterId = packageCaterId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public Integer getFoodCategoryId() {
        return foodCategoryId;
    }

    public void setFoodCategoryId(Integer foodCategoryId) {
        this.foodCategoryId = foodCategoryId;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getFoodIds() {
        return foodIds;
    }

    public void setFoodIds(String foodIds) {
        this.foodIds = foodIds;
    }
}
