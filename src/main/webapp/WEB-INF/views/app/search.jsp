<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>搜索</title>
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/search.css" charset="UTF-8">
    <style>

    </style>

</head>

<body>

    <header id="header" class="mui-bar mui-bar-nav">
        <div id="searchBar" class="search-bar">
            <div class="mui-row">
                <div class="mui-col-xs-10 mui-col-sm-11 timeWidthLeft">
                    <input type="text" class="mui-input-clear mui-input" id="searchInput" placeholder="请输入食材或菜品">
                    <i class="mui-icon mui-icon-search"></i>
                </div>
                <div class="mui-col-xs-2 mui-col-sm-1 timeWidthRight" style="text-align: right">
                    <a id="cancelBtn" class="cancel-btn">取消</a>
                    <a id="confirmBtn" class="cancel-btn hide">确认</a>
                </div>
            </div>
        </div>
    </header>

    <!-- 搜索历史记录 -->
    <div class="history-div" id="history">
        <div class="his-title">搜索记录</div>
        <ul class="mui-table-view" id="historyList">

        </ul>
        <div class="empty-div hide" onclick="clearHistory()">清空历史搜索</div>
    </div>

    <!--下拉刷新容器-->
    <div id="pullrefresh" class="mui-content">
        <div class="">
            <ul class="mui-table-view hide" id="foodList">

            </ul>
        </div>

        <div id="loadingData">
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
        </div>
    </div>



    <!--引入抽取js文件-->
    <%@include file="common/public-js.jsp" %>

    <!--引入购物车弹窗-->
    <div class="hide">
        <%@include file="common/car-popupAngular.jsp" %>
    </div>

    <script type="text/javascript">

        //获取登录用户token
        var userToken = localStorage.getItem('userToken');
        console.log("token:" + userToken);

        getHistoryList();
        //获取历史记录
        function getHistoryList() {
            var historyList = localStorage.getItem("historyList");
            var html = "";
            if (historyList != null) {
                $(".empty-div").show();
                var obj = historyList.split(",");//字符串转化为数组
                for (var i = 0; i < obj.length; i++){
                    html += "<li class=\"mui-table-view-cell\" onclick=\"selectHistory('" + obj[i] + "')\">" + obj[i] + "</li>";
                }
            }
            else {
                html = "<div class='notData'>暂无搜索.</div>";
                $(".empty-div").hide();
            }
            $("#historyList").html(html);
        }

        //清空历史记录
        function clearHistory () {
            localStorage.removeItem("historyList");
            getHistoryList();
        }

        $(function (){
            $("#searchInput").click(function () {
                getHistoryList();
                $("#history").slideDown();
            });
            $("#cancelBtn").click(function () {
                //window.history.go(-1);
                $("#history").slideUp();
            });
            $('#searchInput').bind('input propertychange', function() {
                if ($('#searchInput').val().trim().length < 1) {
                    $("#cancelBtn").show();
                    $("#confirmBtn").hide();
                }
                else {
                    $("#confirmBtn").show();
                    $("#cancelBtn").hide();
                }
            });
            //确认
            $("#confirmBtn").click(function () {
                var foodName = $("#searchInput").val().trim();
                searchFood(foodName);

                //存入本地历史记录
                var historyList = localStorage.getItem("historyList");
                var arrayHistoryList = new Array();
                arrayHistoryList.push(foodName);
                if (historyList != null) {
                    arrayHistoryList.push(historyList);
                }
                console.log(arrayHistoryList);
                localStorage.setItem("historyList", arrayHistoryList);
            });
        });

        //选择历史搜索
        function selectHistory(foodName){
            $('#searchInput').val(foodName);
            searchFood(foodName);
        }

        function searchFood (foodName) {
            $("body").append(BJW.uploadDialogLoading("正在加载"));//弹窗loading
            var html = getFoodList(foodName, 1, 10);
            if (html == "") {
                $("#foodList").html("<div class='notData'>暂无该商品.</div>");
            }
            else {
                $("#foodList").html(html);
            }
            setTimeout(function () {
                BJW.closeUploadDialogLoading();//关闭弹窗loading
            }, 500);
            $("#foodList").show();
            $("#history").slideUp();
        }

        //获取数据
        function getFoodList (foodName, pageNO, pageSize) {
            console.debug("传入的页码：" + pageNO);
            var arr = {
                foodName : foodName,
                pageNO : pageNO,
                pageSize : pageSize
            }
            var html = "";
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/food/searchFood', arr, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    html = bindData(result.data);
                }
            });
            return html;
        }

        //绑定数据
        function bindData (jsonData){
            var html = "";
            for (var i = 0; i < jsonData.length; i++) {
                var recommendationIndex = "";
                for (var j = 0; j < jsonData[i].recommendationIndex; j++) {
                    recommendationIndex += "<i class=\"mui-icon mui-icon-star-filled\"></i>";
                }
                var number = jsonData[i].countNumber == null ? 0 : jsonData[i].countNumber;
                html += "<li>" +
                            "<div class=\"commodity-item\">" +
                                "<a onclick=\"cookbookDetail(" + jsonData[i].id + ", " + jsonData[i].foodCategoryId + ")\">" +
                                    "<img src=\"" + BJW.ip + "/" + jsonData[i].coverImg + "\">" +
                                "</a>" +
                                "<div class=\"commodity-info\">" +
                                    "<p class=\"commodity-row\">" +
                                        "<span class=\"commodity-name\">" + jsonData[i].foodName + "</span>" +
                                        "<span class=\"commodity-price\">￥" + jsonData[i].price + "<span>/" + jsonData[i].units + "</span></span>" +
                                    "</p>" +
                                    "<p class=\"commodity-row\">" +
                                        "<span class=\"commodity-sales\">总销" + jsonData[i].sales + "份</span>" +
                                    "</p>" +
                                    "<p class=\"commodity-row\">" +
                                        "<span class=\"commodity-index-mark\">推荐指数:" +
                                            recommendationIndex +
                                        "</span>" +
                                        "<div class=\"addBtnBox\">" +
                                            "<button class=\"addOrReduceBtn\" onclick=\"reduceCar(this)\" foodId=\"" + jsonData[i].id + "\" foodCategoryId=\"" + jsonData[i].foodCategoryId + "\" price=\"" + jsonData[i].price + "\">-</button>" +
                                            "<input class=\"boxInput\" type=\"number\" value=\"" + number + "\" readonly id=\"boxInput\">" +
                                            "<button class=\"addOrReduceBtn\" onclick=\"addCart(event, this)\" foodId=\"" + jsonData[i].id + "\" foodCategoryId=\"" + jsonData[i].foodCategoryId + "\" price=\"" + jsonData[i].price + "\">+</button>" +
                                        "</div>" +
                                    "</p>" +
                                "</div>" +
                            "</div>" +
                        "</li>";
            }
            return html;
        }

        //详情
        function cookbookDetail(foodId, foodCategoryId){
            localStorage.setItem("cookbookId", foodId);
            localStorage.setItem("foodCategoryId", foodCategoryId);
            window.location.href = BJW.ip + "/app/page/cookbookDetail?isOpen=4";
        }

        //购物车加
        function addCart(event, obj) {
            var foodId = $(obj).attr("foodId");
            var foodCategoryId = $(obj).attr("foodCategoryId");
            var price = $(obj).attr("price");
            addOrReduceShopCar(null, obj, 1, foodId, foodCategoryId, null, null, null, price, BJW.ip + "/app/page/search?isOpen=1");
        }

        //购物车减
        function reduceCar(obj){
            var foodId = $(obj).attr("foodId");
            var foodCategoryId = $(obj).attr("foodCategoryId");
            var price = $(obj).attr("price");
            addOrReduceShopCar(null, obj, 0, foodId, foodCategoryId, null, null, null, price, BJW.ip + "/app/page/search?isOpen=1");
        }

        //加载数据
        var pageNo1 = 1;
        function insertcode() {
            var html = getFoodList($("#searchInput").val().trim(), ++pageNo1, 10);
            console.log(html);
            if (html == "") {
                mui.toast("没有更多数据了.");
                pageNo1-- ;
            }
            $("#foodList").append(html);
            $("#loadingData").fadeOut();
        }
        $(document).ready(function () {
            $(window).scroll(function () {
                $("#loadingData").fadeIn();
                var $body = $("body");
                /*判断窗体高度与竖向滚动位移大小相加 是否 超过内容页高度*/
                if (($(window).height() + $(window).scrollTop()) >= $body.height()) {
                    setTimeout(insertcode, 1500);/*IE 不支持*/
                }
            });
        });

       /* (function($) {
            //阻尼系数
            var deceleration = mui.os.ios?0.003:0.0009;
            $('.mui-scroll-wrapper').scroll({
                bounce: false,
                indicators: true, //是否显示滚动条
                deceleration:deceleration
            });
        })(mui);*/

        /*mui.init({
            swipeBack: true, //启用右滑关闭功能
            pullRefresh: {
                container: '#pullrefresh',
                down: {
                    callback: pulldownRefresh
                },
                up: {
                    callback: pullupRefresh
                }
            }
        });
        /!**
         * 下拉刷新具体业务实现
         *!/
        function pulldownRefresh() {
            setTimeout(function() {
                mui('#pullrefresh').pullRefresh().endPulldownToRefresh(); //refresh completed
                console.log("下拉刷新了...");
            }, 1500);
        }
        var count = 1;
        /!**
         * 上拉加载具体业务实现
         *!/
        function pullupRefresh() {
            if ($("#searchInput").val().trim().length > 0) {
                var html = getFoodList($("#searchInput").val().trim(), ++count, 10);
                setTimeout(function() {
                    if (html == "") {
                        mui('#pullrefresh').pullRefresh().endPullupToRefresh((true)); //参数为true代表没有更多数据了。
                        count-- ;
                    }
                    else {
                        mui('#pullrefresh').pullRefresh().endPullupToRefresh((false));
                        $("#foodList").append(html);
                    }
                }, 1500);
            }
            else {
                mui('#pullrefresh').pullRefresh().endPullupToRefresh();
            }
        }
        if (mui.os.plus) {
            mui.plusReady(function() {
                setTimeout(function() {
                    mui('#pullrefresh').pullRefresh().pullupLoading();
                }, 1000);

            });
        } else {
            mui.ready(function() {
                mui('#pullrefresh').pullRefresh().pullupLoading();
            });
        }*/
    </script>
</body>

</html>