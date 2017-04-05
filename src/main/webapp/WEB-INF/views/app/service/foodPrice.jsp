<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>实时菜价</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/service/foodPrice.css" charset="UTF-8">
    <style>
        .mui-plus header.mui-bar {
            display: none!important;
        }
        .mui-plus .mui-bar-nav~.mui-content {
            padding: 0!important;
        }

        .mui-plus .plus{
            display: inline;
        }

        .plus{
            display: none;
        }

        #topPopover {
            position: absolute;
            top: 16px;
            right: 6px;
        }
        #topPopover .mui-popover-arrow {
            left: auto;
            right: 6px;
        }
        p {
            text-indent: 22px;
        }
        span.mui-icon {
            font-size: 14px;
            color: #007aff;
            margin-left: -15px;
            padding-right: 10px;
        }
        .mui-popover {
            min-height: 260px;
        }
    </style>

</head>

<body>
    <div class="mui-content">

        <!-- Swiper -->
        <div class="swiper-container">
            <div class="swiper-wrapper" id="swiperSlide">
            </div>
            <!-- Add Pagination -->
            <div class="swiper-pagination"></div>
        </div>

        <div class="search-bar">
            <div class="mui-row">
                <div class="mui-col-xs-4 mui-col-sm-4 padding-left15">
                    <a id="topPopoverBtn1" class="mui-btn search-btn">点击选择</a>
                    <div class="search-popup" id="topPopover1">
                        <div class="searchDiv">
                            <ul class="searchUl">
                                <li><a onclick="selectMarket(this)">芽米菜市</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="mui-col-xs-4 mui-col-sm-4 padding-left15">
                    <a id="topPopoverBtn2" class="mui-btn search-btn">点击选择</a>
                    <div class="search-popup" id="topPopover2">
                        <div class="searchDiv">
                            <ul class="searchUl" id="selectVegetables">
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="mui-col-xs-4 mui-col-sm-4 padding-left15">
                    <a id="topPopoverBtn3" class="mui-btn search-btn">点击选择</a>
                    <div class="search-popup" id="topPopover3">
                        <div class="searchDiv">
                            <ul class="searchUl" id="selectTime">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="food-bar">
            <table class="food-table">
                <thead>
                    <tr>
                        <td>菜名</td>
                        <td>规格</td>
                        <td>价格</td>
                    </tr>
                </thead>
                <tbody id="foodList">

                </tbody>
            </table>
        </div>

    </div>


    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

    <script type="text/javascript">
        mui.init({
            swipeBack: true //启用右滑关闭功能
        });

        var userToken = BJW.getLocalStorageToken(); //获取本地存储token

        initData();

        function initData(){

            //获取轮播图
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/homeBanner/getBanner', {flag : 3}, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    var html = "";
                    for (var i = 0; i < result.data.length; i++) {
                        html += "<div class=\"swiper-slide\">" +
                            "<a href=\"#\" title=\"" + result.data[i].title + "\" content='" + result.data[i].content + "'>" +
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
            //初始化列表
            var timestamp = Date.parse(new Date());
            timestamp = timestamp / 1000;
            console.log("当前时间戳为：" + timestamp);
            getData(1,timestamp);
            //搜索条件--所有蔬菜
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/vegetablesPrice/getVegetablesHouse', {}, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    var html = "";
                    for (var i = 0; i < result.data.length; i++) {
                        html += "<li><a onclick=\"selectDish(this)\" dishId=\"" + result.data[i].id + "\">" + result.data[i].dishName + "</a></li>";
                    }
                    if (html == "") {
                        $("#selectVegetables").html("暂无.");
                    }
                    else {
                        $("#selectVegetables").html(html);
                    }
                }else {
                    mui.toast(result.msg);
                }
            });

            //搜索条件--初始化时间
            var html = "";
            for (var i = 0; i < 7; i++) {
                var mydate = new Date();
                var str = "" + mydate.getFullYear() + "-";
                str += (mydate.getMonth() + 1) + "-";
                str += (mydate.getDate() - i);
                if (i == 0) {
                    html += "<li><a class=\"active-food\" onclick=\"selectTime(this)\" time=\"" + str + "\">" + str + "</a></li>";
                    $("#topPopoverBtn3").html(str);
                }
                else {
                    html += "<li><a onclick=\"selectTime(this)\" time=\"" + str + "\">" + str + "</a></li>";
                }
            }
            $("#selectTime").html(html);

        }

        function getData(vegetablesId, time) {
            console.log(time);
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/vegetablesPrice/getVegetablesPrice', {vegetablesId : vegetablesId,time : time}, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    var html = "";
                    for (var i = 0; i < result.data.length; i++) {
                        html += "<tr>" +
                                "<td>"+result.data[i].dishName+"</td>" +
                                "<td>"+result.data[i].units+"</td>" +
                                "<td><span class=\"food-price\">￥"+result.data[i].price+"</span></td>" +
                                "</tr>";
                    }
                    if (html == "") {
                        $("#foodList").html("<tr><td colspan='3' class='notData'>没有最新菜价,换一天试试。</td></tr>");
                    }
                    else {
                        $("#foodList").html(html);
                    }
                }
                else {
                    mui.toast(result.msg);
                }
            });
        }

        var selectId = 0; // 蔬菜ID
        function selectDish(obj) {
            //添加选中样式--选择蔬菜
            $(obj).parent().parent().find("a").removeClass("active-food");
            $(obj).addClass("active-food");
            selectId = $(obj).attr("dishId") == undefined ? null : $(obj).attr("dishId");
            $("#topPopoverBtn2").html($(obj).html());
            $('#topPopover2').slideToggle(300);
            var time = $("#topPopoverBtn3").html();  //时间
            time = BJW.getTimeStamp(time) / 1000;
            getData(selectId, time == "" ? null : time);
        }
        //添加选中样式--选择时间
        function selectTime(obj) {
            $(obj).parent().parent().find("a").removeClass("active-food");
            $(obj).addClass("active-food");
            var time = $(obj).attr("time") == undefined ? null : $(obj).attr("time");
            $("#topPopoverBtn3").html($(obj).html());
            $('#topPopover3').slideToggle(300);
            time = BJW.getTimeStamp(time) / 1000;
            getData(selectId == 0 ? null : selectId, time);
        }
        //选择芽头菜市
        function selectMarket (obj) {
            $(obj).parent().parent().find("a").removeClass("active-food");
            $(obj).addClass("active-food");
            $("#topPopoverBtn1").html($(obj).html());
        }

        var swiper = new Swiper('.swiper-container', {
            pagination: '.swiper-pagination',
            paginationClickable: true,
            centeredSlides: true,
            autoplay: 3000,
            loop: true,
            autoplayDisableOnInteraction: false
        });

        $(function () {
            $('#topPopoverBtn1').on("click", function (event) {
                $('#topPopover1').slideToggle(300);
                $('#topPopover2').slideUp(300);
                $('#topPopover3').slideUp(300);
                event.stopPropagation();
            });
            $('#topPopoverBtn2').on("click", function (event) {
                $('#topPopover2').slideToggle(300);
                $('#topPopover1').slideUp(300);
                $('#topPopover3').slideUp(300);
                event.stopPropagation();
            });
            $('#topPopoverBtn3').on("click", function (event) {
                $('#topPopover3').slideToggle(300);
                $('#topPopover1').slideUp(300);
                $('#topPopover2').slideUp(300);
                event.stopPropagation();
            });
        });
        //点击body关闭弹出
        $('html').on('click', function(){
            $('#topPopover1').slideUp(300);
            $('#topPopover2').slideUp(300);
            $('#topPopover3').slideUp(300);
        });

    </script>
</body>

</html>