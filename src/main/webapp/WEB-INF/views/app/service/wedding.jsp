<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>婚庆预约</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/service/wedding.css" charset="UTF-8">
    <style>

    </style>

</head>

<body>
<!--下拉刷新容器-->
<div id="pullrefresh" class="mui-content mui-scroll-wrapper">
    <div class="mui-scroll">
        <!--数据列表-->
        <div class="mui-table-view mui-table-view-chevron" id="content">

        </div>
    </div>
</div>


    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

    <script type="text/javascript">

        $("body").append(BJW.dialogLoading("正在加载"));//弹窗loading

        //获取登录用户token
        var userToken = BJW.getLocalStorageToken();

        var html = getDataList(1, 10);
        if (html == null) {
            $("#content").html("<div class='notData'>没有更多商品信息.</div>");
        }
        else {
            $("#content").html(html);
        }

        //获取列表
        function getDataList(pageNO, pageSize) {
            console.debug("传入的页码：" + pageNO);
            var arr = {
                pageNO : pageNO,
                pageSize : pageSize,
                foodCategoryId: BJW.foodCategoryId.wedding
            }
            var html = "";
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/food/queryByCategory', arr, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    html = bindData(result.data);
                }
            });
            return html;
        }

        //封装数据
        function bindData(jsonData){
            var html = "";
            if(jsonData.length  == 0){
                html = "";
            }
            else{
                for (var i=0; i<jsonData.length; i++){
                    var obj = jsonData[i];
                    var img = BJW.ip+"/"+obj.coverImg;
                    var start = "";
                    for (var j=0; j < obj.recommendationIndex; j++ ){
                        start += '<i class="mui-icon mui-icon-star-filled"></i>';
                    }
                    html += '<div class="wedding">'+
                            '<a href="javascript:weddingDetail(' + jsonData[i].id + ')" >'+
                                '<img src="'+img+'">'+
                                '<div class="title-bar">'+
                                '<div class="title">'+obj.name+'</div>'+
                                '<div class="index-mark">推荐指数:'+start+'</div>'+
                                '<div class="money-bar">'+
                                '<span class="price">'+
                                ''+obj.price+''+
                                '</span>'+
                                '<span>/场</span>'+
                                '</div>'+
                                '</div>'+
                                '</a>'+
                            '</div>';
                }
            }
            return html;
        }

        //详情
        function weddingDetail(foodId) {
            localStorage.setItem("weddingFoodId", foodId);
            location.href = BJW.ip + "/app/page/weddingDetail?isOpen=4";
        }

        // 监听tap事件，解决 a标签 不能跳转页面问题
        mui("body").on('tap','a',function(){document.location.href=this.href;});

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
        var count = 1;
        /**
         * 上拉加载具体业务实现
         */
        function pullupRefresh() {
            $(".mui-pull").show();
            var html = getDataList(++count, 10);
            setTimeout(function() {
                if (html == "") {
                    mui('#pullrefresh').pullRefresh().endPullupToRefresh((true)); //参数为true代表没有更多数据了。
                    //<div class='notData'>没有更多商品信息</div>
                    count-- ;
                }
                else {
                    mui('#pullrefresh').pullRefresh().endPullupToRefresh((false));
                    $("#content").append(html);
                }
                if (count == 0 && html == "") {
                    BJW.closeDialogLoading();//关闭弹窗loading
                }
                else if (count == 1 && html != "") {
                    BJW.closeDialogLoading();//关闭弹窗loading
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

    </script>
</body>

</html>