<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>发现</title>
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/detail.css" charset="UTF-8">
    <style>
        .swiper-container{
            height: 260px;
        }
        /*iphone5*/
        @media screen and (max-width:320px) {
            .swiper-container{
                height: 200px !important;
            }
        }
        /*iphone6*/
        @media screen and (max-width:375px) {
            .swiper-container {
                height: 250px;
            }
        }
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

<div id="pullrefresh" class="mui-content mui-scroll-wrapper">
    <div class="mui-scroll">

        <!-- Swiper -->
        <div class="swiper-container">
            <div class="swiper-wrapper" id="swiperSlide">

            </div>
            <!-- Add Pagination -->
            <div class="swiper-pagination"></div>
        </div>

        <!--产品推荐-->
        <div class="evaluate">
            <div class="evaluate-title">
                产品推荐
            </div>
            <div class="user-deuce-list">
                <div class="recommend-bar">

                    <div class="swiper-container2">
                        <div class="swiper-wrapper" id="swiperSlide2">
                            <div class="swiper-slide">
                                <div class="mui-loading">
                                    <div class="mui-spinner">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!--促销信息-->
        <div class="evaluate">
            <div class="evaluate-title">
                促销信息
            </div>
            <div class="user-deuce-list">
                <div class="recommend-bar">

                    <div class="swiper-container2">
                        <div class="swiper-wrapper" id="swiperSlide3">

                            <div class="swiper-slide">
                                <div class="mui-loading">
                                    <div class="mui-spinner">
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>


        <!--评价栏-->
        <div class="evaluate">
            <div class="evaluate-title">
                七嘴八舌
            </div>
            <div class="user-deuce-list">
                <ul class="mui-table-view" id="evaluateList">

                </ul>
            </div>
        </div>
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
        <a class="mui-tab-item mui-active" href="<%=request.getContextPath()%>/app/page/find">
            <div class="tab-icon find-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-3.png"></div>
        </a>
        <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/customer">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-4.png"></div>
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

        var userToken = BJW.getLocalStorageToken(); //获取本地存储token
        console.log("userToken：" + userToken);

        if (!BJW.isWeiXin()){
            $(".mui-content").css("paddingBottom", "0");
        }

        $("body").append(BJW.dialogLoading("加载中···"));//弹窗loading

        initData();
        //初始化数据
        function initData(){
            //获取轮播图
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/homeBanner/getBanner', {flag : 2}, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    var html = "";
                    for (var i = 0; i < result.data.length; i++) {
                        var object = JSON.stringify(result.data[i]);
                        html += "<div class=\"swiper-slide\">" +
                                    "<a href='javascript:bannerDetail(" + object + ")'>" +
                                        "<img src=\"" + BJW.ip + "/" + result.data[i].banner + "\">" +
                                    "</a>" +
                                "</div>";
                    }
                    $("#swiperSlide").html(html);
                }
                else {
                    mui.toast("获取轮播失败.");
                }
            });

            //获取推荐商品和促销商品
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/food/getRecommendationPromotion', {}, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    //促销
                    var html = "";
                    for (var i = 0; i < result.data.promotion.length; i++) {
                        html += "<div class=\"swiper-slide\">" +
                                    "<a href=\"javascript:cookbookDetail(" + result.data.promotion[i].id + "," + result.data.promotion[i].foodCategoryId + ")\">" +
                                        "<img class=\"recommend-img\" src=\""+ BJW.ip + "/" + result.data.promotion[i].coverImg + "\">" +
                                        "<p class=\"recommend-name\">" + result.data.promotion[i].foodName + "</p>" +
                                    "</a>" +
                                "</div>";
                    }
                    if (html == "") {
                        html = "<div class='notData'>暂无推荐产品.</div>";
                    }
                    $("#swiperSlide2").html(html);

                    //推荐
                    var html2 = "";
                    for (var i = 0; i < result.data.recommendation.length; i++) {
                        html2 += "<div class=\"swiper-slide\">" +
                                    "<a href=\"javascript:cookbookDetail(" + result.data.recommendation[i].id + "," + result.data.recommendation[i].foodCategoryId + ")\">" +
                                        "<img class=\"recommend-img\" src=\""+ BJW.ip + "/" + result.data.recommendation[i].coverImg + "\">" +
                                        "<p class=\"recommend-name\">" + result.data.recommendation[i].foodName + "</p>" +
                                        "<p class=\"sale-price\"><i>￥" + result.data.recommendation[i].price + "</i></p>" +
                                        "<p class=\"now-price\">￥" + result.data.recommendation[i].promotionPrice + "</p>" +
                                    "</a>" +
                                "</div>";
                    }
                    if (html2 == "") {
                        html2 = "<div class='notData'>暂无促销信息.</div>";
                    }
                    $("#swiperSlide3").html(html2);
                }
                else {
                    mui.toast(result.msg);
                }
            });
        }

        //banner详情
        function bannerDetail(object){
            localStorage.setItem("indexPage", 1);
            localStorage.setItem("bannerDetail", JSON.stringify(object));
            location.href = BJW.ip + "/app/page/bannerDetail?isOpen=1";
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
                if (jsonData[i].imgs != null) {
                    var imgs = jsonData[i].imgs.split(",");
                }
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
            var html = getEvaluateList(1, null, ++pageNo1, 10);
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

        //详情
        function cookbookDetail(foodId, foodCategoryId){
            localStorage.setItem("cookbookId", foodId);
            localStorage.setItem("foodCategoryId", foodCategoryId);
            location.href = BJW.ip + "/app/page/cookbookDetail?isOpen=4&cookbookId=" + foodId;
        }


        // 监听tap事件，解决 a标签 不能跳转页面问题
        mui('body').on('tap','a',function(){document.location.href=this.href;});

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
            loop: true,
            autoplayDisableOnInteraction: false
        });

        var swiper2 = new Swiper('.swiper-container2', {
            slidesPerView: 3,
            paginationClickable: true,
            spaceBetween: 15,
            freeMode: true
        });

        //开启图片预览
        mui.previewImage();

    </script>
</body>

</html>