<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>填写订单</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/mui.dtpicker.css" charset="UTF-8">
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/order/orderEdit.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="orderEditCtr" ng-cloak>
<div class="mui-content">

    <!--选择地址-->
    <div class="order-bar">
        <div class="title">
            服务地址
        </div>
        <div class="context" ng-show="address != null && address.length != 0">
            <p>
                <span class="user-name">{{address.contact}}</span>
                <span class="user-gender" ng-show="address.gender == 0">先生</span>
                <span class="user-gender" ng-show="address.gender == 1">女士</span>
                <span class="user-phone">{{address.contactPhone}}</span>
            </p>
            <p class="address">
                {{address.address}}
            </p>
            <p class="address">
                {{address.detailAddress}}
            </p>
            <p class="hint" ng-show="isRange > 0">
                您的地址已超过服务范围，需要补充相应的交通费用￥{{isRange}}
            </p>
            <p class="hint" ng-show="isRange == -1">
                您已超过服务范围
            </p>
        </div>

        <div class="context" ng-show="address == null">
            <p class="hint">
                暂无默认收货地址
            </p>
        </div>

        <a ng-click="replaceAddress()">
            <div class="title title-bottom">
                更换服务地址
                <span class="right-hint">
                    <i class="mui-icon mui-icon-arrowright"></i>
                </span>
            </div>
        </a>

    </div>

    <!--服务时间-->
    <div class="order-bar">
        <div class="title">
            服务时间
            <span class="right-hint">
                请选择您用餐的时间
            </span>
        </div>
        <div class="context">
            <div class="mui-row">
                <div class="mui-col-xs-2 mui-col-sm-2 timeWidthLeft">
                    <span class="title-hint">日期：</span>
                </div>
                <div class="mui-col-xs-10 mui-col-sm-10 timeWidthRight">
                    <input id="result" type="text" readonly data-options='{"type":"date"}' class="btn mui-btn mui-btn-block" value="选择日期"/>
                    <%--<input id="myLabel" type="text" ng-model="myLabel">
                    <input type="text" value="{{myLabel}}">--%>
                </div>
            </div>
            <div class="mui-row">
                <div class="mui-col-xs-2 mui-col-sm-2 timeWidthLeft">
                    <span class="title-hint">时间：</span>
                </div>
                <div class="mui-col-xs-10 mui-col-sm-10 timeWidthRight">
                    <table class="time-table">
                        <tr>
                            <td>10:00</td>
                            <td>10:00</td>
                            <td>10:00</td>
                            <td>10:00</td>
                        </tr>
                        <tr>
                            <td>11:00</td>
                            <td>11:00</td>
                            <td>11:00</td>
                            <td>11:00</td>
                        </tr>
                        <tr>
                            <td>12:00</td>
                            <td>12:00</td>
                            <td>12:00</td>
                            <td>12:00</td>
                        </tr>
                        <tr>
                            <td>12:00</td>
                            <td>12:00</td>
                            <td>12:00</td>
                            <td>12:00</td>
                        </tr>
                    </table>
                    <p class="hint hide" id="premiumHtml">
                        您的服务时间为服务高峰期，需要溢价（￥<span id="premium">0</span>）
                    </p>
                    <!-- 存放已选时间 -->
                    <input type="hidden" id="selectTime">
                </div>
            </div>
        </div>
    </div>

    <!--我的订单-->
    <div class="order-bar">
        <div class="title">
            我的订单
        </div>
        <ul class="mui-table-view">
            <!--半餐演奏类-->
            <li class="mui-table-view-cell" ng-repeat="act in actShopCarList" ng-if="actShopCarList.length != 0">
                <span class="goods-name">{{act.name}}</span>
                <span class="goods-price">￥{{act.price}}</span>
                <span class="goods-number">x{{act.number}}</span>
            </li>
            <!--套餐-->
            <li class="mui-table-view-cell" ng-repeat="packageCater in packageCaterShopCarList" ng-if="packageCaterShopCarList.length != 0">
                <span class="goods-name">{{packageCater.name}}</span>
                <span class="goods-price">￥{{packageCater.price}}</span>
                <span class="goods-number">x{{packageCater.number}}</span>
            </li>
            <!--坝坝宴类-->
            <li class="mui-table-view-cell" ng-repeat="babaYan in babaYanShopCarList" ng-if="babaYanShopCarList.length != 0">
                <span class="goods-name">{{babaYan.name}}</span>
                <span class="goods-price">￥{{babaYan.price}}</span>
                <span class="goods-number">x{{babaYan.number}}</span>
            </li>
            <!--专业服务类-->
            <li class="mui-table-view-cell" ng-repeat="service in serviceShopCarList" ng-if="serviceShopCarList.length != 0">
                <span class="goods-name">{{service.name}}</span>
                <span class="goods-price">￥{{service.price}}</span>
                <span class="goods-number">x{{service.number}}</span>
            </li>
            <!--单点-->
            <li class="mui-table-view-cell" ng-repeat="singleFood in singleFoodShopCarList" ng-if="singleFoodShopCarList.length != 0">
                <span class="goods-name">{{singleFood.name}}</span>
                <span class="goods-price">￥{{singleFood.price}}</span>
                <span class="goods-number">x{{singleFood.number}}</span>
            </li>
            <!--婚庆类-->
            <li class="mui-table-view-cell" ng-repeat="wedding in weddingShopCarList" ng-if="weddingShopCarList.length != 0">
                <span class="goods-name">{{wedding.name}}</span>
                <span class="goods-price">￥{{wedding.price}}</span>
                <span class="goods-number">x{{wedding.number}}</span>
            </li>

            <li class="mui-table-view-cell" ng-show="isRange > 0">
                <span class="goods-name">交通费用<span>(超出范围)</span></span>
                <span class="goods-price">￥{{isRange}}</span>
            </li>
            <li class="mui-table-view-cell hide" id="premiumHtml2">
                <span class="goods-name">溢价</span>
                <span class="goods-price">￥<span id="premium2">0</span></span>
            </li>
            <li class="mui-table-view-cell" ng-show="servicePrice != 0">
                <span class="goods-name">服务费</span>
                <span class="goods-price">￥{{servicePrice}}</span>
            </li>
        </ul>
    </div>

    <!--我的优惠-->
    <div class="order-bar">
        <ul class="mui-table-view">
            <li class="mui-table-view-cell mui-collapse">
                <a class="mui-navigate-right" href="javascript:void(0)">我的优惠</a>
                <div class="mui-collapse-content">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" ng-show="couponList.length != 0">
                            优惠券
                            <span class="hint margin-left10" id="voucherNeedSpend"></span>
                            <div id="voucher" class="mui-switch mui-switch-blue mui-switch-mini voucher-switch">
                                <div class="mui-switch-handle"></div>
                            </div>
                            <div id="voucherDiv" class="voucher-list-div">
                                <ul class="mui-table-view">
                                    <li class="mui-table-view-cell" ng-repeat="coupon in couponList">
                                        <div class="mui-input-row mui-radio mui-left">
                                            <label>
                                                <span class="goods-name">{{coupon.text}}</span>
                                                <p class="condition">满{{coupon.needSpend}}元使用</p>
                                                <span class="goods-price">￥{{coupon.faceValue}}</span>
                                            </label>
                                            <input onclick="voucherRadio(this)" name="voucher-radio" class="voucher-radio" type="radio" value="{{coupon.id}}" need="{{coupon.needSpend}}" price="{{coupon.faceValue}}">
                                            <input type="hidden" name="voucherRadioId" value="{{coupon.id}}">
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li class="mui-table-view-cell" ng-show="cashCouponList.length != 0">
                            现金券
                            <span class="hint margin-left10" id="cashNeedSpend"></span>
                            <div id="cash" class="mui-switch mui-switch-blue mui-switch-mini voucher-switch">
                                <div class="mui-switch-handle"></div>
                            </div>
                            <div id="cashDiv" class="voucher-list-div">
                                <ul class="mui-table-view">
                                    <li class="mui-table-view-cell" ng-repeat="cashCoupon in cashCouponList">
                                        <div class="mui-input-row mui-radio mui-left">
                                            <label>
                                                <span class="goods-name">{{cashCoupon.text}}</span>
                                                <span class="goods-price cash-goods-price">￥{{cashCoupon.faceValue}}</span>
                                            </label>
                                            <input onclick="cashRadio(this)" name="cash-radio" type="radio" class="cash-radio" value="{{cashCoupon.id}}" price="{{cashCoupon.faceValue}}">
                                            <input type="hidden" name="cashRadioId" value="{{cashCoupon.id}}">
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li class="mui-table-view-cell">
                            积分
                            <span class="hint margin-left10 maxWidth"><span id="accumulate">0</span>积分 可抵用￥<span id="accumulateMoney">0</span><span id="shengYu">&nbsp;剩余<span id="shengYuAccumulate">0</span>积分</span></span>
                            <div id="integral" class="mui-switch mui-switch-blue mui-switch-mini">
                                <div class="mui-switch-handle"></div>
                            </div>
                        </li>
                        <li class="mui-table-view-cell">
                            会员卡
                            <span class="hint margin-left10 maxWidth">(￥<span id="balance">{{userInfo.balance}}</span>)&nbsp;
                                <span id="memberCardMoney">
                                    可抵扣￥<span id="onBalance"></span>&nbsp;剩余￥<span id="surplus"></span>
                                </span>
                            </span>
                            <div id="memberCard" class="mui-switch mui-switch-blue mui-switch-mini">
                                <div class="mui-switch-handle"></div>
                            </div>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>
    </div>

    <!--备注-->
    <div class="order-bar">
        <div class="title">
            备注
        </div>
        <div class="context">
            <textarea id="reMarket" class="textarea" placeholder="另外需要说明什么"></textarea>
        </div>
    </div>

</div>

<!--合计-->
<nav class="mui-bar mui-bar-tab car-bottom">
    <a class="mui-tab-item car-popup-left">
        <div class="car-popup">
            合计
            <span class="car-popup-price">￥<span id="countMoney">{{countMoney}}</span></span>
            <input type="hidden" id="tempCountMoney" value="{{countMoney}}">
        </div>
    </a>
    <a class="mui-tab-item car-popup-right" href="javascript:void(0)">
        <button type="button" class="mui-btn mui-btn-danger" ng-disabled="isRange == -1" ng-click="payment()">
            去支付
        </button>
    </a>
</nav>

<!-- 选择支付弹窗 -->
<div id="paymentPopup" class="mui-popover mui-popover-action mui-popover-bottom">
    <ul class="mui-table-view">
        <li class="mui-table-view-cell">
            <div class="orderMoneyDiv">订单金额：<span class="orderMoney">￥<span id="payMoney">0</span></span></div>
            <div class="mui-row" ng-if="!isWei">
                <div class="mui-col-xs-4 mui-col-sm-4 paymentMode" ng-click="weiXinPayment()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/weixin.png">
                    <p class="paymentModeTiele">微信支付</p>
                </div>
                <div class="mui-col-xs-4 mui-col-sm-4 paymentMode" ng-click="zhiFuBaoPayment()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/zhifubao.png">
                    <p class="paymentModeTiele">支付宝支付</p>
                </div>
                <div class="mui-col-xs-4 mui-col-sm-4 paymentMode" ng-click="xianXiaPayment()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/xianxia.png">
                    <p class="paymentModeTiele">线下支付</p>
                </div>
            </div>
            <div class="mui-row" ng-if="isWei">
                <div class="mui-col-xs-6 mui-col-sm-6 paymentMode" ng-click="weiXinPayment()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/weixin.png">
                    <p class="paymentModeTiele">微信支付</p>
                </div>
                <div class="mui-col-xs-6 mui-col-sm-6 paymentMode" ng-click="xianXiaPayment()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/xianxia.png">
                    <p class="paymentModeTiele">线下支付</p>
                </div>
            </div>
        </li>
    </ul>

    <ul class="mui-table-view">
        <li class="mui-table-view-cell cancelBtn">
            <a href="#paymentPopup"><b>取消</b></a>
        </li>
    </ul>
</div>


<!--引入抽取js文件-->
<%@include file="../common/public-js.jsp" %>
<script src="<%=request.getContextPath()%>/appResources/js/common/mui.picker.js" type="text/javascript" charset="UTF-8"></script>
<script src="<%=request.getContextPath()%>/appResources/js/common/mui.dtpicker.js" type="text/javascript" charset="UTF-8"></script>
<script src="<%=request.getContextPath()%>/appResources/js/common/mui.picker.min.js" type="text/javascript" charset="UTF-8"></script>


<script type="text/javascript">

    $("body").append(BJW.dialogLoading("正在加载"));//弹窗loading

    var voucherId = 0; //存放已选优惠券ID
    var cashId = 0; //存放已选现金券ID
    var countAccumulate = 0;//存放计算积分金额
    var countBalance = 0;//存放抵扣会员卡金额
    var configAccumulate = 0; //存放积分计算配置

    var lastNodeVoucher = 0;//存放上一个选择的值--优惠券
    var lastNodeCash = 0;//存放上一个选择的值--现金券
    var lastNodeTime = 0; //存放上一个选择的时间溢价
    var totalMoney = 0;
    var totalMoney2 = 0;

    var serviceConfigTime = ""; //存放服务器返回时间


    var webApp=angular.module('webApp',[]);
    //填写订单
    webApp.controller('orderEditCtr',function($scope,$http,$timeout){
        $scope.orderId = null; // 临时存放订单ID
        $scope.countMoney = 0.0; //存放总金额
        $scope.orderMoney = 0.0; //存放订单总额，不包括积分抵换那些
        //获取登录用户token
        $scope.userToken = BJW.getLocalStorageToken();
        console.log("token:" + $scope.userToken);
        $scope.isWei = BJW.isWeiXin();//是否是微信
        $scope.userInfo = null; //存放用户信息
        $scope.address = null; //存放默认地址
        $scope.selectAddress = null; //存放选择地址
        $scope.isRange = 0; //判断是否超出范围
        $scope.pointTime = 0; //下单需要的时间
        $scope.couponList = new Array(); //存放可用优惠券
        $scope.cashCouponList = new Array(); //存放可用现金券
        $scope.couponListInitial = new Array(); //存放可用优惠券---初始
        $scope.cashCouponListInitial = new Array(); //存放可用现金券---初始
        $scope.actTotalMoney = 0; //半餐演奏类总金额
        $scope.packageCaterTotalMoney = 0; //套餐总金额
        $scope.babaYanTotalMoney = 0; //坝坝宴类总金额
        $scope.serviceTotalMoney = 0; //专业服务类总金额
        $scope.waiterNumber = 0; // 服务员数量
        $scope.singleFoodTotalMoney = 0; //婚庆类总金额
        $scope.weddingTotalMoney = 0; //单点总金额
        $scope.premiumMoney = 0; //溢价价格
        $scope.lastPremium = 0; //存放上一个溢价价格
        $scope.servicePrice = 0; //存放服务费
        $scope.accumulateConfig = null; //存放积分计算规则
        //$scope.myLabel = "text for label";

        // 存放当前用户 能使用在 溢价、里程费、服务费 区间的所有券信息
        $scope.allList = new Array();// 所有券信息

        //获取 当前用户 能使用在 溢价、里程费、服务费 区间的所有券信息
        // 其中 溢价类型ID： 17 ，里程费类型ID：16，服务费类型ID： 15
        BJW.ajaxRequestData("get", false, BJW.ip+'/app/order/getConfigByCoupon', {}, $scope.userToken , function(result){
            if(result.flag == 0 && result.code == 200){
                $scope.allList = result.data;
            }
        });
        /**
         *  计算能使用的优惠券 返回 能使用的优惠券集合
         *  foodCategoryId : 类型ID  溢价类型ID： 17 ，里程费类型ID：16，服务费类型ID： 15
         *  price ： 类型的价格
         * */
        $scope.calculateUserCoupon =function(foodCategoryId,price){
            var okCoupon = new Array();
            if(null == foodCategoryId || null == price || 0 == price){
                return okCoupon;
            }
            var listSize = $scope.allList.length;
            for (var i = 0; i < listSize; i++){
                var obj = $scope.allList[i];
                if(obj.foodCategoryId == foodCategoryId && obj.type == 1){
                    // 现金券直接装备
                    okCoupon.push(obj);
                    continue;
                }
                if(obj.foodCategoryId == foodCategoryId && obj.type == 0){
                    // 优惠券装备
                    if(price >= obj.needSpend){
                        okCoupon.push(obj);
                        continue;
                    }
                }
            }
            return okCoupon;

        }

        //获取用户信息
        BJW.ajaxRequestData("get", false, BJW.ip+'/app/user/getInfo', {}, $scope.userToken , function(result){
            if(result.flag == 0 && result.code == 200){
                $scope.userInfo = result.data;
                console.log($scope.userInfo);
            }
        });

        //获取默认地址
        var arr = {pageNO : 1,pageSize : 100}
        BJW.ajaxRequestData("get", false, BJW.ip+'/app/address/getAddress', arr, $scope.userToken , function(result){
            if(result.flag == 0 && result.code == 200){
                for (var i = 0; i < result.data.length; i++ ) {
                    if (result.data[i].isDefault == 1) {
                        $scope.address = result.data[i];
                        $scope.selectAddress = result.data[i];
                        break;
                    }
                }
            }
        });

        //获取选择地址
        $scope.selectAddress = JSON.parse(localStorage.getItem("selectOrderAddress")) == null ? $scope.selectAddress : JSON.parse(localStorage.getItem("selectOrderAddress"));
        if ($scope.selectAddress != null) {
            $scope.address = $scope.selectAddress;
            console.log($scope.selectAddress);
        }

        //跳转收货地址列表
        $scope.replaceAddress = function () {
            localStorage.setItem("orderEdit", 1)
            localStorage.setItem("selectOrderAddress", JSON.stringify($scope.selectAddress));
            window.location.href = BJW.ip + "/app/page/address?isOpen=1";
        }

        if ($scope.address != null) {
            //获取范围价格
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/address/getTransportationCost', {addressId : $scope.address.id}, $scope.userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    $scope.isRange = result.data.price;
                    $scope.pointTime = result.data.pointTime;
                    console.log("超出范围费用：" + $scope.isRange);
                }
            });
        }

        //获取结算商品
        // 半餐演奏类
        $scope.actShopCarList = JSON.parse(localStorage.getItem("actShopCarList"));
        // 套餐
        $scope.packageCaterShopCarList = JSON.parse(localStorage.getItem("packageCaterShopCarList"));
        // 坝坝宴类
        $scope.babaYanShopCarList = JSON.parse(localStorage.getItem("babaYanShopCarList"));
        // 专业服务类
        $scope.serviceShopCarList = JSON.parse(localStorage.getItem("serviceShopCarList"));
        // 单点
        $scope.singleFoodShopCarList = JSON.parse(localStorage.getItem("singleFoodShopCarList"));
        // 婚庆类
        $scope.weddingShopCarList = JSON.parse(localStorage.getItem("weddingShopCarList"));
        //购物车传过来的服务费
        $scope.servicePrice = localStorage.getItem("servicePrice");

        console.log($scope.singleFoodShopCarList);

        //统计金额
        $scope.countMoneyOrNumber = function (){
            console.log($scope.actShopCarList);
            // 半餐演奏类
            if ($scope.actShopCarList.length != 0) {
                $scope.actType = $scope.actShopCarList[0].foodCategoryId; //商品类型ID
                for (var i = 0; i < $scope.actShopCarList.length; i++) {
                    $scope.actTotalMoney += $scope.actShopCarList[i].price * $scope.actShopCarList[i].number;
                }
            }
            // 套餐
            if ($scope.packageCaterShopCarList.length != 0) {
                $scope.packageCaterType = $scope.packageCaterShopCarList[0].foodCategoryId; //商品类型ID
                for (var i = 0; i < $scope.packageCaterShopCarList.length; i++) {
                    $scope.packageCaterTotalMoney += $scope.packageCaterShopCarList[i].price * $scope.packageCaterShopCarList[i].number;
                }
            }
            // 坝坝宴类
            if ($scope.babaYanShopCarList.length != 0) {
                $scope.babaYanType = $scope.babaYanShopCarList[0].foodCategoryId; //商品类型ID
                for (var i = 0; i < $scope.babaYanShopCarList.length; i++) {
                    $scope.babaYanTotalMoney += $scope.babaYanShopCarList[i].price * $scope.babaYanShopCarList[i].number;
                }
            }
            // 专业服务类
            console.log("**************");
            console.log($scope.serviceShopCarList);
            console.log("**************");
            if ($scope.serviceShopCarList.length != 0) {
                $scope.serviceType = $scope.serviceShopCarList[0].foodCategoryId; //商品类型ID
                for (var i = 0; i < $scope.serviceShopCarList.length; i++) {
                    $scope.serviceTotalMoney += $scope.serviceShopCarList[i].price * $scope.serviceShopCarList[i].number;
                    if ($scope.serviceShopCarList[i].foodId != 3) {
                        $scope.waiterNumber += $scope.serviceShopCarList[i].number;
                    }
                }
            }
            //单点
            if ($scope.singleFoodShopCarList.length != 0) {
                $scope.singleFoodType = $scope.singleFoodShopCarList[0].foodCategoryId; //商品类型ID
                for (var i = 0; i < $scope.singleFoodShopCarList.length; i++) {
                    $scope.singleFoodTotalMoney += $scope.singleFoodShopCarList[i].price * $scope.singleFoodShopCarList[i].number;
                }
            }
            // 婚庆类
            if ($scope.weddingShopCarList.length != 0) {
                $scope.weddingFoodType = $scope.weddingShopCarList[0].foodCategoryId; //商品类型ID
                for (var i = 0; i < $scope.weddingShopCarList.length; i++) {
                    $scope.weddingTotalMoney += $scope.weddingShopCarList[i].price * $scope.weddingShopCarList[i].number;
                }
            }
            //总金额--相加商品总金额
            $scope.countMoney = ($scope.actTotalMoney + $scope.packageCaterTotalMoney + $scope.babaYanTotalMoney + $scope.serviceTotalMoney + $scope.singleFoodTotalMoney + $scope.weddingTotalMoney);
            //相加交通费用
            //获取交通费
            $scope.traffic = $scope.isRange == null || $scope.isRange == -1 ? 0 : $scope.isRange;
            $scope.countMoney = ($scope.countMoney + parseFloat($scope.traffic));
            //相加服务费用
            $scope.countMoney = parseFloat($scope.servicePrice) + $scope.countMoney;
            $scope.countMoney = $scope.countMoney.toFixed(2);
            $scope.orderMoney = $scope.countMoney;
            totalMoney2 = $scope.orderMoney;
            console.log("计算出的订单总金额：" + $scope.orderMoney);
            console.log("计算出的支付总金额：" + $scope.countMoney);
            console.log("服务费用：" + $scope.servicePrice);

            //拼装json
            console.log("$scope.actTotalMoney:" + $scope.actTotalMoney);
            console.log("$scope.actType:" + $scope.actType);
            console.log("$scope.packageCaterTotalMoney:" + $scope.packageCaterTotalMoney);
            console.log("$scope.packageCaterType:" + $scope.packageCaterType);
            console.log("$scope.babaYanTotalMoney:" + $scope.babaYanTotalMoney);
            console.log("$scope.babaYanType:" + $scope.babaYanType);
            console.log("$scope.serviceTotalMoney:" + $scope.serviceTotalMoney);
            console.log("$scope.serviceType:" + $scope.serviceType);
            console.log("$scope.singleFoodTotalMoney:" + $scope.singleFoodTotalMoney);
            console.log("$scope.singleFoodType:" + $scope.singleFoodType);
            console.log("$scope.weddingTotalMoney:" + $scope.weddingTotalMoney);
            console.log("$scope.weddingFoodType:" + $scope.weddingFoodType);

            $scope.arrayJson = "[";
            if ($scope.actTotalMoney != undefined && $scope.actType != undefined) {
                $scope.arrayJson += "{\"foodCategory\" : " + $scope.actType + ", \"price\" : " + $scope.actTotalMoney + "},";
            }
            if ($scope.packageCaterTotalMoney != undefined && $scope.packageCaterType != undefined) {
                $scope.arrayJson += "{\"foodCategory\" : " + $scope.packageCaterType + ", \"price\" : " + $scope.packageCaterTotalMoney + "},";
            }
            if ($scope.babaYanTotalMoney != undefined && $scope.babaYanType != undefined) {
                $scope.arrayJson += "{\"foodCategory\" : " + $scope.babaYanType + ", \"price\" : " + $scope.babaYanTotalMoney + "},";
            }
            if ($scope.serviceTotalMoney != undefined && $scope.serviceType != undefined) {
                $scope.arrayJson += "{\"foodCategory\" : " + $scope.serviceType + ", \"price\" : " + $scope.serviceTotalMoney + "},";
            }
            if ($scope.singleFoodTotalMoney != undefined && $scope.singleFoodType != undefined) {
                $scope.arrayJson += "{\"foodCategory\" : " + $scope.singleFoodType + ", \"price\" : " + $scope.singleFoodTotalMoney + "},";
            }
            if ($scope.weddingTotalMoney != undefined && $scope.weddingFoodType != undefined) {
                $scope.arrayJson += "{\"foodCategory\" : " + $scope.weddingFoodType + ", \"price\" : " + $scope.weddingTotalMoney + "},";
            }
            $scope.arrayJson = $scope.arrayJson.substring(0,$scope.arrayJson.length-1);
            $scope.arrayJson += "]";
            $scope.arrayJson = $scope.arrayJson.replace("\\", "");
            return JSON.stringify($scope.arrayJson);
        }
        //调用
        $scope.countJson = $scope.countMoneyOrNumber();
        var arr2 = {
            categoryPriceJsonData : $scope.countJson
        }
        //获取服务时间配置
        BJW.ajaxRequestData("get", false, BJW.ip+'/app/order/getConfigInfo', arr2, $scope.userToken , function(result){
            if(result.flag == 0 && result.code == 200){
                //赋值时间
                serviceConfigTime = result.data.time;//$scope.pointTime
                var date = new Date(serviceConfigTime);
                console.log(date.getMinutes());
                date.setMinutes((date.getMinutes() + $scope.pointTime * 60));
                console.log(date.getMinutes());
                console.log(date.getTime());
                serviceConfigTime = date.getTime();
                var dateStr = (date.getFullYear()) + "-" +
                        (date.getMonth() + 1) + "-" +
                        (date.getDate());
                $("#result").val(dateStr);
                var timeStr = date.getHours() + ":" + date.getMinutes();
                console.log("timeStr : " + timeStr);
                var $arrayTd = $(".time-table td");
                for (var i = 0; i < result.data.timeConfig.length; i++) {
                    //BJW.turnTime(result.data.time, "yyyy-MM-dd HH:mm:ss");
                    //console.log(BJW.turnTime(result.data.time, "yyyy-MM-dd HH:mm:ss"));
                    console.log(result.data.timeStr > "11:30");
                    if (result.data.timeConfig[i].time < timeStr) {
                        $($arrayTd[i]).html(result.data.timeConfig[i].time);
                        $($arrayTd[i]).attr("premium", result.data.timeConfig[i].price);
                        $($arrayTd[i]).addClass("overdue");
                    }
                    else {
                        $($arrayTd[i]).html(result.data.timeConfig[i].time);
                        $($arrayTd[i]).attr("premium", result.data.timeConfig[i].price);
                    }
                }
                //存放积分配置对象
                $scope.accumulateConfig = JSON.stringify(result.data.config);
                //赋值服务费--服务端反的服务费
                //$scope.servicePrice = result.data.servicePrice;
                //相加服务费
                //$scope.countMoney = $scope.servicePrice + $scope.countMoney;
                //$scope.countMoney = $scope.countMoney.toFixed(2);
                //赋值优惠券、现金券
                for (var i = 0; i < result.data.coupon.length; i++) {
                    if (result.data.coupon[i].type == 0) {
                        $scope.couponList.push(result.data.coupon[i]);
                        $scope.couponListInitial.push(result.data.coupon[i]);
                    }
                }
                for (var i = 0; i < result.data.coupon.length; i++) {
                    if (result.data.coupon[i].type == 1) {
                        $scope.cashCouponList.push(result.data.coupon[i]);
                        $scope.cashCouponListInitial.push(result.data.coupon[i]);
                    }
                }
                console.log("********存放可用优惠券、现金券**********");
                console.log($scope.couponList);
                console.log($scope.cashCouponList);
                console.log("********存放可用优惠券、现金券**********");

                //计算积分
                countAccumulate = $scope.userInfo.accumulate * (1 / result.data.config.accumulate);
                configAccumulate = result.data.config.accumulate;
                $("#accumulate").html($scope.userInfo.accumulate);
                $("#accumulateMoney").html(countAccumulate.toFixed(2));
                console.log("可抵金额：" + countAccumulate.toFixed(2));

            }
        });

        console.log("********可用的优惠券、现金券**********");
        console.log($scope.couponList);
        console.log($scope.cashCouponList);
        console.log("********可用的优惠券、现金券**********");
        //获取服务费可用的优惠券
        if ($scope.servicePrice > 0) {
            var couponList = $scope.calculateUserCoupon(15, $scope.servicePrice);
            console.log("服务费可用优惠券、现金券");
            console.log(couponList);
            console.log("服务费可用优惠券、现金券");
            if (couponList.length != 0) {
                for (var i = 0; i < couponList.length; i++) {
                    //判断该优惠券是否已经存在可用的优惠券当中了。
                    if (couponList[i].type == 0) {
                        var isBool = false;
                        for (var j = 0; j < $scope.couponList.length; j++) {
                            if ($scope.couponList[j].id == couponList[i].id) {
                                isBool = true;
                                break;
                            }
                        }
                        if (!isBool) {
                            $scope.couponList.push(couponList[i]);
                            $scope.couponListInitial.push(couponList[i]);
                        }
                    }
                    else if(couponList[i].type == 1) {
                        var isBool = false;
                        for (var j = 0; j < $scope.cashCouponList.length; j++) {
                            if ($scope.cashCouponList[j].id == couponList[i].id) {
                                isBool = true;
                                break;
                            }
                        }
                        if (!isBool) {
                            $scope.cashCouponList.push(couponList[i]);
                            $scope.cashCouponListInitial.push(couponList[i]);
                        }
                    }
                }
            }
        }

        //获取交通费可用的优惠券
        if ($scope.isRange > 0) {
            var couponList = $scope.calculateUserCoupon(16, $scope.isRange);
            console.log("交通费可用优惠券、现金券");
            console.log(couponList);
            console.log("交通费可用优惠券、现金券");
            if (couponList.length != 0) {
                for (var i = 0; i < couponList.length; i++) {
                    //判断该优惠券是否已经存在可用的优惠券当中了。
                    if (couponList[i].type == 0) {
                        var isBool = false;
                        for (var j = 0; j < $scope.couponList.length; j++) {
                            if ($scope.couponList[j].id == couponList[i].id) {
                                isBool = true;
                                break;
                            }
                        }
                        if (!isBool) {
                            $scope.couponList.push(couponList[i]);
                            $scope.couponListInitial.push(couponList[i]);
                        }
                    }
                    else if(couponList[i].type == 1) {
                        var isBool = false;
                        for (var j = 0; j < $scope.cashCouponList.length; j++) {
                            if ($scope.cashCouponList[j].id == couponList[i].id) {
                                isBool = true;
                                break;
                            }
                        }
                        if (!isBool) {
                            $scope.cashCouponList.push(couponList[i]);
                            $scope.cashCouponListInitial.push(couponList[i]);
                        }
                    }
                }
            }
        }

        console.log("********原始的优惠券、现金券**********");
        console.log($scope.couponListInitial);
        console.log($scope.cashCouponListInitial);
        console.log("********原始的优惠券、现金券**********");

        $scope.lastTimeCouponList = new Array(); //存放上一次选择的优惠券数据
        $scope.lastTimeCashList = new Array(); //存放上一次选择的现金券数据
        //选择时间
        $(".time-table tr td").each(function(){
            $(this).click(function (){
                var $thisClass = $(this).attr("class");
                console.log($thisClass);
                if ($thisClass != undefined && $thisClass != "") {
                    if ($thisClass.indexOf("overdue") != -1) {
                        mui.alert("该时间已过时");
                        return false;
                    }
                }
                else {
                    var obj = $(this);
                    $(".time-table tr td").removeClass("time-active");
                    obj.addClass("time-active");
                    $("#selectTime").val(obj.html());
                    $("#premium").html(obj.attr("premium"));
                    $("#premium2").html(obj.attr("premium"));
                    //赋值溢价
                    $scope.premiumMoney = parseFloat(obj.attr("premium"));
                    console.log($scope.premiumMoney);
                    if ($scope.premiumMoney <= 0) {
                        $("#premiumHtml").hide();
                        $("#premiumHtml2").hide();
                    }
                    else {
                        $("#premiumHtml").show();
                        $("#premiumHtml2").show();
                    }
                    totalMoney = parseFloat(totalMoney - lastNodeTime) + $scope.premiumMoney;
                    console.log("totalMoney ：" + totalMoney);
                    $("#countMoney").html(totalMoney.toFixed(2));
                    $scope.orderMoney = parseFloat($scope.orderMoney - lastNodeTime) + $scope.premiumMoney;
                    $scope.lastPremium = $scope.premiumMoney;//存放上一个溢价价格
                    console.log("计算出的订单总金额：" + $scope.orderMoney);
                    console.log("计算出的订单支付金额（来自溢价打印）：" + $scope.countMoney);
                    lastNodeTime = $scope.premiumMoney;

                    //获取溢价优惠券，现金券
                    var couponList = $scope.calculateUserCoupon(17,$scope.premiumMoney);

                    console.log("溢价可用优惠券、现金券");
                    console.log(couponList);
                    console.log("溢价可用优惠券、现金券");

                    console.log("********点击原始的优惠券、现金券**********");
                    console.log($scope.couponListInitial);
                    console.log($scope.cashCouponListInitial);
                    console.log("********点击原始的优惠券、现金券**********");

                    var couponArr = new Array();
                    var cashCouponArr = new Array();
                    for (var j = 0; j < $scope.couponListInitial.length; j++) {
                        couponArr.push( $scope.couponListInitial[j])
                    }
                    for (var j = 0; j < $scope.cashCouponListInitial.length; j++) {
                        cashCouponArr.push( $scope.cashCouponListInitial[j])
                    }
                    for (var i = 0; i < couponList.length; i++) {
                        //判断该优惠券是否已经存在可用的优惠券当中了。
                        if (couponList[i].type == 0) {
                            var isBool = false;
                            for(var k=0; k < couponArr.length; k++){
                                if(couponList[i].id == couponArr[k].id){
                                    isBool = true;
                                }
                            }
                            if(!isBool){
                                couponArr.push(couponList[i]);
                                continue;
                            }
                        }
                        else if(couponList[i].type == 1) {
                            var isBool = false;
                            for(var k=0; k < cashCouponArr.length; k++){
                                if(couponList[i].id == cashCouponArr[k].id){
                                    isBool = true;
                                }
                            }
                            if(!isBool){
                                cashCouponArr.push(couponList[i]);
                                continue;
                            }
                        }
                    }

                    console.log("临时优惠券");
                    console.log(couponArr);
                    console.log("临时优惠券");
                    console.log("临时现金券");
                    console.log(cashCouponArr);
                    console.log("临时现金券");

                    $timeout(function () {
                        $scope.couponList = couponArr;
                     });
                    $timeout(function () {
                        $scope.cashCouponList = cashCouponArr;
                    });

                }
            });
        });

        //会员卡抵扣
        if ($scope.userInfo != null) {
            $("#balance").html($scope.userInfo.balance.toFixed(2));
        }

        //去支付
        $scope.payment = function () {

            console.log($scope.waiterNumber);
            var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g; //emoji 表情正则
            if ($scope.address == null) {
                mui.toast("请选择服务地址.");
                return false;
            }
            else if ($("#result").val() == "选择日期") {
                mui.toast("请选择服务日期.");
                return false;
            }
            else if ($("#selectTime").val() == "") {
                mui.toast("请选择服务时间.");
                return false;
            }
            else if($("#reMarket").val().trim().match(regRule)) {
                mui.toast("备注不支持emoji表情.");
                return false;
            }

            var serviceTime = $("#result").val() + " " + $("#selectTime").val();
            console.log(serviceTime);
            var date = new Date(serviceTime);
            console.log(BJW.getTimeStamp(serviceTime));
            $scope.shopCarIds = "";
            //拼装json
            $scope.orderGoodsJson = "[";
            // 半餐演奏类
            if ($scope.actShopCarList != null) {
                for (var i = 0; i < $scope.actShopCarList.length; i++) {
                    $scope.shopCarIds += $scope.actShopCarList[i].id + ",";
                    $scope.orderGoodsJson += "{\"foodId\" : " + $scope.actShopCarList[i].foodId + ", \"foodCategoryId\" : " + $scope.actShopCarList[i].foodCategoryId + ", \"price\" : " + $scope.actShopCarList[i].price + ", \"imgUrl\" : \"" + $scope.actShopCarList[i].img + "\", \"number\" : " + $scope.actShopCarList[i].number + ", \"name\" : \"" + $scope.actShopCarList[i].name + "\"},";
                }
            }
            console.log($scope.babaYanShopCarList);
            console.log($scope.packageCaterShopCarList);
            // 套餐
            if ($scope.packageCaterShopCarList != null) {
                for (var i = 0; i < $scope.packageCaterShopCarList.length; i++) {
                    var object = (JSON.stringify($scope.packageCaterShopCarList[i].singleFoodList));
                    $scope.shopCarIds += $scope.packageCaterShopCarList[i].id + ",";
                    $scope.orderGoodsJson += "{\"foodId\" : " + $scope.packageCaterShopCarList[i].foodId + ", \"foodCategoryId\" : " + $scope.packageCaterShopCarList[i].foodCategoryId + ", \"price\" : " + $scope.packageCaterShopCarList[i].price + ", \"imgUrl\" : \"" + $scope.packageCaterShopCarList[i].img + "\", \"number\" : " + $scope.packageCaterShopCarList[i].number + ", \"name\" : \"" + $scope.packageCaterShopCarList[i].name + "\", \"detail\" : " + object + "},";
                }
            }
            // 坝坝宴类
            if ($scope.babaYanShopCarList != null) {
                for (var i = 0; i < $scope.babaYanShopCarList.length; i++) {
                    var object = (JSON.stringify($scope.babaYanShopCarList[i].singleFoodList));
                    $scope.shopCarIds += $scope.babaYanShopCarList[i].id + ",";
                    $scope.orderGoodsJson += "{\"foodId\" : " + $scope.babaYanShopCarList[i].foodId + ", \"foodCategoryId\" : " + $scope.babaYanShopCarList[i].foodCategoryId + ", \"price\" : " + $scope.babaYanShopCarList[i].price + ", \"imgUrl\" : \"" + $scope.babaYanShopCarList[i].img + "\", \"number\" : " + $scope.babaYanShopCarList[i].number + ", \"name\" : \"" + $scope.babaYanShopCarList[i].name + "\", \"detail\" : " + object + "},";
                }
            }
            // 专业服务类
            if ($scope.serviceShopCarList != null) {
                for (var i = 0; i < $scope.serviceShopCarList.length; i++) {
                    $scope.shopCarIds += $scope.serviceShopCarList[i].id + ",";
                    $scope.orderGoodsJson += "{\"foodId\" : " + $scope.serviceShopCarList[i].foodId + ", \"foodCategoryId\" : " + $scope.serviceShopCarList[i].foodCategoryId + ", \"price\" : " + $scope.serviceShopCarList[i].price + ", \"imgUrl\" : \"" + $scope.serviceShopCarList[i].img + "\", \"number\" : " + $scope.serviceShopCarList[i].number + ", \"name\" : \"" + $scope.serviceShopCarList[i].name + "\"},";
                }
            }
            // 婚庆类
            if ($scope.singleFoodShopCarList != null) {
                for (var i = 0; i < $scope.singleFoodShopCarList.length; i++) {
                    $scope.shopCarIds += $scope.singleFoodShopCarList[i].id + ",";
                    $scope.orderGoodsJson += "{\"foodId\" : " + $scope.singleFoodShopCarList[i].foodId + ", \"foodCategoryId\" : " + $scope.singleFoodShopCarList[i].foodCategoryId + ", \"price\" : " + $scope.singleFoodShopCarList[i].price + ", \"imgUrl\" : \"" + $scope.singleFoodShopCarList[i].img + "\", \"number\" : " + $scope.singleFoodShopCarList[i].number + ", \"name\" : \"" + $scope.singleFoodShopCarList[i].name + "\"},";
                }
            }
            //单点
            if ($scope.weddingShopCarList != null) {
                for (var i = 0; i < $scope.weddingShopCarList.length; i++) {
                    $scope.shopCarIds += $scope.weddingShopCarList[i].id + ",";
                    $scope.orderGoodsJson += "{\"foodId\" : " + $scope.weddingShopCarList[i].foodId + ", \"foodCategoryId\" : " + $scope.weddingShopCarList[i].foodCategoryId + ", \"price\" : " + $scope.weddingShopCarList[i].price + ", \"imgUrl\" : \"" + $scope.weddingShopCarList[i].img + "\", \"number\" : " + $scope.weddingShopCarList[i].number + ", \"name\" : \"" + $scope.weddingShopCarList[i].name + "\"},";
                }
            }
            $scope.orderGoodsJson = $scope.orderGoodsJson.substring(0, $scope.orderGoodsJson.length - 1);
            $scope.orderGoodsJson += "]";
            $scope.orderGoodsJson = $scope.orderGoodsJson.replace("\\", "");
            console.log(JSON.stringify($scope.orderGoodsJson));
            //购物车ID集合
            $scope.shopCarIds = $scope.shopCarIds.substring(0, $scope.shopCarIds.length - 1);

            var accumulateMoney = 0; //积分抵用了多少钱
            if (countAccumulate > parseFloat($("#countMoney").html())) {
                accumulateMoney = $scope.orderMoney;
            }
            else {
                accumulateMoney = countAccumulate;
            }

            //封装参数
            $scope.arr = {
                addressId : $scope.address.id, //地址ID
                serviceDateLong : BJW.getTimeStamp(serviceTime), //时间
                serviceCost : $scope.servicePrice, //服务费
                reMarket : $("#reMarket").val(), //备注
                price : $scope.orderMoney, //订单总价 -- 不包括积分抵换那些
                otherPay : parseFloat($("#countMoney").html()), //订单支付金额
                transportationCost : $scope.isRange, //交通费用
                premium : parseFloat($(".time-active").attr("premium")), //溢价费用
                coupon : lastNodeVoucher, //优惠券抵扣金额
                couponId : voucherId, //优惠券抵扣ID
                cashCoupon : lastNodeCash, //现金券抵扣金额
                cashCouponId : cashId, //现金券抵扣ID
                accumulate : accumulateMoney.toFixed(2), //积分抵扣金额
                accumulateNum : $scope.userInfo.accumulate - parseInt($("#shengYuAccumulate").html()), //被抵扣的积分数量
                balance : $("#onBalance").html() == "" ? 0 : parseFloat($("#onBalance").html()), //被抵扣的金额
                orderDetail : JSON.stringify($scope.orderGoodsJson),//订单 商品 详情
                shopCarIds : $scope.shopCarIds, //购物车ID集合
                accumulateConfig : $scope.accumulateConfig, //积分计算规则
                waiterNumber : $scope.waiterNumber, //服务员数量
            }

            if (parseFloat($("#countMoney").html()) == 0) {
                BJW.ajaxRequestData("POST", false, BJW.ip+'/app/order/addOrder', $scope.arr, $scope.userToken , function(result){
                    if(result.flag == 0 && result.code == 200){
                        window.location.href = BJW.ip + "/app/page/myOrder?isOpen=1&pageType=1";
                    }
                });
            }
            else {
                mui('#paymentPopup').popover('toggle');
                $("#payMoney").html(parseFloat($("#countMoney").html()).toFixed(2));
            }
        }


        //微信支付
        $scope.weiXinPayment = function () {
            mui('#paymentPopup').popover('toggle');
            if ($scope.orderId == null) {
                BJW.ajaxRequestData("POST", false, BJW.ip+'/app/order/addOrder', $scope.arr, $scope.userToken , function(result){
                    if(result.flag == 0 && result.code == 200){
                        $scope.orderId = result.data;
                        if ($scope.isWei) {
                            setTimeout(function () {
                                //微信端--微信支付
                                BJW.ajaxRequestData("post", false, BJW.ip+'/app/jsAPI/signByOrder', {orderId : $scope.orderId}, $scope.userToken , function(result){
                                    if(result.flag == 0 && result.code == 200){
                                        //alert(JSON.stringify(result.data));
                                        BJW.wechatPay(result.data.appId, result.data.timeStamp, result.data.nonceStr, result.data.package, result.data.signType, result.data.sign, "/app/page/myOrder");
                                    }
                                    else {
                                        mui.alert(result.msg);
                                    }
                                });
                            }, 100);
                        }
                        else {//移动端支付
                            try {
                                window.JSBridge.goPayment($scope.orderId, $scope.userToken, 0);
                            }
                            catch (error){}
                        }
                    }
                });
            }
            else {
                try {
                    window.JSBridge.goPayment($scope.orderId, $scope.userToken, 0);
                }
                catch (error){}
            }

        }
        //支付宝支付
        $scope.zhiFuBaoPayment = function () {
            mui('#paymentPopup').popover('toggle');
            if ($scope.orderId == null) {
                BJW.ajaxRequestData("POST", false, BJW.ip+'/app/order/addOrder', $scope.arr, $scope.userToken , function(result){
                    if(result.flag == 0 && result.code == 200){
                        $scope.orderId = result.data;
                        try {
                            window.JSBridge.goPayment($scope.orderId, $scope.userToken, 1);
                        }
                        catch (error){}
                    }
                });
            }
            else {
                try {
                    window.JSBridge.goPayment($scope.orderId, $scope.userToken, 1);
                }
                catch (error){}
            }

        }
        //线下支付
        $scope.xianXiaPayment = function () {
            mui('#paymentPopup').popover('toggle');
            mui.confirm('是否确认线下支付？', '', ["确认","取消"], function(e) {
                if (e.index == 0) {
                    if ($scope.orderId == null) {
                        BJW.ajaxRequestData("POST", false, BJW.ip+'/app/order/addOrder', $scope.arr, $scope.userToken , function(result){
                            if(result.flag == 0 && result.code == 200){
                                $scope.orderId = result.data;
                                BJW.ajaxRequestData("post", false, BJW.ip+'/app/order/orderOffLinePay', {orderId : $scope.orderId}, $scope.userToken , function(result){
                                    if(result.flag == 0 && result.code == 200){
                                        window.location.href = BJW.ip + "/app/page/myOrder?isOpen=1&pageType=4";
                                    }
                                });
                            }
                        });
                    }
                    else {
                        BJW.ajaxRequestData("post", false, BJW.ip+'/app/order/orderOffLinePay', {orderId : $scope.orderId}, $scope.userToken , function(result){
                            if(result.flag == 0 && result.code == 200){
                                window.location.href = BJW.ip + "/app/page/myOrder?isOpen=1&pageType=4";
                            }
                        });
                    }
                }
            });
        }

    });

    //移动端支付成功回调函数--暂无用
    function payCallback(payStatus) {
        if (payStatus == 0) { //支付失败
            mui.alert("支付失败.");
            window.history.go(-1);
            window.location.href = BJW.ip + "/app/page/myOrder?isOpen=1&pageType=1";
        }
        else if (payStatus == 1) { //支付成功
            mui.alert("支付成功.");
            window.history.go(-1);
            window.location.href = BJW.ip + "/app/page/myOrder?isOpen=1&pageType=1";
        }
    }

    mui.init({
        swipeBack: true //启用右滑关闭功能
    });

    var voucherRadioIsZero = false;
    var cashRadioIsZero = false;

    //选择优惠券
    function voucherRadio(obj){
        var isZero = $(obj).attr("isZero");
        console.log("isZero : " + isZero);
        if (totalMoney <= 0 && voucherRadioIsZero) {
            mui.alert("不可使用此优惠.");
            $(obj).removeAttr("checked");
            return false;
        }
        $("#voucherNeedSpend").html("满" + $(obj).attr("need") + "元使用");
        voucherId = $(obj).val();//存已选ID
        //可抵用券金额
        var voucherMoney = parseFloat($(obj).attr("price")).toFixed(2);
        console.log(totalMoney);
        if ((totalMoney + parseFloat(lastNodeVoucher)) - voucherMoney <= 0){
            lastNodeVoucher = totalMoney;
            totalMoney = 0;
        }
        else {
            totalMoney = (totalMoney + parseFloat(lastNodeVoucher)) - voucherMoney;
            lastNodeVoucher = voucherMoney;
        }

        if (totalMoney <= 0) {
            cashRadioIsZero = true;
            $(obj).attr("isZero", "true");
        }

        $("#countMoney").html(totalMoney.toFixed(2));
    }

    $(function () {
        totalMoney = parseFloat($("#countMoney").html()).toFixed(2);
    });

    //选择现金券
    function cashRadio(obj){
        var isZero = $(obj).attr("isZero");
        console.log("isZero : " + isZero);
        if (totalMoney <= 0 && cashRadioIsZero && !isZero) {
            mui.alert("不可使用此优惠.");
            $(obj).removeAttr("checked");
            return false;
        }
        console.log($(obj).attr("price"));
        $("#cashNeedSpend").html("￥" + $(obj).attr("price"));
        cashId = $(obj).val();//存已选ID
        //可抵用券金额
        var cashMoney = parseFloat($(obj).attr("price"));
        if (cashMoney >= totalMoney2) {
            if (isVoucher) {
                mui("#voucher").switch().toggle();
            }
        }
        if ((totalMoney + parseFloat(lastNodeCash)) - cashMoney <= 0) {
            lastNodeCash = totalMoney2;
            totalMoney = 0;
        }
        else {
            totalMoney = (totalMoney + parseFloat(lastNodeCash)) - cashMoney;
            lastNodeCash = cashMoney;
        }

        if (totalMoney <= 0) {
            voucherRadioIsZero = true;
            $(obj).attr("isZero", "true");
        }

        $("#countMoney").html(totalMoney.toFixed(2));
    }

    var isVoucher = false;//存放优惠卷开关状态
    //优惠券开关状态
    document.getElementById("voucher").addEventListener('toggle',function (e) {
        var isActive = e.detail.isActive;//获取开关状态
        console.debug(isActive);
        if (isActive) {
            $("#voucherDiv").slideDown();
            isVoucher = true;
        }
        else {
            isVoucher = false;
            totalMoney = (parseFloat(totalMoney) + parseFloat(lastNodeVoucher));
            if (totalMoney != undefined) {
                $("#countMoney").html(totalMoney.toFixed(2));
            }
            else {
                mui.alert("计算金额出错.");
            }
            $("#voucherNeedSpend").html("");
            $("#voucherDiv").slideUp();
            voucherId = 0; //关闭还原已选优惠券ID
            $(".voucher-radio").removeAttr("checked");
            lastNodeVoucher = 0; //关闭之后上一次的存放金额全部至0
        }
    });

    //现金券开关状态
    document.getElementById("cash").addEventListener('toggle',function (e) {
        var isActive = e.detail.isActive;//获取开关状态
        console.debug(isActive);
        if (isActive) {
            $("#cashDiv").slideDown();
        }
        else {
            totalMoney = (parseFloat(totalMoney) + parseFloat(lastNodeCash));
            if (totalMoney != undefined) {
                $("#countMoney").html(totalMoney.toFixed(2));
            }
            else {
                mui.alert("计算金额出错.");
            }

            $("#cashDiv").slideUp();
            $("#cashNeedSpend").html("");
            cashId = 0; //关闭还原已选现金券
            $(".cash-radio").removeAttr("checked");
            lastNodeCash = 0; //关闭之后上一次的存放金额全部至0
        }
    });

    //积分开关状态
    document.getElementById("integral").addEventListener('toggle',function (e) {
        var isActive = e.detail.isActive;//获取开关状态
        console.debug(isActive);
        //可抵用钱
        var accumulateMoney = parseFloat($("#accumulateMoney").html()).toFixed(2);
        console.log("获取可抵用金额：" + accumulateMoney);
        //var totalMoney = totalMoney * (1 / configAccumulate);
        if (isActive) {
            if (parseFloat(totalMoney) <= 0) {
                return false;
            }
            if (parseFloat(totalMoney) - parseFloat(accumulateMoney) <= 0) {
                var surplusIntegral = parseFloat(accumulateMoney) * configAccumulate - parseFloat(totalMoney) * configAccumulate;
                totalMoney = 0;
                $("#shengYuAccumulate").html(surplusIntegral.toFixed(0));
                $("#shengYu").show();
            }
            else {
                totalMoney = parseFloat(totalMoney) - parseFloat(accumulateMoney);
                var surplusIntegral = 0;
                $("#shengYuAccumulate").html(surplusIntegral);
                $("#shengYu").show();
            }

            $("#countMoney").html(totalMoney.toFixed(2));
        }
        else {
            $("#shengYu").hide();
            var surplusIntegral = parseFloat($("#shengYuAccumulate").html());
            var accumulate = parseFloat($("#accumulate").html());
            totalMoney = totalMoney + (accumulate -surplusIntegral) / configAccumulate;
            console.log(totalMoney);
            //totalMoney = parseFloat(totalMoney) + parseFloat(accumulateMoney);
            $("#countMoney").html(totalMoney.toFixed(2));
        }
    });

    //会员卡开关状态
    document.getElementById("memberCard").addEventListener('toggle',function (e) {
        var isActive = e.detail.isActive;//获取开关状态
        console.debug(isActive);
        //会员卡总金额
        var balance = parseFloat($("#balance").html());
        console.log("获取会员卡总金额：" + balance);
        if (isActive) {
            if (balance > totalMoney) {
                balance = parseFloat(balance) - parseFloat(totalMoney);
                $("#surplus").html(balance.toFixed(2)); //剩余余额
                $("#onBalance").html(totalMoney.toFixed(2)); //抵用了余额
                totalMoney = 0;
            }
            else {
                totalMoney = parseFloat(totalMoney) - parseFloat(balance);
                $("#onBalance").html(balance.toFixed(2)); //抵用了余额
                balance = 0;
                $("#surplus").html(balance.toFixed(2)); //剩余余额
            }
            $("#countMoney").html(totalMoney.toFixed(2));
            $("#memberCardMoney").show();
        }
        else {

            $("#memberCardMoney").hide();
            var onBalance = $("#onBalance").html(); //抵用了余额
            var surplus = $("#surplus").html();  //剩余余额
            totalMoney = parseFloat(totalMoney) + parseFloat(onBalance);

            $("#countMoney").html(totalMoney.toFixed(2));
        }
    });

    //初始化时间
    (function($) {
        $.init();
        var result = $('#result')[0];
        var btns = $('.btn');
        btns.each(function(i, btn) {
            btn.addEventListener('tap', function() {
                var optionsJson = this.getAttribute('data-options') || '{}';
                var options = JSON.parse(optionsJson);
                var id = this.getAttribute('id');
                /*
                 * 首次显示时实例化组件
                 * 示例为了简洁，将 options 放在了按钮的 dom 上
                 * 也可以直接通过代码声明 optinos 用于实例化 DtPicker
                 */
                //不能选择以前时间
                var now=new Date(serviceConfigTime);
                options.beginYear=now.getFullYear();
                options.beginMonth=now.getMonth()+1;
                options.beginDay=now.getDate();
                options.beginHours=now.getHours()+1;
                var picker = new mui.DtPicker(options);
                $("#result").on('tap', function() {picker.show(function(rs) {
                    $("#result").val(rs.y.text+'-'+rs.m.text+'-'+rs.d.text);});
                }, false);
                picker.show(function(rs) {
                    /*
                     * rs.value 拼合后的 value
                     * rs.text 拼合后的 text
                     * rs.y 年，可以通过 rs.y.vaue 和 rs.y.text 获取值和文本
                     * rs.m 月，用法同年
                     * rs.d 日，用法同年
                     * rs.h 时，用法同年
                     * rs.i 分（minutes 的第二个字母），用法同年
                     */
                    result.value = rs.text;
                    document.getElementById("myLabel").value = rs.text;
                    console.log(serviceConfigTime);
                    var currentTime = new Date(serviceConfigTime);
                    var date = (currentTime.getFullYear()) + "-" +
                            (currentTime.getMonth() + 1) + "-" +
                            (currentTime.getDate());
                    var selectTime = result.value;
                    var d1 = new Date(date.replace(/\-/g, "\/"));
                    var d2 = new Date(selectTime.replace(/\-/g, "\/"));

                    if(currentTime != "" && selectTime != "" && d1 < d2)
                    {
                        configTime();
                        //return false;
                    }
                    else {
                        eqTime();
                    }
                    console.log(result.value);
                    /*
                     * 返回 false 可以阻止选择框的关闭
                     * return false;
                     */
                    /*
                     * 释放组件资源，释放后将将不能再操作组件
                     * 通常情况下，不需要示放组件，new DtPicker(options) 后，可以一直使用。
                     * 当前示例，因为内容较多，如不进行资原释放，在某些设备上会较慢。
                     * 所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例。
                     */
                    picker.dispose();
                });
            }, false);
        });
    })(mui);

    var tableHtml = null;
    //选择时间等于当前时间
    function eqTime() {
        console.log(tableHtml);
        if (tableHtml != null) {
            $(".time-table").html(tableHtml);
            tableHtml = tableHtml.clone(true);
        }
    }
    //选择时间大于当前时间
    function configTime() {
        console.log(tableHtml);
        if (tableHtml == null) {
            tableHtml = $(".time-table").clone(true);
        }
        $(".time-table tr td").removeClass("overdue").removeClass("time-active");
        $("#premiumHtml").hide();
        $("#premiumHtml2").hide();
    }



    setTimeout(function (){
        BJW.closeDialogLoading();//关闭弹窗loading
    },1000);


</script>
</body>

</html>