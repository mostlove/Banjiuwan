<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>订单详情</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/cook/cookOrderDetail.css" charset="UTF-8">
    <style>


    </style>

</head>

<body ng-app="webApp" ng-controller="orderDetailCtr" ng-cloak>
<div class="mui-content">

    <div class="order-bar">
        <div class="order-num">
            订单号：<span>{{order.orderNumber}}</span>
            <span class="delete-btn" ng-click="deleteOrder()" ng-show="order.status == 2005 || order.status == 2006 || order.status == 2007 || order.status == 2009"><i class="mui-icon mui-icon-trash"></i></span>
            <span class="order-status status-1" ng-show="order.status == 2001">待支付</span>
            <span class="order-status status-1" ng-show="order.status == 2002">待确认</span>
            <span class="order-status status-1" ng-show="order.status == 2003">待服务</span>
            <span class="order-status status-1" ng-show="order.status == 2004">服务中</span>
            <span class="order-status status-1" ng-show="order.status == 2005">完成</span>
            <span class="order-status status-1" ng-show="order.status == 2006">待评价</span>
            <span class="order-status status-1" ng-show="order.status == 2007">评价完成</span>
            <span class="order-status status-1" ng-show="order.status == 2008">待接单</span>
            <span class="order-status status-1" ng-show="order.status == 2009">订单已取消</span>
        </div>
        <div class="address-bar">
            <ul class="mui-table-view">
                <li class="mui-table-view-cell mui-media">
                    <a href="javascript:;">
                        <%--<img class="mui-media-object mui-pull-left address-icon" src="<%=request.getContextPath()%>/appResources/img/person/address.png">--%>
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
                                    <p class="title-hint">{{order.serviceDate}}</p>
                                    <p class="title-hint">{{order.userAddress.detailAddress}}</p>
                                </div>
                            </div>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <div class="order-bar">
        <div class="order-num">
            订单列表
        </div>
        <ul class="mui-table-view">
            <li class="mui-table-view-cell mui-media" ng-repeat="goods in order.orderDetail" ng-if="order != null">
                <a href="javascript:;">
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
        <div class="total-bar">
            共{{order.orderDetail.length}}件商品，合计：<span class="total-price">￥{{order.otherPay}}</span>
        </div>
    </div>

</div>


<nav class="mui-bar mui-bar-tab tab-bottom">
    <div class="operation-bar">
        <div class="mui-row">
            <!--待接单-->
            <div class="mui-col-xs-6 mui-col-sm-6" ng-show="order.status == 2008">
                <a class="operation-btn border-right" href="javascript:void(0)" ng-click="confirmOrders()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/cook-icon-3.png">
                    确认接单
                </a>
            </div>
            <!--待服务-->
            <div class="mui-col-xs-6 mui-col-sm-6" ng-show="order.status == 2003">
                <a class="operation-btn border-right" href="javascript:void(0)" ng-click="startService()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/cook-icon-1.png">
                    开始服务
                </a>
            </div>
            <!--服务中-->
            <div class="mui-col-xs-6 mui-col-sm-6" ng-show="order.status == 2004">
                <a class="operation-btn border-right" href="javascript:void(0)" ng-click="serviceConfirm()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/cook-icon-2.png">
                    服务完成
                </a>
            </div>
            <!--已完成-->
            <div class="mui-col-xs-6 mui-col-sm-6" ng-show="order.status == 2005">
                <a disabled type="button" class="operation-btn border-right isConfirm" href="javascript:void(0)">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/cook-icon-2.png">
                    已完成
                </a>
            </div>
            <div class="mui-col-xs-6 mui-col-sm-6">
                <a class="operation-btn" href="tel:{{order.userAddress.contactPhone}}">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/cook-icon-4.png">
                    联系客户
                </a>
            </div>
        </div>
    </div>
</nav>



<!--引入抽取js文件-->
<%@include file="../common/public-js.jsp" %>

<script type="text/javascript">

    $("body").append(BJW.dialogLoading("加载中···"));//弹窗loading

    var webApp=angular.module('webApp',[]);
    //填写订单
    webApp.controller('orderDetailCtr',function($scope,$http,$timeout){
        //获取登录用户token
        $scope.cookToken = BJW.getLocalStorageCookToken();
        console.log("token:" + $scope.cookToken);
        $scope.isWei = BJW.isWeiXin();//是否是微信
        $scope.order = null;
        $scope.orderId = localStorage.getItem("orderId");
        if ($scope.orderId != null) {
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/order/queryOrderById', {orderId : $scope.orderId}, $scope.cookToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    $scope.order = result.data;
                    $scope.order.orderDetail = JSON.parse(JSON.parse($scope.order.orderDetail));
                    $scope.order.serviceDate = new Date($scope.order.serviceDate).format("yyyy-MM-dd hh:mm:ss");
                }
            });
        }
        else {
            location.href =  BJW.ip + "/app/page/cookMyOrder?isOpen=1";
        }
        console.log($scope.order);

        //确认接单
        $scope.confirmOrders = function () {
            if ($scope.order.isMain == 0) {
                mui.alert("抱歉,您不是主厨,不能做此操作.");
            }
            else {
                var arr = {
                    orderId : $scope.order.id,
                    flag : 0
                }
                mui.confirm('是否确认接单？', '', ["确认","取消"], function(e) {
                    if (e.index == 0) {
                        BJW.cookAjaxRequestData("post", false, BJW.ip+'/app/order/cookUpdateOrder', arr, $scope.cookToken , function(result){
                            if(result.flag == 0 && result.code == 200){
                                location.reload();
                            }
                        });
                    } else {

                    }
                });
            }
        }

        //开始服务
        $scope.startService = function (){
            if ($scope.order.isMain == 0) {
                mui.alert("抱歉,您不是主厨,不能做此操作.");
            }
            else {
                var arr = {
                    orderId : $scope.order.id,
                    flag : 1
                }
                mui.confirm('是否确认开始服务？', '', ["确认","取消"], function(e) {
                    if (e.index == 0) {
                        BJW.cookAjaxRequestData("post", false, BJW.ip+'/app/order/cookUpdateOrder', arr, $scope.cookToken , function(result){
                            if(result.flag == 0 && result.code == 200){
                                location.reload();
                            }
                        });
                    } else {

                    }
                });
            }
        }
        //服务完成
        $scope.serviceConfirm = function (isMain, orderId, payMethod){
            if ($scope.order.isMain == 0) {
                mui.alert("抱歉,您不是主厨,不能做此操作.");
            }
            else {
                var arr = {
                    orderId : $scope.order.id,
                    flag : 2
                }
                if ($scope.order.payMethod != 2) {
                    mui.confirm('是否确认服务完成？', '', ["确认","取消"], function(e) {
                        if (e.index == 0) {
                            BJW.cookAjaxRequestData("post", false, BJW.ip+'/app/order/cookUpdateOrder', arr, $scope.cookToken , function(result){
                                if(result.flag == 0 && result.code == 200){
                                    location.reload();
                                }
                            });
                        } else {

                        }
                    });
                }
                else {
                    mui.confirm('此单为线下订单，请确认是否收款？', '', ["确认","取消"], function(e) {
                        if (e.index == 0) {
                            BJW.cookAjaxRequestData("post", false, BJW.ip+'/app/order/cookUpdateOrder', arr, $scope.cookToken , function(result){
                                if(result.flag == 0 && result.code == 200){
                                    location.reload();
                                }
                            });
                        } else {

                        }
                    });
                }


            }
        }

        //删除订单
        $scope.deleteOrder = function () {
            mui.confirm('是否确认删除订单？', '', ["确认","取消"], function(e) {
                if (e.index == 0) {
                    BJW.cookAjaxRequestData("post", false, BJW.ip+'/app/order/delOrder', {orderId : $scope.orderId}, $scope.cookToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            if (BJW.isWeiXin()) {
                                window.history.go(-1);
                            }
                            else {
                                location.href = BJW.ip + "/app/page/cookMyOrder?isOpen=1&pageType=2";
                            }
                        }
                    });
                }
            });
        }

    });

    // 监听tap事件，解决 a标签 不能跳转页面问题
    //mui('body').on('tap','a',function(){document.location.href=this.href;});

    mui.init({
        swipeBack: false
    });

    setTimeout(function (){
        BJW.closeDialogLoading();//关闭弹窗loading
    },1000);

</script>
</body>

</html>