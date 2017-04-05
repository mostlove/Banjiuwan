<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>会员卡</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/person/memberCard.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="memberCardController" ng-cloak>
    <div class="mui-content">

        <%--<img src="<%=request.getContextPath()%>/appResources/img/person/member-card-bg.png">--%>
        <div class="member-bg"></div>

        <div class="balance-bar">
            <div class="balance-title">余额</div>
            <div class="balance">{{user.balance}}<span>元</span></div>
        </div>
        <div class="recharge-bar">
            <div class="mui-row">
                <div class="mui-col-xs-4 mui-col-sm-4 padding-left15" ng-repeat="memberCard in memberCardList">
                    <div class="recharge-scheme">
                        <div class="scheme-money"><span class="money-1">{{memberCard.balance}}</span>元</div>
                        <div class="give-money">赠送<span class="money-2">{{memberCard.giveBalance}}</span>元</div>
                        <div style="display: none" class="rechargeId">{{memberCard.id}}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="balance-btn-bar">
            <button class="mui-btn balance-btn" ng-click="goChongzhi()">
                立即充值&nbsp;(到账<span class="number">0元</span>)
            </button>
        </div>

        <div class="balance-agreement">
            点击立即充值,即表示您已同意<a href="<%=request.getContextPath()%>/app/page/recharge">《充值协议》</a>
        </div>

        <input type="hidden" value="0" id="money">
        <input type="hidden" value="0" id="rechargeId">
    </div>



    <!-- 选择支付弹窗 -->
    <div id="paymentPopup" class="mui-popover mui-popover-action mui-popover-bottom">
        <ul class="mui-table-view">
            <li class="mui-table-view-cell">
                <div class="orderMoneyDiv">订单金额：<span class="orderMoney">￥<span id="payMoney">0</span></span></div>
                <div class="mui-row" ng-if="!isWei">
                    <div class="mui-col-xs-6 mui-col-sm-6 paymentMode" ng-click="weiXinPayment()">
                        <img src="<%=request.getContextPath()%>/appResources/img/icon/weixin.png">
                        <p class="paymentModeTiele">微信支付</p>
                    </div>
                    <div class="mui-col-xs-6 mui-col-sm-6 paymentMode" ng-click="zhiFuBaoPayment()">
                        <img src="<%=request.getContextPath()%>/appResources/img/icon/zhifubao.png">
                        <p class="paymentModeTiele">支付宝支付</p>
                    </div>
                </div>
                <div class="mui-row" ng-if="isWei">
                    <div class="mui-col-xs-12 mui-col-sm-12 paymentMode" ng-click="weiXinPayment()">
                        <img src="<%=request.getContextPath()%>/appResources/img/icon/weixin.png">
                        <p class="paymentModeTiele">微信支付</p>
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
        //地址管理
        webApp.controller('memberCardController',function($scope,$http,$timeout){
            $scope.memberCardList = null;
            $scope.user = null;
            //获取登录用户token
            $scope.userToken = BJW.getLocalStorageToken();
//            mui.alert("test...");
            var arr = {}
            BJW.ajaxRequestData("post", false, BJW.ip+'/app/rechargeConfig/getAllRechargeConfig', arr, $scope.userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    $scope.memberCardList = result.data;
                }
            });
            BJW.ajaxRequestData("post", false, BJW.ip+'/app/user/getInfo', arr, $scope.userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    $scope.user = result.data;
                }
            });

            $scope.isWei = BJW.isWeiXin();

            //去支付
            $scope.goChongzhi=function(){
                var money = $("#rechargeId").val();
                if (money == 0) {
                    mui.toast("请选择充值金额.");
                    return false;
                }
                else {
                    //弹出菜单的显示、隐藏
                    mui('#paymentPopup').popover('toggle');
                }
            }


            //微信支付
            $scope.weiXinPayment = function () {
                //弹出菜单的显示、隐藏
                mui('#paymentPopup').popover('toggle');
                var rechargeId = $("#rechargeId").val();
                if (BJW.isWeiXin()) {
                    setTimeout(function () {
                        //微信端--微信支付
                        BJW.ajaxRequestData("post", false, BJW.ip+'/app/jsAPI/sign', {rechargeId : rechargeId,flag : 1}, $scope.userToken , function(result){
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
                    window.JSBridge.goRecharge(rechargeId, $scope.userToken, 0);
                }
            }
            //支付宝支付
            $scope.zhiFuBaoPayment = function() {
                //弹出菜单的显示、隐藏
                mui('#paymentPopup').popover('toggle');
                var rechargeId = $("#rechargeId").val();
                window.JSBridge.goRecharge(rechargeId, $scope.userToken, 1);
            }



        });


        //回调函数
        function payCallback(status){
            if(status == 1){
                // Success
                location.reload();
            }else{
                mui.alert("支付失败");
            }
        }

        //微信端微信支付 -- 暂无用
        function pay (appId, timeStamp, nonceStr, prepayId, signType, paySign) {
            if (typeof WeixinJSBridge == "undefined"){
                if( document.addEventListener ){
                    document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
                }else if (document.attachEvent){
                    document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
                    document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
                }
            }else{
                onBridgeReady(appId, timeStamp, nonceStr, prepayId, signType, paySign);
            }
        }
        function onBridgeReady(appId, timeStamp, nonceStr, prepayId, signType, paySign){
            WeixinJSBridge.invoke(
                    'getBrandWCPayRequest', {
                        "appId" : appId,     //公众号名称，由商户传入
                        "timeStamp" : timeStamp,         //时间戳，自1970年以来的秒数
                        "nonceStr" : nonceStr, //随机串
                        "package" : prepayId,
                        "signType" : signType,         //微信签名方式：
                        "paySign" : paySign //微信签名
                    },
                    function(res){
                        alert(JSON.stringify(res));
                        if(res.err_msg == "get_brand_wcpay_request:ok" ) {// 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
                            //mui.alert("支付成功.");
                            location.reload();
                        }
                        else {
                            mui.alert("支付失败.");
                        }
                    }
            );
        }


        mui.init({
            swipeBack: true //启用右滑关闭功能
        });

        $(function (){
            $(".recharge-bar .recharge-scheme").each(function(){
                $(this).click(function (){
                    var obj = $(this);
                    $(".recharge-bar .recharge-scheme").removeClass("scheme-active");
                    obj.addClass("scheme-active");
                    var money1 = parseFloat(obj.find(".money-1").html());
                    var money2 = parseFloat(obj.find(".money-2").html());
                    $(".number").html((money1 + money2)+"元");
                    $("#money").val((money1 + money2));
                    $("#payMoney").html(money1);
                    $("#rechargeId").val(obj.find(".rechargeId").html());
                });
            })
        });


        setTimeout(function (){
            BJW.closeDialogLoading();//关闭弹窗loading
        },500);
    </script>
</body>

</html>