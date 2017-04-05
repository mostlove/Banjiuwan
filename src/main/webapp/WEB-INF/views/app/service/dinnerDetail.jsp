<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>伴餐演奏详情</title>
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
    </style>

</head>

<body>

    <header class="detail-header">
        <%--<img class="return-icon" src="<%=request.getContextPath()%>/appResources/img/icon/return-incon.png">--%>
        <a onclick="jumpCar()"><img class="car-icon" src="<%=request.getContextPath()%>/appResources/img/icon/car-icon.png"></a>
    </header>

    <div class="mui-content">
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
            <p class="commodity-row commodity-context" id="remarks">

            </p>
            <p class="commodity-row margin-bottom-10">
                <span class="commodity-sales">总销<span id="sales">0</span><span id="danWei">份</span></span>
                <span class="commodity-index-mark">推荐指数:
                    <span id="recommendationIndexHtml"></span>
                </span>
            </p>
            <p class="commodity-row">
                <span class="commodity-price">
                    <span class="price" id="priceHtml">￥0.00</span>
                    <span id="danWei2">份</span>
                </span>
                <div class="addBtnBox">
                    <button class="addOrReduceBtn" onclick="reduceCar(this)">-</button>
                    <input class="boxInput" id="boxInput" type="number" value="0" readonly>
                    <button class="addOrReduceBtn" onclick="addCart(event, this)">+</button>
                </div>
            </p>
        </div>

        <!--擅长节目-->
        <div class="evaluate">
            <div class="evaluate-title">
                擅长节目
            </div>
            <div class="commodity-introduce" id="programmes">

            </div>
        </div>

        <input id="price" type="hidden">
        <input id="foodId" type="hidden">
        <input id="foodCategoryId" type="hidden">

    </div>


    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

    <!--引入购物车弹窗-->
    <%@include file="../common/car-popupAngular.jsp" %>

    <script type="text/javascript">

        $("body").append(BJW.dialogLoading("正在加载"));//弹窗loading

        //获取登录用户token
        var userToken = BJW.getLocalStorageToken();
        console.log("token:" + userToken);
        var foodId = BJW.getUrlParam("foodId");
        console.log("传入商品ID：" + foodId);
        if (foodId == null) {
            foodId = localStorage.getItem("foodBamId");
        }
        initData();
        //获取数据
        function initData() {
            var arr = {
                foodCategoryId : BJW.foodCategoryId.dinner,
                foodId : foodId
            }
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/food/queryFoodById', arr, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    console.log(result.data);
                    //获取轮播
                    var banners = result.data.banners.split(",");
                    var bannersHtml = "";
                    for (var i = 0; i < banners.length; i++) {
                        bannersHtml += "<div class=\"swiper-slide\"><img src=\"" + BJW.ip + "/" + banners[i] + "\" data-preview-src=\"\" data-preview-group=\"1\"></div>";
                    }
                    $("#swiperSlide").html(bannersHtml);

                    $("#foodName").html(result.data.name);//菜名
                    $("#programmes").html(result.data.programmes);//擅长节目
                    $("#sales").html(result.data.sales);//销量
                    $("#danWei").html(result.data.units);//销量--单位
                    $("#remarks").html(result.data.remarks);//备注
                    //推荐指数
                    var recommendationIndexHtml = "";
                    for (var i = 0; i < result.data.recommendationIndex; i++) {
                        recommendationIndexHtml += "<i class=\"mui-icon mui-icon-star-filled\"></i>";
                    }
                    $("#recommendationIndexHtml").html(recommendationIndexHtml);
                    $("#priceHtml").html("￥" + result.data.price); //菜价
                    $("#danWei2").html("/" + result.data.units);
                    $("#boxInput").val(result.data.countNumber == null ? 0 : result.data.countNumber);
                    $("#boxInput").attr("inputFood", "inputFood_" + result.data.id);
                    $("#price").val(result.data.price);
                    $("#foodCategoryId").val(result.data.foodCategoryId);

                }
            });
        }

        //购物车加
        function addCart(event, obj) {
            addOrReduceShopCar(event, obj, 1, foodId, $("#foodCategoryId").val(), null, null, null, $("#price").val(), BJW.ip + "/app/page/dinnerDetail?isOpen=4&foodId=" + foodId);
        }

        //购物车减
        function reduceCar(obj){
            addOrReduceShopCar(null, obj, 0, foodId, $("#foodCategoryId").val(), null, null, null, $("#price").val(), BJW.ip + "/app/page/dinnerDetail?isOpen=4&foodId=" + foodId);
        }

        //跳转购物车
        function jumpCar(){
            location.href = BJW.ip + "/app/page/car";
        }

        var swiper = new Swiper('.swiper-container', {
            pagination: '.swiper-pagination',
            paginationClickable: true,
            centeredSlides: true,
            autoplay: 3000,
            autoplayDisableOnInteraction: false
        });

        mui.init({
            swipeBack: true //启用右滑关闭功能
        });
        (function($) {
            //阻尼系数
            var deceleration = mui.os.ios?0.003:0.0009;
            $('.mui-scroll-wrapper').scroll({
                bounce: false,
                indicators: true, //是否显示滚动条
                deceleration:deceleration
            });
        })(mui);

        /*// 监听tap事件，解决 a标签 不能跳转页面问题
         mui('body').on('tap','a',function(){document.location.href=this.href;});*/

        //开启图片预览
        mui.previewImage();

        setTimeout(function (){
            BJW.closeDialogLoading();//关闭弹窗loading
        },500);

        //设置飞入购物车特效
        $(function (){
            var height = $(window).height();
            $(".mui-content").css("overflowX", "hidden");
            $(".mui-content").css("height", height + "px");
        });
    </script>
</body>

</html>