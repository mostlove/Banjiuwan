<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>详情</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/detail.css" charset="UTF-8">
    <style>
        table tr td{
            display: table-cell;
            vertical-align: -webkit-baseline-middle;
        }

        /*图片预览css*/
        .mui-preview-image.mui-fullscreen {
            position: fixed;
            z-index: 1001;
            background-color: #000;
        }
        .mui-preview-header,
        .mui-preview-footer {
            position: absolute;
            width: 100%;
            left: 0;
            z-index: 10;
        }
        .mui-preview-header {
            height: 44px;
            top: 0;
        }
        .mui-preview-footer {
            height: 50px;
            bottom: 0px;
        }
        .mui-preview-header .mui-preview-indicator {
            display: block;
            line-height: 25px;
            color: #fff;
            text-align: center;
            margin: 15px auto 4px !important;
            background-color: rgba(0, 0, 0, 0.4);
            border-radius: 12px;
            font-size: 16px;
        }
        .mui-preview-image {
            display: none;
            -webkit-animation-duration: 0.5s;
            animation-duration: 0.5s;
            -webkit-animation-fill-mode: both;
            animation-fill-mode: both;
        }
        .mui-preview-image.mui-preview-in {
            -webkit-animation-name: fadeIn;
            animation-name: fadeIn;
        }
        .mui-preview-image.mui-preview-out {
            background: none;
            -webkit-animation-name: fadeOut;
            animation-name: fadeOut;
        }
        .mui-preview-image.mui-preview-out .mui-preview-header,
        .mui-preview-image.mui-preview-out .mui-preview-footer {
            display: none;
        }
        .mui-zoom-scroller {
            position: absolute;
            display: -webkit-box;
            display: -webkit-flex;
            display: flex;
            -webkit-box-align: center;
            -webkit-align-items: center;
            align-items: center;
            -webkit-box-pack: center;
            -webkit-justify-content: center;
            justify-content: center;
            left: 0;
            right: 0;
            bottom: 0;
            top: 0;
            width: 100%;
            height: 100%;
            margin: 0;
            -webkit-backface-visibility: hidden;
        }
        .mui-zoom {
            -webkit-transform-style: preserve-3d;
            transform-style: preserve-3d;
        }
        .mui-slider .mui-slider-group .mui-slider-item img {
            width: auto;
            height: auto;
            max-width: 100%;
            max-height: 100%;
        }
        .mui-android-4-1 .mui-slider .mui-slider-group .mui-slider-item img {
            width: 100%;
        }
        .mui-android-4-1 .mui-slider.mui-preview-image .mui-slider-group .mui-slider-item {
            display: inline-table;
        }
        .mui-android-4-1 .mui-slider.mui-preview-image .mui-zoom-scroller img {
            display: table-cell;
            vertical-align: middle;
        }
        .mui-preview-loading {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            display: none;
        }
        .mui-preview-loading.mui-active {
            display: block;
        }
        .mui-preview-loading .mui-spinner-white {
            position: absolute;
            top: 50%;
            left: 50%;
            margin-left: -25px;
            margin-top: -25px;
            height: 50px;
            width: 50px;
        }
        .mui-preview-image img.mui-transitioning {
            -webkit-transition: -webkit-transform 0.5s ease, opacity 0.5s ease;
            transition: transform 0.5s ease, opacity 0.5s ease;
        }
        @-webkit-keyframes fadeIn {
            0% {
                opacity: 0;
            }
            100% {
                opacity: 1;
            }
        }
        @keyframes fadeIn {
            0% {
                opacity: 0;
            }
            100% {
                opacity: 1;
            }
        }
        @-webkit-keyframes fadeOut {
            0% {
                opacity: 1;
            }
            100% {
                opacity: 0;
            }
        }
        @keyframes fadeOut {
            0% {
                opacity: 1;
            }
            100% {
                opacity: 0;
            }
        }
        p img {
            max-width: 100%;
            height: auto;
        }
        .swiper-slide{
            width: 100% !important;
        }
    </style>

</head>

<body>

    <header class="detail-header">
        <%--<img class="return-icon" src="<%=request.getContextPath()%>/appResources/img/icon/return-incon.png">--%>
        <a onclick="jumpCar()"><img class="car-icon" src="<%=request.getContextPath()%>/appResources/img/icon/car-icon.png"></a>
    </header>

    <div id="pullrefresh" class="mui-content">
        <div class="mui-scroll">
            <!-- Swiper -->
            <div class="swiper-container">
                <div class="swiper-wrapper" id="swiperSlide">

                </div>
                <!-- Add Pagination -->
                <div class="swiper-pagination"></div>
            </div>

            <div class="commodity-detail">
                <p class="commodity-row">
                    <span class="commodity-name" id="foodName"></span>
                </p>
                <p class="commodity-row margin-bottom-10">
                    <span class="commodity-sales">总销<span id="sales">0</span><span id="danWei">份</span></span>
                    <span class="commodity-index-mark">推荐指数:
                        <span id="recommendationIndexHtml"></span>
                    </span>
                </p>
                <p class="commodity-row">
                    <span class="commodity-price">
                        <span id="priceHtml"></span>
                        <span id="danWei2">/份</span>
                    </span>
                    <div class="addBtnBox">
                        <button class="addOrReduceBtn" onclick="reduceCar(this)">-</button>
                        <input class="boxInput" type="number" value="0" readonly id="boxInput">
                        <button class="addOrReduceBtn" onclick="addCart(event, this)">+</button>
                    </div>
                    <!--存放ID-->
                    <input id="price" type="hidden">
                    <input id="foodId" type="hidden">
                    <input id="foodCategoryId" type="hidden">
                </p>
            </div>
            <div class="commodity-introduce">
                <table>
                    <tr>
                        <td width="40px">主料：</td>
                        <td id="marinade"></td>
                    </tr>
                    <tr>
                        <td width="40px">辅料：</td>
                        <td id="accessories"></td>
                    </tr>
                    <tr>
                        <td width="40px">简介：</td>
                        <td id="introduction"></td>
                    </tr>
                </table>
            </div>

            <!--评价栏-->
            <div class="evaluate">
                <div class="evaluate-title">
                    消费评价
                </div>
                <div class="deuce-bar">
                    <div class="comprehensive-deuce">
                        <p class="deuce-max-num" id="deuce-max-num">0</p>
                        <p class="comprehensive-deuce-name">综合评分</p>
                        <p class="person-deuce">共<span id="person-deuce">0</span>人评价</p>
                    </div>
                    <div class="item-deuce">
                        <p class="deuce-classify">
                            <span class="deuce-name">菜品:</span>
                            <span id="foodScoreHtml"></span>
                            <span class="fraction" id="foodScore">0</span>
                        </p>
                        <p class="deuce-classify">
                            <span class="deuce-name">厨师:</span>
                            <span id="cookScoreHtml"></span>
                            <span class="fraction" id="cookScore">0</span>
                        </p>
                        <p class="deuce-classify">
                            <span class="deuce-name">服务:</span>
                            <span id="serviceScoreHtml"></span>
                            <span class="fraction" id="serviceScore">0</span>
                        </p>
                    </div>
                </div>

                <div class="user-deuce-list">
                    <ul class="mui-table-view" id="evaluateList">

                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

    <!--引入购物车弹窗-->
    <%@include file="../common/car-popupAngular.jsp" %>

    <script type="text/javascript">

        $("body").append(BJW.dialogLoading("加载中···"));//弹窗loading

        //获取登录用户token
        var userToken = BJW.getLocalStorageToken();
        console.log("token:" + userToken);
        var foodId = localStorage.getItem("cookbookId");
        var foodCategoryId = localStorage.getItem("foodCategoryId");
        console.log("foodId：" + foodId);
        console.log("foodCategoryId：" + foodCategoryId);

        initData();
        //获取数据
        function initData() {
            var arr = {
                foodCategoryId : foodCategoryId,
                foodId : foodId
            }
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/food/queryFoodById', arr, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    console.log(result.data);
                    //获取轮播
                    var banners = result.data.banners.split(",");
                    var bannersHtml = "";
                    for (var i = 0; i < banners.length; i++) {
                        bannersHtml += "<div class=\"swiper-slide\"><img src=\"" + BJW.ip + "/" + banners[i] + "\" data-preview-src=\"\" data-preview-group=\"0\"></div>";
                    }
                    $("#swiperSlide").html(bannersHtml);

                    $("#foodName").html(result.data.foodName);//菜名
                    $("#foodContext").html(result.data.introduction);//菜介绍
                    $("#sales").html(result.data.sales);//销量
                    $("#danWei").html(result.data.units);//销量--单位
                    //推荐指数
                    var recommendationIndexHtml = "";
                    for (var i = 0; i < result.data.recommendationIndex; i++) {
                        recommendationIndexHtml += "<i class=\"mui-icon mui-icon-star-filled\"></i>";
                    }
                    $("#recommendationIndexHtml").html(recommendationIndexHtml);
                    $("#priceHtml").html("￥" + result.data.promotionPrice); //菜价
                    $("#danWei2").html("/" + result.data.units);
                    $("#fiveRise").html(result.data.leastNumber);
                    $("#boxInput").val(result.data.countNumber == null ? 0 : result.data.countNumber);
                    $("#boxInput").attr("inputFood", "inputFood_" + result.data.id);
                    $("#marinade").html(result.data.marinade); //主料
                    $("#accessories").html(result.data.accessories); //辅料
                    $("#introduction").html(result.data.introduction); //简介

                    $("#price").val(result.data.promotionPrice);
                    $("#foodId").val(result.data.id);
                    $("#foodCategoryId").val(result.data.foodCategoryId);

                }
            });

            //获取平均评分
            var arr2 = {
                type : 2,
                objectId : foodId
            }
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/evaluate/getAvgScore', arr2, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    var avg = (result.data.foodScore + result.data.cookScore + result.data.serviceScore) / 3;
                    $("#deuce-max-num").html(avg.toFixed(1));
                    $("#foodScore").html(result.data.foodScore.toFixed(1));
                    $("#cookScore").html(result.data.cookScore.toFixed(1));
                    $("#serviceScore").html(result.data.serviceScore.toFixed(1));
                    //菜品
                    var foodScoreHtml = "";
                    for (var i = 0; i < parseInt(result.data.foodScore); i++) {
                        foodScoreHtml += BJW.isMan;
                    }
                    for (var i = 0; i < (5 - parseInt(result.data.foodScore)); i++) {
                        foodScoreHtml += BJW.isFei;
                    }
                    $("#foodScoreHtml").html(foodScoreHtml);
                    //厨师
                    var cookScoreHtml = "";
                    for (var i = 0; i < parseInt(result.data.cookScore); i++) {
                        cookScoreHtml += BJW.isMan;
                    }
                    for (var i = 0; i < (5 - parseInt(result.data.cookScore)); i++) {
                        cookScoreHtml += BJW.isFei;
                    }
                    $("#cookScoreHtml").html(cookScoreHtml);
                    //服务
                    var serviceScoreHtml = "";
                    for (var i = 0; i < parseInt(result.data.serviceScore); i++) {
                        serviceScoreHtml += BJW.isMan;
                    }
                    for (var i = 0; i < (5 - parseInt(result.data.serviceScore)); i++) {
                        serviceScoreHtml += BJW.isFei;
                    }
                    $("#serviceScoreHtml").html(serviceScoreHtml);

                }
            });

        }

        //获取评价列表
        /**
         * 评论列表
         * @param type 评论类型
         * @param objectId 被评论的id
         * @param pageNO 页码
         * @param pageSize 条数
         * @return
         */
        function getEvaluateList(type, objectId, pageNO, pageSize){
            console.debug("传入的页码：" + pageNO);
            var arr = {
                type : type,
                objectId : objectId,
                pageNO : pageNO,
                pageSize : pageSize
            }
            var html = "";
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/evaluate/list', arr, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    $("#person-deuce").html(result.data.count);
                    html = bindData(result.data.dataList);
                }
            });
            return html;
        }
        var imgNo = 0;
        //绑定数据
        function bindData(jsonData) {
            var html = "";
            for (var i = 0; i < jsonData.length; i++) {
                imgNo ++;
                var imgs = jsonData[i].imgs.split(",");
                var imgHtml = "";
                for (var j = 0; j < imgs.length; j++) {
                    if (imgs[j] != "") {
                        imgHtml += "<img src=\"" + BJW.ip + "/" + imgs[j] + "\" data-preview-src=\"\" data-preview-group=\"" + imgNo + "\">";
                    }
                }
                var phone = "****";
                if (jsonData[i].phoneNumber != null) {
                    phone = jsonData[i].phoneNumber.substring(0, 3);
                    phone += "****" + jsonData[i].phoneNumber.substring(7, 11);
                }
                var sum = jsonData[i].foodScore;
                var scoreHtml = "";
                for (var j = 0; j < sum; j++) {
                    scoreHtml += BJW.isMan;
                }
                for (var j = 0; j < (5 - sum); j++) {
                    scoreHtml += BJW.isFei;
                }
                var avatarUrl = "";
                if (jsonData[i].avatar == null) {
                    avatarUrl = "/appResources/img/icon/default-head.png";
                }
                else {
                    avatarUrl = jsonData[i].avatar;
                }
                html += "<li class=\"mui-table-view-cell mui-media\">" +
                        "<img class=\"mui-media-object mui-pull-left user-head\" src=\"" + BJW.ip + "/" + avatarUrl + "\">" +
                        "<div class=\"mui-media-body\">" +
                        "<span>" + phone + "</span>" +
                        "<img class=\"vip-img\" src=\""+ BJW.ip +"/appResources/img/icon/VIP.png\">" +
                        "<span class=\"user-deuce-time\">" + new Date(jsonData[i].createTime).format("yyyy-MM-dd") + "</span>" +
                        "<div class=\"user-deuce\">" +
                        scoreHtml +
                        "</div>" +
                        "<div class=\"user-deuce-context\">" + jsonData[i].content + "</div>" +
                        "<div class=\"user-deuce-img\">" +
                        imgHtml  +
                        "</div>" +
                        "</div>" +
                        "</li>";
            }
            return html;
        }


        mui.init({
            pullRefresh: {
                container: '#pullrefresh',
                down : {
                    auto: false,
                    contentdown : "",
                    contentover : "",
                    contentrefresh : "",
                    callback : pullLoad
                },
                up: {
                    contentrefresh: '正在使劲加载...',
                    callback: pullupRefresh,
                    auto:false,
                }
            }
        });
        function pullLoad() {
            $(".mui-pull").hide();
            mui('#pullrefresh').pullRefresh().endPulldownToRefresh(); //refresh completed
            BJW.closeDialogLoading();//关闭弹窗loading
        }

        var pageNo1 = 0;
        /**
         * 上拉加载具体业务实现
         */
        function pullupRefresh() {
            $(".mui-pull").show();
            var html = getEvaluateList(2, foodId, ++pageNo1, 10);
            setTimeout(function() {
                if (html == "") {
                    mui('#pullrefresh').pullRefresh().endPullupToRefresh((true)); //参数为true代表没有更多数据了。
                    $(".mui-pull-caption-nomore").html("暂无评价了.");
                    pageNo1-- ;
                }
                else {
                    mui('#pullrefresh').pullRefresh().endPullupToRefresh((false));
                    $("#evaluateList").append(html);
                }
                /*if (pageNo1 == 0 && html == "") {
                    mui('#pullrefresh').scroll().scrollTo(0,0);
                    BJW.closeDialogLoading();//关闭弹窗loading
                    if (!BJW.isWeiXin()) {
                        BJW.closeMoveLoading();
                    }
                }
                else if (pageNo1 == 1 && html != "") {
                    mui('#pullrefresh').scroll().scrollTo(0,0);
                    BJW.closeDialogLoading();//关闭弹窗loading
                    if (!BJW.isWeiXin()) {
                        BJW.closeMoveLoading();
                    }
                }*/
            }, 1500);
        }
        if (mui.os.plus) {
            mui.plusReady(function() {
                setTimeout(function() {
                    mui('#pullrefresh').pullRefresh().pulldownLoading();
                }, 1000);

            });
        } else {
            mui.ready(function() {
                mui('#pullrefresh').pullRefresh().pulldownLoading();
            });
        }


        //购物车加
        function addCart(event, obj) {
            addOrReduceShopCar(event, obj, 1, $("#foodId").val(), $("#foodCategoryId").val(), null, null, null, $("#price").val(), BJW.ip + "/app/page/cookbookDetail?isOpen=4");
        }

        //购物车减
        function reduceCar(obj){
            addOrReduceShopCar(null, obj, 0, $("#foodId").val(), $("#foodCategoryId").val(), null, null, null, $("#price").val(), BJW.ip + "/app/page/cookbookDetail?isOpen=4");
        }

        //跳转购物车
        function jumpCar(){
            location.href = BJW.ip + "/app/page/car";
        }


        (function($) {
            //阻尼系数
            var deceleration = mui.os.ios?0.003:0.0009;
            $('.mui-scroll-wrapper').scroll({
                bounce: false,
                indicators: false, //是否显示滚动条
                deceleration:deceleration
            });
        })(mui);

        var swiper = new Swiper('.swiper-container', {
            pagination: '.swiper-pagination',
            paginationClickable: true,
            centeredSlides: true,
            autoplay: 3000,
            autoplayDisableOnInteraction: false
        });

        /*// 监听tap事件，解决 a标签 不能跳转页面问题
        mui('body').on('tap','a',function(){document.location.href=this.href;});*/
        //开启图片预览
        mui.previewImage();

        //设置飞入购物车特效
        $(function (){
            var height = $(window).height();
            $(".mui-content").css("overflowX", "hidden");
            $(".mui-content").css("height", height + "px");
        });
    </script>
</body>

</html>