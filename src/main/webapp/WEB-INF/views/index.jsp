<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>主页</title>

    <!-- 引用公用css -->
    <jsp:include page="common/resources-css.jsp"></jsp:include>
    <link id="beyond-link" href="<%=request.getContextPath()%>/resources/assets/css/beyond.min.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/resources/assets/js/skins.min.js"></script>
    <link href="<%=request.getContextPath()%>/resources/assets/css/skins/gray.min.css" rel="stylesheet" />

    <style>

        .navbar .navbar-inner .navbar-header .navbar-account .account-area>li .dropdown-menu.dropdown-messages li .message{
            width: 100%;
        }

        .navbar-brand{
            padding-top: 10px !important;
            padding-left: 20px !important;
        }
    </style>

    <script>
        //装载子页面
        function resizeHeight() {
            var ifm= document.getElementById("iframe");
            var subWeb = document.frames ? document.frames["iframe"].document : ifm.contentDocument;
            if (ifm != null && subWeb != null) {
                ifm.height = subWeb.body.scrollHeight;
            }
        }
    </script>
</head>
<body>
<!-- 加载样式 Container -->
<div class="loading-container">
    <div class="loading-progress">
        <div class="rotator">
            <div class="rotator">
                <div class="rotator colored">
                    <div class="rotator">
                        <div class="rotator colored">
                            <div class="rotator colored"></div>
                            <div class="rotator"></div>
                        </div>
                        <div class="rotator colored"></div>
                    </div>
                    <div class="rotator"></div>
                </div>
                <div class="rotator"></div>
            </div>
            <div class="rotator"></div>
        </div>
        <div class="rotator"></div>
    </div>
</div>
<!--  /Loading Container -->
<!-- 顶部导航 Navbar -->
<div class="navbar">
    <div class="navbar-inner">
        <div class="navbar-container">
            <!-- Navbar Barnd -->
            <div class="navbar-header pull-left">
                <a href="<%=request.getContextPath()%>/web/main" target="iframe" class="navbar-brand">
                    <img src="<%=request.getContextPath()%>/resources/img/index_title.png" alt="" />
                </a>
            </div>
            <!-- /Navbar Barnd -->

            <!-- Sidebar Collapse -->
            <div class="sidebar-collapse" id="sidebar-collapse">
                <i class="collapse-icon fa fa-bars"></i>
            </div>
            <!-- /Sidebar Collapse -->
            <!-- Account Area and Settings --->
            <div class="navbar-header pull-right">
                <div class="navbar-account">
                    <!-- 消息通知 -->
                    <ul class="account-area">
                        <li>

                            <!--Messages Dropdown-->
                            <ul class="pull-right dropdown-menu dropdown-arrow dropdown-messages" id="message">
                                <li>
                                    <a href="#">
                                        <span class='label-hint'>暂未消息通知...</span>
                                    </a>
                                </li>
                            </ul>
                            <!--/Messages Dropdown-->
                        </li>

                        <li style="display: none;">
                            <a class="dropdown-toggle" data-toggle="dropdown" title="Tasks" href="#">
                                <i class="icon fa fa-tasks"></i>
                                <span class="badge">4</span>
                            </a>
                            <!--Tasks Dropdown-->
                            <ul class="pull-right dropdown-menu dropdown-tasks dropdown-arrow ">
                                <li class="dropdown-header bordered-darkorange">
                                    <i class="fa fa-tasks"></i>
                                    内容待定...
                                </li>
                                <li>
                                    <a href="#">
                                        <div class="clearfix">
                                            <span class="pull-left">Account Creation</span>
                                            <span class="pull-right">65%</span>
                                        </div>

                                        <div class="progress progress-xs">
                                            <div style="width:65%" class="progress-bar"></div>
                                        </div>
                                    </a>
                                </li>
                                <li class="dropdown-footer">
                                    <a href="#">
                                        See All Tasks
                                    </a>
                                    <button class="btn btn-xs btn-default shiny darkorange icon-only pull-right"><i class="fa fa-check"></i></button>
                                </li>
                            </ul>
                            <!--/Tasks Dropdown-->
                        </li>
                        <li>
                            <a class="login-area dropdown-toggle" data-toggle="dropdown">
                                <div class="avatar" title="${user.userName}">
                                    <img src="<%=request.getContextPath()%>/resources/img/hotel.png">
                                </div>
                                <section>
                                    <h2><span class="profile"><span>${user.userName}</span></span></h2>
                                </section>
                                <input type="hidden" value="${user.id}" id="userId">
                            </a>
                            <!--Login Area Dropdown-->
                            <ul class="pull-right dropdown-menu dropdown-arrow dropdown-login-area">
                                <li class="username"><a>获取名字</a></li>
                                <li class="dropdown-footer">
                                    <a href="javascript:void(0)" onclick="updateUserPwd()" class="text-align-center" style="width: 100%" target="iframe">
                                        修改密码
                                    </a>
                                </li>
                                <li class="dropdown-footer">
                                    <a href="<%=request.getContextPath()%>/web/logout" class="text-align-center" style="width: 100%">
                                        退出
                                    </a>
                                </li>
                            </ul>
                            <!--/Login Area Dropdown-->
                        </li>
                    </ul>
                    <!-- Settings -->
                </div>
            </div>
            <!-- /Account Area and Settings -->
        </div>
    </div>
</div>
<!-- /Navbar -->
<!-- 左侧菜单栏--Main Container -->
<div class="main-container container-fluid">
    <!-- Page Container -->
    <div class="page-container">
        <!-- Page Sidebar -->
        <div class="page-sidebar" id="sidebar">
            <!-- Sidebar Menu -->
            <ul class="nav sidebar-menu">
                <li class="active">
                    <a href="<%=request.getContextPath()%>/web/main" target="iframe">
                        <i class="menu-icon glyphicon glyphicon-home"></i>
                        <span class="menu-text"> 主页面 </span>
                    </a>
                </li>
                <c:forEach items="${user.role.menus}" var="menu">
                    <li>
                        <a href="<%=request.getContextPath()%>/web${menu.url}" target="iframe">
                            <i class="menu-icon glyphicon glyphicon-th-large"></i>
                            <span class="menu-text"> ${menu.menuName} </span>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="page-content">
            <iframe id="iframe" name="iframe" onload="resizeHeight()" src="<%=request.getContextPath()%>/web/main" frameborder="0" style="width: 100%;height:1000px; overflow-x:hidden;"></iframe>
        </div>
    </div>
</div>

<!-- 引用公用js -->
<jsp:include page="common/resources-js.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/assets/js/jQuery.md5.js"></script>
<script>



    function updateUserPwd(){

        var str='<div id="myModal">' +
                '<form  class="form-horizontal" >' +
                '   <div class="form-body">'+
                '       <div class="form-group border-1">'+
                '           <div class="inline-form">'+
                '               <label class="control-label col-md-2">原密码</label>'+
                '               <div class="col-md-8">'+
                '           <input type="password" class="form-control" maxlength="50" name="oldPassword" id="oldPassword" placeholder="请输入原密码">'+
                '           <span class="help-block"></span>'+
                '          </div>'+
                '           </div>'+
                '       </div>'+
                '       <div class="form-group border-1">'+
                '           <div class="inline-form">'+
                '               <label class="control-label col-md-2">新密码</label>'+
                '               <div class="col-md-8">'+
                '           <input type="password" class="form-control" maxlength="50" name="newPassword" id="newPassword" placeholder="请输入新密码">'+
                '           <span class="help-block"></span>'+
                '          </div>'+
                '           </div>'+
                '       </div>'+
                '       <div class="form-group border-1">'+
                '           <div class="inline-form">'+
                '               <label class="control-label col-md-2">重复新密码</label>'+
                '               <div class="col-md-8">'+
                '           <input type="password" class="form-control" maxlength="50" name="reNewPassword" id="reNewPassword" placeholder="">'+
                '           <span class="help-block"></span>'+
                '          </div>'+
                '           </div>'+
                '       </div>'+
                '   </div>' +
                '</form>'+
                '</div>';
        bootbox.dialog({
            message: str,
            title: "修改密码",
            buttons: {
                "关闭": {
                    className: "btn-default",
                    callback: function () {

                    }
                },
                success: {
                    label: "确定",
                    className: "btn-primary",
                    callback: function () {

                        var oldPassword = $.md5($("#oldPassword").val());
                        var newPassword = $.md5($("#newPassword").val());
                        var reNewPassword = $.md5($("#reNewPassword").val());
                        var userId = $("#userId").val();
                        if(null == oldPassword.length || null == newPassword || oldPassword.length == 0 || newPassword == 0){
                            Notify("没有输入密码", 'top-right', '5000', 'danger', 'fa-desktop', true);
                            return;
                        }
                        if(newPassword != reNewPassword){
                            Notify("两次输入的新密码不对", 'top-right', '5000', 'danger', 'fa-desktop', true);
                            return;
                        }

                        $.ajax({
                            type:"POST",
                            url:getRootPath()+"/web/user/updateUserPwd",
                            data:{
                                oldPassword:oldPassword,
                                newPassword:newPassword,
                                userId:userId
                            },
                            dataType:"json",
                            async:false,
                            timeout:5000,
                            success : function(json){
                                if(json.code == 200){
                                    Notify("更新成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                    location.reload();
                                }
                                else{
                                    Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                                }
                            }
                        });
                    }
                }

            }
        });

    }


    var secthei = document.documentElement.clientHeight || document.body.clientHeight;
    var headerh = 55;
    document.getElementById("iframe").style.height = (secthei-headerh) + "px";
    //左侧菜单选择
    $('#sidebar-collapse').click(function(){
        if($(this).hasClass('active')){
            $('.navbar-brand .logo-lg').hide();
            $('.navbar-brand .logo-mini').show();
        }else{
            $('.navbar-brand .logo-lg').show();
            $('.navbar-brand .logo-mini').hide();
        }
    })
    $('.sidebar-menu li').each(function(){
        var $this=$(this).find('a');
        $(this).click(function(){
            $('.sidebar-menu li').removeClass('active');
            $(this).addClass('active');
        })
    })

    //taskScheduling();//默认调一次

    //setInterval(taskScheduling,60000);//一分钟调一次

    //获取订单消息
    function taskScheduling () {
        $.ajax({
            type:"get",
            url: "<%=request.getContextPath()%>/ctl/order/getNewOrder",
            data:{},
            success:function(json){
                console.log(json);
                if (json.code == 0) {
                    $("#news").html(json.data.length);//获取多少条消息
                    var html = "";
                    if (json.data.length < 1) {
                        html = "<li><a href=\"#\"><span class='label-hint'>暂未消息通知...</span></a></li>";
                    }
                    else {
                        html = "";
                    }
                    for (var i = 0 ; i < json.data.length; i++) {
                        var updateTime = countTime(json.data[i].updateTime);
                        console.log(updateTime);
                        html += "<li>" +
                                "<a href='<%=request.getContextPath()%>/ctl/order/edit?id="+ json.data[i].id +"' target='iframe'>" +
                                "<div class='message'>" +
                                "<span class='message-sender'>订单号:"+ json.data[i].sn +"</span>" +
                                "<span class='message-time'>"+ updateTime +"</span>" +
                                "<span class='message-subject'>您有一个新的订单请注意查看...</span>" +
                                "</div>" +
                                "</a>" +
                                "</li>";
                    }
                    $("#message").html(html);
                }
            }
        });
    }

    //验证是否完善资料了
    var bankAccount = "${company.bankAccount}";
    if (bankAccount == null || bankAccount == "") {
        /*bootbox.dialog({
            message: "<h4 style='color: red;'><b>系统检测到资料未完善，请前往完善资料。</b></h4>",
            title: "温馨提示",
            closeButton: false,
            buttons: {
                success: {
                    label: "确认",
                    className: "btn-danger",
                    callback: function () {
                        window.open("<%=request.getContextPath()%>/ctl/company/edit","iframe");
                    }
                }
            }
        });*/
    }

</script>
</body>
</html>
