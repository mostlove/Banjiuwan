<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>专业服务详情</title>
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

<body ng-app="webApp">

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
            <div ng-controller="serviceDetailCtr" ng-cloak>
                <div class="commodity-detail">
                    <p class="commodity-row">
                        <span class="commodity-name">请选择服务员</span>
                        <span class="service-price">
                        <span class="price">￥<span id="price">{{man.price}}</span></span>
                        <span>/人</span>
                        </span>
                    </p>
                    <p class="commodity-row">
                        <div class="select-gender">
                            <button class="gender-active" value="0">男</button>
                            <button value="1">女</button>
                        </div>

                        <!--男加购物车按钮-->
                        <div class="addBtnBox" style="top:-24px" id="man">
                            <button class="addOrReduceBtn" onclick="reduceCar(this)"
                                    foodId="{{man.id}}"
                                    price="{{man.price}}">-</button>
                            <input class="boxInput" id="manBoxInput" type="number" inputFood="inputFood_{{man.id}}" value="0" readonly ng-if="man.countNumber == null">
                            <input class="boxInput" id="manBoxInput" type="number" inputFood="inputFood_{{man.id}}" value="{{man.countNumber}}" readonly ng-if="man.countNumber != null">
                            <button class="addOrReduceBtn" onclick="addCart(event, this)"
                                    foodId="{{man.id}}"
                                    price="{{man.price}}">+</button>
                        </div>
                        <!--女加购物车按钮-->
                        <div class="addBtnBox hide" style="top:-24px" id="woman">
                            <button class="addOrReduceBtn" onclick="reduceCar(this)"
                                    foodId="{{woman.id}}"
                                    price="{{woman.price}}">-</button>
                            <input class="boxInput" id="womanBoxInput" type="number" inputFood="inputFood_{{woman.id}}" value="0" readonly ng-if="woman.countNumber == null">
                            <input class="boxInput" id="womanBoxInput" type="number" inputFood="inputFood_{{woman.id}}" value="{{woman.countNumber}}" readonly ng-if="woman.countNumber != null">
                            <button class="addOrReduceBtn" onclick="addCart(event, this)"
                                    foodId="{{woman.id}}"
                                    price="{{woman.price}}">+</button>
                        </div>
                    </p>
                </div>

                <!-- 加入购物车传入的类型ID -->
                <input type="hidden" id="foodCategoryId" value="{{serviceDetail.foodCategoryId}}">

                <!--服务理念-->
                <div class="evaluate">
                    <div class="evaluate-title">
                        服务理念
                    </div>
                    <div class="commodity-introduce">
                        {{serviceDetail.serviceIdea}}
                    </div>
                </div>

                <!--服务流程-->
                <div class="evaluate">
                    <div class="evaluate-title">
                        服务流程
                    </div>
                    <div class="commodity-introduce service-flow">
                        <div ng-bind-html="serviceFlow"></div>
                    </div>
                </div>

                <!--服务标准-->
                <div class="evaluate">
                    <div class="evaluate-title">
                        服务标准
                    </div>
                    <div class="commodity-introduce service-flow">
                        <div ng-bind-html="serviceStandard"></div>
                    </div>
                </div>

                <!--评价栏-->
                <div class="evaluate">
                    <div class="evaluate-title">
                        消费评价
                    </div>
                    <div class="user-deuce-list">
                        <ul class="mui-table-view" id="evaluateList">

                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

    <!--引入购物车弹窗-->
    <%@include file="../common/car-popup.jsp" %>

    <script type="text/javascript">

        $("body").append(BJW.dialogLoading("正在加载"));//弹窗loading

        //获取登录用户token
        var userToken = BJW.getLocalStorageToken();
        console.log("token:" + userToken);

        initData();
        //获取数据
        function initData() {
            var arr = {
                foodCategoryId: BJW.foodCategoryId.service,
                foodId: null
            }
            BJW.ajaxRequestData("get", false, BJW.ip + '/app/food/queryFoodById', arr, userToken, function (result) {
                if (result.flag == 0 && result.code == 200) {
                    console.log(result.data);
                    //获取轮播
                    var banners = result.data.banners.split(",");
                    var bannersHtml = "";
                    for (var i = 0; i < banners.length; i++) {
                        bannersHtml += "<div class=\"swiper-slide\"><img src=\"" + BJW.ip + "/" + banners[i] + "\" data-preview-src=\"\" data-preview-group=\"1\"></div>";
                    }
                    $("#swiperSlide").html(bannersHtml);
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
                var cookScore = jsonData[i].cookScore;
                var serviceScore = jsonData[i].serviceScore;
                var sum = parseInt((cookScore + serviceScore) / 2);
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
            var html = getEvaluateList(5, null, ++pageNo1, 10);
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

        //专业服务
        webApp.controller('serviceDetailCtr',function($scope,$http,$timeout,$sce){
            //存放专业服务数据
            $scope.serviceDetail = null;
            //存放服务流程
            $scope.serviceFlow = null;
            //存放服务标准
            $scope.serviceStandard = null;
            //存放男服务员的数据
            $scope.man = null;
            //存放女服务员的数据
            $scope.woman = null;

            var arr = {
                foodCategoryId: BJW.foodCategoryId.service,
                foodId: null
            }
            BJW.ajaxRequestData("get", false, BJW.ip + '/app/food/queryFoodById', arr, userToken, function (result) {
                if (result.flag == 0 && result.code == 200) {
                    $scope.serviceDetail = result.data;
                    //解析angularJS富文本字符串 --服务流程
                    $scope.serviceFlow = $scope.serviceDetail.serviceFlow;
                    $scope.serviceFlow = $sce.trustAsHtml($scope.serviceFlow);
                    //解析angularJS富文本字符串 --服务标准
                    $scope.serviceStandard = $scope.serviceDetail.serviceStandard;
                    $scope.serviceStandard = $sce.trustAsHtml($scope.serviceStandard);

                    $scope.man = $scope.serviceDetail.specialServiceChilds[0];
                    $scope.woman = $scope.serviceDetail.specialServiceChilds[1];
                }
            });

            //选择男、女
            $(".select-gender button").each(function(){
                $(this).click(function (){
                    var obj = $(this);
                    var value = $(this).attr("value");
                    console.log(value);
                    if (value == 0) {
                        $("#price").html($scope.man.price);
                        $("#man").show();
                        $("#woman").hide();
                    }
                    else {
                        $("#price").html($scope.woman.price);
                        $("#man").hide();
                        $("#woman").show();
                    }
                    $(".select-gender button").removeClass("gender-active");
                    obj.addClass("gender-active");
                });
            });

        });


        //购物车加
        function addCart(event, obj) {
            var price = $(obj).attr("price");
            var foodId = $(obj).attr("foodId");
            addOrReduceShopCar(event, obj, 1, foodId, $("#foodCategoryId").val(), null, null, null, price, BJW.ip + "/app/page/serviceDetail?isOpen=4&foodId=" + foodId);
        }

        //购物车减
        function reduceCar(obj){
            var price = $(obj).attr("price");
            var foodId = $(obj).attr("foodId");
            addOrReduceShopCar(null, obj, 0, foodId, $("#foodCategoryId").val(), null, null, null, price, BJW.ip + "/app/page/serviceDetail?isOpen=4&foodId=" + foodId);
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