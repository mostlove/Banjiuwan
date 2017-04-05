<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>抵用券</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/person/voucher.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="voucherCtr" ng-cloak>
    <div class="mui-content">

        <div class="not-voucher" ng-if="voucherList.length == 0 || voucherList == null"> 暂无优惠券 </div>

        <div class="voucher-list" ng-repeat="voucher in voucherList">
            <div class="voucher-title">
                {{voucher.text}}
            </div>
            <div class="voucher-time-hint">
                使用期限：
            </div>
            <div class="voucher-time">
                {{ voucher.startTime*1000 | date:'yyyy-MM-dd' }}至{{ voucher.endTime*1000 | date:'yyyy-MM-dd' }}
            </div>
            <div class="voucher-badge">
                <div ng-class="{true:'voucher-context',false:'voucher-context notFaceValue'}[voucher.type == 0]">
                    <span class="voucher-symbol">￥</span>
                    <span class="voucher-money">{{voucher.faceValue}}</span>
                    <div class="voucher-condition" ng-if="voucher.type == 0">满{{voucher.needSpend}}元使用</div>
                </div>
            </div>
        </div>


    </div>


    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

    <script type="text/javascript">

        $("body").append(BJW.dialogLoading("加载中···"));//弹窗loading

        var webApp=angular.module('webApp',[]);
        //地址管理
        webApp.controller('voucherCtr',function($scope,$http,$timeout){
            //获取登录用户token
            $scope.userToken = BJW.getLocalStorageToken();
            console.log("token:" + $scope.userToken);
            $scope.voucherList = null;
            var arr = {
                pageNO : 1,
                pageSize : 100
            }
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/user/getCoupon', arr, $scope.userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    if (result.data.length < 1) {
                        $scope.voucherList = null;
                    }
                    $scope.voucherList = result.data;
                }
            });

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