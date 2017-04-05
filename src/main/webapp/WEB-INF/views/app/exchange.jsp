<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>换一换</title>
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/exchange.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="exchangeCtr" ng-cloak>
    <!--下拉刷新容器-->
    <div class="mui-content">
        <ul class="mui-table-view">
            <li ng-repeat="food in foodList" ng-if="foodList.length != 0">
                <div class="commodity-item">
                    <a href="javascript:void(0)">
                        <img class="foodImg" src="<%=request.getContextPath()%>/{{food.coverImg}}">
                    </a>
                    <div class="commodity-info">
                        <p class="commodity-row">
                            <span class="commodity-name">{{food.foodName}}</span>
                            <span class="commodity-price">￥{{food.price}}<span>/份</span></span>
                        </p>
                        <p class="commodity-row">
                            <span class="commodity-sales">总销{{food.sales}}份</span>
                        </p>
                        <p class="commodity-row">
                            <span class="commodity-index-mark">推荐指数:
                                <span starnum score="{{food.recommendationIndex}}"></span>
                            </span>
                        </p>
                        <p>
                            <input type="button" value="替换" class="mui-btn replaceBtn" ng-click="exchange(food.id, food.foodCategoryId)">
                        </p>
                    </div>
                </div>
            </li>
            <li ng-if="foodList.length == 0">
                <div class="notData">暂无可换商品.</div>
            </li>
        </ul>

    </div>


    <!--引入抽取js文件-->
    <%@include file="common/public-js.jsp" %>

    <script type="text/javascript">

        $("body").append(BJW.dialogLoading("正在加载"));//弹窗loading

        var webApp=angular.module('webApp',[]);
        //填写订单
        webApp.controller('exchangeCtr',function($scope,$http,$timeout) {
            //获取登录用户token
            $scope.userToken = BJW.getLocalStorageToken();
            console.log("token：" + $scope.userToken);
            $scope.carId = localStorage.getItem("carId");
            $scope.foodId = localStorage.getItem("foodId");
            $scope.pageUrl = localStorage.getItem("pageUrl");
            $scope.exchangeSingleFoodShopCarList = JSON.parse(localStorage.getItem("exchangeSingleFoodShopCarList"));
            console.log("购物车传入的carId：" + $scope.carId);
            console.log("购物车传入的foodId：" + $scope.foodId);
            $scope.foodList = null; //存放商品集合
            var arr = {
                foodId : $scope.foodId
            }
            if ($scope.carId == null || $scope.foodId == null) {
                mui.confirm('传入商品不能为空', '', ["确认"], function(e) {
                    if (e.index == 0) {
                        window.history.go(-1);
                    }
                });
            }
            $scope.foodList = new Array();
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/food/queryChangeFood', arr, $scope.userToken , function(result) {
                if (result.flag == 0 && result.code == 200) {
                    for (var i = 0; i < result.data.length; i++) {
                        //判断加入购物车的数据是否存在替换列表里面
                        var bool = false;
                        for (var j = 0; j < $scope.exchangeSingleFoodShopCarList.length; j++) {
                            if (result.data[i].id == $scope.exchangeSingleFoodShopCarList[j].foodId) {
                                bool = true;
                            }
                        }
                        if (!bool && result.data[i] != null) {
                            $scope.foodList.push(result.data[i]);
                        }
                    }
                    console.log($scope.foodList);
                }
            });

            $scope.exchange = function (foodId, foodCategoryId) {
                var arr = {
                    shopCarId : $scope.carId,
                    newFoodId : foodId,
                    foodCategoryId : foodCategoryId
                }
                BJW.ajaxRequestData("get", false, BJW.ip+'/app/shopCar/updateChangeFood', arr, $scope.userToken , function(result) {
                    if (result.flag == 0 && result.code == 200) {
                        localStorage.removeItem("carId");
                        localStorage.removeItem("foodId");
                        //self.location=document.referrer;
                        var str = "";
                        console.log($scope.pageUrl);
                        if ($scope.pageUrl.indexOf("?") != -1) {
                            str = "&pageType=2";
                        }
                        else {
                            str = "?pageType=2";
                        }
                        window.location.href = $scope.pageUrl + str;
                    }
                });
            }
        });
        //星级过滤器
        webApp.directive('starnum',function(){
            return {
                link:function(score,ele,attr){
                    var str='';
                    //console.log("attr.score：" + attr.score);
                    for (var i=0;i< Math.floor(attr.score);i++) {
                        str+='<i class="mui-icon mui-icon-star-filled"></i>';
                    }
                    ele.html(str);
                }
            }
        });

        mui.init({
            swipeBack: true //启用右滑关闭功能
        });

        setTimeout(function (){
            BJW.closeDialogLoading();//关闭弹窗loading
        },500);
    </script>
</body>

</html>