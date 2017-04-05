<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div <%--ng-app="webAppCar"--%> ng-controller="carPopupCtr" ng-cloak>

    <nav class="mui-bar mui-bar-tab car-bottom">
        <a class="mui-tab-item car-popup-left" ng-click="getCarList()">
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

    <div id="carPopup" class="mui-popover mui-popover-action mui-popover-bottom">
        <div class="carPopup-list">
            <div class="carPopup-title">
                <span class="name">购物车</span>
                <a class="clear-right" onclick="clearFoodType()"><i class="mui-icon mui-icon-trash"></i>清空</a>
            </div>
            <div class="carPopup-controller">
                <div class="mui-scroll-wrapper">
                    <div class="mui-scroll">
                        <!-- 单点 -->
                        <div class="carPopup-item" ng-if="singleFoodShopCarList.length != 0 && singleFoodShopCarList != null"  ng-repeat="singleFood in singleFoodShopCarList">
                            <div class="mui-row">
                                <div class="mui-col-xs-6 mui-col-sm-6">
                                    <span class="commodity-name mui-ellipsis">{{singleFood.name}}</span>
                                    <span class="commodity-list-refresh" ng-click="exchange(singleFood.id, singleFood.foodId)"><i class="mui-icon mui-icon-loop"></i>换一换</span>
                                </div>
                                <div class="mui-col-xs-6 mui-col-sm-6">
                                    <span class="commodity-unit-Price">￥{{singleFood.price}}</span>
                                    <div class="addBtnBox">
                                        <button class="addOrReduceBtn" onclick="reduceCarPopup(this)"
                                                foodId="{{singleFood.foodId}}"
                                                foodCategoryId="{{singleFood.foodCategoryId}}"
                                                childCategoryId="{{singleFood.childCategoryId}}"
                                                weddingSonId="{{singleFood.weddingSonId}}"
                                                price="{{singleFood.price}}">-</button>
                                        <input class="boxInput" type="text" value="{{singleFood.number}}" readonly>
                                        <button class="addOrReduceBtn" onclick="addCartPopup(this)"
                                                foodId="{{singleFood.foodId}}"
                                                foodCategoryId="{{singleFood.foodCategoryId}}"
                                                childCategoryId="{{singleFood.childCategoryId}}"
                                                weddingSonId="{{singleFood.weddingSonId}}"
                                                price="{{singleFood.price}}">+</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 套餐 -->
                        <div class="carPopup-item" ng-if="packageCaterShopCarList.length != 0 && packageCaterShopCarList != null"  ng-repeat="packageCater in packageCaterShopCarList">
                            <div class="mui-row">
                                <div class="mui-col-xs-6 mui-col-sm-6">
                                    <span class="commodity-name mui-ellipsis">{{packageCater.name}}</span>
                                </div>
                                <div class="mui-col-xs-6 mui-col-sm-6">
                                    <span class="commodity-unit-Price">￥{{packageCater.price}}</span>
                                    <div class="addBtnBox">
                                        <button class="addOrReduceBtn" onclick="reduceCarPopup(this)"
                                                foodId="{{packageCater.foodId}}"
                                                foodCategoryId="{{packageCater.foodCategoryId}}"
                                                childCategoryId="{{packageCater.childCategoryId}}"
                                                weddingSonId="{{packageCater.weddingSonId}}"
                                                price="{{packageCater.price}}">-</button>
                                        <input class="boxInput" type="text" value="{{packageCater.number}}" readonly>
                                        <button class="addOrReduceBtn" onclick="addCartPopup(this)"
                                                foodId="{{packageCater.foodId}}"
                                                foodCategoryId="{{packageCater.foodCategoryId}}"
                                                childCategoryId="{{packageCater.childCategoryId}}"
                                                weddingSonId="{{packageCater.weddingSonId}}"
                                                price="{{packageCater.price}}">+</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 坝坝宴 -->
                        <div class="carPopup-item" ng-if="babaYanShopCarList.length != 0 && babaYanShopCarList != null"  ng-repeat="babaYan in babaYanShopCarList">
                            <div class="mui-row">
                                <div class="mui-col-xs-6 mui-col-sm-6">
                                    <span class="commodity-name mui-ellipsis">{{babaYan.name}}</span>
                                </div>
                                <div class="mui-col-xs-6 mui-col-sm-6">
                                    <span class="commodity-unit-Price">￥{{babaYan.price}}</span>
                                    <div class="addBtnBox">
                                        <button class="addOrReduceBtn" onclick="reduceCarPopup(this)"
                                                foodId="{{babaYan.foodId}}"
                                                foodCategoryId="{{babaYan.foodCategoryId}}"
                                                childCategoryId="{{babaYan.childCategoryId}}"
                                                weddingSonId="{{babaYan.weddingSonId}}"
                                                price="{{babaYan.price}}">-</button>
                                        <input class="boxInput" type="text" value="{{babaYan.number}}" readonly>
                                        <button class="addOrReduceBtn" onclick="addCartPopup(this)"
                                                foodId="{{babaYan.foodId}}"
                                                foodCategoryId="{{babaYan.foodCategoryId}}"
                                                childCategoryId="{{babaYan.childCategoryId}}"
                                                weddingSonId="{{babaYan.weddingSonId}}"
                                                price="{{babaYan.price}}">+</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 半餐演奏 -->
                        <div class="carPopup-item" ng-if="actShopCarList.length != 0 && actShopCarList != null"  ng-repeat="act in actShopCarList">
                            <div class="mui-row">
                                <div class="mui-col-xs-6 mui-col-sm-6">
                                    <span class="commodity-name mui-ellipsis">{{act.name}}</span>
                                </div>
                                <div class="mui-col-xs-6 mui-col-sm-6">
                                    <span class="commodity-unit-Price">￥{{act.price}}</span>
                                    <div class="addBtnBox">
                                        <button class="addOrReduceBtn" onclick="reduceCarPopup(this)"
                                                foodId="{{act.foodId}}"
                                                foodCategoryId="{{act.foodCategoryId}}"
                                                childCategoryId="{{act.childCategoryId}}"
                                                weddingSonId="{{act.weddingSonId}}"
                                                price="{{act.price}}">-</button>
                                        <input class="boxInput" type="text" value="{{act.number}}" readonly>
                                        <button class="addOrReduceBtn" onclick="addCartPopup(this)"
                                                foodId="{{act.foodId}}"
                                                foodCategoryId="{{act.foodCategoryId}}"
                                                childCategoryId="{{act.childCategoryId}}"
                                                weddingSonId="{{act.weddingSonId}}"
                                                price="{{act.price}}">+</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 婚庆 -->
                        <div class="carPopup-item" ng-if="weddingShopCarList.length != 0 && weddingShopCarList != null"  ng-repeat="wedding in weddingShopCarList">
                            <div class="mui-row">
                                <div class="mui-col-xs-6 mui-col-sm-6">
                                    <span class="commodity-name mui-ellipsis">{{wedding.name}}</span>
                                </div>
                                <div class="mui-col-xs-6 mui-col-sm-6">
                                    <span class="commodity-unit-Price">￥{{wedding.price}}</span>
                                    <div class="addBtnBox">
                                        <button class="addOrReduceBtn" onclick="reduceCarPopup(this)"
                                                foodId="{{wedding.foodId}}"
                                                foodCategoryId="{{wedding.foodCategoryId}}"
                                                childCategoryId="{{wedding.childCategoryId}}"
                                                weddingSonId="{{wedding.weddingSonId}}"
                                                price="{{wedding.price}}">-</button>
                                        <input class="boxInput" type="text" value="{{wedding.number}}" readonly>
                                        <button class="addOrReduceBtn" onclick="addCartPopup(this)"
                                                foodId="{{wedding.foodId}}"
                                                foodCategoryId="{{wedding.foodCategoryId}}"
                                                childCategoryId="{{wedding.childCategoryId}}"
                                                weddingSonId="{{wedding.weddingSonId}}"
                                                price="{{wedding.price}}">+</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 专业服务类 -->
                        <div class="carPopup-item" ng-if="serviceShopCarList.length != 0 && serviceShopCarList != null"  ng-repeat="service in serviceShopCarList">
                            <div class="mui-row">
                                <div class="mui-col-xs-6 mui-col-sm-6">
                                    <span class="commodity-name mui-ellipsis">{{service.name}}</span>
                                </div>
                                <div class="mui-col-xs-6 mui-col-sm-6">
                                    <span class="commodity-unit-Price">￥{{service.price}}</span>
                                    <div class="addBtnBox">
                                        <button class="addOrReduceBtn" onclick="reduceCarPopup(this)"
                                                foodId="{{service.foodId}}"
                                                foodCategoryId="{{service.foodCategoryId}}"
                                                childCategoryId="{{service.childCategoryId}}"
                                                weddingSonId="{{service.weddingSonId}}"
                                                price="{{service.price}}">-</button>
                                        <input class="boxInput" type="text" value="0" readonly ng-if="service.number == null">
                                        <input class="boxInput" type="text" value="{{service.number}}" readonly ng-if="service.number != null">
                                        <button class="addOrReduceBtn" onclick="addCartPopup(this)"
                                                foodId="{{service.foodId}}"
                                                foodCategoryId="{{service.foodCategoryId}}"
                                                childCategoryId="{{service.childCategoryId}}"
                                                weddingSonId="{{service.weddingSonId}}"
                                                price="{{service.price}}">+</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <%--<div class="not-car" ng-if="singleFoodShopCarList.length == 0 || singleFoodShopCarList == null">
                        <img src="<%=request.getContextPath()%>/appResources/img/icon/not-car.png">
                    </div>--%>
                </div>
            </div>
            <div class="carPopup-service-hint" id="carServiceHint">
                包含￥<span id="maxServicePrice"></span>服务费（{{serviceConfigHtml}}<span id="maxServiceConfig">{{maxServiceConfig}}</span>元以上不收取服务费）
            </div>
        </div>
    </div>

</div>

<script>

    var webApp=angular.module('webApp',[]);
    //获取购物车
    webApp.controller('carPopupCtr',function($scope,$http,$timeout){

        $scope.serviceConfigHtml = ""; //服务费配置
        $scope.maxServiceConfig = 0; //最大服务费配置

        var userToken = BJW.getLocalStorageToken(); //获取本地存储token
        console.log("来自抽取购物车弹窗打印：" + userToken);
        if (userToken != null) {
            $scope.actShopCarList = null; // 半餐演奏类
            $scope.packageCaterShopCarList = null; // 套餐
            $scope.babaYanShopCarList = null; // 坝坝宴类
            $scope.serviceShopCarList = null; // 专业服务类
            $scope.singleFoodShopCarList = null; //单点
            $scope.weddingShopCarList = null; // 婚庆类

            //获取商品列表
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

            //弹窗购物车列表
            $scope.getCarList = function (){
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
                if ($scope.actShopCarList.length == 0 &&
                        $scope.packageCaterShopCarList.length == 0 &&
                        $scope.babaYanShopCarList.length == 0 &&
                        $scope.serviceShopCarList[0].number == null &&
                        $scope.singleFoodShopCarList.length == 0 &&
                        $scope.weddingShopCarList.length == 0) {
                    $("#shoppingCarTotal").html(0);
                }
                mui('#carPopup').popover('toggle');
            }

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
                // 半餐演奏类
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

                /*// 半餐演奏类
                 localStorage.setItem("actShopCarList", JSON.stringify($scope.actShopCarList));
                 // 套餐
                 localStorage.setItem("packageCaterShopCarList", JSON.stringify($scope.packageCaterShopCarList));
                 // 坝坝宴类
                 localStorage.setItem("babaYanShopCarList", JSON.stringify($scope.babaYanShopCarList));
                 // 专业服务类
                 for (var i = 0; i < $scope.serviceShopCarList.length; i++) {
                 if ($scope.serviceShopCarList[i].foodId == 3 && $scope.serviceShopCarList[i].number == null) {
                 localStorage.setItem("serviceShopCarList",  JSON.stringify([]));
                 }
                 else {
                 localStorage.setItem("serviceShopCarList", JSON.stringify($scope.serviceShopCarList));
                 }
                 }
                 // 单点
                 localStorage.setItem("singleFoodShopCarList", JSON.stringify($scope.singleFoodShopCarList));
                 // 婚庆类
                 localStorage.setItem("weddingShopCarList", JSON.stringify($scope.weddingShopCarList));*/
                if ($scope.actShopCarList.length == 0 &&
                        $scope.packageCaterShopCarList.length == 0 &&
                        $scope.babaYanShopCarList.length == 0 &&
                        $scope.serviceShopCarList[0].number == null &&
                        $scope.singleFoodShopCarList.length == 0 &&
                        $scope.weddingShopCarList.length == 0) {
                    mui.alert("您还未添加商品，赶快去添加吧.");
                    return false;
                }
                else {
                    location.href = BJW.ip + "/app/page/car?pageType=5";
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
        }


    });

    //购物车加
    function addCartPopup(obj) {
        var foodId = $(obj).attr("foodId");
        var foodCategoryId = $(obj).attr("foodCategoryId");
        var price = $(obj).attr("price");
        var childCategoryId = $(obj).attr("childCategoryId");
        var weddingSonId = $(obj).attr("weddingSonId");
        addOrReduceShopCar(null, obj, 1, foodId, foodCategoryId, childCategoryId, weddingSonId, null, price, BJW.ip + "/app/page/car?isOpen=0");
    }

    //购物车减
    function reduceCarPopup(obj){
        var foodId = $(obj).attr("foodId");
        var foodCategoryId = $(obj).attr("foodCategoryId");
        var price = $(obj).attr("price");
        var childCategoryId = $(obj).attr("childCategoryId");
        var weddingSonId = $(obj).attr("weddingSonId");
        addOrReduceShopCar(1, obj, 0, foodId, foodCategoryId, childCategoryId, weddingSonId, null, price, BJW.ip + "/app/page/car?isOpen=0");
    }

    //清空购物车
    function clearFoodType(){
        mui.confirm('是否确认清空？', '', ["确认","取消"], function(e) {
            if (e.index == 0) {
                BJW.ajaxRequestData("post", false, BJW.ip+'/app/shopCar/clearShopCar', {}, userToken , function(result){
                    if(result.flag == 0 && result.code == 200){
                        //location.reload();
                        $(".carPopup-controller .carPopup-item").fadeOut();
                        $(".boxInput").val(0);
                        $("#shoppingCar").html(0);
                        $("#shoppingCarTotal").html(0);
                        $("#carServiceHint").hide();
                        lastServiceConfigPrice = 0;
                        mui('#carPopup').popover('toggle');
                    }
                });
            }
        });
    }

</script>