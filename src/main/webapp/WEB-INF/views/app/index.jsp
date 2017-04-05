<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>办酒碗</title>
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/index.css" charset="UTF-8">
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=KEsjqKjcGICVqaZV82t1IOoh"></script>
    <style>

    </style>
</head>

<body>


    <!--下拉刷新容器-->
    <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
        <div class="mui-scroll">
            <!-- Swiper -->
            <div class="swiper-container">
                <div class="swiper-wrapper" id="swiperSlide">

                </div>
                <!-- Add Pagination -->
                <div class="swiper-pagination"><br></div>
            </div>

            <!--搜索栏-->
            <div class="search-bar" id="searchBar">
                <div class="mui-row">
                    <div class="mui-col-xs-4 mui-col-sm-4">
                        <a class="search-address mui-ellipsis" href="<%=request.getContextPath()%>/app/page/selectAddress">
                            <i class="mui-icon mui-icon-location"></i>
                            <span class="" id="currentAddress"></span>
                            <i class="mui-icon mui-icon-arrowright"></i>
                        </a>
                    </div>
                    <div class="mui-col-xs-8 mui-col-sm-8">
                        <a href="<%=request.getContextPath()%>/app/page/search">
                            <input readonly class="search-input" placeholder="请输入食材或菜品">
                            <i class="mui-icon mui-icon-search"></i>
                        </a>
                    </div>
                </div>
            </div>
            <!--菜单栏-->
            <div class="index-menu-bar">
                <div class="mui-row">
                    <div class="mui-col-xs-3 mui-col-sm-3">
                        <div class="mui-table-view-cell">
                            <a href="javascript:isCaregory('/app/page/cookbook?isOpen=1','1')">
                                <div class="index-menu-icon"><img src="<%=request.getContextPath()%>/appResources/img/index/cai-1.png"></div>
                                <div class="index-menu-lable" id="meun0">点菜</div>
                            </a>
                        </div>
                    </div>
                    <div class="mui-col-xs-3 mui-col-sm-3">
                        <div class="mui-table-view-cell">
                            <a href="javascript:isCaregory('/app/page/setMeal','2')">
                                <div class="index-menu-icon"><img src="<%=request.getContextPath()%>/appResources/img/index/cai-2.png"></div>
                                <div class="index-menu-lable" id="meun1">套餐</div>
                            </a>
                        </div>
                    </div>
                    <div class="mui-col-xs-3 mui-col-sm-3">
                        <div class="mui-table-view-cell">
                            <a href="javascript:isCaregory('/app/page/bamYan','3')">
                                <div class="index-menu-icon"><img src="<%=request.getContextPath()%>/appResources/img/index/cai-3.png"></div>
                                <div class="index-menu-lable" id="meun2">坝坝宴</div>
                            </a>
                        </div>
                    </div>
                    <div class="mui-col-xs-3 mui-col-sm-3">
                        <div class="mui-table-view-cell">
                            <a href="javascript:isCaregory('/app/page/cookbook?isOpen=1&type=1','8')">
                                <div class="index-menu-icon"><img src="<%=request.getContextPath()%>/appResources/img/index/cai-4.png"></div>
                                <div class="index-menu-lable" id="meun3">酒水</div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!--特色服务-->
            <div class="feature-service-div">
                <div class="index-title">
                    <h2><i id="meun4">特色服务</i><span>HOT</span></h2>
                </div>
                <div class="mui-row">
                    <div class="mui-col-xs-6 mui-col-sm-6 padding5">
                        <a href="javascript:isCaregory('/app/page/serviceDetail?isOpen=4','6')">
                            <div class="mui-row index-bg">
                                <div class="mui-col-xs-6 mui-col-sm-6 service-left-div">
                                    <h4 class="index-service-title" id="meun5">专业服务</h4>
                                    <p class="index-service-context">服务一体化</p>
                                </div>
                                <div class="mui-col-xs-6 mui-col-sm-6 service-right-div">
                                    <img class="index-service-img" src="<%=request.getContextPath()%>/appResources/img/index/service-1.png">
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="mui-col-xs-6 mui-col-sm-6 padding5">
                        <a href="javascript:isCaregory('/app/page/dinner','5')">
                            <div class="mui-row index-bg">
                                <div class="mui-col-xs-6 mui-col-sm-6 service-left-div">
                                    <h4 class="index-service-title" id="meun6">伴餐演奏</h4>
                                    <p class="index-service-context">服务一体化</p>
                                </div>
                                <div class="mui-col-xs-6 mui-col-sm-6 service-right-div">
                                    <img class="index-service-img" src="<%=request.getContextPath()%>/appResources/img/index/service-2.png">
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="mui-col-xs-6 mui-col-sm-6 padding5">
                        <a href="javascript:isCaregory('/app/page/wedding','4')">
                            <div class="mui-row index-bg">
                                <div class="mui-col-xs-6 mui-col-sm-6 service-left-div">
                                    <h4 class="index-service-title" id="meun7">婚庆预约</h4>
                                    <p class="index-service-context">服务一体化</p>
                                </div>
                                <div class="mui-col-xs-6 mui-col-sm-6 service-right-div">
                                    <img class="index-service-img" src="<%=request.getContextPath()%>/appResources/img/index/service-3.png">
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="mui-col-xs-6 mui-col-sm-6 padding5">
                        <a href="<%=request.getContextPath()%>/app/page/foodPrice">
                            <div class="mui-row index-bg">
                                <div class="mui-col-xs-6 mui-col-sm-6 service-left-div">
                                    <h4 class="index-service-title" id="meun8">实时菜价</h4>
                                    <p class="index-service-context">服务一体化</p>
                                </div>
                                <div class="mui-col-xs-6 mui-col-sm-6 service-right-div">
                                    <img class="index-service-img" src="<%=request.getContextPath()%>/appResources/img/index/service-4.png">
                                </div>
                            </div>
                        </a>
                    </div>

                </div>
            </div>

            <!--精品生活-->
            <div class="products">
                <div class="index-title">
                    <h2><i id="meun9">精品生活</i><span>BEST</span></h2>
                </div>
                <ul class="mui-table-view" id="news">

                </ul>
            </div>
        </div>
    </div>

    <!--首页轮播弹窗-->
    <div id="popupBanner" onclick="closeBanner()">
        <div class="popupBannerDiv">
            <img id="popupBannerImg" onclick="bannerNews(event)" src="<%=request.getContextPath()%>/appResources/img/index/1.jpg">
        </div>
    </div>

    <!--服务范围提示-->
    <div class="serviceHint" onclick="closeHint()">
        <div class="serviceHintDiv">
            <img src="<%=request.getContextPath()%>/appResources/img/icon/ii.png">
            <div id="hintContext"></div>
        </div>
    </div>

    <input type="hidden" id="longitude">
    <input type="hidden" id="latitude">

    <!--底部-->
    <nav class="mui-bar mui-bar-tab tab-bottom" id="tabBottom">
        <a class="mui-tab-item mui-active" href="<%=request.getContextPath()%>/app/page/index">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-1-active.png"></div>
            <span class="mui-tab-label">首页</span>
        </a>
        <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/car">
            <div class="tab-icon"><img src="<%=request.getContextPath()%>/appResources/img/tab/tab-2.png"></div>
            <span class="mui-tab-label">购物车</span>
        </a>
        <a class="mui-tab-item" href="<%=request.getContextPath()%>/app/page/find">
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
    <script src="<%=request.getContextPath()%>/appResources/js/common/geoUtils.js" type="text/javascript" charset="UTF-8"></script>

    <script type="text/javascript">

        $("body").append(BJW.dialogLoading("正在加载"));//弹窗loading

        var userToken = BJW.getLocalStorageToken(); //获取本地存储token
        console.log("来自首页打印：" + userToken);

        var categoryConfig = null; // 点餐范围配置
        var mapList = null; //经纬度集合

        initData();

        function initData(){
            //获取弹窗轮播
            if (localStorage.getItem("isFirst") != 1 && BJW.isWeiXin()) {
                BJW.ajaxRequestData("get", false, BJW.ip+'/app/homeBanner/getBanner', {flag : 1}, userToken , function(result){
                    if(result.flag == 0 && result.code == 200){
                        $("#popupBannerImg").attr("src", BJW.ip + "/" + result.data[0].banner);
                        $("#popupBanner").fadeIn();
                        $("#popupBannerImg").css("width" , "70%");
                        $("#popupBannerImg").css("height" , "70%");
                    }
                });
                localStorage.setItem("isFirst", 1)
            }


            //获取轮播图
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/homeBanner/getBanner', {flag : 0}, userToken , function(result){
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
                    mui.toast("获取首页轮播失败.");
                }
            });

            //获取菜单名字
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/food/queryHomeFont', {}, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    for (var i = 0; i < result.data.length; i++) {
                        $("#meun" + i).html(result.data[i].font);
                    }
                }
                else {
                    mui.toast("获取菜单名字失败.");
                }
            });

            //获取点餐范围
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/category/getCategoryConfig', {}, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    categoryConfig = result.data.categoryConfig;
                    mapList = result.data.mapList;
                }
            });

        }

        //轮播详情
        function bannerDetail(object){
            localStorage.setItem("indexPage", 0);
            localStorage.setItem("bannerDetail", JSON.stringify(object));
            location.href = BJW.ip + "/app/page/bannerDetail?isOpen=1";
        }

        //精品生活
        function bannerNews(event){
            event.stopPropagation();
            location.href = BJW.ip + "/app/page/bannerNews?isOpen=1";
        }

        //关闭首页弹窗
        function closeBanner(){
            $("#popupBanner").hide();
        }

        //关闭服务范围弹窗
        function closeHint() {
            $(".serviceHint").hide();
        }

        //判断是否在点餐范围内
        // id 单点菜品 1 套餐:2 宴席:3 庆典:4 "演艺伴奏":5  "专业服务":6  "酒水":8
        function isCaregory (url,id) {
            if (!BJW.isWeiXin()) {
                location.href = BJW.ip + url;
                return false;
            }
            var lng = $("#longitude").val();
            var lat = $("#latitude").val();
            /*var lng = 104.072689;
            var lat = 30.655485;*/
            var point = new BMap.Point(lng,lat);
            console.log(lng+"-----------lng" + lat+"---------lat");
            console.log(categoryConfig);
            console.log(mapList);
            var polys = [];
            for (var i = 0; i < mapList.length; i++) {
                var coordsArr = [];
                var temp = mapList[i].mapList;
                var objJson = eval('(' + temp + ')');
                for(var obj in objJson){
                    coordsArr.push(new BMap.Point(obj,objJson[obj]));
                    console.debug(obj+"--------------------"+objJson[obj]);
                }
                // 创建 多边形 对象
                var poly = new BMap.Polygon(coordsArr);
                // 装载 多边形对象
                polys.push(poly);
            }

            var isIn = false;  // 是否在圈内
            for (var i=0 ; i<polys.length; i++){
                console.debug(BMapLib.GeoUtils.isPointInPolygon(point,polys[i]));
                if(BMapLib.GeoUtils.isPointInPolygon(point,polys[i])){
                    isIn = true;
                    break;
                }
            }
            //判断是否可以点击
            for (var i=0; i<categoryConfig.length; i++){
                var obj = categoryConfig[i];
                if(obj.id == id){
                    if (isIn && obj.isInside == 0){
                        //mui.alert(obj.msg);
                        $("#hintContext").html(obj.msg);
                        $(".serviceHint").show();
                        $(".serviceHintDiv").css("width" , "220px").css("height" , "125px");
                        return;
                    }
                    if(!isIn && obj.isInside == 0){
                        //mui.alert(obj.msg);
                        $("#hintContext").html(obj.msg);
                        $(".serviceHint").show();
                        $(".serviceHintDiv").css("width" , "220px").css("height" , "125px");
                        return;
                    }
                }
            }
            location.href = BJW.ip + url;
        }

        //获取定位地址
        var address = localStorage.getItem("selectAddress");
        var latOrLng = JSON.parse(localStorage.getItem("latOrLng"));
        console.log(latOrLng);
        if (address != null && latOrLng != null) {
            $("#currentAddress").html(address);
            $("#longitude").val(latOrLng.lng);
            $("#latitude").val(latOrLng.lat);
        }
        else {
            // 百度地图API功能
            var ak = "s17UeM0d7jGd5SYRblDPbStXsGKuw5Kp";
            var map = new BMap.Map("allmap");
            var gc = new BMap.Geocoder();
            function myFun(result){
                console.log(result);
                $("#longitude").val(result.center.lng);
                $("#latitude").val(result.center.lat);
                $.ajax({
                    type:"get",
                    url: "http://api.map.baidu.com/geocoder/v2/",
                    data: {
                        location: result.center.lat + "," + result.center.lng,
                        output: "json",
                        pois: 1,
                        ak: ak
                    },
                    dataType:"jsonp",    //跨域json请求一定是jsonp
                    success: function (data){
                        if (data.status == 0) {
                            $("#currentAddress").html(data.result.formatted_address);
                            //mui.toast("定位成功!");
                        }else {
                            mui.toast("定位失败!");
                        }
                        console.log(data);
                    }
                });

            }
            var myCity = new BMap.LocalCity();
            myCity.get(myFun);
        }

        if (BJW.isWeiXin()){
            $("#searchBar").show();
        }
        else {
            //不是微信--隐藏
            $("#searchBar").hide();
            $(".mui-content").css("paddingBottom", "0");
        }

        var swiper = new Swiper('.swiper-container', {
            pagination: '.swiper-pagination',
            paginationClickable: true,
            centeredSlides: true,
            autoplay: 3000,
            loop: true,
            autoplayDisableOnInteraction: false
        });

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
            setTimeout(function () {
                BJW.closeDialogLoading();//关闭弹窗loading
            }, 500);
        }
        var pageNo1 = 0;
        /**
         * 上拉加载具体业务实现
         */
        function pullupRefresh() {
            $(".mui-pull").show();
            var html = getOrderList(++pageNo1, 10);
            mui('#pullrefresh').pullRefresh().scrollToBottom();
            setTimeout(function() {
                if (html == "") {
                    mui('#pullrefresh').pullRefresh().endPullupToRefresh((true)); //参数为true代表没有更多数据了。
                    $(".mui-pull-caption-nomore").html("没有更多数据了.");
                    pageNo1-- ;
                }
                else {
                    mui('#pullrefresh').pullRefresh().endPullupToRefresh((false));
                    $(".mui-table-view").append(html);
                }

                /*if (pageNo1 == 0 && html == "") {
                    BJW.closeDialogLoading();//关闭弹窗loading
                }
                else if (pageNo1 == 1 && html != "") {
                    BJW.closeDialogLoading();//关闭弹窗loading
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

        (function($) {
            //阻尼系数
            var deceleration = mui.os.ios?0.003:0.0009;
            $('.mui-scroll-wrapper').scroll({
                bounce: false,
                indicators: false, //是否显示滚动条
                deceleration:deceleration
            });
        })(mui);

        //获取精品生活
        function getOrderList(pageNO, pageSize){
            console.debug("传入的页码：" + pageNO);
            var arr = {
                pageNO : pageNO,
                pageSize : pageSize
            }
            var html = "";
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/news/queryNews', arr, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    html = bindData(result.data);
                }
            });
            return html;
        }

        //拼装数据
        function bindData(jsonData){
            var html = "";
            for (var i = 0; i < jsonData.length; i++) {
                var iHtml = "";
                for (var j = 0; j < jsonData[i].recommendationIndex; j++) {
                    iHtml += "<i class=\"mui-icon mui-icon-star-filled\"></i>";
                }
                html += "<li class=\"mui-table-view-cell mui-media\">" +
                        "<a href='javascript:newsDetail(" + jsonData[i].id + ")'>" +
                                "<div class=\"item-border\">" +
                                        "<img class=\"mui-media-object mui-pull-left index-item-logo\" src=\"" + BJW.ip + "/" + jsonData[i].icon + "\">" +
                                        "<div class=\"mui-media-body\">" +
                                            "<p class='mui-ellipsis index-item-text'>" + jsonData[i].title + "</p>" +
                                            "<p>" +
                                                "<span class=\"index-item-lable\">推荐指数:" +
                                                iHtml +
                                                "</span>" +
                                            "</p>" +
                                        "</div>" +
                                "</div>" +
                            "<div class=\"index-item-img\">" +
                                "<img src=\"" + BJW.ip + "/" + jsonData[i].img + "\">" +
                            "</div>" +
                        "</a></li>";
            }
            return html;
        }


        //跳转详情链接
        function newsDetail(newsId) {
            location.href = BJW.ip + "/app/page/news?isOpen=1&newsId=" + newsId;
        }

        // 监听tap事件，解决 a标签 不能跳转页面问题
        mui('body').on('tap','a',function(){document.location.href=this.href;});

    </script>
</body>

</html>