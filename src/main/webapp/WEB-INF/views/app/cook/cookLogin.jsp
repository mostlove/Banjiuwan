<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>登录</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/cook/cookLogin.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="cookLoginCtr" ng-cloak>

    <div class="mui-content">
        <form id='login-form' class="mui-input-group">
            <div class="mui-input-row">
                <label><img class="login-icon" src="<%=request.getContextPath()%>/appResources/img/login/phone.png"></label>
                <input id='account' type="text" class="mui-input-clear mui-input" placeholder="请在此输入手机号"  maxlength="11" onKeypress="return (/[\d.]/.test(String.fromCharCode(event.keyCode)))">
            </div>
            <div class="mui-input-row">
                <label><img class="login-icon-password" src="<%=request.getContextPath()%>/appResources/img/login/password.png"></label>
                <input id='password' type="password" class="mui-input-clear mui-input" placeholder="请输入密码" maxlength="16">
            </div>
        </form>
        <div class="default-bar">
            <%--<div class="mui-input-row mui-checkbox mui-left">
                <label>记住登录</label>
                <input name="checkbox" value="1" type="checkbox" id="remember">
            </div>--%>
            <a class="forgetPassword" href="<%=request.getContextPath()%>/app/page/forgetPassword">忘记密码</a>
        </div>
        <div class="mui-content-padded">
            <a ng-click="confirmLogin()" id='login' class="mui-btn mui-btn-block mui-btn-primary">登录</a>
        </div>
        <div class="mui-content-padded oauth-area">

        </div>
    </div>

    <%
        String redirectUrl = request.getParameter("redirectUrl");
        if (null == redirectUrl) {
            redirectUrl = "";
        }

    %>
    <input type="hidden" id="redirectUrl" value="<%=redirectUrl%>">


    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>
    <script src="<%=request.getContextPath()%>/appResources/js/common/jQuery.md5.js" type="text/javascript" charset="UTF-8"></script>

    <script type="text/javascript">

        var webApp=angular.module('webApp',[]);
        webApp.controller('cookLoginCtr',function($scope,$http,$timeout){

            $scope.cookToken = BJW.getLocalStorageCookToken();
            if ($scope.cookToken != null) {
                window.location.href = BJW.ip + "/app/page/cookMy?isOpen=0";
            }

            $scope.qrCode = "";
            //确认登录
            $scope.confirmLogin=function () {
                var $account =$('#account').val();
                var $password =$('#password').val();
                if($account == ''){
                    mui.toast("手机号不能为空!");
                    return false;
                }
                else if (!BJW.isMobile.test($account)){
                    mui.toast("请输入一个正确的手机号!");
                    return false;
                }
                else if ($password == ""){
                    mui.toast("密码不能为空!");
                    return false;
                }

                /*var isRemember = $('#remember').is(':checked');
                console.log("是否记住登录：" + isRemember);*/


                var token = BJW.getToken();
                var device =  BJW.getDevice();
                //alert("token：" + token);
                //alert("device：" + device);
                //$('#phone').val(token);
                //$('#qr').val(device);
                var arr={
                    phoneNumber: $account,
                    password: $.md5($password),
                    flag: 6,
                    deviceToken: token == "undefined" ? "": token,
                    deviceType: device == "undefined" ? "": device,
                };
                BJW.cookAjaxRequestData("post", false, BJW.ip+'/app/user/login', arr, "", function(result){
                    if(result.flag==0 && result.code==200){
                        //localStorage.clear();//清空所有本地储存
                        var redirectUrl = $("#redirectUrl").val();
                        localStorage.setItem('cookUserInfo',JSON.stringify(result.data));//存放厨师信息
                        localStorage.setItem("cookToken", result.data.token); //存放厨师token
                        location.href = BJW.ip + "/app/page/cookMy?isOpen=0";
                        if (redirectUrl.length > 0) {
                            window.location.href = redirectUrl;
                        } else {
                            window.location.href = BJW.ip + "/app/page/cookMy?isOpen=0";
                        }
                    }
                });
            }

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
                BJW.ajaxRequestData("get", false, BJW.ip + "/app/user/sendCode",{phoneNumber: $phone}, "", function (result){
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
                    }
                });


            }
        })

    </script>
</body>

</html>