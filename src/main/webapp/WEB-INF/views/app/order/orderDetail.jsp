<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>订单详情</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/order/orderDetail.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="orderDetailCtr" ng-cloak>
<div class="mui-content">

    <!--订单状态栏-->
    <div class="status-bar">
        <table>
            <tr>
                <td ng-show="order.status == 2001" class="order-active">
                    <div class="border-bar">
                        <img class="img-active" src="<%=request.getContextPath()%>/appResources/img/person/order.png">
                    </div>
                    <p class="order-font">待支付</p>
                </td>
                <td ng-show="order.status != 2001">
                    <div class="border-bar">
                        <img class="flow" src="<%=request.getContextPath()%>/appResources/img/person/flow-active.png">
                    </div>
                    <p>待支付</p>
                </td>

                <td ng-show="order.status == 2002" class="order-active">
                    <div class="border-bar">
                        <img class="img-active" src="<%=request.getContextPath()%>/appResources/img/person/order.png">
                    </div>
                    <p class="order-font">待确认</p>
                </td>
                <td ng-show="order.status < 2002">
                    <div class="border-bar">
                        <img class="flow" src="<%=request.getContextPath()%>/appResources/img/person/flow.png">
                    </div>
                    <p>待确认</p>
                </td>
                <td ng-show="order.status > 2002">
                    <div class="border-bar">
                        <img class="flow" src="<%=request.getContextPath()%>/appResources/img/person/flow-active.png">
                    </div>
                    <p>待确认</p>
                </td>

                <td ng-show="order.status == 2003" class="order-active">
                    <div class="border-bar">
                        <img class="img-active" src="<%=request.getContextPath()%>/appResources/img/person/order.png">
                    </div>
                    <p class="order-font">待服务</p>
                </td>
                <td ng-show="order.status < 2003">
                    <div class="border-bar">
                        <img class="flow" src="<%=request.getContextPath()%>/appResources/img/person/flow.png">
                    </div>
                    <p>待服务</p>
                </td>
                <td ng-show="order.status > 2003">
                    <div class="border-bar">
                        <img class="flow" src="<%=request.getContextPath()%>/appResources/img/person/flow-active.png">
                    </div>
                    <p>待服务</p>
                </td>

                <td ng-show="order.status == 2004" class="order-active">
                    <div class="border-bar">
                        <img class="img-active" src="<%=request.getContextPath()%>/appResources/img/person/order.png">
                    </div>
                    <p class="order-font">服务中</p>
                </td>
                <td ng-show="order.status < 2004">
                    <div class="border-bar">
                        <img class="flow" src="<%=request.getContextPath()%>/appResources/img/person/flow.png">
                    </div>
                    <p>服务中</p>
                </td>
                <td ng-show="order.status > 2004">
                    <div class="border-bar">
                        <img class="flow" src="<%=request.getContextPath()%>/appResources/img/person/flow-active.png">
                    </div>
                    <p>服务中</p>
                </td>

                <td ng-show="order.status == 2005" class="order-active">
                    <div class="border-bar">
                        <img class="img-active" src="<%=request.getContextPath()%>/appResources/img/person/order.png">
                    </div>
                    <p class="order-font">完成</p>
                </td>
                <td ng-show="order.status < 2005">
                    <div class="border-bar">
                        <img class="flow" src="<%=request.getContextPath()%>/appResources/img/person/flow.png">
                    </div>
                    <p>完成</p>
                </td>
                <td ng-show="order.status > 2005">
                    <div class="border-bar">
                        <img class="flow" src="<%=request.getContextPath()%>/appResources/img/person/flow-active.png">
                    </div>
                    <p>完成</p>
                </td>

                <td ng-show="order.status == 2006" class="order-active">
                    <div class="border-bar">
                        <img class="img-active" src="<%=request.getContextPath()%>/appResources/img/person/order.png">
                    </div>
                    <p class="order-font">待评价</p>
                </td>
                <td ng-show="order.status < 2006">
                    <div class="border-bar">
                        <img class="flow" src="<%=request.getContextPath()%>/appResources/img/person/flow.png">
                    </div>
                    <p>待评价</p>
                </td>
                <td ng-show="order.status > 2006">
                    <div class="border-bar">
                        <img class="flow" src="<%=request.getContextPath()%>/appResources/img/person/flow-active.png">
                    </div>
                    <p>待评价</p>
                </td>

            </tr>
        </table>
    </div>

    <div class="address-bar">
        <ul class="mui-table-view">
            <li class="mui-table-view-cell mui-media">
                <a href="javascript:;">
                    <img class="mui-media-object mui-pull-left address-icon" src="<%=request.getContextPath()%>/appResources/img/person/address.png">
                    <div class="mui-media-body">
                        <div class="mui-row">
                            <div class="mui-col-xs-3 mui-col-sm-3">
                                <p class="title-hint">联系人：</p>
                                <p class="title-hint">服务时间：</p>
                                <p class="title-hint">服务地址：</p>
                            </div>
                            <div class="mui-col-xs-9 mui-col-sm-9">
                                <p class="title-hint">
                                    <span class="user-name">{{order.userAddress.contact}}</span>
                                    <span class="user-phone">{{order.userAddress.contactPhone}}</span>
                                </p>
                                <p class="title-hint" style="margin-top: 8px">{{order.serviceDate}}</p>
                                <p class="title-hint">{{order.userAddress.address}}</p>
                            </div>
                        </div>
                    </div>
                </a>
            </li>
        </ul>
    </div>

    <div class="order-bar">
        <div class="order-num">
            订单列表
        </div>
        <ul class="mui-table-view">
            <li class="mui-table-view-cell mui-media" ng-repeat="goods in order.orderDetail" ng-show="goods.foodCategoryId != 11 && goods.foodId > 4 && order != null">
                <a href="javascript:;" ng-show="goods.foodCategoryId != 11 && goods.foodId > 4">
                    <img class="mui-media-object mui-pull-left goods-img" src="<%=request.getContextPath()%>/{{goods.imgUrl}}">
                    <div class="mui-media-body">
                        <span class="goods-name">{{goods.name}}</span>
                        <p class="goods-p">
                            <span class="goods-price">￥{{goods.price}}</span>
                            <span class="goods-num">x{{goods.number}}</span>
                        </p>
                    </div>
                </a>
            </li>
            <li class="mui-table-view-cell mui-media" ng-repeat="goods in order.orderDetail" ng-show="goods.foodCategoryId == 11 && goods.foodId < 4 && order != null">
                <a href="javascript:;">
                    <span class="mui-media-object mui-pull-left service-money">{{goods.name}}</span>
                    <div class="mui-media-body">
                        <span class="goods-price">￥{{goods.price}}</span>
                        <span class="goods-num">x{{goods.number}}</span>
                    </div>
                </a>
            </li>
            <li class="mui-table-view-cell mui-media">
                <a href="javascript:;">
                    <span class="mui-media-object mui-pull-left service-money">服务</span>
                    <div class="mui-media-body">
                        <span class="goods-price">￥{{order.serviceCost}}</span>
                        <%--<span class="goods-num">x1</span>--%>
                    </div>
                </a>
            </li>
        </ul>
        <div class="use-time-bar">
            用餐时间：
            <span class="use-time">{{order.serviceDate}}</span>
        </div>
        <div class="total-bar">
            共{{order.orderDetail.length}}件商品，合计：<span class="total-price">￥{{order.otherPay}}</span>
        </div>
    </div>

    <!--厨师信息-->
    <div class="order-bar" ng-if="order.mainCook != null">
        <div class="order-num">
            厨师信息
        </div>
        <ul class="mui-table-view">
            <li class="mui-table-view-cell mui-media">
                <a href="javascript:void(0);">
                    <img ng-if="order.mainCook.avatar == null" class="mui-media-object mui-pull-left cook-head" src="<%=request.getContextPath()%>/appResources/img/icon/default-head.png">
                    <img ng-if="order.mainCook.avatar != null" class="mui-media-object mui-pull-left cook-head" src="<%=request.getContextPath()%>/{{order.mainCook.avatar}}">
                    <div class="mui-media-body">
                        <p class="cook-name">{{order.mainCook.realName}}</p>
                        <p class="cook-phone">联系电话：<span>{{order.mainCook.phoneNumber}}</span></p>
                    </div>
                    <div class="dial-phone">
                        <a href="tel:{{order.mainCook.phoneNumber}}">
                            <img src="<%=request.getContextPath()%>/appResources/img/person/phone.png">
                        </a>
                    </div>
                </a>
            </li>
        </ul>
    </div>

    <!--支付状态-->
    <div class="order-info">
        <p>订单编号：{{order.orderNumber}}</p>
        <p>创建时间：{{order.createTime}}</p>
        <p ng-if="order.payMethod == 0">付款方式：微信</p>
        <p ng-if="order.payMethod == 1">付款方式：支付宝</p>
        <p ng-if="order.payMethod == 2">付款方式：线下</p>
    </div>

</div>

<!--合计-->
<nav class="mui-bar mui-bar-tab car-bottom">
    <div class="mui-tab-item car-popup-right" ng-show="order.status == 2001">
        <div class="mui-btn mui-btn-danger cancel-btn" ng-click="cancelOrder()">取消订单</div>
        <div class="mui-btn mui-btn-danger payment-btn" ng-click="goPaymentPopup()">去支付</div>
    </div>
    <div class="mui-tab-item car-popup-right" ng-show="order.status == 2002">
        <div class="mui-btn mui-btn-danger cancel-btn" ng-click="cancelOrder()">取消订单</div>
    </div>
    <div class="mui-tab-item car-popup-right" ng-show="order.status == 2003">
        <div class="mui-btn mui-btn-danger cancel-btn" ng-click="cancelOrder()">取消订单</div>
    </div>
    <div class="mui-tab-item car-popup-right" ng-show="order.status == 2004">
        <div class="mui-btn mui-btn-danger cancel-btn" disabled="disabled">服务中··</div>
    </div>
    <div class="mui-tab-item car-popup-right" ng-show="order.status == 2005">
        <div class="mui-btn mui-btn-danger cancel-btn" ng-click="deleteOrder()">删除订单</div>
        <div class="mui-btn mui-btn-danger payment-btn" ng-click="goEvaluate()">去评价</div>
    </div>
    <div class="mui-tab-item car-popup-right" ng-show="order.status == 2006">
        <div class="mui-btn mui-btn-danger cancel-btn" ng-click="deleteOrder()">删除订单</div>
        <div class="mui-btn mui-btn-danger payment-btn" ng-click="goEvaluate()">去评价</div>
    </div>
    <div class="mui-tab-item car-popup-right" ng-show="order.status == 2007">
        <div class="mui-btn mui-btn-danger cancel-btn" ng-click="deleteOrder()">删除订单</div>
        <div class="mui-btn mui-btn-danger payment-btn" disabled="disabled">已评价</div>
    </div>
    <div class="mui-tab-item car-popup-right" ng-show="order.status == 2008">
        <div class="mui-btn mui-btn-danger cancel-btn" ng-click="deleteOrder()">删除订单</div>
        <div class="mui-btn mui-btn-danger payment-btn" disabled="disabled">已完成</div>
    </div>
    <div class="mui-tab-item car-popup-right" ng-show="order.status == 2009">
        <div class="mui-btn mui-btn-danger cancel-btn" ng-click="deleteOrder()">删除订单</div>
        <div class="mui-btn mui-btn-danger payment-btn" disabled="disabled">已取消</div>
    </div>

</nav>

<!-- 选择支付弹窗 -->
<div id="paymentPopup" class="mui-popover mui-popover-action mui-popover-bottom">
    <ul class="mui-table-view">
        <li class="mui-table-view-cell">
            <div class="orderMoneyDiv">订单金额：<span class="orderMoney">￥<span id="payMoney">{{order.otherPay}}</span></span></div>
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

<script type="text/javascript">

    $("body").append(BJW.dialogLoading("加载中···"));//弹窗loading

    var webApp=angular.module('webApp',[]);
    //填写订单
    webApp.controller('orderDetailCtr',function($scope,$http,$timeout){
        //获取登录用户token
        $scope.userToken = BJW.getLocalStorageToken();
        console.log("token:" + $scope.userToken);
        $scope.isWei = BJW.isWeiXin();//是否是微信
        $scope.order = null;
        $scope.orderId = localStorage.getItem("orderId");
        if ($scope.orderId != null) {
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/order/queryOrderById', {orderId : $scope.orderId}, $scope.userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    $scope.order = result.data;
                    $scope.order.orderDetail = JSON.parse(JSON.parse($scope.order.orderDetail));
                    $scope.order.serviceDate = new Date($scope.order.serviceDate).format("yyyy-MM-dd hh:mm:ss");
                }
            });
        }
        else {
            location.href =  BJW.ip + "/app/page/myOrder?isOpen=1";
        }
        console.log($scope.order);

        //去评价
        $scope.goEvaluate = function () {
            console.log(JSON.stringify(JSON.stringify($scope.order.orderDetail)));
            $scope.order.orderDetail = JSON.stringify(JSON.stringify($scope.order.orderDetail));
            console.log(JSON.stringify($scope.order));
            localStorage.setItem("orderDetail", JSON.stringify($scope.order));
            location.href = BJW.ip + "/app/page/orderEvaluate?isOpen=1";
        }

        //删除订单
        $scope.deleteOrder = function () {
            mui.confirm('是否确认删除订单？', '', ["确认","取消"], function(e) {
                if (e.index == 0) {
                    BJW.ajaxRequestData("post", false, BJW.ip+'/app/order/delOrder', {orderId : $scope.orderId}, $scope.userToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            if (BJW.isWeiXin()) {
                                window.history.go(-1);
                            }
                            else {
                                location.href = BJW.ip + "/app/page/myOrder?isOpen=1&pageType=2";
                            }
                        }
                    });
                }
            });
        }

        //取消订单
        $scope.cancelOrder = function () {
            var btnArray = ['不，手滑', '取消订单'];
            mui.confirm('您确认要取消该订单？', '&nbsp;', btnArray, function(e) {
                if (e.index == 0) {

                } else {
                    BJW.cookAjaxRequestData("post", false, BJW.ip+'/app/order/cancelOrder', {orderId : $scope.orderId}, $scope.userToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            if (BJW.isWeiXin()) {
                                window.history.go(-1);
                            }
                            else {
                                location.href = BJW.ip + "/app/page/myOrder?isOpen=1&pageType=2";
                            }
                        }
                    });
                }
            });
        }

        //去支付
         $scope.goPaymentPopup = function (){
            //弹出菜单的显示、隐藏
            mui('#paymentPopup').popover('toggle');
        }

        //微信支付
        $scope.weiXinPayment = function () {
            mui('#paymentPopup').popover('toggle');
            if ($scope.isWei) {
                setTimeout(function () {
                    //微信端--微信支付
                    BJW.ajaxRequestData("post", false, BJW.ip+'/app/jsAPI/signByOrder', {orderId : $scope.orderId}, $scope.userToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            //alert(JSON.stringify(result.data));
                            BJW.wechatPay(result.data.appId, result.data.timeStamp, result.data.nonceStr, result.data.package, result.data.signType, result.data.sign, null);
                        }
                        else {
                            mui.alert(result.msg);
                        }
                    });
                }, 100);
            }
            else {//移动端支付
                window.JSBridge.goPayment($scope.orderId, $scope.userToken, 0);
            }
        }
        //支付宝支付
        $scope.zhiFuBaoPayment = function () {
            mui('#paymentPopup').popover('toggle');
            window.JSBridge.goPayment($scope.orderId, $scope.userToken, 1);
        }
        //线下支付
        $scope.xianXiaPayment = function () {
            mui('#paymentPopup').popover('toggle');
            mui.confirm('是否确认线下支付？', '', ["确认","取消"], function(e) {
                if (e.index == 0) {
                    BJW.ajaxRequestData("post", false, BJW.ip+'/app/order/orderOffLinePay', {orderId : $scope.orderId}, $scope.userToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            window.location.reload();
                        }
                    });
                }
            });

        }

    });

    //支付宝回调函数
    function payCallback(status){
        if(status == 1){
            location.reload();
        }else{
            mui.alert("支付失败");
        }
    }


    mui.init({
        swipeBack: true //启用右滑关闭功能
    });

    setTimeout(function (){
        BJW.closeDialogLoading();//关闭弹窗loading
    },500);

</script>
</body>

</html>