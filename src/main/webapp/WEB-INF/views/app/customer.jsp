<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>客服</title>
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/customer.css" charset="UTF-8">
    <style>

    </style>

</head>

<body>

    <div class="mui-content">

        <img style="margin-top: -90px" src="<%=request.getContextPath()%>/appResources/img/customer/bg.png">
        <div class="customer-head">
            <div class="customer-head-div">
                <img src="<%=request.getContextPath()%>/appResources/img/customer/head.png">
            </div>
            <div class="customer-name">
                碗妹儿
            </div>
            <div class="customer-info">
                我是客服经理
            </div>
        </div>

        <div class="call-bar">
            <p>亲，你好!</p>
            <p>很高兴为您服务，按键召唤，3分钟我会拨打您的电话。</p>
            <br>
            <div class="mui-input-row">
                <input id="phone" type="number" class="mui-input-clear" placeholder="请在此输入您的号码" maxlength="11">
            </div>
            <button id="tel" class="mui-btn call-btn">
                召唤我的客服经理
            </button>
            <br>
            <br>
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
        <a class="mui-tab-item mui-active" href="<%=request.getContextPath()%>/app/page/customer">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-4-active.png"></div>
            <span class="mui-tab-label">客服</span>
        </a>
        <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/my">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-5.png"></div>
            <span class="mui-tab-label">我的</span>
        </a>
    </nav>


    <!--引入抽取js文件-->
    <%@include file="common/public-js.jsp" %>

    <script type="text/javascript">

        $(function (){

            var userToken = BJW.getLocalStorageToken(); //获取本地存储token
            console.log("来自客服中心打印：" + userToken);

            if (userToken != null) {
                BJW.ajaxRequestData("get", false, BJW.ip+'/app/user/getInfo',{}, userToken , function(result){
                    if(result.flag==0 && result.code==200){
                        $("#phone").val(result.data.phoneNumber);
                    }
                });
            }


            //客服电话
            $("#tel").click(function (){
                if (userToken == null) {
                    mui.confirm('未登录，是否前往登录？', '', ["确认","取消"], function(e) {
                        if (e.index == 0) {
                            location.href = BJW.ip + "/app/page/login?redirectUrl=" + BJW.ip + "/app/page/customer?isOpen=0";
                        }
                    });
                }
                else {
                    var phone = $("#phone").val();
                    if (phone.trim() == '' || phone == null) {
                        $("#contactPhone").val("");
                        mui.toast("请输入您的号码.");
                        return false;
                    }
                    else if (!BJW.isMobile.test(phone.trim())) {
                        mui.toast("请输入正确号码.");
                        return false;
                    }
                    else {
                        //召唤
                        BJW.ajaxRequestData("get", false, BJW.ip+'/app/callMyAM/application', {phoneNumber : phone}, userToken , function(result){
                            if(result.flag == 0 && result.code == 200){
                                mui.alert("召唤成功");
                            }
                        });
                    }
                }
            });
        });




    </script>
</body>

</html>