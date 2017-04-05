<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>套餐详情</title>
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
                <p class="commodity-row commodity-context" id="foodContext">
                </p>
                <p class="commodity-row margin-bottom-10">
                    <span class="commodity-sales">总销<span id="sales">0</span><span id="danWei">份</span></span>
                    <span class="commodity-index-mark">推荐指数:
                        <span id="recommendationIndexHtml"></span>
                    </span>
                </p>
                <p class="commodity-row">
                    <span class="commodity-price"><span id="priceHtml">￥0.00</span><span id="danWei2">/桌</span></span>
                    <div class="addBtnBox">
                        <button class="addOrReduceBtn" onclick="reduceCar(this)">-</button>
                        <input class="boxInput" id="boxInput" type="number" value="0" readonly>
                        <button class="addOrReduceBtn" onclick="addCart(event, this)">+</button>
                    </div>
                </p>
            </div>

            <input id="price" type="hidden">
            <input id="foodId" type="hidden">
            <input id="foodCategoryId" type="hidden">

            <!--套餐菜单-->
            <div class="evaluate">
                <div class="evaluate-title">
                    套餐菜单
                </div>
                <div class="commodity-introduce foodList" id="setMealMenu">

                </div>
            </div>

            <!--评价栏-->
            <div class="evaluate">
                <div class="evaluate-title">
                    消费评价
                </div>
                <div class="deuce-bar">
                    <div class="comprehensive-deuce">
                        <p class="deuce-max-num" id="deuce-max-num">0</p>
                        <p class="comprehensive-deuce-name">综合平分</p>
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

            <%--<div id="loadingData">
                <div class="mui-row">
                    <div class="mui-col-xs-5 mui-col-sm-5">
                        <div class="mui-loading">
                            <div class="mui-spinner">
                            </div>
                        </div>
                    </div>
                    <div class="mui-col-xs-7 mui-col-sm-7">
                        <span id="loadingText">加载中...</span>
                    </div>
                </div>
            </div>--%>

        </div>
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
            foodId = localStorage.getItem("foodId");
        }
        initData();
        //获取数据
        function initData() {
            var arr = {
                foodCategoryId : BJW.foodCategoryId.setMeal,
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
                    $("#boxInput").val(result.data.countNumber == null ? 0 : result.data.countNumber);
                    $("#boxInput").attr("inputFood", "inputFood_" + result.data.id);
                    $("#price").val(result.data.promotionPrice);
                    $("#foodCategoryId").val(result.data.foodCategoryId);

                    var arrayData1 = new Array();// 凉菜
                    var arrayData2 = new Array();// 热菜
                    var arrayData3 = new Array();// 海河鲜
                    var arrayData4 = new Array();// 素菜
                    var arrayData5 = new Array();// 燕鲍翅
                    var arrayData6 = new Array();// 小吃
                    var arrayData7 = new Array();// 汤
                    var arrayData8 = new Array();// 酒水
                    var a=0, b=0, c=0, d=0, e=0, f=0, j=0, k=0;
                    for (var i = 0; i < result.data.singleFoodList.length; i++) {
                        if (result.data.singleFoodList[i].foodCategoryId == 1) {
                            arrayData1[a++] = result.data.singleFoodList[i];
                        }
                        if (result.data.singleFoodList[i].foodCategoryId == 2) {
                            arrayData2[b++] = result.data.singleFoodList[i];
                        }
                        if (result.data.singleFoodList[i].foodCategoryId == 3) {
                            arrayData3[c++] = result.data.singleFoodList[i];
                        }
                        if (result.data.singleFoodList[i].foodCategoryId == 4) {
                            arrayData4[d++] = result.data.singleFoodList[i];
                        }
                        if (result.data.singleFoodList[i].foodCategoryId == 5) {
                            arrayData5[e++] = result.data.singleFoodList[i];
                        }
                        if (result.data.singleFoodList[i].foodCategoryId == 6) {
                            arrayData6[f++] = result.data.singleFoodList[i];
                        }
                        if (result.data.singleFoodList[i].foodCategoryId == 7) {
                            arrayData7[j++] = result.data.singleFoodList[i];
                        }
                        if (result.data.singleFoodList[i].foodCategoryId == 8) {
                            arrayData8[k++] = result.data.singleFoodList[i];
                        }
                    }

                    if (arrayData1.length != 0) {
                        var setHtml = "";
                        for (var i = 0; i < arrayData1.length; i++) {
                            setHtml += "<div class=\"food-type\">" + arrayData1[i].foodName + "</div>";
                        }
                        $("#setMealMenu").append("<div class=\"food-title\">- 凉菜 -</div>" + setHtml);
                    }
                    if (arrayData2.length != 0) {
                        var setHtml = "";
                        for (var i = 0; i < arrayData2.length; i++) {
                            setHtml += "<div class=\"food-type\">" + arrayData2[i].foodName + "</div>";
                        }
                        $("#setMealMenu").append("<div class=\"food-title\">- 热菜 -</div>" + setHtml);
                    }
                    if (arrayData3.length != 0) {
                        var setHtml = "";
                        for (var i = 0; i < arrayData3.length; i++) {
                            setHtml += "<div class=\"food-type\">" + arrayData3[i].foodName + "</div>";
                        }
                        $("#setMealMenu").append("<div class=\"food-title\">- 海河鲜 -</div>" + setHtml);
                    }
                    if (arrayData4.length != 0) {
                        var setHtml = "";
                        for (var i = 0; i < arrayData4.length; i++) {
                            setHtml += "<div class=\"food-type\">" + arrayData4[i].foodName + "</div>";
                        }
                        $("#setMealMenu").append("<div class=\"food-title\">- 素菜 -</div>" + setHtml);
                    }
                    if (arrayData5.length != 0) {
                        var setHtml = "";
                        for (var i = 0; i < arrayData5.length; i++) {
                            setHtml += "<div class=\"food-type\">" + arrayData5[i].foodName + "</div>";
                        }
                        $("#setMealMenu").append("<div class=\"food-title\">- 燕鲍翅 -</div>" + setHtml);
                    }
                    if (arrayData6.length != 0) {
                        var setHtml = "";
                        for (var i = 0; i < arrayData6.length; i++) {
                            setHtml += "<div class=\"food-type\">" + arrayData6[i].foodName + "</div>";
                        }
                        $("#setMealMenu").append("<div class=\"food-title\">- 小吃 -</div>" + setHtml);
                    }
                    if (arrayData7.length != 0) {
                        var setHtml = "";
                        for (var i = 0; i < arrayData7.length; i++) {
                            setHtml += "<div class=\"food-type\">" + arrayData7[i].foodName + "</div>";
                        }
                        $("#setMealMenu").append("<div class=\"food-title\">- 汤 -</div>" + setHtml);
                    }
                    if (arrayData8.length != 0) {
                        var setHtml = "";
                        for (var i = 0; i < arrayData8.length; i++) {
                            setHtml += "<div class=\"food-type\">" + arrayData8[i].foodName + "</div>";
                        }
                        $("#setMealMenu").append("<div class=\"food-title\">- 酒水 -</div>" + setHtml);
                    }


                }
            });

            //获取平均评分
            var arr2 = {
                type : 3,
                objectId : foodId
            }
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/evaluate/getAvgScore', arr2, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    var avg = (result.data.foodScore + result.data.cookScore + result.data.serviceScore) / 3;
                    $("#deuce-max-num").html(avg.toFixed(1));
                    $("#foodScore").html(result.data.foodScore.toFixed(1));
                    $("#cookScore").html(result.data.cookScore.toFixed(1));
                    $("#serviceScore").html(result.data.serviceScore.toFixed(1));
                    var fei = "<i class=\"mui-icon mui-icon-star\"></i>";
                    var man = "<i class=\"mui-icon mui-icon-star-filled\"></i>";
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
                    auto:false, //默认加载
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
            var html = getEvaluateList(3, foodId, ++pageNo1, 10);
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
            addOrReduceShopCar(event, obj, 1, foodId, $("#foodCategoryId").val(), null, null, null, $("#price").val(), BJW.ip + "/app/page/setMealDetail?isOpen=4&foodId=" + foodId);
        }

        //购物车减
        function reduceCar(obj){
            addOrReduceShopCar(null, obj, 0, foodId, $("#foodCategoryId").val(), null, null, null, $("#price").val(), BJW.ip + "/app/page/setMealDetail?isOpen=4&foodId=" + foodId);
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

        (function($) {
            //阻尼系数
            var deceleration = mui.os.ios?0.003:0.0009;
            $('.mui-scroll-wrapper').scroll({
                bounce: false,
                indicators: false, //是否显示滚动条
                deceleration:deceleration
            });
        })(mui);
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