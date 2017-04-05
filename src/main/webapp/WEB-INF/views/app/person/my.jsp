<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>我的</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/person/my.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="myCtr" ng-cloak>
    <%--<header class="mui-bar mui-bar-nav">
        <h1 class="mui-title">我的</h1>
    </header>--%>
    <div class="mui-content">
        <div class="head-bar">
            <ul class="mui-table-view mui-table-view-chevron">
                <li class="mui-table-view-cell mui-media">

                    <a ng-if="userInfo != null" class="mui-navigate-right" href="<%=request.getContextPath()%>/app/page/personData?isOpen=1">
                        <img ng-if="userInfo.avatar == null" class="mui-media-object mui-pull-left my-logo" src="<%=request.getContextPath()%>/appResources/img/icon/default-head.png">
                        <img ng-if="userInfo.avatar != null" class="mui-media-object mui-pull-left my-logo" ng-src="<%=request.getContextPath()%>/{{userInfo.avatar}}">
                        <div class="mui-media-body">
                            <p class="user-name">{{userInfo.userName}}</p>
                            <p class='user-autograph mui-ellipsis' ng-if="userInfo.personalTaste != '' && userInfo.personalTaste != null">{{userInfo.personalTaste}}</p>
                            <p class='user-autograph mui-ellipsis' ng-if="userInfo.personalTaste == '' || userInfo.personalTaste == null">暂无</p>
                        </div>
                    </a>

                    <a ng-if="userInfo == null" class="mui-navigate-right" href="javascript:;">
                        <img class="mui-media-object mui-pull-left my-logo" src="<%=request.getContextPath()%>/appResources/img/icon/default-head.png">
                        <div class="mui-media-body">
                            <p class="no-login">您还没有登录!</p>
                            <button class="mui-btn click-login-btn" onclick="window.location.href='<%=request.getContextPath()%>/app/page/login?redirectUrl=<%=request.getContextPath()%>/app/page/my&isOpen=1';">
                                点击登录
                            </button>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
        <!--菜单栏-->
        <div class="my-menu-bar">
            <div class="mui-row">
                <div class="mui-col-xs-4 mui-col-sm-4">
                    <div class="mui-table-view-cell">
                        <a ng-click="isLogin('app/page/memberCard?isOpen=1')">
                            <div class="my-menu-icon"><img src="<%=request.getContextPath()%>/appResources/img/person/menu-1.png"></div>
                            <div class="my-menu-lable">会员卡</div>
                        </a>
                    </div>
                </div>
                <div class="mui-col-xs-4 mui-col-sm-4">
                    <div class="mui-table-view-cell">
                        <a ng-click="isLogin('/app/page/integration?isOpen=1')">
                            <div class="my-menu-icon"><img src="<%=request.getContextPath()%>/appResources/img/person/menu-2.png"></div>
                            <div class="my-menu-lable">积分</div>
                        </a>
                    </div>
                </div>
                <div class="mui-col-xs-4 mui-col-sm-4">
                    <div class="mui-table-view-cell">
                        <a ng-click="isLogin('app/page/voucher?isOpen=1')">
                            <div class="my-menu-icon"><img src="<%=request.getContextPath()%>/appResources/img/person/menu-3.png"></div>
                            <div class="my-menu-lable">抵用券</div>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!--列表菜单栏-->
        <div class="my-list-menu">
            <ul class="mui-table-view mui-table-view-chevron">
                <li class="mui-table-view-cell mui-media">
                    <a class="mui-navigate-right" ng-click="isLogin('app/page/myOrder?isOpen=1')">
                        <img class="mui-media-object mui-pull-left my-list-icon" src="<%=request.getContextPath()%>/appResources/img/person/list-1.png">
                        <div class="mui-media-body">
                            <p class='mui-ellipsis'>我的订单</p>
                        </div>
                    </a>
                </li>
                <li class="mui-table-view-cell mui-media">
                    <a class="mui-navigate-right" ng-click="isLogin('app/page/address?isOpen=1')">
                        <img class="mui-media-object mui-pull-left my-list-icon" src="<%=request.getContextPath()%>/appResources/img/person/list-2.png">
                        <div class="mui-media-body">
                            <p class='mui-ellipsis'>地址管理</p>
                        </div>
                    </a>
                </li>
                <li class="mui-table-view-cell mui-media">
                    <a class="mui-navigate-right" ng-click="isLogin('app/page/personData?isOpen=1')">
                        <img class="mui-media-object mui-pull-left my-list-icon" src="<%=request.getContextPath()%>/appResources/img/person/list-3.png">
                        <div class="mui-media-body">
                            <p class='mui-ellipsis'>个人设置</p>
                        </div>
                    </a>
                </li>
                <li ng-if="userInfo != null" class="mui-table-view-cell mui-media click-out-btn-li">
                    <button class="click-out-btn" ng-click="outLogin()">点击退出</button>
                </li>
            </ul>
        </div>

    </div>

    <!--底部-->
    <nav class="mui-bar mui-bar-tab tab-bottom" id="tabBottom">
        <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/index">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-1.png"></div>
            <span class="mui-tab-label">首页</span>
        </a>
        <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/car">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-2.png"></div>
            <span class="mui-tab-label">购物车</span>
        </a>
        <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/find">
            <div class="tab-icon find-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-3.png"></div>
        </a>
        <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/customer">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-4.png"></div>
            <span class="mui-tab-label">客服</span>
        </a>
        <a class="mui-tab-item mui-active" href="<%=request.getContextPath()%>/app/page/my">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-5-active.png"></div>
            <span class="mui-tab-label">我的</span>
        </a>
    </nav>

    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

    <script type="text/javascript">

        var webApp=angular.module('webApp',[]);
        //我的
        webApp.controller('myCtr',function($scope,$http,$timeout){
            $scope.userInfo = null;
            //获取登录用户token
            $scope.userToken = BJW.getLocalStorageToken();
            if ($scope.userToken != null) {
                BJW.ajaxRequestData("get", false, BJW.ip+'/app/user/getInfo',{}, $scope.userToken , function(result){
                    if(result.flag==0 && result.code==200){
                        $scope.userInfo = result.data;
                        console.log($scope.userInfo);
                    }
                });
            }

            //检查是否登录
            $scope.isLogin = function (url){
                if ($scope.userInfo == null) {
                    mui.confirm('未登录，是否前往登录？', '', ["确认","取消"], function(e) {
                        if (e.index == 0) {
                            location.href = BJW.ip + "/app/page/login?redirectUrl=" + BJW.ip + "/app/page/my?isOpen=0";
                        }
                    });
                }
                else {
                    localStorage.removeItem("selectOrderAddress");
                    localStorage.removeItem("orderEdit");
                    window.location.href =  BJW.ip + "/" +url;
                }
            }

            //退出登录
            $scope.outLogin = function (){
                mui.confirm('是否确认退出？', '', ["确认","取消"], function(e) {
                    if (e.index == 0) {
                        BJW.ajaxRequestData("get", false, BJW.ip+'/app/user/logout',{}, $scope.userToken , function(result){
                            if(result.flag==0 && result.code==200){
                                localStorage.clear();//清空所有本地储存
                                BJW.removeUserToken();//清空移动端token
                                if (!BJW.isWeiXin()) { //清除移动端缓存webToken
                                    try {
                                        window.JSBridge.removeToken();
                                    }catch (error){

                                    }
                                }
                                window.location.href =  BJW.ip + "/app/page/login?pageType=3";
                            }
                        });
                    }
                });
            }
        });

    </script>
</body>

</html>