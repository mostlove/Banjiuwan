<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>我的订单</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/order/myOrder.css" charset="UTF-8">
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
                待支付
            </a>
            <a class="mui-control-item" href="#page2">
                已支付
            </a>
            <a class="mui-control-item" href="#page3">
                完成
            </a>
        </div>
        <div id="sliderProgressBar" class="mui-slider-progress-bar mui-col-xs-4"></div>
        <div class="mui-slider-group" id="mui-slider-group">
            <!--待支付-->
            <div id="page1" class="mui-slider-item mui-control-content mui-active">
                <!--loading-->
                <div class="mui-scroll-wrapper">
                    <div class="mui-scroll notOrderHeight">
                        <div id="scroll1">
                            <div class="order-loading notOrderHeight">
                                <img src="<%=request.getContextPath()%>/appResources/img/icon/loading.gif"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--已支付-->
            <div id="page2" class="mui-slider-item mui-control-content">
                <!--loading-->
                <div class="mui-scroll-wrapper">
                    <div class="mui-scroll notOrderHeight">
                        <div id="scroll2">
                            <div class="order-loading notOrderHeight">
                                <img src="<%=request.getContextPath()%>/appResources/img/icon/loading.gif"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--完成-->
            <div id="page3" class="mui-slider-item mui-control-content">
                <!--loading-->
                <div class="mui-scroll-wrapper">
                    <div class="mui-scroll notOrderHeight">
                        <div id="scroll3">
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


<!-- 选择支付弹窗 -->
<div id="paymentPopup" class="mui-popover mui-popover-action mui-popover-bottom">
    <ul class="mui-table-view">
        <li class="mui-table-view-cell">
            <div class="orderMoneyDiv">订单金额：<span class="orderMoney">￥<span id="payMoney">0</span></span></div>
            <div class="mui-row" id="isWei1">
                <div class="mui-col-xs-4 mui-col-sm-4 paymentMode" onclick="weiXinPayment()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/weixin.png">
                    <p class="paymentModeTiele">微信支付</p>
                </div>
                <div class="mui-col-xs-4 mui-col-sm-4 paymentMode" onclick="zhiFuBaoPayment()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/zhifubao.png">
                    <p class="paymentModeTiele">支付宝支付</p>
                </div>
                <div class="mui-col-xs-4 mui-col-sm-4 paymentMode" onclick="xianXiaPayment()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/xianxia.png">
                    <p class="paymentModeTiele">线下支付</p>
                </div>
            </div>
            <div class="mui-row" id="isWei2">
                <div class="mui-col-xs-6 mui-col-sm-6 paymentMode" onclick="weiXinPayment()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/weixin.png">
                    <p class="paymentModeTiele">微信支付</p>
                </div>
                <div class="mui-col-xs-6 mui-col-sm-6 paymentMode" onclick="xianXiaPayment()">
                    <img src="<%=request.getContextPath()%>/appResources/img/icon/xianxia.png">
                    <p class="paymentModeTiele">线下支付</p>
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
<script src="<%=request.getContextPath()%>/appResources/js/common/mui.pullToRefresh.js" type="text/javascript" charset="UTF-8"></script>
<script src="<%=request.getContextPath()%>/appResources/js/common/mui.pullToRefresh.material.js" type="text/javascript" charset="UTF-8"></script>


<script type="text/javascript">

    $("body").append(BJW.dialogLoading("加载中···"));//弹窗loading
    //获取登录用户token
    var userToken = BJW.getLocalStorageToken();
    console.log("token:" + userToken);
    var isWei = BJW.isWeiXin();
    if (isWei) {
        $("#isWei1").hide();
        $("#isWei2").show();
    }
    else {
        $("#isWei2").hide();
        $("#isWei1").show();
    }

    //初始化订单列表
    //未支付
    var scrollHtml1 = getOrderList(BJW.getOrderStatus.NOT_PAYMENT, 1, 10);
    if (scrollHtml1 == null) {
        $("#scroll1").html("<div class='orderList notOrderHeight'><div class='notOrder'>您还没有相关订单.</div></div>");
    }
    else {
        $("#scroll1").html("<div class=\"orderList\">" + scrollHtml1 + "</div>");
    }
    /*//已支付
    var scrollHtml2 = getOrderList(BJW.getOrderStatus.ALREADY_PAYMENT, 1, 10);
    if (scrollHtml2 == null) {
        $("#scroll2").html("<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class='orderList notOrderHeight'><div class='notOrder'>您还没有相关订单.</div></div></div></div>");
    }
    else {
        $("#scroll2").html("<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class=\"orderList\">" + scrollHtml2 + "</div></div></div>");
    }
    //已完成
    var scrollHtml3 = getOrderList(BJW.getOrderStatus.COMPLETE, 1, 10);
    if (scrollHtml3 == null) {
        $("#scroll3").html("<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class='orderList notOrderHeight'><div class='notOrder'>您还没有相关订单.</div></div></div></div>");
    }
    else {
        $("#scroll3").html("<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class=\"orderList\">" + scrollHtml3 + "</div></div></div>");
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
        BJW.ajaxRequestData("get", false, BJW.ip+'/app/order/getOrders', arr, userToken , function(result){
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
                var object = JSON.stringify(jsonData[i]);
                //判断订单状态
                var orderStatus = ""; //存放订单状态文字
                var orderOperationHtml = ""; //订单操作按钮
                if (jsonData[i].status == 2001) {
                    orderStatus = "<span class='status1'>待支付</span>";
                    orderOperationHtml = "<div class=\"button-bar\">" +
                                            "<button onclick=\"cancelOrder(this," + jsonData[i].id + ")\" class=\"mui-btn cancel-btn\">取消订单</button>" +
                                            "<a href=\"javascript:goPayment("+ jsonData[i].id +", " + jsonData[i].otherPay + ")\" class=\"mui-btn payment-btn\">去支付</a>" +
                                        "</div>";
                }
                else if (jsonData[i].status == 2002) {
                    orderStatus = "<span class='status1'>待确认</span>";
                    orderOperationHtml = "<div class=\"button-bar\">" +
                                            "<button onclick=\"cancelOrder(this," + jsonData[i].id + ")\" class=\"mui-btn cancel-btn\">取消订单</button>" +
                                        "</div>";
                }
                else if (jsonData[i].status == 2003) {
                    orderStatus = "<span class='status1'>待服务</span>";
                    orderOperationHtml = "<div class=\"button-bar\">" +
                            "<button onclick=\"cancelOrder(this," + jsonData[i].id + ")\" class=\"mui-btn cancel-btn\">取消订单</button>" +
                            "</div>";
                }
                else if (jsonData[i].status == 2004) {
                    orderStatus = "<span class='status1'>服务中··</span>";
                }
                else if (jsonData[i].status == 2005) {
                    orderStatus = "<span class='status1'>完成</span>";
                    orderOperationHtml = "<div class=\"button-bar\">" +
                            "<a href='javascript:goEvaluate(" + object + ")' class='mui-btn cancel-btn'>去评价</a>" +
                            "</div>";
                }
                else if (jsonData[i].status == 2006) {
                    orderStatus = "<span class='status1'>待评价</span>";
                    orderOperationHtml = "<div class=\"button-bar\">" +
                            "<a href='javascript:goEvaluate(" + object + ")' class='mui-btn cancel-btn'>去评价</a>" +
                            "</div>";
                }
                else if (jsonData[i].status == 2007) {
                    orderStatus = "<span class='status1'>已评价</span>";
                }
                else if (jsonData[i].status == 2008) {
                    orderStatus = "<span class='status1'>待服务</span>";
                    orderOperationHtml = "<div class=\"button-bar\">" +
                            "<button onclick=\"cancelOrder(this," + jsonData[i].id + ")\" class=\"mui-btn cancel-btn\">取消订单</button>" +
                            "</div>";
                }
                else if (jsonData[i].status == 2009) {
                    orderStatus = "<span class='status1'>已取消</span>";
                    orderOperationHtml = "<div class=\"button-bar\">" +
                                            "<button onclick=\"deleteOrder(this," + jsonData[i].id + ")\" class=\"mui-btn payment-btn\">删除订单</button>" +
                                        "</div>";
                }
                //解析商品json
                var goodsArray = JSON.parse(JSON.parse(jsonData[i].orderDetail));
                var html2 = "";
                var html3 = ""; //存放专业服务数据
                for (var j = 0; j < goodsArray.length; j++) {
                    if (goodsArray[j].foodCategoryId == 11 && goodsArray[j].foodId < 4) {
                        html3 += "<li class=\"mui-table-view-cell mui-media\">" +
                                        "<a href=\"javascript:orderDetail(" + jsonData[i].id + ")\">" +
                                            "<span class=\"mui-media-object mui-pull-left service-money\">" + goodsArray[j].name + "</span>" +
                                            "<div class=\"mui-media-body\">" +
                                                "<span class=\"goods-price\">￥" + goodsArray[j].price + "</span>" +
                                                "<span class=\"goods-num\">x" + goodsArray[j].number + "</span>" +
                                            "</div>" +
                                        "</a>" +
                                    "</li>"
                    }
                    else {
                        html2 += "<li class=\"mui-table-view-cell mui-media\">" +
                                    "<a href=\"javascript:orderDetail(" + jsonData[i].id + ")\">" +
                                        "<img class=\"mui-media-object mui-pull-left goods-img\" src=\"" + BJW.ip + "/" +goodsArray[j].imgUrl + "\">" +
                                        "<div class=\"mui-media-body\">" +
                                            "<span class=\"goods-name\">" + goodsArray[j].name + "</span>" +
                                            "<p class=\"goods-p\">" +
                                                "<span class=\"goods-price\">￥" + goodsArray[j].price + "</span>" +
                                                "<span class=\"goods-num\">x" + goodsArray[j].number + "</span>" +
                                            "</p>" +
                                        "</div>" +
                                    "</a>" +
                                "</li>"
                    }

                }
                if (i == 0) {
                    html += "<div class=\"order-bar\" style=\"margin-top: 0;\">" +
                                "<div class=\"order-num\">" +
                                    "订单号：<a href=\"javascript:void(0)\"><span>" + jsonData[i].orderNumber + "</span></a>" +
                                    "<span class=\"order-status status-1\">" + orderStatus + "</span>" +
                                "</div>" +
                                "<ul class=\"mui-table-view\">" +
                                    html2 + html3 + //商品列表
                                    "<li class=\"mui-table-view-cell mui-media\">" +
                                        "<a href=\"javascript:;\">" +
                                            "<span class=\"mui-media-object mui-pull-left service-money\">服务</span>" +
                                            "<div class=\"mui-media-body\">" +
                                                "<span class=\"goods-price\">￥" + jsonData[i].serviceCost + "</span>" +
                                                /*"<span class=\"goods-num\">x1</span>" +*/
                                            "</div>" +
                                        "</a>" +
                                    "</li>" +
                                "</ul>" +
                                "<div class=\"use-time-bar\">用餐时间：" +
                                    "<span class=\"use-time\">" + new Date(jsonData[i].serviceDate).format("yyyy-MM-dd hh:mm:ss") + "</span>" +
                                "</div>" +
                                "<div class=\"total-bar\">共" + goodsArray.length + "件商品，合计：" +
                                    "<span class=\"total-price\">￥" + jsonData[i].otherPay + "</span>" +
                                "</div>" +
                                orderOperationHtml +
                            "</div>";
                }
                else {
                    html += "<div class=\"order-bar\">" +
                            "<div class=\"order-num\">" +
                                "订单号：<a href=\"javascript:void(0)\"><span>" + jsonData[i].orderNumber + "</span></a>" +
                                "<span class=\"order-status status-1\">" + orderStatus + "</span>" +
                            "</div>" +
                            "<ul class=\"mui-table-view\">" +
                                html2 + //商品列表
                                "<li class=\"mui-table-view-cell mui-media\">" +
                                    "<a href=\"javascript:;\">" +
                                        "<span class=\"mui-media-object mui-pull-left service-money\">服务</span>" +
                                        "<div class=\"mui-media-body\">" +
                                            "<span class=\"goods-price\">￥" + jsonData[i].serviceCost + "</span>" +
                                            /*"<span class=\"goods-num\">x1</span>" +*/
                                        "</div>" +
                                    "</a>" +
                                "</li>" +
                            "</ul>" +
                            "<div class=\"use-time-bar\">用餐时间：" +
                                "<span class=\"use-time\">" + new Date(jsonData[i].serviceDate).format("yyyy-MM-dd hh:mm:ss") + "</span>" +
                            "</div>" +
                            "<div class=\"total-bar\">共" + goodsArray.length + "件商品，合计：" +
                                "<span class=\"total-price\">￥" + jsonData[i].otherPay + "</span>" +
                            "</div>" +
                            orderOperationHtml +
                        "</div>";
                }
            }
        }
        else {
            return null;
        }

        return html;
    }

    //订单详情
    function orderDetail(orderId){
        console.log(orderId);
        localStorage.setItem("orderId", orderId);
        if (orderId != null) {
            location.href = BJW.ip + "/app/page/orderDetail";
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


    //取消订单
    function cancelOrder(obj, orderId){
        if (orderId != null) {
            var btnArray = ['不，手滑', '取消订单'];
            mui.confirm('您确认要取消该订单？', '&nbsp;', btnArray, function(e) {
                if (e.index == 0) {

                } else {
                    BJW.cookAjaxRequestData("post", false, BJW.ip+'/app/order/cancelOrder', {orderId : orderId}, userToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            //location.reload();
                            $(obj).parent().parent().fadeOut();
                        }
                    });
                }
            });
        }
    }

    //删除订单
    function deleteOrder(obj, orderId) {
        mui.confirm('是否确认删除订单？', '', ["确认","取消"], function(e) {
            if (e.index == 0) {
                BJW.ajaxRequestData("post", false, BJW.ip+'/app/order/delOrder', {orderId : orderId}, userToken , function(result){
                    if(result.flag == 0 && result.code == 200){
                        $(obj).parent().parent().fadeOut();
                        //window.location.reload();
                    }
                });
            }
        });
    }

    var orderId = 0;//存放订单ID
    //去支付
    function goPayment(oId, payMoney){
        orderId = oId;
        $("#payMoney").html(payMoney.toFixed(2));
        //弹出菜单的显示、隐藏
        mui('#paymentPopup').popover('toggle');
    }
    //微信支付
    function weiXinPayment() {
        mui('#paymentPopup').popover('toggle');
        //mui.alert("orderId : " + orderId + "<br>" + userToken);
        if (BJW.isWeiXin()) {
            setTimeout(function () {
                //微信端--微信支付
                BJW.ajaxRequestData("post", false, BJW.ip+'/app/jsAPI/signByOrder', {orderId : orderId}, userToken , function(result){
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
            window.JSBridge.goPayment(orderId, userToken, 0);
        }
    }
    //支付宝支付
    function zhiFuBaoPayment() {
        mui('#paymentPopup').popover('toggle');
        //mui.alert("orderId : " + orderId + "<br>" + userToken);
        window.JSBridge.goPayment(orderId, userToken, 1);
    }
    //线下支付
    function xianXiaPayment () {
        mui('#paymentPopup').popover('toggle');
        mui.confirm('是否确认线下支付？', '', ["确认","取消"], function(e) {
            if (e.index == 0) {
                BJW.ajaxRequestData("post", false, BJW.ip+'/app/order/orderOffLinePay', {orderId : orderId}, userToken , function(result){
                    if(result.flag == 0 && result.code == 200){
                        window.location.href = BJW.ip + "/app/page/myOrder?isOpen=1";
                    }
                });
            }
        });
    }

    //去评价
    function goEvaluate (object) {
        console.log(JSON.stringify(object));
        localStorage.setItem("orderDetail", JSON.stringify(object));
        location.href = BJW.ip + "/app/page/orderEvaluate?isOpen=1";
    }

    var pageNo1 = 1;
    var pageNo2 = 1;
    var pageNo3 = 1;

    var isComeNo1 = 0;
    var isComeNo2 = 0;

    (function($) {
        //阻尼系数
        var deceleration = mui.os.ios?0.003:0.0009;
        $('.mui-scroll-wrapper').scroll({
            bounce: false,
            indicators: true, //是否显示滚动条
            deceleration:deceleration
        });

        //左右却换加载
        document.getElementById('slider').addEventListener('slide', function(e) {
            console.log(e.detail.slideNumber);
            if (e.detail.slideNumber == 0) {

            }
            else if (e.detail.slideNumber == 1 && isComeNo1 == 0) {
                //已支付
                var scrollHtml2 = getOrderList(BJW.getOrderStatus.ALREADY_PAYMENT, 1, 10);
                if (scrollHtml2 == null) {
                    document.getElementById('scroll2').innerHTML = "<div class='orderList notOrderHeight'><div class='notOrder'>您还没有相关订单.</div></div>";
                }
                else {
                    document.getElementById('scroll2').innerHTML = "<div class=\"orderList\">" + scrollHtml2 + "</div>";
                }
                initPullToRefresh ();
                isComeNo1 = 1;
            }
            else if (e.detail.slideNumber == 2 && isComeNo2 == 0) {
                //已完成
                var scrollHtml3 = getOrderList(BJW.getOrderStatus.COMPLETE, 1, 10);
                if (scrollHtml3 == null) {
                    document.getElementById('scroll3').innerHTML = "<div class='orderList notOrderHeight'><div class='notOrder'>您还没有相关订单.</div></div>";
                }
                else {
                    document.getElementById('scroll3').innerHTML = "<div class=\"orderList\">" + scrollHtml3 + "</div>";
                }
                initPullToRefresh ();
                isComeNo2 = 1;
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
                            //下拉刷新
                            setTimeout(function() {
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
                                var ul = self.element.querySelector('.orderList');
                                ul.appendChild(createFragment(ul, index, 10));
                                self.endPullUpToRefresh();
                            }, 1000);
                        }
                    }
                });
            });
            var createFragment = function(ul, index, count, reverse) {

                console.log(ul);
                console.log("index：" + index);
                console.log("count：" + count);
                console.log("reverse：" + reverse);

                var html = "";
                if (index == 0) { //未支付
                    if (reverse) {
                        html = getOrderList(BJW.getOrderStatus.NOT_PAYMENT, 1, 10);
                        if (html == null) {
                            html = "<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class='orderList notOrderHeight'><div class=\"notOrder\">您还没有相关订单.</div></div></div></div>";
                        }
                    }
                    else {
                        html = getOrderList(BJW.getOrderStatus.NOT_PAYMENT, ++pageNo1, 10);
                        if (html == null) {
                            pageNo1--;
                            //mui.toast("没有更多数据了.");
                            var doc = document.getElementsByClassName("mui-pull-loading");
                            doc.innerHTML = "没有更多数据了.";
                        }
                    }
                }
                else if (index == 1) { //已支付
                    if (reverse) {
                        html = getOrderList(BJW.getOrderStatus.ALREADY_PAYMENT, 1, 10);
                        if (html == null) {
                            html = "<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class='orderList notOrderHeight'><div class=\"notOrder\">您还没有相关订单.</div></div></div></div>";
                        }
                    }
                    else {
                        html = getOrderList(BJW.getOrderStatus.ALREADY_PAYMENT, ++pageNo2, 10);
                        if (html == null) {
                            pageNo2--;
                            //mui.toast("没有更多数据了.");
                            var doc = document.getElementsByClassName("mui-pull-loading");
                            doc.innerHTML = "没有更多数据了.";
                        }
                    }
                }
                else if(index == 2) { //完成
                    if (reverse) {
                        html = getOrderList(BJW.getOrderStatus.COMPLETE, 1, 10);
                        if (html == null) {
                            html = "<div class=\"mui-scroll-wrapper\"><div class=\"mui-scroll\"><div class='orderList notOrderHeight'><div class=\"notOrder\">您还没有相关订单.</div></div></div></div>";
                        }
                    }
                    else {
                        html = getOrderList(BJW.getOrderStatus.COMPLETE, ++pageNo3, 10);
                        if (html == null) {
                            pageNo3--;
                            //mui.toast("没有更多数据了.");
                            var doc = document.getElementsByClassName("mui-pull-loading");
                            doc.innerHTML = "没有更多数据了.";
                        }
                    }
                }
                //console.log(html);
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
        $(".mui-slider-item").css("minHeight", (height-50) + "px");
        $(".notOrderHeight").css("minHeight", (height-50) + "px");
    });


    setTimeout(function (){
        BJW.closeDialogLoading();//关闭弹窗loading
    },1000);

</script>
</body>

</html>