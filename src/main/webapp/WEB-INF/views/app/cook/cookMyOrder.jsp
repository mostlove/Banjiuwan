<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>我的订单</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/cook/cookMyOrder.css" charset="UTF-8">
    <style>
        .mui-bar~.mui-content .mui-fullscreen {
            top: 44px;
            height: auto;
        }
        .mui-pull-top-tips {
            position: absolute;
            top: -20px;
            left: 50%;
            margin-left: -25px;
            width: 40px;
            height: 40px;
            border-radius: 100%;
            z-index: 1;
        }
        .mui-bar~.mui-pull-top-tips {
            top: 24px;
        }
        .mui-pull-top-wrapper {
            width: 42px;
            height: 42px;
            display: block;
            text-align: center;
            background-color: #efeff4;
            border: 1px solid #ddd;
            border-radius: 25px;
            background-clip: padding-box;
            box-shadow: 0 4px 10px #bbb;
            overflow: hidden;
        }
        .mui-pull-top-tips.mui-transitioning {
            -webkit-transition-duration: 200ms;
            transition-duration: 200ms;
        }
        .mui-pull-top-tips .mui-pull-loading {
            /*-webkit-backface-visibility: hidden;
            -webkit-transition-duration: 400ms;
            transition-duration: 400ms;*/

            margin: 0;
        }
        .mui-pull-top-wrapper .mui-icon,
        .mui-pull-top-wrapper .mui-spinner {
            margin-top: 7px;
        }
        .mui-pull-top-wrapper .mui-icon.mui-reverse {
            /*-webkit-transform: rotate(180deg) translateZ(0);*/
        }
        .mui-pull-bottom-tips {
            text-align: center;
            background-color: #efeff4;
            font-size: 15px;
            line-height: 40px;
            color: #777;
        }
        .mui-pull-top-canvas {
            overflow: hidden;
            background-color: #fafafa;
            border-radius: 40px;
            box-shadow: 0 4px 10px #bbb;
            width: 40px;
            height: 40px;
            margin: 0 auto;
        }
        .mui-pull-top-canvas canvas {
            width: 40px;
        }

    </style>

</head>

<body>
<div class="mui-content">

    <div id="slider" class="mui-slider">
        <div id="sliderSegmentedControl" class="mui-slider-indicator mui-segmented-control mui-segmented-control-inverted">
            <a class="mui-control-item mui-active" href="#page1">
                待接单
            </a>
            <a class="mui-control-item" href="#page2">
                待服务
            </a>
            <a class="mui-control-item" href="#page3">
                服务中
            </a>
            <a class="mui-control-item" href="#page4">
                完成
            </a>
        </div>
        <div id="sliderProgressBar" class="mui-slider-progress-bar mui-col-xs-3"></div>
        <div class="mui-slider-group" id="mui-slider-group">

            <!--待接单-->
            <div id="page1" class="mui-slider-item mui-control-content mui-active">
                <!--loading-->
                <div class="mui-scroll-wrapper">
                    <div class="mui-scroll notOrderHeight">
                        <div id="status1">
                            <div class="order-loading notOrderHeight">
                                <img src="<%=request.getContextPath()%>/appResources/img/icon/loading.gif"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--待服务-->
            <div id="page2" class="mui-slider-item mui-control-content">
                <!--loading-->
                <div class="mui-scroll-wrapper">
                    <div class="mui-scroll notOrderHeight">
                        <div id="status2">
                            <div class="order-loading notOrderHeight">
                                <img src="<%=request.getContextPath()%>/appResources/img/icon/loading.gif"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--服务中-->
            <div id="page3" class="mui-slider-item mui-control-content">
                <!--loading-->
                <div class="mui-scroll-wrapper">
                    <div class="mui-scroll notOrderHeight">
                        <div id="status3">
                            <div class="order-loading notOrderHeight">
                                <img src="<%=request.getContextPath()%>/appResources/img/icon/loading.gif"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--完成-->
            <div id="page4" class="mui-slider-item mui-control-content">
                <!--loading-->
                <div class="mui-scroll-wrapper">
                    <div class="mui-scroll notOrderHeight">
                        <div id="status4">
                            <div class="order-loading notOrderHeight">
                                <img src="<%=request.getContextPath()%>/appResources/img/icon/loading.gif"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>

<!--底部-->
<nav class="mui-bar mui-bar-tab tab-bottom" id="tabBottom2">
    <a class="mui-tab-item mui-active" href="<%=request.getContextPath()%>/app/page/cookMyOrder">
        <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-6-active.png"></div>
        <span class="mui-tab-label">我的订单</span>
    </a>
    <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/cookMy">
        <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-5.png"></div>
        <span class="mui-tab-label">我的</span>
    </a>
</nav>



<!--引入抽取js文件-->
<%@include file="../common/public-js.jsp" %>
<script src="<%=request.getContextPath()%>/appResources/js/common/mui.pullToRefresh.js" type="text/javascript" charset="UTF-8"></script>
<script src="<%=request.getContextPath()%>/appResources/js/common/mui.pullToRefresh.material.js" type="text/javascript" charset="UTF-8"></script>


<script type="text/javascript">

    $("body").append(BJW.dialogLoading("加载中···"));//弹窗loading
    //获取登录用户token
    var cookToken = BJW.getLocalStorageCookToken();
    //mui.alert("token:" + cookToken);
    console.log("token:" + cookToken);

    //初始化订单列表
    //待接单
    var statusHtml1 = getOrderList(BJW.getOrderStatus.PENDING_ORDERS, 1, 10);
    if (statusHtml1 == null) {
        $("#status1").html("<div class='orderList notOrderHeight'><div class='notOrder'>您还没有相关订单.</div></div>");
    }
    else {
        $("#status1").html("<div class=\"orderList\">" + statusHtml1 + "</div>");
    }
    /*//待服务
    var statusHtml2 = getOrderList(BJW.getOrderStatus.PENDING_SERVICE, 1, 10);
    if (statusHtml2 == null) {
        $("#status2").html("<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class='orderList notOrderHeight'><div class='notOrder'>您还没有相关订单.</div></div></div></div>");
    }
    else {
        $("#status2").html("<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class=\"orderList\">" + statusHtml2 + "</div></div></div>");
    }
    //服务中
    var statusHtml3 = getOrderList(BJW.getOrderStatus.SERVICEING, 1, 10);
    if (statusHtml3 == null) {
        $("#status3").html("<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class='orderList notOrderHeight'><div class='notOrder'>您还没有相关订单.</div></div></div></div>");
    }
    else {
        $("#status3").html("<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class=\"orderList\">" + statusHtml3 + "</div></div></div>");
    }
    //完成
    var statusHtml4 = getOrderList(BJW.getOrderStatus.FINISHED, 1, 10);
    if (statusHtml4 == null) {
        $("#status4").html("<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class='orderList notOrderHeight'><div class='notOrder'>您还没有相关订单.</div></div></div></div>");
    }
    else {
        $("#status4").html("<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class=\"orderList\">" + statusHtml4 + "</div></div></div>");
    }*/

    //获取订单列表
    function getOrderList(status, pageNO, pageSize){
        console.debug("传入的页码：" + pageNO);
        var arr = {
            status : status,
            pageNO : pageNO,
            pageSize : pageSize
        }
        var html = "";
        BJW.cookAjaxRequestData("get", false, BJW.ip+'/app/order/getOrders', arr, cookToken , function(result){
            if(result.flag == 0 && result.code == 200){
                html = bindData(result.data);
            }
        });
        return html;
    }

    //绑定数据
    function bindData(jsonData) {
        console.log(jsonData);
        if (jsonData.length != 0) {
            //遍历商品
            var html = "";
            for ( var i = 0; i < jsonData.length; i++) {
                var payMethod = "<span class=\"line-down\">线下</span>";
                if (jsonData[i].payMethod != 2) {
                    payMethod = "<span class=\"line-up\">线上</span>";
                }
                var servicePower = "";
                //待接单
                if (jsonData[i].status == BJW.getOrderStatus.PENDING_ORDERS) {
                    servicePower = "<button class=\"operation-btn border-right\" onclick=\"confirmOrders(this, " + jsonData[i].isMain + ", " + jsonData[i].id + ")\"><img src=\"" + BJW.ip + "/appResources/img/icon/cook-icon-3.png\">确认接单</button>";
                }
                //待服务
                else if (jsonData[i].status == BJW.getOrderStatus.PENDING_SERVICE) {
                    servicePower = "<button class=\"operation-btn border-right\" onclick=\"startService(this, " + jsonData[i].isMain + ", " + jsonData[i].id + ")\"><img src=\"" + BJW.ip + "/appResources/img/icon/cook-icon-1.png\">开始服务</button>";
                }
                //服务中
                else if (jsonData[i].status == BJW.getOrderStatus.SERVICEING) {
                    servicePower = "<button class=\"operation-btn border-right\" onclick=\"serviceConfirm(this, " + jsonData[i].isMain + ", " + jsonData[i].id + ", " + jsonData[i].payMethod + ")\"><img src=\"" + BJW.ip + "/appResources/img/icon/cook-icon-2.png\">服务完成</button>";
                }
                //完成
                else if (jsonData[i].status == BJW.getOrderStatus.FINISHED) {
                    servicePower = "<button disabled type='button' class=\"operation-btn border-right isConfirm\"><img src=\"" + BJW.ip + "/appResources/img/icon/cook-icon-2.png\">已完成</button>";
                }

                if (i == 0) {
                    html += "<div class=\"order-bar\" style=\"margin-top: 0;\">" +
                                "<div class=\"order-num\">" +
                                        payMethod + "订单号：" +
                                        "<a href=\"javascript:orderCookDetail(" + jsonData[i].id + ")\"><span>" + jsonData[i].orderNumber + "</span></a>" +
                                "</div>" +
                                "<div class=\"address-bar\">" +
                                    "<ul class=\"mui-table-view\">" +
                                        "<li class=\"mui-table-view-cell mui-media\">" +
                                            "<a href=\"javascript:orderCookDetail(" + jsonData[i].id + ")\">" +
                                                "<div class=\"mui-media-body\">" +
                                                    "<div class=\"mui-row\">" +
                                                        "<div class=\"mui-col-xs-3 mui-col-sm-3\">" +
                                                            "<p class=\"title-hint\">联系人：</p>" +
                                                            "<p class=\"title-hint\">服务时间：</p>" +
                                                            "<p class=\"title-hint\">服务地址：</p>" +
                                                        "</div>" +
                                                        "<div class=\"mui-col-xs-9 mui-col-sm-9\">" +
                                                            "<p class=\"title-hint\">" +
                                                                "<span class=\"user-name\">" + jsonData[i].userName + "</span>" +
                                                                "<span class=\"user-phone\">" + jsonData[i].userPhone + "</span>" +
                                                            "</p>" +
                                                            "<p class=\"title-hint\" style='margin-top: 7px;'>" + new Date(jsonData[i].serviceDate).format("yyyy-MM-dd hh:mm:ss") + "</p>" +
                                                            "<p class=\"title-hint\">" + jsonData[i].address + "</p>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</a>" +
                                        "</li>" +
                                    "</ul>" +
                                "</div>" +
                                "<div class=\"operation-bar\">" +
                                    "<div class=\"mui-row\">" +
                                        "<div class=\"mui-col-xs-6 mui-col-sm-6\">" +
                                            servicePower +
                                        "</div>" +
                                    "<div class=\"mui-col-xs-6 mui-col-sm-6\">" +
                                        "<a class=\"operation-btn\" href=\"tel:" + jsonData[i].userPhone + "\"><img src=\"" + BJW.ip + "/appResources/img/icon/cook-icon-4.png\">联系客户</a>" +
                                    "</div>" +
                                "</div>" +
                            "</div>" +
                        "</div>";
                }
                else {
                    html += "<div class=\"order-bar\">" +
                                "<div class=\"order-num\">" +
                                        payMethod + "订单号：" +
                                        "<a href=\"javascript:orderCookDetail(" + jsonData[i].id + ")\"><span>" + jsonData[i].orderNumber + "</span></a>" +
                                "</div>" +
                                "<div class=\"address-bar\">" +
                                    "<ul class=\"mui-table-view\">" +
                                        "<li class=\"mui-table-view-cell mui-media\">" +
                                            "<a href=\"javascript:orderCookDetail(" + jsonData[i].id + ")\">" +
                                                "<div class=\"mui-media-body\">" +
                                                    "<div class=\"mui-row\">" +
                                                        "<div class=\"mui-col-xs-3 mui-col-sm-3\">" +
                                                            "<p class=\"title-hint\">联系人：</p>" +
                                                            "<p class=\"title-hint\">服务时间：</p>" +
                                                            "<p class=\"title-hint\">服务地址：</p>" +
                                                        "</div>" +
                                                        "<div class=\"mui-col-xs-9 mui-col-sm-9\">" +
                                                            "<p class=\"title-hint\">" +
                                                                "<span class=\"user-name\">" + jsonData[i].userName + "</span>" +
                                                                "<span class=\"user-phone\">" + jsonData[i].userPhone + "</span>" +
                                                            "</p>" +
                                                            "<p class=\"title-hint\" style='margin-top: 7px;'>" + new Date(jsonData[i].serviceDate).format("yyyy-MM-dd hh:mm:ss") + "</p>" +
                                                            "<p class=\"title-hint\">" + jsonData[i].address + "</p>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</a>" +
                                        "</li>" +
                                    "</ul>" +
                                "</div>" +
                                "<div class=\"operation-bar\">" +
                                    "<div class=\"mui-row\">" +
                                        "<div class=\"mui-col-xs-6 mui-col-sm-6\">" +
                                            servicePower +
                                        "</div>" +
                                    "<div class=\"mui-col-xs-6 mui-col-sm-6\">" +
                                        "<a class=\"operation-btn\" href=\"tel:" + jsonData[i].userPhone + "\"><img src=\"" + BJW.ip + "/appResources/img/icon/cook-icon-4.png\">联系客户</a>" +
                                    "</div>" +
                                "</div>" +
                            "</div>" +
                        "</div>";
                }
            }
        }
        else {
            return null;
        }

        return html;
    }

    //确认接单
    function confirmOrders(isMain, orderId){
        if (isMain == 0) {
            mui.alert("抱歉,您不是主厨,不能做此操作.");
        }
        else {
            var arr = {
                orderId : orderId,
                flag : 0
            }
            mui.confirm('是否确认接单？', '', ["确认","取消"], function(e) {
                if (e.index == 0) {
                    BJW.cookAjaxRequestData("post", false, BJW.ip+'/app/order/cookUpdateOrder', arr, cookToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            location.reload();
                        }
                    });
                } else {

                }
            });
        }
    }
    //开始服务
    function startService(obj, isMain, orderId){
        if (isMain == 0) {
            mui.alert("抱歉,您不是主厨,不能做此操作.");
        }
        else {
            var arr = {
                orderId : orderId,
                flag : 1
            }
            mui.confirm('是否确认开始服务？', '', ["确认","取消"], function(e) {
                if (e.index == 0) {
                    BJW.cookAjaxRequestData("post", false, BJW.ip+'/app/order/cookUpdateOrder', arr, cookToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            $(obj).parent().parent().parent().parent().fadeOut();
                            //location.reload();
                        }
                    });
                } else {

                }
            });
        }
    }
    //服务完成
    function serviceConfirm(obj, isMain, orderId, payMethod){
        if (isMain == 0) {
            mui.alert("抱歉,您不是主厨,不能做此操作.");
        }
        else {
            var arr = {
                orderId : orderId,
                flag : 2
            }
            if (payMethod != 2) {
                mui.confirm('是否确认服务完成？', '', ["确认","取消"], function(e) {
                    if (e.index == 0) {
                        BJW.cookAjaxRequestData("post", false, BJW.ip+'/app/order/cookUpdateOrder', arr, cookToken , function(result){
                            if(result.flag == 0 && result.code == 200){
                                $(obj).parent().parent().parent().parent().fadeOut();
                                //location.reload();
                            }
                        });
                    } else {

                    }
                });
            }
            else {
                mui.confirm('此单为线下订单，请确认是否收款？', '', ["确认","取消"], function(e) {
                    if (e.index == 0) {
                        BJW.cookAjaxRequestData("post", false, BJW.ip+'/app/order/cookUpdateOrder', arr, cookToken , function(result){
                            if(result.flag == 0 && result.code == 200){
                                location.reload();
                            }
                        });
                    } else {

                    }
                });
            }


        }
    }

    function orderCookDetail(orderId) {
        console.log(orderId);
        localStorage.setItem("orderId", orderId);
        if (orderId != null) {
            location.href = BJW.ip + "/app/page/cookOrderDetail";
        }
        else {
            mui.alert("订单ID不能为空.");
        }
    }

    // 监听tap事件，解决 a标签 不能跳转页面问题
    mui("#mui-slider-group").on('tap','a',function(){document.location.href=this.href;});

    mui.init({
        swipeBack: false
    });


    var pageNo1 = 1;
    var pageNo2 = 1;
    var pageNo3 = 1;
    var pageNo4 = 1;

    var isComeNo1 = 0;
    var isComeNo2 = 0;
    var isComeNo3 = 0;
    (function($) {
        //阻尼系数
        var deceleration = mui.os.ios?0.003:0.0009;
        $('.mui-scroll-wrapper').scroll({
            bounce: false, //是否回弹
            indicators: true, //是否显示滚动条
            deceleration:deceleration
        });

        //左右却换加载
        document.getElementById('slider').addEventListener('slide', function(e) {
            console.log(e.detail.slideNumber);
            if (e.detail.slideNumber == 0) {

            }
            else if (e.detail.slideNumber == 1 && isComeNo1 == 0) {
                //待服务
                var statusHtml2 = getOrderList(BJW.getOrderStatus.PENDING_SERVICE, 1, 10);
                if (statusHtml2 == null) {
                    document.getElementById('status2').innerHTML = "<div class='orderList notOrderHeight'><div class='notOrder'>您还没有相关订单.</div></div>";
                }
                else {
                    //var aaa = "<div class=\"mui-pull-bottom-tips\"><div class=\"mui-pull-bottom-wrapper\"><span class=\"mui-pull-loading\">上拉显示更多</span></div></div>";
                    document.getElementById('status2').innerHTML = "<div class=\"orderList\">" + statusHtml2 + "</div>";
                }
                initPullToRefresh ();
                isComeNo1 = 1;
            }
            else if (e.detail.slideNumber == 2 && isComeNo2 == 0) {
                //服务中
                var statusHtml3 = getOrderList(BJW.getOrderStatus.SERVICEING, 1, 10);
                if (statusHtml3 == null) {
                    document.getElementById('status3').innerHTML = "<div class='orderList notOrderHeight'><div class='notOrder'>您还没有相关订单.</div></div>";
                }
                else {
                    document.getElementById('status3').innerHTML = "<div class=\"orderList\">" + statusHtml3 + "</div>"
                }
                initPullToRefresh ();
                isComeNo2 = 1;
            }
            else if (e.detail.slideNumber == 3 && isComeNo3 == 0) {
                //完成
                var statusHtml4 = getOrderList(BJW.getOrderStatus.FINISHED, 1, 10);
                if (statusHtml4 == null) {
                    document.getElementById('status4').innerHTML = "<div class='orderList notOrderHeight'><div class='notOrder'>您还没有相关订单.</div></div>";
                }
                else {
                    document.getElementById('status4').innerHTML = "<div class=\"orderList\">" + statusHtml4 + "</div>";
                }
                initPullToRefresh ();
                isComeNo3 = 1;
            }
        });

        //初始化下拉容器
        function initPullToRefresh () {
            $('.mui-scroll-wrapper').scroll({
                bounce: true, //是否回弹
                indicators: false, //是否显示滚动条
            });
        }

        $.ready(function() {
            //循环初始化所有下拉刷新，上拉加载。
            $.each(document.querySelectorAll('.mui-slider-group .mui-scroll'), function(index, pullRefreshEl) {
                $(pullRefreshEl).pullToRefresh({
                    down: {
                        callback: function() {
                            var self = this;
                            setTimeout(function() {
                                //下拉刷新
                                var ul = self.element.querySelector('.orderList');
                                var nodeHtml = createFragment(ul, index, 10, true);
                                console.log("--------");
                                //console.log(nodeHtml);
                                console.log("--------");
                                ul.innerHTML = createFragment(ul, index, 10, true);
                                //ul.insertBefore(createFragment(ul, index, 10, true), ul.firstChild);
                                self.endPullDownToRefresh();
                            }, 1000);
                        }
                    },
                    up: {
                        callback: function() {
                            var self = this;
                            setTimeout(function() {
                               /* var html = document.getElementById("orderList");
                                html.innerHTML = html.innerHTML + createFragment();*/

                                var ul = self.element.querySelector('.orderList');
                                ul.appendChild(createFragment(ul, index, 5));

                                self.endPullUpToRefresh();
                            }, 1000);
                        }
                    }
                });
            });
            var createFragment = function(ul, index, count, reverse) {
                /*var html = document.getElementById("testHtml").innerHTML;
                return html;*/

                console.log(ul);
                console.log("index：" + index);
                console.log("count：" + count);
                console.log("reverse：" + reverse);

                var html = "";
                if (index == 0) { //待接单
                    if (reverse) {
                        html = getOrderList(BJW.getOrderStatus.PENDING_ORDERS, 1, 10);
                        if (html == null) {
                            html = "<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class='orderList notOrderHeight'><div class=\"notOrder\">您还没有相关订单.</div></div></div></div>";
                        }
                    }
                    else {
                        html = getOrderList(BJW.getOrderStatus.PENDING_ORDERS, ++pageNo1, 10);
                        if (html == null) {
                            pageNo1--;
                            //mui.toast("没有更多数据了.");
                            var doc = document.getElementsByClassName("mui-pull-loading");
                            doc.innerHTML = "没有更多数据了.";
                        }
                    }
                }
                else if (index == 1) { //待服务
                    if (reverse) {
                        html = getOrderList(BJW.getOrderStatus.PENDING_SERVICE, 1, 10);
                        if (html == null) {
                            html = "<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class='orderList notOrderHeight'><div class=\"notOrder\">您还没有相关订单.</div></div></div></div>";
                        }
                    }
                    else {
                        html = getOrderList(BJW.getOrderStatus.PENDING_SERVICE, ++pageNo2, 10);
                        if (html == null) {
                            pageNo2--;
                            //mui.toast("没有更多数据了.");
                            var doc = document.getElementsByClassName("mui-pull-loading");
                            doc.innerHTML = "没有更多数据了.";
                        }
                    }

                }
                else if (index == 2) { //服务中
                    if (reverse) {
                        html = getOrderList(BJW.getOrderStatus.SERVICEING, 1, 10);
                        if (html == null) {
                            html = "<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class='orderList notOrderHeight'><div class=\"notOrder\">您还没有相关订单.</div></div></div></div>";
                        }
                    }
                    else {
                        html = getOrderList(BJW.getOrderStatus.SERVICEING, ++pageNo3, 10);
                        if (html == null) {
                            pageNo3--;
                            //mui.toast("没有更多数据了.");
                            var doc = document.getElementsByClassName("mui-pull-loading");
                            doc.innerHTML = "没有更多数据了.";
                        }
                    }
                }
                else if (index == 3) { //完成
                    if (reverse) {
                        html = getOrderList(BJW.getOrderStatus.FINISHED, 1, 10);
                        if (html == null) {
                            html = "<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class='orderList notOrderHeight'><div class=\"notOrder\">您还没有相关订单.</div></div></div></div>";
                        }
                    }
                    else {
                        html = getOrderList(BJW.getOrderStatus.FINISHED, ++pageNo4, 10);
                        if (html == null) {
                            pageNo4--;
                            //mui.toast("没有更多数据了.");
                            var doc = document.getElementsByClassName("mui-pull-loading");
                            doc.innerHTML = "没有更多数据了.";
                        }
                    }
                }
                if (reverse) {
                    //下拉加载数据
                    var fragment = document.createDocumentFragment();
                    var node = document.createElement("div");
                    node.innerHTML = html;
                    fragment.innerHTML = node;
                    return html;
                }
                else {
                    //上拉加载数据
                    var fragment = document.createDocumentFragment();
                    var node = document.createElement("div");
                    node.innerHTML = html;
                    fragment.appendChild(node);
                    return fragment;
                }
            };
        });
    })(mui);

    $(function (){
        var height = document.body.clientHeight;
        if (!BJW.isWeiXin()) {
            $(".mui-slider-item").css("minHeight", (height-50) + "px");
            $(".notOrderHeight").css("minHeight", (height-50) + "px");
        }
        else {
            $(".mui-slider-item").css("minHeight", (height-110) + "px");
            $(".notOrderHeight").css("minHeight", (height-110) + "px");
        }
    });

    setTimeout(function (){
        BJW.closeDialogLoading();//关闭弹窗loading
    },1000);

</script>
</body>

</html>