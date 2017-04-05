<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    
    <meta charset="utf-8" />
    <title>登录</title>

    <jsp:include page="common/resources-css.jsp"></jsp:include>
    <link id="beyond-link" href="<%=request.getContextPath()%>/resources/assets/css/beyond.min.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/resources/assets/js/skins.min.js"></script>
    <link href="<%=request.getContextPath()%>/resources/assets/css/skins/gray.min.css" rel="stylesheet" />
    <style>
        html,body,.login-container{
            width: 100%;
            height: 100%;
        }
        .login-container{
            margin: auto;
        }
        .login-container .loginbox{
            width: 400px!important;
            height: 320px !important;
            position: absolute;
            left: 50%;
            top: 50%;
            margin-top: -250px;
            margin-left: -200px;
        }
        .login-container .loginbox .social-buttons{
            height: auto !important;
        }
        .login-container .loginbox .social-buttons img{
            width: 100%;
            height: 50px;
        }
    </style>
</head>
<body>
<div class="login-container animated fadeInDown">
    <div class="loginbox bg-white">
        <div class="loginbox-title">SIGN IN</div>
        <div class="loginbox-social">
            <div class="social-buttons">
                <img src="<%=request.getContextPath()%>/resources/img/logo.png" alt="该位置放置logo  logo高度为50px" />
            </div>
        </div>
        <div class="loginbox-or">
            <div class="or-line"></div>
            <div class="or">OR</div>
        </div>
        <div class="loginbox-textbox">
            <input type="text" class="form-control" id="mobile" placeholder="手机号" value="admin"/>
        </div>
        <div class="loginbox-textbox">
            <input type="password" class="form-control" id="password" placeholder="密码" value="111111"/>
        </div>
        <div class="loginbox-submit">
            <input type="button" class="btn btn-primary btn-block" id="loginBtn" value="登录">
        </div>
    </div>
</div>
<!--Basic Scripts-->
<jsp:include page="common/resources-js.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/assets/js/jQuery.md5.js"></script>
<script type="text/javascript">

    if(window.top != window.self){
        window.top.location = window.location;
    }

    $("#loginBtn").click(function(){
        login();
    });

    document.onkeydown = function(event) {
        var code;
        if (!event) {
            event = window.event; //针对ie浏览器
            code = event.keyCode;
            if (code == 13) {
                login();
            }
        }
        else {
            code = event.keyCode;
            if (code == 13) {
                login();
            }
        }
    };

    function login(){
        var mobile = $("#mobile").val();
        var password = $.md5($("#password").val());
        if(mobile != "" && password!=""){
            $.ajax({
                type : "POST",
                url : "<%=request.getContextPath()%>/web/user/login",
                data : {phoneNumber:mobile,password:password},
                dataType :"json",
                async : false,
                timeout : 5000,
                success : function(respObj){
                    var status = respObj.code;
                    if(status==200){
                        window.location.href="<%=request.getContextPath()%>/web/index";
                    }else{
                        Notify(respObj.msg,'top-right','5000','danger','fa-desktop',true);
                    }
                }
            });
        }else{
            Notify("请输入手机号或密码",'top-right','5000','danger','fa-desktop',true);
        }
    }

</script>
</body>
</html>
