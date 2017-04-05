<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>找回密码</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/cook/forgetPassword.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="forgetPasswordCtr" ng-cloak>


    <div class="mui-content" id="phoneBar">
        <form id='forgetPasswordForm' class="mui-input-group">
            <div class="mui-input-row">
                <label>手机号：</label>
                <input id='phone' type="text" class="mui-input-clear mui-input" placeholder="请在此输入手机号" maxlength="11" onKeypress="return (/[\d.]/.test(String.fromCharCode(event.keyCode)))">
            </div>
            <div class="mui-input-row">
                <label>验证码：</label>
                <input id='qr' type="text" class="mui-input" placeholder="请输验证码" maxlength="4" onKeypress="return (/[\d.]/.test(String.fromCharCode(event.keyCode)))">
                <button type="button" class="mui-btn qr-btn" ng-click="sendCode()">
                    获取验证码
                </button>
            </div>
        </form>
        <div class="mui-content-padded">
            <button id='login' class="mui-btn mui-btn-block mui-btn-primary" ng-click="nextStep()">下一步</button>
        </div>
        <div class="mui-content-padded oauth-area">

        </div>
    </div>

    <div class="mui-content" id="passwordBar">
        <form id='resetPasswordForm' class="mui-input-group">
            <div class="mui-input-row">
                <label>密码：</label>
                <input type="password" id="paw1" class="mui-input-clear mui-input" placeholder="重新输入6-12位字母或数字组成的密码" maxlength="16">
            </div>
            <div class="mui-input-row">
                <label></label>
                <input type="password" id="paw2" class="mui-input-clear mui-input" placeholder="再次输入密码" maxlength="16">
            </div>
        </form>
        <div class="mui-content-padded">
            <button class="mui-btn mui-btn-block mui-btn-primary" ng-click="confirm()">确认</button>
        </div>
        <div class="mui-content-padded oauth-area">

        </div>
    </div>


    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>
    <script src="<%=request.getContextPath()%>/appResources/js/common/jQuery.md5.js" type="text/javascript" charset="UTF-8"></script>

    <script type="text/javascript">

        var webApp=angular.module('webApp',[]);
        webApp.controller('forgetPasswordCtr',function($scope,$http,$timeout){
            $scope.phone = null; //存放获取验证码手机号码
            $scope.isPhone = false; //存放手机号是否存在状态
            $scope.width = $("body").width();
            $("#passwordBar").css("transform", "translate(" + $scope.width + "px, 0px)");
            $scope.qrCode = "";

            //下一步
            $scope.nextStep = function () {
                var $phone =$('#phone').val();
                var $qr =$('#qr').val();
                if($phone == ''){
                    mui.toast("手机号不能为空!");
                    return false;
                }
                else if (!BJW.isMobile.test($phone)){
                    mui.toast("请输入一个正确的手机号!");
                    return false;
                }
                else if ($scope.qrCode == ""){
                    mui.toast("请获取验证码!");
                    return false;
                }
                else if ($qr == ""){
                    mui.toast("验证码不能为空!");
                    return false;
                }
                else if($scope.qrCode != $qr){
                    mui.toast("验证码错误，请重新输入!");
                    return false;
                }
                else if ($scope.phone != $phone) {
                    mui.toast("检查到手机号被修改!");
                    return false;
                }

                //验证手机号是否存在
                if ($scope.isPhone) {
                    $("#passwordBar").css("transform", "translate(0px, 0px)");
                    $("#phoneBar").css("transform", "translate(-" + $scope.width + "px, 0px)");
                    $("#passwordBar").show();
                }
                else {
                    mui.alert("手机号错误.");
                }

            }

            //提交密码
            $scope.confirm = function () {
                var $paw1 = $("#paw1").val(); //新密码
                var $paw2 = $("#paw2").val(); //确认密码
                if ($paw1 == "") {
                    mui.toast("请输入新密码.");
                    return false;
                }
                else if ($paw1.trim().length < 6 || $paw1.trim().length > 12) {
                    mui.toast("请输入6-12位的密码.");
                    return false;
                }
                else if ($paw2 == "") {
                    mui.toast("请输入确认密码.");
                    return false;
                }
                else if ($paw1 != $paw2){
                    mui.toast("两次密码不一致.");
                    return false;
                }


                var arr = {
                    phoneNumber : $('#phone').val(),
                    pwd : $.md5($paw2)
                }
                //提交密码
                BJW.ajaxRequestData("post", false, BJW.ip+'/app/cook/forgetPwd',arr, null , function(result){
                    if(result.flag == 0 && result.code == 200){
                        location.href = BJW.ip + "/app/page/cookLogin?pageType=2";
                    }
                });

            }

            //获取验证码
            $scope.sendCode = function (){
                var $phone =$('#phone').val();
                if($phone == ''){
                    mui.toast('手机号不能为空');
                    return false;
                }
                else if (!BJW.isMobile.test($phone)){
                    mui.toast("请输入一个正确的手机号!");
                    return false;
                }
                $(".qr-btn").attr("disabled", true);
                $scope.phone = $phone;
                BJW.ajaxRequestData("get", false, BJW.ip + "/app/cook/checkCook",{phoneNumber: $phone}, "", function (result){
                    if (result.flag==0 && result.code==200){
                        var count = 60;
                        var resend;
                        resend = setInterval(function(){
                            count--;
                            if (count > 0){
                                //console.log(count);
                                $(".qr-btn").html(count+'秒后可重新获取').attr('disabled',true).css('cursor','not-allowed');
                            }else {
                                clearInterval(resend);
                                $(".qr-btn").html("获取验证码").removeClass('disabled').removeAttr('disabled style');
                            }
                        }, 1000);
                        $scope.qrCode = result.data;
                        mui.toast("验证码:" + result.data);
                        $scope.isPhone = true;
                    }
                    else {
                        mui.alert(result.msg);
                        $(".qr-btn").html("获取验证码").removeClass('disabled').removeAttr('disabled style');
                    }
                });


            }
        });


    </script>
</body>

</html>