<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>婚庆预约详情</title>
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

        /*覆盖样式*/
        .evaluate .carPopup-item .commodity-name{
            top: -2px;
        }
        .evaluate .carPopup-item .commodity-unit-Price{
            top: -2px;
        }
        .evaluate .carPopup-item .addBtnBox{
            margin-top: 0;
        }
        .evaluate .addBtnBox{
            top: 10px;
        }
    </style>

</head>

<body ng-app="webApp">

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

    <div ng-controller="weddingDetailCtr" ng-cloak>
        <div class="commodity-detail">
            <p class="commodity-row">
                <span class="commodity-name">{{weddingDetail.name}}</span>
            </p>
            <p class="commodity-row commodity-context">
                {{weddingDetail.packageDescription}}
            </p>
            <p class="commodity-row margin-bottom-10">
                <span class="commodity-sales">总销{{weddingDetail.sales}}份</span>
                <span class="commodity-index-mark">推荐指数:
                    <span starnum score="{{weddingDetail.recommendationIndex}}"></span>
                </span>
            </p>
            <p class="commodity-row">
            <span class="commodity-price">
                <span class="price">￥{{weddingDetail.price}}</span>
            </span>
            </p>
        </div>

        <!--区-->
        <div class="evaluate" ng-repeat="partition in partitionList" ng-if="partitionList != null">
            <ul class="mui-table-view">
                <li class="mui-table-view-cell mui-collapse mui-active">
                    <a class="mui-navigate-right" href="javascript:void(0)">{{partition.weddingCategoryName}}</a>
                    <div class="mui-collapse-content">
                        <img src="<%=request.getContextPath()%>/{{partition.img}}">
                        <div class="carPopup-item" ng-repeat="wedding in partition.weddingSons">
                            <span class="commodity-name">{{wedding.name}}</span>
                            <span class="commodity-unit-Price">
                                <span>￥{{wedding.price}}</span>
                                <span>/{{wedding.units}}</span>
                            </span>
                            <div class="addBtnBox">
                                <button class="addOrReduceBtn" onclick="reduceCar(this)"
                                        childCategoryId="{{partition.id}}"
                                        weddingSonId="{{wedding.id}}"
                                        price="{{wedding.price}}">-</button>
                                <input class="boxInput" id="boxInput" type="number" inputFood="weddingSonId_{{wedding.id}}" value="0" readonly ng-if="wedding.countNumber == null">
                                <input class="boxInput" id="boxInput" type="number" inputFood="weddingSonId_{{wedding.id}}" value="{{wedding.countNumber}}" readonly ng-if="wedding.countNumber != null">
                                <button class="addOrReduceBtn" onclick="addCart(event, this)"
                                        childCategoryId="{{partition.id}}"
                                        weddingSonId="{{wedding.id}}"
                                        price="{{wedding.price}}">+</button>
                            </div>
                        </div>

                        <%--<a class="more-btn">
                            展示更多<img src="<%=request.getContextPath()%>/appResources/img/icon/zhankai.png">
                        </a>--%>
                    </div>
                </li>
            </ul>
        </div>

        <!-- 加入购物车传入的类型ID -->
        <input type="hidden" id="foodCategoryId" value="{{weddingDetail.foodCategoryId}}">

        <%--<!--仪式区-->
        <div class="evaluate">
            <ul class="mui-table-view">
                <li class="mui-table-view-cell mui-collapse">
                    <a class="mui-navigate-right" href="#">仪式区</a>
                    <div class="mui-collapse-content">
                        <img src="<%=request.getContextPath()%>/appResources/img/index/2.jpg">
                        <div class="carPopup-item">
                            <span class="commodity-name">葱香鸡蛋干</span>
                        <span class="commodity-unit-Price">
                            <span>￥100</span>
                            <span>/对</span>
                        </span>
                            <div class="addBtnBox">
                                <button class="addOrReduceBtn" onclick="reduceCar(this)">-</button>
                                <input class="boxInput" id="boxInput" type="number" value="0" readonly>
                                <button class="addOrReduceBtn" onclick="addCart(event, this)">+</button>
                            </div>
                        </div>
                        <div class="carPopup-item">
                            <span class="commodity-name">迎宾喷绘</span>
                        <span class="commodity-unit-Price">
                            <span>￥18</span>
                            <span>/平米</span>
                        </span>
                            <div class="addBtnBox">
                                <button class="addOrReduceBtn" onclick="reduceCar(this)">-</button>
                                <input class="boxInput" id="boxInput" type="number" value="0" readonly>
                                <button class="addOrReduceBtn" onclick="addCart(event, this)">+</button>
                            </div>
                        </div>
                        <div class="carPopup-item">
                            <span class="commodity-name">水牌</span>
                        <span class="commodity-unit-Price">
                            <span>￥8</span>
                            <span>/个</span>
                        </span>
                            <div class="addBtnBox">
                                <button class="addOrReduceBtn" onclick="reduceCar(this)">-</button>
                                <input class="boxInput" id="boxInput" type="number" value="0" readonly>
                                <button class="addOrReduceBtn" onclick="addCart(event, this)">+</button>
                            </div>
                        </div>
                        <a class="more-btn">
                            展示更多<img src="<%=request.getContextPath()%>/appResources/img/icon/zhankai.png">
                        </a>
                    </div>
                </li>
            </ul>
        </div>

        <!--宴会区-->
        <div class="evaluate">
            <ul class="mui-table-view">
                <li class="mui-table-view-cell mui-collapse">
                    <a class="mui-navigate-right" href="#">宴会区</a>
                    <div class="mui-collapse-content">
                    </div>
                </li>
            </ul>
        </div>

        <!--局部装饰-->
        <div class="evaluate">
            <ul class="mui-table-view">
                <li class="mui-table-view-cell mui-collapse">
                    <a class="mui-navigate-right" href="#">局部装饰</a>
                    <div class="mui-collapse-content">
                    </div>
                </li>
            </ul>
        </div>

        <!--灯光设备-->
        <div class="evaluate">
            <ul class="mui-table-view">
                <li class="mui-table-view-cell mui-collapse">
                    <a class="mui-navigate-right" href="#">灯光设备</a>
                    <div class="mui-collapse-content">
                    </div>
                </li>
            </ul>
        </div>

        <!--专家团队-->
        <div class="evaluate">
            <ul class="mui-table-view">
                <li class="mui-table-view-cell mui-collapse">
                    <a class="mui-navigate-right" href="#">专家团队</a>
                    <div class="mui-collapse-content">
                    </div>
                </li>
            </ul>
        </div>

        <!--演艺人员-->
        <div class="evaluate">
            <ul class="mui-table-view">
                <li class="mui-table-view-cell mui-collapse">
                    <a class="mui-navigate-right" href="#">演艺人员</a>
                    <div class="mui-collapse-content">
                    </div>
                </li>
            </ul>
        </div>--%>
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
    var foodId = localStorage.getItem("weddingFoodId");
    initData();
    //获取数据
    function initData() {
        var arr = {
            foodCategoryId: BJW.foodCategoryId.wedding,
            foodId: foodId
        }
        BJW.ajaxRequestData("get", false, BJW.ip + '/app/food/queryFoodById', arr, userToken, function (result) {
            if (result.flag == 0 && result.code == 200) {
                console.log("******************");
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

    //婚庆
    webApp.controller('weddingDetailCtr',function($scope,$http,$timeout){
        $scope.banners = null; // 存放轮播图
        $scope.weddingDetail = null; //婚庆详情
        $scope.partitionList = null //存放分区list

        var arr = {
            foodCategoryId: BJW.foodCategoryId.wedding,
            foodId: foodId
        }
        BJW.ajaxRequestData("get", false, BJW.ip + '/app/food/queryFoodById', arr, userToken, function (result) {
            if (result.flag == 0 && result.code == 200) {
                console.log(result.data);
                //获取轮播
                //$scope.banners = result.data.banners.split(",");
                $scope.weddingDetail = result.data;
                $scope.partitionList = result.data.weddingChildCategories;
                console.log("************************");
                console.log($scope.partitionList);
                console.log("************************");
            }
        });
    });
    //星级过滤器
    webApp.directive('starnum',function(){
        return {
            link:function(score,ele,attr){
                var str='';
                //console.log("attr.score：" + attr.score);
                for (var i=0;i< Math.floor(attr.score);i++) {
                    str+='<i class="mui-icon mui-icon-star-filled"></i>';
                }
                ele.html(str);
            }
        }
    });

    //购物车加
    function addCart(event, obj) {
        var price = $(obj).attr("price");
        var childCategoryId = $(obj).attr("childCategoryId");
        var weddingSonId = $(obj).attr("weddingSonId");
        addOrReduceShopCar(event, obj, 1, foodId, $("#foodCategoryId").val(), childCategoryId, weddingSonId, null, price, BJW.ip + "/app/page/weddingDetail?isOpen=4&foodId=" + foodId);
    }

    //购物车减
    function reduceCar(obj){
        var price = $(obj).attr("price");
        var childCategoryId = $(obj).attr("childCategoryId");
        var weddingSonId = $(obj).attr("weddingSonId");
        addOrReduceShopCar(null, obj, 0, foodId, $("#foodCategoryId").val(), childCategoryId, weddingSonId, null, price, BJW.ip + "/app/page/weddingDetail?isOpen=4&foodId=" + foodId);
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