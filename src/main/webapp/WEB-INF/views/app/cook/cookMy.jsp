<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>我的</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/cook/cookMy.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="cookMyCtr" ng-cloak>
    <%--<header class="mui-bar mui-bar-nav">
        <h1 class="mui-title">我的</h1>
    </header>--%>
    <div class="mui-content">
        <div class="head-bar">
            <ul class="mui-table-view mui-table-view-chevron">
                <li class="mui-table-view-cell mui-media">

                    <a ng-if="cookInfo != null" class="mui-navigate-right" href="<%=request.getContextPath()%>/app/page/cookPersonData?isOpen=1">
                        <img ng-if="cookInfo.avatar == null" class="mui-media-object mui-pull-left my-logo" src="<%=request.getContextPath()%>/appResources/img/icon/default-head.png">
                        <img ng-if="cookInfo.avatar != null" class="mui-media-object mui-pull-left my-logo" ng-src="<%=request.getContextPath()%>/{{cookInfo.avatar}}">
                        <div class="mui-media-body">
                            <p class="user-name">{{cookInfo.realName}}</p>
                            <p class='user-autograph mui-ellipsis' ng-if="cookInfo.signature != '' && cookInfo.signature != null">{{cookInfo.signature}}</p>
                            <p class='user-autograph mui-ellipsis' ng-if="cookInfo.signature == '' || cookInfo.signature == null">暂无</p>
                        </div>
                    </a>

                    <a ng-if="cookInfo == null" class="mui-navigate-right" href="javascript:;">
                        <img class="mui-media-object mui-pull-left my-logo" src="<%=request.getContextPath()%>/appResources/img/icon/default-head.png">
                        <div class="mui-media-body">
                            <p class="no-login">您还没有登录!</p>
                            <button class="mui-btn click-login-btn" onclick="window.location.href='<%=request.getContextPath()%>/app/page/cookLogin?redirectUrl=<%=request.getContextPath()%>/app/page/cookMy&isOpen=1';">
                                点击登录
                            </button>
                        </div>
                    </a>

                </li>
            </ul>
        </div>

        <!--列表菜单栏-->
        <div class="my-list-menu">
            <ul class="mui-table-view mui-table-view-chevron">
                <li class="mui-table-view-cell mui-media">
                    <a class="mui-navigate-right" ng-click="isLogin('app/page/cookMyOrder?isOpen=1')">
                        <img class="mui-media-object mui-pull-left my-list-icon" src="<%=request.getContextPath()%>/appResources/img/person/list-1.png">
                        <div class="mui-media-body">
                            <p class='mui-ellipsis'>我的订单</p>
                        </div>
                    </a>
                </li>
                <li class="mui-table-view-cell mui-media">
                    <a class="mui-navigate-right" ng-click="isLogin('app/page/cookPersonData?isOpen=1')">
                        <img class="mui-media-object mui-pull-left my-list-icon" src="<%=request.getContextPath()%>/appResources/img/person/list-3.png">
                        <div class="mui-media-body">
                            <p class='mui-ellipsis'>个人设置</p>
                        </div>
                    </a>
                </li>
                <li ng-if="cookInfo != null" class="mui-table-view-cell mui-media">
                    <a ng-click="goCard()">
                        <img class="mui-media-object mui-pull-left my-list-icon" src="<%=request.getContextPath()%>/appResources/img/person/list-4.png">
                        <div class="mui-media-body">
                            <p class='mui-ellipsis' ng-show="isOnline == 0">上班打卡</p>
                            <p class='mui-ellipsis' ng-show="isOnline == 1">下班打卡</p>
                        </div>
                        <span class="onLine" ng-show="isOnline == 1">在线</span>
                        <span class="offLine" ng-show="isOnline == 0">离线</span>
                    </a>
                </li>
                <li ng-if="cookInfo != null" class="mui-table-view-cell mui-media click-out-btn-li">
                    <button class="click-out-btn" ng-click="outLogin()">点击退出</button>
                </li>
            </ul>
        </div>

    </div>

    <!--底部-->
    <nav class="mui-bar mui-bar-tab tab-bottom" id="tabBottom2">
        <a class="mui-tab-item" ng-click="isLogin('app/page/cookMyOrder?isOpen=1')">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-6.png"></div>
            <span class="mui-tab-label">我的订单</span>
        </a>
        <a class="mui-tab-item mui-active" href="<%=request.getContextPath()%>/app/page/cookMy">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-5-active.png"></div>
            <span class="mui-tab-label">我的</span>
        </a>
    </nav>

    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

    <script type="text/javascript">

        var webApp=angular.module('webApp',[]);
        webApp.controller('cookMyCtr',function($scope,$http,$timeout){
            $scope.isOnline = 0; //打卡状态：是否在线  0:否 1:在， 默认没有打卡
            $scope.cookInfo = null;
            //获取登录用户token
            $scope.cookToken = BJW.getLocalStorageCookToken();
            //mui.alert($scope.cookToken);
            console.log($scope.cookToken);
            if ($scope.cookToken != null) {
                BJW.cookAjaxRequestData("get", false, BJW.ip+'/app/user/getInfo',{}, $scope.cookToken , function(result){
                    if(result.flag==0 && result.code==200){
                        $scope.cookInfo = result.data;
                        $scope.isOnline = result.data.isOnline;
                        console.log($scope.cookInfo);
                    }
                });
            }

            //上班打卡
            $scope.goCard = function () {
                if ($scope.isOnline == 0) {
                    mui.confirm('是否确认上班打卡？', '', ["确认","取消"], function(e) {
                        if (e.index == 0) {
                            BJW.cookAjaxRequestData("get", false, BJW.ip+'/app/cook/onLine',{isOnline : 1}, $scope.cookToken , function(result){
                                if(result.flag==0 && result.code==200){
                                    $timeout(function () {
                                        $scope.isOnline = 1;
                                    });
                                }
                            });
                        }
                    });
                }
                else {
                    mui.confirm('是否确认下班打卡？', '', ["确认","取消"], function(e) {
                        if (e.index == 0) {
                            BJW.cookAjaxRequestData("get", false, BJW.ip+'/app/cook/onLine',{isOnline : 0}, $scope.cookToken , function(result){
                                if(result.flag==0 && result.code==200){
                                    $timeout(function () {
                                        $scope.isOnline = 0;
                                    });
                                }
                            });
                        }
                    });
                }
            }

            //检查是否登录
            $scope.isLogin = function (url){
                if ($scope.cookInfo == null) {
                    mui.confirm('未登录，是否前往登录？', '', ["确认","取消"], function(e) {
                        if (e.index == 0) {
                            location.href = BJW.ip + "/app/page/cookLogin?redirectUrl=" + BJW.ip + "/app/page/cookLogin?isOpen=0";
                        }
                    });
                }
                else {
                    window.location.href =  BJW.ip + "/" +url;
                }
            }

            //退出登录
            $scope.outLogin = function (){
                mui.confirm('是否确认退出？', '', ["确认","取消"], function(e) {
                    if (e.index == 0) {
                        BJW.cookAjaxRequestData("get", false, BJW.ip+'/app/user/logout',{}, $scope.cookToken , function(result){
                            if(result.flag==0 && result.code==200){
                                localStorage.clear();//清空所有本地储存
                                BJW.removeUserToken();//清空移动端token
                                window.location.href =  BJW.ip + "/app/page/cookLogin";
                            }
                        });
                    }
                });
            }
        });

    </script>
</body>

</html>