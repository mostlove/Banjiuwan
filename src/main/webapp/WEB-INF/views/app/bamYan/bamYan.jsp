<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>坝坝宴</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/card.css" charset="UTF-8">
    <style>

        /*.mui-content, body, html{
            background: #FF5B3D;
        }*/

    </style>

</head>

<body>

<div class="mui-content">
    <!-- Swiper -->
    <div class="swiper-container">
        <div class="swiper-wrapper" id="swiperSlide">

            <div class="loadingCar">
                <div class="mui-loading">
                    <div class="mui-spinner">
                    </div>
                </div>
            </div>

        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
    </div>
</div>




    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

    <script type="text/javascript">

        $("body").append(BJW.dialogLoading("正在加载"));//弹窗loading

        //获取登录用户token
        var userToken = BJW.getLocalStorageToken();
        console.log("token:" + userToken);

        initData();
        function initData() {
            var arr = {
                foodCategoryId : BJW.foodCategoryId.bamYan
            }
            var html = "";
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/food/queryByCategory', arr, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    html = bindData(result.data);
                }
            });
            $("#swiperSlide").html(html);
        }

        //装载数据
        function bindData(jsonData) {
            var html = "";
            for (var i = 0; i < jsonData.length; i++) {
                html += "<div class=\"swiper-slide\">" +
                            "<img onclick=\"cardDetail(" + jsonData[i].id + ")\" src=\""+ BJW.ip + "/" + jsonData[i].topBanner +"\">" +
                        "</div>";
                /*var recommendationIndexHtml = "";
                for (var j = 0; j < jsonData[i].recommendationIndex; j++) {
                    recommendationIndexHtml += "<i class=\"mui-icon mui-icon-star-filled\"></i>";
                }
                html += "<div class=\"swiper-slide\">" +
                        "<a href=\"javascript:cardDetail(" + jsonData[i].id + ")\">" +
                        "<img src=\""+ BJW.ip + "/" + jsonData[i].topBanner +"\">" +
                        "<div class=\"title\">" + jsonData[i].name + "</div>" +
                        "<div class=\"context\">" + jsonData[i].introduction + "</div>" +
                        "<div class=\"sales\">总销<span>" + jsonData[i].sales + "</span>" + jsonData[i].units + "</div>" +
                        "<div class=\"money-bottom\">" +
                        "<div class=\"money\">￥" + jsonData[i].price + "<span class=\"zhuo\">/" + jsonData[i].units + "</span></div>" +
                        "<div class=\"indexMark\">" +
                        "<span class=\"index-item-lable\">推荐指数:" + recommendationIndexHtml + "</span>" +
                        "</div>" +
                        "</div>" +
                        "</a>" +
                        "</div>";*/
            }
            return html;
        }

        //详情
        function cardDetail (foodId) {
            localStorage.setItem("foodBamId", foodId);
            location.href = BJW.ip + "/app/page/bamYanDetail?isOpen=4&foodId=" + foodId;
        }

        var swiper = new Swiper('.swiper-container', {
            pagination: '.swiper-pagination',
            paginationType: 'fraction',
            effect: 'coverflow',
            grabCursor: true,
            centeredSlides: true,
            slidesPerView: 'auto',
            paginationClickable: true,
            coverflow: {
                rotate: 50,
                stretch: 0,
                depth: 100,
                modifier: 1,
                slideShadows : true
            }
        });

        setTimeout(function (){
            BJW.closeDialogLoading();//关闭弹窗loading
        },500);

    </script>
</body>

</html>