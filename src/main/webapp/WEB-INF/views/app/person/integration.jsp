<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>我的积分</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/person/integration.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="integrationCtr" ng-cloak>
    <div class="mui-content">
        <div class="my-integration">
            <img src="<%=request.getContextPath()%>/appResources/img/person/integration-bg.png">

            <div class="integration-bar">
                <div class="integration-title">积分</div>
                <div class="integration" ng-if="accumulate == null || accumulate =='' ">0</div>
                <div class="integration" ng-if="accumulate != null && accumulate !='' ">{{accumulate}}</div>
            </div>

            <div class="text-align-center">
                <button class="mui-btn resist-btn">可抵<span id="config">0</span>元消费</button>
            </div>
        </div>


        <div class="integration-list">
            <div class="list-title">
                积分使用规则
            </div>
            <div class="list-context">
                <p>·{{config}}积分=1元</p>
                <p>·积分在支付时可低现金使用</p>
            </div>
        </div>

        <div class="integration-list">
            <div class="list-title">
                如何获得积分
            </div>
            <div class="list-context">
                <p>每支付1元获得{{yuan}}个积分</p>
                <p>餐后参与评论可获得积分</p>
            </div>
        </div>


    </div>


    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

    <script type="text/javascript">

        $("body").append(BJW.dialogLoading("加载中···"));//弹窗loading

        var webApp=angular.module('webApp',[]);
        //地址管理
        webApp.controller('integrationCtr',function($scope,$http,$timeout){
            $scope.accumulate = null; //获取积分
            $scope.config = null; //积分规则
            $scope.yuan = null; //元
            //获取登录用户token
            $scope.userToken = BJW.getLocalStorageToken();
            console.log($scope.userToken);
            if ($scope.userToken != null) {
                BJW.ajaxRequestData("get", false, BJW.ip+'/app/user/getAccumulateConfig',{}, $scope.userToken , function(result){
                    if(result.flag==0 && result.code==200){
                        $scope.accumulate = result.data.accumulate;
                        $scope.config = result.data.config.accumulate;
                        $scope.yuan = result.data.config.yuan;
                        var sum = $scope.accumulate * (1 / $scope.config);
                        $("#config").html(sum.toFixed(2));
                    }
                });
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