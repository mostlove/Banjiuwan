<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>购物车</title>
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/car/car.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="carCtr" ng-cloak>
    <div class="mui-content"<%-- ng-if="actShopCarList != null || packageCaterShopCarList != null || babaYanShopCarList != null || serviceShopCarList != null || singleFoodShopCarList != null || weddingShopCarList != null"--%>>
        <!-- 单点菜品 -->
        <div ng-if="singleFoodShopCarList.length != 0 && singleFoodShopCarList != null">
            <div class="car-title">
                <span class="name">单点菜品</span>
                <a class="clear-right" onclick="clearFoodType(1, this)"><i class="mui-icon mui-icon-trash"></i>清空</a>
            </div>
            <!--购物车商品列表-->
            <div class="commodity-list">
                <ul class="mui-table-view mui-table-view-chevron">
                    <li class="mui-table-view-cell mui-media" ng-repeat="singleFood in singleFoodShopCarList">
                        <a class="mui-navigate-right">
                            <img class="mui-media-object mui-pull-left commodity-list-img" src="<%=request.getContextPath()%>/{{singleFood.img}}" ng-click="cookbookDetail(singleFood.foodId, singleFood.foodCategoryId)">
                            <div class="mui-media-body">
                                <p class='mui-ellipsis commodity-list-name' ng-click="cookbookDetail(singleFood.foodId, singleFood.foodCategoryId)">{{singleFood.name}}</p>
                                <p class='mui-ellipsis commodity-list-money'>￥{{singleFood.price}}</p>
                                <p class='mui-ellipsis commodity-list-refresh'>
                                    <button class="exchangeBtn" ng-click="exchange(singleFood.id, singleFood.foodId)"><i class="mui-icon mui-icon-loop"></i>换一换</button>
                                </p>
                                <div class="addBtnBox">
                                    <button class="addOrReduceBtn" onclick="reduceCar(event, this)"
                                            foodId="{{singleFood.foodId}}"
                                            foodCategoryId="{{singleFood.foodCategoryId}}"
                                            childCategoryId="{{singleFood.childCategoryId}}"
                                            weddingSonId="{{singleFood.weddingSonId}}"
                                            price="{{singleFood.price}}">-</button>
                                    <input class="boxInput" type="text" value="{{singleFood.number}}" readonly>
                                    <button class="addOrReduceBtn" onclick="addCart(event, this)"
                                            foodId="{{singleFood.foodId}}"
                                            foodCategoryId="{{singleFood.foodCategoryId}}"
                                            childCategoryId="{{singleFood.childCategoryId}}"
                                            weddingSonId="{{singleFood.weddingSonId}}"
                                            price="{{singleFood.price}}">+</button>
                                </div>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- 套餐 -->
        <div ng-if="packageCaterShopCarList.length != 0 && packageCaterShopCarList != null">
            <div class="car-title">
                <span class="name">套餐</span>
                <a class="clear-right" onclick="clearFoodType(2, this)"><i class="mui-icon mui-icon-trash"></i>清空</a>
            </div>
            <!--购物车商品列表-->
            <div class="commodity-list">
                <ul class="mui-table-view mui-table-view-chevron">
                    <li class="mui-table-view-cell mui-media" ng-repeat="packageCater in packageCaterShopCarList">
                        <a class="mui-navigate-right">
                            <img class="mui-media-object mui-pull-left commodity-list-img" src="<%=request.getContextPath()%>/{{packageCater.img}}" ng-click="setMealDetail(packageCater.foodId)">
                            <div class="mui-media-body">
                                <p class='mui-ellipsis commodity-list-name' ng-click="setMealDetail(packageCater.foodId)">{{packageCater.name}}</p>
                                <p class='mui-ellipsis commodity-list-money margin-top26'>￥{{packageCater.price}}</p>
                                <div class="addBtnBox">
                                    <button class="addOrReduceBtn" onclick="reduceCar(event, this)"
                                            foodId="{{packageCater.foodId}}"
                                            foodCategoryId="{{packageCater.foodCategoryId}}"
                                            childCategoryId="{{packageCater.childCategoryId}}"
                                            weddingSonId="{{packageCater.weddingSonId}}"
                                            price="{{packageCater.price}}">-</button>
                                    <input class="boxInput" type="text" value="{{packageCater.number}}" readonly>
                                    <button class="addOrReduceBtn" onclick="addCart(event, this)"
                                            foodId="{{packageCater.foodId}}"
                                            foodCategoryId="{{packageCater.foodCategoryId}}"
                                            childCategoryId="{{packageCater.childCategoryId}}"
                                            weddingSonId="{{packageCater.weddingSonId}}"
                                            price="{{packageCater.price}}">+</button>
                                </div>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- 坝坝宴 -->
        <div ng-if="babaYanShopCarList.length != 0 && babaYanShopCarList != null">
            <div class="car-title">
                <span class="name">坝坝宴</span>
                <a class="clear-right" onclick="clearFoodType(3, this)"><i class="mui-icon mui-icon-trash"></i>清空</a>
            </div>
            <!--购物车商品列表-->
            <div class="commodity-list">
                <ul class="mui-table-view mui-table-view-chevron">
                    <li class="mui-table-view-cell mui-media" ng-repeat="babaYan in babaYanShopCarList">
                        <a class="mui-navigate-right">
                            <img class="mui-media-object mui-pull-left commodity-list-img" src="<%=request.getContextPath()%>/{{babaYan.img}}" ng-click="bamYanDetail(babaYan.foodId)">
                            <div class="mui-media-body">
                                <p class='mui-ellipsis commodity-list-name' ng-click="bamYanDetail(babaYan.foodId)">{{babaYan.name}}</p>
                                <p class='mui-ellipsis commodity-list-money margin-top26'>￥{{babaYan.price}}</p>
                                <div class="addBtnBox">
                                    <button class="addOrReduceBtn" onclick="reduceCar(event, this)"
                                            foodId="{{babaYan.foodId}}"
                                            foodCategoryId="{{babaYan.foodCategoryId}}"
                                            childCategoryId="{{babaYan.childCategoryId}}"
                                            weddingSonId="{{babaYan.weddingSonId}}"
                                            price="{{babaYan.price}}">-</button>
                                    <input class="boxInput" type="text" value="{{babaYan.number}}" readonly>
                                    <button class="addOrReduceBtn" onclick="addCart(event, this)"
                                            foodId="{{babaYan.foodId}}"
                                            foodCategoryId="{{babaYan.foodCategoryId}}"
                                            childCategoryId="{{babaYan.childCategoryId}}"
                                            weddingSonId="{{babaYan.weddingSonId}}"
                                            price="{{babaYan.price}}">+</button>
                                </div>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- 半餐演奏类 -->
        <div ng-if="actShopCarList.length != 0 && actShopCarList != null">
            <div class="car-title">
                <span class="name">伴餐演奏</span>
                <a class="clear-right" onclick="clearFoodType(5, this)"><i class="mui-icon mui-icon-trash"></i>清空</a>
            </div>
            <!--购物车商品列表-->
            <div class="commodity-list">
                <ul class="mui-table-view mui-table-view-chevron">
                    <li class="mui-table-view-cell mui-media" ng-repeat="act in actShopCarList">
                        <a class="mui-navigate-right">
                            <img class="mui-media-object mui-pull-left commodity-list-img" src="<%=request.getContextPath()%>/{{act.img}}" ng-click="dinnerDetail(act.foodId)">
                            <div class="mui-media-body">
                                <p class='mui-ellipsis commodity-list-name' ng-click="dinnerDetail(act.foodId)">{{act.name}}</p>
                                <p class='mui-ellipsis commodity-list-money margin-top26'>￥{{act.price}}</p>
                                <div class="addBtnBox">
                                    <button class="addOrReduceBtn" onclick="reduceCar(event, this)"
                                            foodId="{{act.foodId}}"
                                            foodCategoryId="{{act.foodCategoryId}}"
                                            childCategoryId="{{act.childCategoryId}}"
                                            weddingSonId="{{act.weddingSonId}}"
                                            price="{{act.price}}">-</button>
                                    <input class="boxInput" type="text" value="{{act.number}}" readonly>
                                    <button class="addOrReduceBtn" onclick="addCart(event, this)"
                                            foodId="{{act.foodId}}"
                                            foodCategoryId="{{act.foodCategoryId}}"
                                            childCategoryId="{{act.childCategoryId}}"
                                            weddingSonId="{{act.weddingSonId}}"
                                            price="{{act.price}}">+</button>
                                </div>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- 婚庆 -->
        <div ng-if="weddingShopCarList.length != 0 && weddingShopCarList != null">
            <div class="car-title">
                <span class="name">婚庆</span>
                <a class="clear-right" onclick="clearFoodType(4, this)"><i class="mui-icon mui-icon-trash"></i>清空</a>
            </div>
            <!--购物车商品列表-->
            <div class="commodity-list">
                <ul class="mui-table-view mui-table-view-chevron">
                    <li class="mui-table-view-cell mui-media" ng-repeat="wedding in weddingShopCarList">
                        <a class="mui-navigate-right">
                            <img class="mui-media-object mui-pull-left commodity-list-img" src="<%=request.getContextPath()%>/{{wedding.img}}" ng-click="weddingDetail(wedding.foodId)">
                            <div class="mui-media-body">
                                <p class='mui-ellipsis commodity-list-name' ng-click="weddingDetail(wedding.foodId)">{{wedding.name}}</p>
                                <p class='mui-ellipsis commodity-list-money margin-top26'>￥{{wedding.price}}</p>
                                <div class="addBtnBox">
                                    <button class="addOrReduceBtn" onclick="reduceCar(event, this)"
                                            foodId="{{wedding.foodId}}"
                                            foodCategoryId="{{wedding.foodCategoryId}}"
                                            childCategoryId="{{wedding.childCategoryId}}"
                                            weddingSonId="{{wedding.weddingSonId}}"
                                            price="{{wedding.price}}">-</button>
                                    <input class="boxInput" type="text" value="{{wedding.number}}" readonly>
                                    <button class="addOrReduceBtn" onclick="addCart(event, this)"
                                            foodId="{{wedding.foodId}}"
                                            foodCategoryId="{{wedding.foodCategoryId}}"
                                            childCategoryId="{{wedding.childCategoryId}}"
                                            weddingSonId="{{wedding.weddingSonId}}"
                                            price="{{wedding.price}}">+</button>
                                </div>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!--服务费提示-->
        <div class="car-service-hint" id="carServiceHint">
            包含￥<span id="maxServicePrice"></span>服务费（{{serviceConfigHtml}}<span id="maxServiceConfig">{{maxServiceConfig}}</span>元以上不收取服务费）
        </div>

        <!--专业服务-->
        <div class="car-service-title" ng-show="userToken != null">
            服务
        </div>

        <!-- 专业服务 -->
        <div ng-if="serviceShopCarList.length != 0 && serviceShopCarList != null">
            <div class="number-box-clear" ng-repeat="service in serviceShopCarList">
                <label class="service-title">{{service.name}}<span class="service-money">￥{{service.price}}</span></label>
                <div class="addBtnBox">
                    <button class="addOrReduceBtn" onclick="reduceCar(event, this)"
                            foodId="{{service.foodId}}"
                            foodCategoryId="{{service.foodCategoryId}}"
                            price="{{service.price}}">-</button>
                    <input class="boxInput" type="text" value="0" readonly ng-if="service.number == null">
                    <input class="boxInput" type="text" value="{{service.number}}" readonly ng-if="service.number != null">
                    <button class="addOrReduceBtn" onclick="addCart(event, this)"
                            foodId="{{service.foodId}}"
                            foodCategoryId="{{service.foodCategoryId}}"
                            price="{{service.price}}">+</button>
                </div>
            </div>
        </div>


        <div class="car-service-hint" ng-show="userToken != null">
            此服务包含一名服务员上门全程服务
        </div>
    </div>
    <div class="not-car" ng-if="actShopCarList.length == 0 && packageCaterShopCarList.length == 0 && babaYanShopCarList.length == 0 && serviceShopCarList.length == 0 && singleFoodShopCarList.length == 0 && weddingShopCarList.length == 0">
        <!-- 暂无 -->
        <%--<img src="<%=request.getContextPath()%>/appResources/img/icon/not-car.png">--%>
    </div>

    <!--购物车弹窗-->
    <nav class="mui-bar mui-bar-tab car-bottom">
        <a class="mui-tab-item car-popup-left">
            <div class="car-popup">
                <span class="mui-badge" id="shoppingCar">0</span>
                <img src="<%=request.getContextPath()%>/appResources/img/tab/tab-2-active.png">
                <span class="car-popup-price">￥<span id="shoppingCarTotal">0</span></span>
            </div>
        </a>
        <a class="mui-tab-item car-popup-right">
            <button type="button" class="mui-btn mui-btn-danger" ng-click="goBalance()">
                去结算
            </button>
        </a>
    </nav>

    <!--底部-->
    <nav class="mui-bar mui-bar-tab tab-bottom" id="tabBottom">
        <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/index">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-1.png"></div>
            <span class="mui-tab-label">首页</span>
        </a>
        <a class="mui-tab-item mui-active" href="<%=request.getContextPath()%>/app/page/car">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-2-active.png"></div>
            <span class="mui-tab-label">购物车</span>
        </a>
        <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/find">
            <div class="tab-icon find-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-3.png"></div>
        </a>
        <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/customer">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-4.png"></div>
            <span class="mui-tab-label">客服</span>
        </a>
        <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/my">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-5.png"></div>
            <span class="mui-tab-label">我的</span>
        </a>
    </nav>

    <!--引入抽取js文件-->
    <%@include file="common/public-js.jsp" %>

    <script type="text/javascript">

        var userToken = BJW.getLocalStorageToken(); //获取本地存储token
        console.log("来自公购物车打印：" + userToken);

        $("body").append(BJW.dialogLoading("加载中···"));//弹窗loading


        var webApp=angular.module('webApp',[]);
        //获取购物车
        webApp.controller('carCtr',function($scope,$http,$timeout){

            $scope.userToken = userToken;

            $scope.actShopCarList = null; // 半餐演奏类
            $scope.packageCaterShopCarList = null; // 套餐
            $scope.babaYanShopCarList = null; // 坝坝宴类
            $scope.serviceShopCarList = null; // 专业服务类
            $scope.singleFoodShopCarList = null; //单点
            $scope.weddingShopCarList = null; // 婚庆类
            $scope.serviceConfigHtml = ""; //服务费配置
            $scope.maxServiceConfig = 0; //最大服务费配置
            $scope.servicePrice = 0; //当前服务费

            //获取购物车列表
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/shopCar/getShopCar', {}, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    $scope.actShopCarList = result.data.actShopCar;
                    $scope.packageCaterShopCarList = result.data.packageCaterShopCar;
                    $scope.babaYanShopCarList = result.data.babaYanShopCar;
                    $scope.serviceShopCarList = result.data.serviceShopCar;
                    $scope.singleFoodShopCarList = result.data.singleFoodShopCar;
                    $scope.weddingShopCarList = result.data.weddingShopCar;
                }
            });

            //获取服务费配置
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/shopCar/getServiceConfig', {}, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    serviceConfigList = result.data;
                    var html = "";
                    var temp = 0;
                    for (var i = 0; i < result.data.length; i++) {
                        html += temp + "-" + result.data[i].price + "元的菜品收取" + result.data[i].addPrice + "元服务费，";
                        temp = result.data[i].price;
                        $scope.maxServiceConfig = result.data[i].price;
                    }
                    $scope.serviceConfigHtml = html;
                }
            });

            //统计金额
            $scope.countMoneyOrNumber = function (){
                // 伴餐演奏类
                var actTotalMoney = 0; //金额
                var actTotalNumber = 0; //数量
                if ($scope.actShopCarList != null) {
                    for (var i = 0; i < $scope.actShopCarList.length; i++) {
                        actTotalMoney += $scope.actShopCarList[i].price * $scope.actShopCarList[i].number;
                        actTotalNumber += $scope.actShopCarList[i].number;
                    }
                }
                // 套餐
                var packageTotalMoney = 0; //金额
                var packageTotalNumber = 0; //数量
                if ($scope.packageCaterShopCarList != null) {
                    for (var i = 0; i < $scope.packageCaterShopCarList.length; i++) {
                        packageTotalMoney += $scope.packageCaterShopCarList[i].price * $scope.packageCaterShopCarList[i].number;
                        packageTotalNumber += $scope.packageCaterShopCarList[i].number;
                    }
                }
                // 坝坝宴类
                var babaYanTotalMoney = 0; //金额
                var babaYanTotalNumber = 0; //数量
                if ($scope.babaYanShopCarList != null) {
                    for (var i = 0; i < $scope.babaYanShopCarList.length; i++) {
                        babaYanTotalMoney += $scope.babaYanShopCarList[i].price * $scope.babaYanShopCarList[i].number;
                        babaYanTotalNumber += $scope.babaYanShopCarList[i].number;
                    }
                }
                // 专业服务类
                var serviceTotalMoney = 0; //金额
                var serviceTotalNumber = 0; //数量
                if ($scope.serviceShopCarList != null) {
                    for (var i = 0; i < $scope.serviceShopCarList.length; i++) {
                        serviceTotalMoney += $scope.serviceShopCarList[i].price * $scope.serviceShopCarList[i].number;
                        serviceTotalNumber += $scope.serviceShopCarList[i].number;
                    }
                }
                // 单点
                var singleFoodTotalMoney = 0; //金额
                var singleFoodTotalNumber = 0; //数量
                if ($scope.singleFoodShopCarList != null) {
                    for (var i = 0; i < $scope.singleFoodShopCarList.length; i++) {
                        singleFoodTotalMoney += $scope.singleFoodShopCarList[i].price * $scope.singleFoodShopCarList[i].number;
                        singleFoodTotalNumber += $scope.singleFoodShopCarList[i].number;
                    }
                }
                // 婚庆类
                var weddingTotalMoney = 0; //金额
                var weddingTotalNumber = 0; //数量
                if ($scope.weddingShopCarList != null) {
                    for (var i = 0; i < $scope.weddingShopCarList.length; i++) {
                        weddingTotalMoney += $scope.weddingShopCarList[i].price * $scope.weddingShopCarList[i].number;
                        weddingTotalNumber += $scope.weddingShopCarList[i].number;
                    }
                }

                var countMoney = actTotalMoney + packageTotalMoney + babaYanTotalMoney + serviceTotalMoney + singleFoodTotalMoney + weddingTotalMoney;//总金额
                var countNumber = actTotalNumber + packageTotalNumber + babaYanTotalNumber + serviceTotalNumber + singleFoodTotalNumber + weddingTotalNumber; //总数量

                //计算服务费
                var temp = 0;
                var tempServicePrice = 0; //服务费
                var bool = false; // 判断是否满足服务费配置
                var bool1 = false;
                for (var i = 0; i < serviceConfigList.length; i++) {
                    if (countMoney >= temp && countMoney <= serviceConfigList[i].price) {
                        temp = serviceConfigList[i].price;
                        tempServicePrice = serviceConfigList[i].addPrice;
                        bool1 = true;
                        bool = false;
                    }
                    else {
                        bool = true;
                    }
                }
                $("#maxServicePrice").html(tempServicePrice);
                if (bool && !bool1 || (countMoney - lastServiceConfigPrice) <= 0) {
                    $("#carServiceHint").hide();
                }
                else {
                    $("#carServiceHint").show();
                }
                if ((countMoney - lastServiceConfigPrice) > 0) {
                    $("#shoppingCarTotal").html((countMoney + tempServicePrice).toFixed(2));
                    lastServiceConfigPrice = tempServicePrice;
                }
                else {
                    $("#shoppingCarTotal").html((countMoney - lastServiceConfigPrice).toFixed(2));
                }
                $("#shoppingCar").html(countNumber);

            }

            //调用
            $scope.countMoneyOrNumber();

            //go 去结算
            $scope.goBalance = function () {

                BJW.ajaxRequestData("get", false, BJW.ip+'/app/shopCar/getShopCar', {}, userToken , function(result){
                    if(result.flag == 0 && result.code == 200){
                        $scope.actShopCarList = result.data.actShopCar;
                        $scope.packageCaterShopCarList = result.data.packageCaterShopCar;
                        $scope.babaYanShopCarList = result.data.babaYanShopCar;
                        $scope.serviceShopCarList = result.data.serviceShopCar;
                        $scope.singleFoodShopCarList = result.data.singleFoodShopCar;
                        $scope.weddingShopCarList = result.data.weddingShopCar;
                    }
                });

                // 半餐演奏类
                localStorage.setItem("actShopCarList", JSON.stringify($scope.actShopCarList));
                // 套餐
                localStorage.setItem("packageCaterShopCarList", JSON.stringify($scope.packageCaterShopCarList));
                // 坝坝宴类
                localStorage.setItem("babaYanShopCarList", JSON.stringify($scope.babaYanShopCarList));
                // 专业服务类
                //localStorage.setItem("serviceShopCarList", JSON.stringify($scope.serviceShopCarList));
                console.log($scope.serviceShopCarList);
                $scope.serviceShopCarList2 = $scope.serviceShopCarList;
                $scope.serviceShopCarList3 = new Array();
                for (var i = 0; i < $scope.serviceShopCarList2.length; i++) {
                    if ($scope.serviceShopCarList2[i].foodId == 3 && $scope.serviceShopCarList2[i].number == null) {
                        //localStorage.setItem("serviceShopCarList", JSON.stringify([]));
                        if ($scope.actShopCarList.length != 0 &&
                                $scope.packageCaterShopCarList.length != 0 &&
                                $scope.babaYanShopCarList.length != 0 &&
                                $scope.singleFoodShopCarList.length != 0 &&
                                $scope.weddingShopCarList.length != 0) {
                            $scope.serviceShopCarList2.splice(i, 1);
                            break;
                        }
                    }
                    else {
                        $scope.serviceShopCarList3.push($scope.serviceShopCarList2[i]);
                    }
                }
                console.log($scope.serviceShopCarList3);
                localStorage.setItem("serviceShopCarList", JSON.stringify($scope.serviceShopCarList3));
                // 单点
                localStorage.setItem("singleFoodShopCarList", JSON.stringify($scope.singleFoodShopCarList));
                // 婚庆类
                localStorage.setItem("weddingShopCarList", JSON.stringify($scope.weddingShopCarList));

                //获取当前服务费用
                $scope.servicePrice = $("#maxServicePrice").html() == "" ? 0 : parseFloat($("#maxServicePrice").html()).toFixed(2);
                localStorage.setItem("servicePrice", $scope.servicePrice);

                console.log($scope.serviceShopCarList);
                for (var i = 0; i < $scope.babaYanShopCarList.length; i++) {
                    if ($scope.babaYanShopCarList[i].leastNumber > $scope.babaYanShopCarList[i].number) {
                        mui.alert("<span style=\"color:red;\">" + $scope.babaYanShopCarList[i].name + " 至少 " + $scope.babaYanShopCarList[i].leastNumber + "桌起订.</span>");
                        return false;
                    }
                }
                if ($scope.actShopCarList.length == 0 &&
                        $scope.packageCaterShopCarList.length == 0 &&
                        $scope.babaYanShopCarList.length == 0 &&
                        $scope.serviceShopCarList3.length == 0 &&
                        $scope.singleFoodShopCarList.length == 0 &&
                        $scope.weddingShopCarList.length == 0) {
                    mui.alert("您还未添加商品，赶快去添加吧.");
                    return false;
                }
                else {
                    location.href = BJW.ip + "/app/page/orderEdit?isOpen=1";
                }
            }

            //换一换
            $scope.exchange = function (id, foodId) {
                localStorage.setItem("carId", id);
                localStorage.setItem("foodId", foodId);
                localStorage.setItem("pageUrl", window.location.href);
                localStorage.setItem("exchangeSingleFoodShopCarList", JSON.stringify($scope.singleFoodShopCarList));
                location.href = BJW.ip + "/app/page/exchange?isOpen=1";
            }

            //单点详情
            $scope.cookbookDetail = function (foodId, foodCategoryId) {
                localStorage.setItem("cookbookId", foodId);
                localStorage.setItem("foodCategoryId", foodCategoryId);
                window.location.href = BJW.ip + "/app/page/cookbookDetail?isOpen=4";
            }

            //套餐详情
            $scope.setMealDetail = function (foodId) {
                localStorage.setItem("foodId", foodId);
                location.href = BJW.ip + "/app/page/setMealDetail?isOpen=4&foodId=" + foodId;
            }

            //坝坝宴详情
            $scope.bamYanDetail = function (foodId) {
                localStorage.setItem("foodBamId", foodId);
                location.href = BJW.ip + "/app/page/bamYanDetail?isOpen=4&foodId=" + foodId;
            }

            //伴餐演奏详情
            $scope.dinnerDetail = function (foodId) {
                localStorage.setItem("foodBamId", foodId);
                location.href = BJW.ip + "/app/page/dinnerDetail?isOpen=4&foodId=" + foodId;
            }

            //婚庆详情
            $scope.weddingDetail = function (foodId) {
                localStorage.setItem("weddingFoodId", foodId);
                location.href = BJW.ip + "/app/page/weddingDetail?isOpen=4";
            }

            //专业服务详情
            $scope.serviceDetail = function () {
                location.href = BJW.ip + "/app/page/setMealDetail?isOpen=4";
            }




        });

        //清空单个类型购物车
        function clearFoodType(type, obj){
            mui.confirm('是否确认清空？', '', ["确认","取消"], function(e) {
                if (e.index == 0) {
                    BJW.ajaxRequestData("post", false, BJW.ip+'/app/shopCar/clearShopCar', {bigCategoryId : type}, userToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            $(obj).parent().parent().fadeOut();
                            location.reload();
                        }
                    });
                }
            });
        }

        //购物车加
        function addCart(event, obj) {
            event.stopPropagation();
            var foodId = $(obj).attr("foodId");
            var foodCategoryId = $(obj).attr("foodCategoryId");
            var price = $(obj).attr("price");
            var childCategoryId = $(obj).attr("childCategoryId");
            var weddingSonId = $(obj).attr("weddingSonId");
            addOrReduceShopCar(event, obj, 1, foodId, foodCategoryId, childCategoryId, weddingSonId, null, price, BJW.ip + "/app/page/car?isOpen=0");
        }

        //购物车减
        function reduceCar(event, obj){
            event.stopPropagation();
            var foodId = $(obj).attr("foodId");
            var foodCategoryId = $(obj).attr("foodCategoryId");
            var price = $(obj).attr("price");
            var childCategoryId = $(obj).attr("childCategoryId");
            var weddingSonId = $(obj).attr("weddingSonId");
            if ($(obj).next().val() <= 1 && foodId != 3) {
                mui.confirm('是否删除此商品？', '', ["确认","取消"], function(e) {
                    if (e.index == 0) {
                        addOrReduceShopCar(null, obj, 0, foodId, foodCategoryId, childCategoryId, weddingSonId, null, price, BJW.ip + "/app/page/car?isOpen=0");
                        $(obj).parent().parent().parent().parent().parent().parent().parent().fadeOut();
                        //location.reload();
                    } else {

                    }
                });
            }
            else {
                addOrReduceShopCar(null, obj, 0, foodId, foodCategoryId, null, null, null, price, BJW.ip + "/app/page/car?isOpen=0");
            }

        }

        setTimeout(function (){
            BJW.closeDialogLoading();//关闭弹窗loading
        },500);

        //设置飞入购物车特效
        $(function (){
            var height = $(window).height();
            $(".mui-content").css("overflowX", "hidden");
            $(".mui-content").css("height", height + "px");
            if (!BJW.isWeiXin()) {
                $(".mui-content").css("paddingBottom", "60px");
            }
        });

    </script>
</body>

</html>