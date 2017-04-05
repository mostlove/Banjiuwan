<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>菜谱</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/cookbook/cookbook.css" charset="UTF-8">
    <style>


    </style>

</head>

<body>
    <header class="mui-bar mui-bar-nav">
        <div class="mui-row">
            <div class="mui-col-xs-3">
                <div class="classify">
                    <span class="dian"></span>
                    <span class="dian"></span>
                    <span class="dian"></span>
                    <span class="className">分类</span>
                </div>
            </div>
            <div class="mui-col-xs-9" style="border-left: 1px solid #eee;">
                <div class="classify-title" id="titleOrIcon">
                    <img>
                    <span></span>
                </div>
            </div>
        </div>
    </header>
    <div class="mui-content mui-row mui-fullscreen">
        <div class="mui-col-xs-3 overflow">
            <div id="segmentedControls" class="mui-segmented-control mui-segmented-control-inverted mui-segmented-control-vertical">

            </div>
        </div>
        <div id="segmentedControlContents" class="mui-col-xs-9 overflow" style="border-left: 1px solid #eee;">

        </div>
    </div>


    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>
    <script src="<%=request.getContextPath()%>/appResources/js/common/jquery.lazyload.min.js"></script>

    <!--引入购物车弹窗-->
    <%@include file="../common/car-popupAngular.jsp" %>

    <script type="text/javascript">

        var scrollTopWine = 0; //存放酒水类型滚动位置

        $("body").append(BJW.dialogLoading("正在加载"));//弹窗loading

        //获取登录用户token
        var userToken = localStorage.getItem('userToken');
        console.log("token:" + userToken);

        var controls = document.getElementById("segmentedControls"); //左侧菜单栏
        var contents = document.getElementById("segmentedControlContents"); //右侧内容栏
        var html = [];

        //获取左侧菜单
        var leftMenuList = null;//存放左侧菜单列表
        BJW.ajaxRequestData("get", false, BJW.ip+'/app/food/querySingleFoodCategory', {}, userToken , function(result){
            if(result.flag == 0 && result.code == 200){
                leftMenuList = result.data;
                var leftHtml = "";
                for (var i = 0; i < leftMenuList.length; i++) {
                    if (leftMenuList[i].id == 8) {
                        leftHtml += "<div id=\"firstIcon_" + i + "\" class=\"mui-control-item mui-control-item-myWine\" data-index=\"" + (i) + "\">" +
                                        "<div class=\"cookbook-menu\">" +
                                            "<div class=\"cookbook-menu-item\">" +
                                                "<img class=\"iconImg\" selectedIcon=\"" + leftMenuList[i].selectedIcon + "\" icon=\"" + leftMenuList[i].icon + "\" categoryName=\"" + leftMenuList[i].categoryName + "\" src=\"" + BJW.ip + "/" + leftMenuList[i].icon + "\">" +
                                                "<span class=\"cookbook-menu-name\">" + leftMenuList[i].categoryName + "</span>" +
                                            "</div>" +
                                        "</div>" +
                                    "</div>";
                    }
                    else {
                         leftHtml += "<div id=\"firstIcon_" + i + "\" class=\"mui-control-item\" data-index=\"" + (i) + "\">" +
                                        "<div class=\"cookbook-menu\">" +
                                            "<div class=\"cookbook-menu-item\">" +
                                                "<img class=\"iconImg\" selectedIcon=\"" + leftMenuList[i].selectedIcon + "\" icon=\"" + leftMenuList[i].icon + "\" categoryName=\"" + leftMenuList[i].categoryName + "\" src=\"" + BJW.ip + "/" + leftMenuList[i].icon + "\">" +
                                                "<span class=\"cookbook-menu-name\">" + leftMenuList[i].categoryName + "</span>" +
                                            "</div>" +
                                        "</div>" +
                                    "</div>";
                    }

                }
                controls.innerHTML = leftHtml;
            }
        });

        //获取菜品
        html = [];
        var goodsHtml = "";
        var a = 0;
        for (var i = 0; i < leftMenuList.length; i++) {
            //通过类型ID获取菜品
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/food/queryByCategory', {foodCategoryId : leftMenuList[i].id}, userToken , function(result){
                if(result.flag == 0 && result.code == 200){
                    if (leftMenuList[i].id == 8) {
                        var wine = "";
                        if (a == 0) {
                            wine = "id=\"scrollTopWine\"";
                        }
                        a++;
                        goodsHtml += "<div id=\"content" + i + "\" class=\"mui-control-content mui-control-content-myWine\">";
                        for (var k = 0; k < result.data.length; k++) {
                            var indexHtml = "";
                            for (var j = 0; j < result.data[k].recommendationIndex; j++) {
                                indexHtml += "<i class=\"mui-icon mui-icon-star-filled\"></i>";
                            }
                            var img = result.data[k].coverImg;
                            var imgs = img.split(".");
                            img =  imgs[0]+"_thumbnail."+imgs[1];
                            var number = result.data[k].countNumber == null ? 0 : result.data[k].countNumber;
                            goodsHtml += "<div " + wine + " class=\"commodity-item\"><a class=\"parentId\" foodCategoryId=\"" + result.data[k].foodCategoryId + "\">" +
                                    "<img onclick=\"cookbookDetail(" + result.data[k].id + "," + result.data[k].foodCategoryId + ")\" class=\"lazy\" data-original=\"" + BJW.ip + "/" + result.data[k].coverImg + "\"></a><p class=\"commodity-row\"><span class=\"commodity-name\">" + result.data[k].foodName + "</span>" +
                                    "<span class=\"commodity-price\">￥" + result.data[k].promotionPrice + "<span>/" + result.data[k].units + "</span></span></p><p class=\"commodity-row\">" +
                                    "<span class=\"commodity-sales\">总销" + result.data[k].sales + "份</span></p><p class=\"commodity-row\"><span class=\"commodity-index-mark\">推荐指数:" +
                                    indexHtml +
                                    "</span><div class=\"addBtnBox\">" +
                                    "<button class=\"addOrReduceBtn\" type=\"button\" onclick='reduceCar(this, " + result.data[k].id + ", " + result.data[k].foodCategoryId + ", " + result.data[k].promotionPrice + ")'>-</button>" +
                                    "<input class=\"boxInput\" type=\"number\" readonly value='" + number + "' inputFood=\"inputFood_" + result.data[k].id + "\"/>" +
                                    "<button class=\"addOrReduceBtn\" type=\"button\" onclick='addCart(event, this, " + result.data[k].id + ", " + result.data[k].foodCategoryId + ", " + result.data[k].promotionPrice + ")'>+</button></div></p></div>";
                        }
                        goodsHtml += "</div>";
                    }
                    else {
                        goodsHtml += "<div id=\"content" + i + "\" class=\"mui-control-content\">";
                        for (var k = 0; k < result.data.length; k++) {
                            var indexHtml = "";
                            for (var j = 0; j < result.data[k].recommendationIndex; j++) {
                                indexHtml += "<i class=\"mui-icon mui-icon-star-filled\"></i>";
                            }
                            var number = result.data[k].countNumber == null ? 0 : result.data[k].countNumber;
                            var img = result.data[k].coverImg;
                            var imgs = img.split(".");
                            img =  imgs[0]+"_thumbnail."+imgs[1];
                            goodsHtml += "<div class=\"commodity-item\"><a class=\"parentId\" foodCategoryId=\"" + result.data[k].foodCategoryId + "\">" +
                                    "<img onclick=\"cookbookDetail(" + result.data[k].id +"," + result.data[k].foodCategoryId + ")\" class=\"lazy\" data-original=\"" + BJW.ip + "/" + img + "\"></a><p class=\"commodity-row\"><span class=\"commodity-name\">" + result.data[k].foodName + "</span>" +
                                    "<span class=\"commodity-price\">￥" + result.data[k].promotionPrice + "<span>/" + result.data[k].units + "</span></span></p><p class=\"commodity-row\">" +
                                    "<span class=\"commodity-sales\">总销" + result.data[k].sales + "份</span></p><p class=\"commodity-row\"><span class=\"commodity-index-mark\">推荐指数:" +
                                    indexHtml +
                                    "</span><div class=\"addBtnBox\">" +
                                    "<button class=\"addOrReduceBtn\" type=\"button\" onclick='reduceCar(this, " + result.data[k].id + ", " + result.data[k].foodCategoryId + ", " + result.data[k].promotionPrice + ")'>-</button>" +
                                    "<input class=\"boxInput\" type=\"number\" readonly value='" +  number  + "' inputFood=\"inputFood_" + result.data[k].id + "\"/>" +
                                    "<button class=\"addOrReduceBtn\" type=\"button\" onclick='addCart(event, this, " + result.data[k].id + ", " + result.data[k].foodCategoryId + ", " + result.data[k].promotionPrice + ")'>+</button></div></p></div>";
                        }
                        goodsHtml += "</div>";
                    }
                }
            });
        }
        contents.innerHTML = goodsHtml;

        //--滚动监听逻辑开始
        //默认选中第一个
        console.log(controls);
        //获取url是否是酒水点击
        var type = BJW.getUrlParam("type");
        console.log("type:" + type);
        if (type == 1) {
            controls.querySelector('.mui-control-item-myWine').classList.add('mui-active');
            contents.querySelector('.mui-control-content-myWine').classList.add('mui-active');
            var selectedIcon = $(".mui-control-item-myWine").find("img").attr("selectedIcon");
            var categoryName = $(".mui-control-item-myWine").find("img").attr("categoryName");
            $(".mui-control-item-myWine").find("img").attr("src", BJW.ip + "/" + selectedIcon);
            $("#titleOrIcon img").attr("src", BJW.ip + "/"  + selectedIcon);
            $("#titleOrIcon span").html(categoryName);


            //获取第一个酒水类型的位置
            //alert($("#segmentedControlContents").height());
            if ($("#scrollTopWine").length > 0) {
                scrollTopWine = $("#scrollTopWine").offset().top;
            }
            else {
                var h = $(document).height() - $(window).height();
                scrollTopWine = h;
            }
            console.log(scrollTopWine);
            $(".overflow").scrollTop(scrollTopWine);
        }
        else {
            controls.querySelector('.mui-control-item').classList.add('mui-active');
            $("#titleOrIcon img").attr("src", BJW.ip + "/" + leftMenuList[0].selectedIcon);
            $("#titleOrIcon span").html(leftMenuList[0].categoryName);
            $("#firstIcon_0 img").attr("src", BJW.ip + "/" + leftMenuList[0].selectedIcon);
            contents.querySelector('.mui-control-content').classList.add('mui-active');
        }


        (function() {
            var controlsElem = document.getElementById("segmentedControls");
            var contentsElem = document.getElementById("segmentedControlContents");
            var controlListElem = controlsElem.querySelectorAll('.mui-control-item');
            var contentListElem = contentsElem.querySelectorAll('.mui-control-content');
            var controlWrapperElem = controlsElem.parentNode;
            var controlWrapperHeight = controlWrapperElem.offsetHeight;
            var controlMaxScroll = controlWrapperElem.scrollHeight - controlWrapperHeight;//左侧类别最大可滚动高度
            var maxScroll = contentsElem.scrollHeight - contentsElem.offsetHeight;//右侧内容最大可滚动高度
            var controlHeight = controlListElem[0].offsetHeight;//左侧类别每一项的高度
            var controlTops = []; //存储control的scrollTop值
            var contentTops = [0]; //存储content的scrollTop值
            var length = contentListElem.length;
            for (var i = 0; i < length; i++) {
                controlTops.push(controlListElem[i].offsetTop + controlHeight);
            }
            for (var i = 1; i < length; i++) {
                var offsetTop = contentListElem[i].offsetTop;
                if (offsetTop + 100 >= maxScroll) {
                    var height = Math.max(offsetTop + 100 - maxScroll, 100);
                    var totalHeight = 0;
                    var heights = [];
                    for (var j = i; j < length; j++) {
                        var offsetHeight = contentListElem[j].offsetHeight;
                        totalHeight += offsetHeight;
                        heights.push(totalHeight);
                    }
                    for (var m = 0, len = heights.length; m < len; m++) {
                        contentTops.push(parseInt(maxScroll - (height - heights[m] / totalHeight * height)));
                    }
                    break;
                } else {
                    contentTops.push(parseInt(offsetTop));
                }
            }
            contentsElem.addEventListener('scroll', function() {
                var scrollTop = contentsElem.scrollTop;
                for (var i = 0; i < length; i++) {
                    var offsetTop = contentTops[i];
                    var offset = Math.abs(offsetTop - scrollTop);
                    //console.log("i:"+i+",scrollTop:"+scrollTop+",offsetTop:"+offsetTop+",offset:"+offset);
                    if (scrollTop < offsetTop) {
                        if (scrollTop >= maxScroll) {
                            onScroll(length - 1);
                        } else {
                            onScroll(i - 1);
                        }
                        break;
                    } else if (offset < 20) {
                        onScroll(i);
                        break;
                    }else if(scrollTop >= maxScroll){
                        onScroll(length - 1);
                        break;
                    }
                }
            });
            var lastIndex = 0;
            //监听content滚动
            var onScroll = function(index) {
                if (lastIndex !== index) {
                    lastIndex = index;
                    var lastActiveElem = controlsElem.querySelector('.mui-active');
                    lastActiveElem && (lastActiveElem.classList.remove('mui-active'));
                    var currentElem = controlsElem.querySelector('.mui-control-item:nth-child(' + (index + 1) + ')');
                    currentElem.classList.add('mui-active');
                    //TODO 导致安卓端闪动
                    $(".iconImg").each(function () {
                        var selectIcon = $(this).attr("selectedicon");
                        var src = $(this).attr("src");
                        var index = src.indexOf("upload");
                        var strSrc = src.substring(index,src.length);
                        if (selectIcon === strSrc) {
                            $(this).attr("src", BJW.ip + "/" + $(this).attr("icon"));
                        }
                    });
                    $(currentElem).find("img").attr("src", BJW.ip + "/" + $(currentElem).find("img").attr("selectedIcon"));
                    //标题
                    $("#titleOrIcon img").attr("src", BJW.ip + "/" + $(currentElem).find("img").attr("selectedicon"));
                    $("#titleOrIcon span").html($(currentElem).find("img").attr("categoryName"));

                    //简单处理左侧分类滚动，要么滚动到底，要么滚动到顶
                    var controlScrollTop = controlWrapperElem.scrollTop;
                    if (controlScrollTop + controlWrapperHeight < controlTops[index]) {
                        controlWrapperElem.scrollTop = controlMaxScroll;
                    } else if (controlScrollTop > controlTops[index] - controlHeight) {
                        controlWrapperElem.scrollTop = 0;
                    }
                }
            };
            //滚动到指定content
            var scrollTo = function(index) {
                contentsElem.scrollTop = contentTops[index];
            };
            //单击左侧菜单
            mui(controlsElem).on('tap', '.mui-control-item', function(e) {
                $(".iconImg").each(function () {
                    var selectIcon = $(this).attr("selectedicon");
                    var src = $(this).attr("src");
                    var index = src.indexOf("upload");
                    var strSrc = src.substring(index,src.length);
                    if (selectIcon === strSrc) {
                        $(this).attr("src", BJW.ip + "/" + $(this).attr("icon"));
                    }
                });
                $(this).find("img").attr("src", BJW.ip + "/" + $(this).find("img").attr("selectedIcon"));
                //标题
                $("#titleOrIcon img").attr("src", BJW.ip + "/" + $(this).find("img").attr("selectedicon"));
                $("#titleOrIcon span").html($(this).find("img").attr("categoryName"));
                scrollTo(this.getAttribute('data-index'));
                return false;
            });



        })();


        //详情
        function cookbookDetail(foodId, foodCategoryId){
            localStorage.setItem("cookbookId", foodId);
            localStorage.setItem("foodCategoryId", foodCategoryId);
            window.location.href = BJW.ip + "/app/page/cookbookDetail?isOpen=4";
        }

        //购物车加
        function addCart(event, obj, foodId, foodCategoryId, price) {
            addOrReduceShopCar(event, obj, 1, foodId, foodCategoryId, null, null, null, price, BJW.ip + "/app/page/cookbook?isOpen=1");
        }

        //购物车减
        function reduceCar(obj, foodId, foodCategoryId, price){
            addOrReduceShopCar(null, obj, 0, foodId, foodCategoryId, null, null, null, price, BJW.ip + "/app/page/cookbook?isOpen=1");
        }


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

        $(function () {
            $("img.lazy").lazyload({
                effect: "show",
                container: $("#segmentedControlContents"),
                placeholder: BJW.ip + "/appResources/img/icon/imageLazyload.png"
            });
        });

        setTimeout(function (){
            BJW.closeDialogLoading();//关闭弹窗loading
        },500);
    </script>
</body>

</html>