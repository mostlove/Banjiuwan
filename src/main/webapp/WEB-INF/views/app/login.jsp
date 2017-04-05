<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>登录</title>
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/login.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="loginCtr" ng-cloak>
    <div class="mui-content">

        <img class="cover" src="<%=request.getContextPath()%>/appResources/img/login/login-bg.png">
        <div class="login-icon-max">
            <img src="<%=request.getContextPath()%>/appResources/img/icon/logo.png">
        </div>
        <form>
            <div class="login">
                <div class="mui-row login-border">
                    <div class="mui-col-xs-2 mui-col-sm-2">
                        <img class="login-icon" src="<%=request.getContextPath()%>/appResources/img/login/phone.png">
                    </div>
                    <div class="mui-col-xs-10 mui-col-sm-10">
                        <label class="login-label">手机号</label>
                        <div class="mui-input-row">
                            <label>+86</label>
                            <input type="text" class="mui-input-clear" id="phone" placeholder="请输入您的手机号" maxlength="11" onKeypress="return (/[\d.]/.test(String.fromCharCode(event.keyCode)))">
                        </div>
                    </div>
                </div>
                <div class="mui-row login-border">
                    <div class="mui-col-xs-2 mui-col-sm-2">
                        <img class="login-icon" src="<%=request.getContextPath()%>/appResources/img/login/qr.png">
                    </div>
                    <div class="mui-col-xs-10 mui-col-sm-10">
                        <label class="login-label">验证码</label>
                        <div class="mui-input-row">
                            <input type="text" class="qr-input" id="qr" placeholder="请输入验证码" maxlength="4" onKeypress="return (/[\d.]/.test(String.fromCharCode(event.keyCode)))">
                            <button type="button" class="mui-btn qr-btn" ng-click="sendCode()">
                                获取验证码
                            </button>
                        </div>
                    </div>
                </div>
                <div class="mui-row">
                    <div class="mui-col-xs-2 mui-col-sm-2">
                    </div>
                    <div class="mui-col-xs-10 mui-col-sm-10">
                        <div class="mui-input-row mui-checkbox mui-left">
                            <label class="protocol-label">我已阅读并同意《办酒碗》</label>
                            <a class="userAgreement" href="<%=request.getContextPath()%>/app/page/userAgreement">用户协议</a>
                            <input class="login-checkbox" name="checkbox" value="1" type="checkbox" id="agreement" checked>
                        </div>
                    </div>
                </div>
            </div>

            <div class="login-btn-div">
                <button class="mui-btn login-btn" ng-click="confirmLogin()">
                    登录
                </button>
            </div>

        </form>
    </div>
    <%
        String redirectUrl = request.getParameter("redirectUrl");
        if (null == redirectUrl) {
            redirectUrl = "";
        }

    %>
    <input type="hidden" id="redirectUrl" value="<%=redirectUrl%>">


    <!--引入抽取js文件-->
    <%@include file="common/public-js.jsp" %>

    <script type="text/javascript">

        mui("body").on('tap','a',function(){document.location.href=this.href;});

        var webApp=angular.module('webApp',[]);
        //登录
        webApp.controller('loginCtr',function($scope,$http,$timeout){

            $scope.phone = null; //存放获取验证码手机号码

            $scope.userToken = BJW.getLocalStorageToken();
            if ($scope.userToken != null) {
                window.location.href = BJW.ip + "/app/page/my?isOpen=0";
            }

            $scope.qrCode = "";
            //确认登录
            $scope.confirmLogin=function () {
                var $phone =$('#phone').val();
                var $qr =$('#qr').val();
                console.log($('#agreement').is(':checked'));
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
                else if (!$('#agreement').is(':checked')){
                    mui.toast("请先阅读协议!");
                    return false;
                }
                var token = BJW.getToken();
                var device =  BJW.getDevice();
                //alert("token：" + token);
                //alert("device：" + device);
                //$('#phone').val(token);
                //$('#qr').val(device);
                var arr={
                    phoneNumber: $phone,
                    flag: 7,
                    deviceToken: token == "undefined" ? "": token,
                    deviceType: device == "undefined" ? "": device,
                };
                BJW.ajaxRequestData("post", false, BJW.ip+'/app/user/login', arr, "", function(result){
                    if(result.flag==0 && result.code==200){
                        //localStorage.clear();//清空所有本地储存
                        localStorage.setItem('loginUserInfo',JSON.stringify(result.data));
                        localStorage.setItem('loginUserId',result.data.id);
                        console.log(result.data.token);
                        localStorage.setItem('userToken',result.data.token);
                        var redirectUrl = $("#redirectUrl").val();
                        if (!BJW.isWeiXin()) {
                            try {
                                window.JSBridge.saveToken(result.data.token);
                            }catch (error){

                            }
                        }
                        var redirectUrl2 = localStorage.getItem("redirectUrl");
                        if (redirectUrl2 != null) {
                            window.location.href = redirectUrl2;
                            return false;
                        }

                        var str = "";
                        if (redirectUrl.indexOf("?") != -1) {
                            str = "&pageType=2";
                        }
                        else {
                            str = "?pageType=2";
                        }
                        if (redirectUrl.length > 0) {
                            window.location.href = redirectUrl + str;
                        } else {
                            window.location.href = BJW.ip + "/app/page/index?pageType=2";
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
                $(".qr-btn").attr("disabled", true);
                $scope.phone = $phone;
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

        });

    </script>
</body>

</html>