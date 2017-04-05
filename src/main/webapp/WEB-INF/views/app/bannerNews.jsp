<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>活动</title>
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/news.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="newsCtr" ng-cloak>

    <div class="mui-content">
        <img class="news-img" src="<%=request.getContextPath()%>/{{newsDetail.img}}" ng-show="newsDetail.banner == undefined">
        <img class="news-img" src="<%=request.getContextPath()%>/{{newsDetail.banner}}" ng-show="newsDetail.img == undefined">
        <div class="news-context">
            <h4 class="news-title">{{newsDetail.title}}</h4>
            <span class="commodity-index-mark" ng-show="newsDetail.recommendationIndex != undefined">推荐指数:
                <span id="recommendationIndexHtml"></span>
            </span>
            <div class="context" ng-bind-html="content">
            </div>
        </div>
        <div class="returnBtn">
            <input type="button" class="mui-btn" value="返回首页" ng-click="returnPage()">
        </div>
    </div>

    <!--引入抽取js文件-->
    <%@include file="common/public-js.jsp" %>

    <script type="text/javascript">

        var webApp=angular.module('webApp',[]);
        //文章详情
        webApp.controller('newsCtr',function($scope,$http,$timeout,$sce){
            $scope.newsDetail = null;
            $scope.content = null;
            var id = BJW.getUrlParam("newsId");
            BJW.ajaxRequestData("post", false, BJW.ip + '/app/homeBanner/getBanner', {flag : 1}, "", function(result){
                if(result.flag==0 && result.code==200){
                    $scope.newsDetail = result.data[0];
                    $scope.content = result.data.content;
                }
            });
            //解析angularJS富文本字符串
            $scope.content = $sce.trustAsHtml($scope.newsDetail.content);
            var fei = "<i class=\"mui-icon mui-icon-star\"></i>";
            var man = "<i class=\"mui-icon mui-icon-star-filled\"></i>";
            var recommendationIndexHtml = "";
            for (var i = 0; i < parseInt($scope.newsDetail.recommendationIndex); i++) {
                recommendationIndexHtml += man;
            }
            $("#recommendationIndexHtml").html(recommendationIndexHtml);

            $scope.returnPage = function () {
                if (BJW.isWeiXin()) {
                    window.history.go(-1);
                }
                else {
                    location.href = BJW.ip + "/app/page/index?pageType=2";
                }
            }

        });



    </script>
</body>

</html>