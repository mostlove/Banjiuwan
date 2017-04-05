<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>晒单评价</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/order/orderEvaluate.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="orderGoodsEvaluateCtr" ng-cloak>
<div class="mui-content">

    <div class="order-bar">
        <ul class="mui-table-view">
            <li class="mui-table-view-cell mui-media" ng-if="serviceFoodPrice == null && orderFood.foodCategoryId != 11 && orderFood.foodId > 4">
                <img class="mui-media-object mui-pull-left goods-img" src="<%=request.getContextPath()%>/{{orderFood.imgUrl}}">
                <div class="mui-media-body">
                    <span class="goods-name">{{orderFood.name}}</span>
                    <p class="goods-p">
                        <span class="goods-price">￥{{orderFood.price}}</span>
                    </p>
                </div>
            </li>
            <li class="mui-table-view-cell mui-media" ng-if="serviceFoodPrice == null && orderFood.foodCategoryId == 11 && orderFood.foodId < 4">
                <span class="mui-media-object mui-pull-left service-money">{{orderFood.name}}</span>
                <div class="mui-media-body" style="text-align: right;">
                    <span class="goods-price">￥{{orderFood.price}}</span>
                </div>
            </li>
            <li class="mui-table-view-cell mui-media" ng-if="serviceFoodPrice != null">
                <span class="mui-media-object mui-pull-left service-money">服务</span>
                <div class="mui-media-body" style="text-align: right;">
                    <span class="goods-price">￥{{serviceFoodPrice}}</span>
                </div>
            </li>
        </ul>
    </div>

    <div class="order-bar">
        <div class="context">
            <div class="mui-row border-bottom">
                <div class="mui-col-xs-4 mui-col-sm-4">
                    <div class="mui-input-row mui-radio mui-left">
                        <label>好评</label>
                        <input name="evaluate" type="radio" checked value="1">
                    </div>
                </div>
                <div class="mui-col-xs-4 mui-col-sm-4">
                    <div class="mui-input-row mui-radio mui-left">
                        <label>中评</label>
                        <input name="evaluate" type="radio" value="2">
                    </div>
                </div>
                <div class="mui-col-xs-4 mui-col-sm-4">
                    <div class="mui-input-row mui-radio mui-left">
                        <label>差评</label>
                        <input name="evaluate" type="radio" value="3">
                    </div>
                </div>
            </div>

            <div class="mui-content-padded" ng-show="serviceFoodPrice == null">
                <div class="mui-inline">菜品评分：</div>
                <div class="icons mui-inline" id="icon1">
                    <i data-index="1" class="mui-icon mui-icon-star"></i>
                    <i data-index="2" class="mui-icon mui-icon-star"></i>
                    <i data-index="3" class="mui-icon mui-icon-star"></i>
                    <i data-index="4" class="mui-icon mui-icon-star"></i>
                    <i data-index="5" class="mui-icon mui-icon-star"></i>
                </div>
            </div>

            <div class="mui-content-padded" ng-show="serviceFoodPrice != null">
                <div class="mui-inline">服务评分：</div>
                <div class="icons mui-inline" id="icon2">
                    <i data-index="1" class="mui-icon mui-icon-star"></i>
                    <i data-index="2" class="mui-icon mui-icon-star"></i>
                    <i data-index="3" class="mui-icon mui-icon-star"></i>
                    <i data-index="4" class="mui-icon mui-icon-star"></i>
                    <i data-index="5" class="mui-icon mui-icon-star"></i>
                </div>
            </div>

            <div class="evaluate-text">
                <div class="mui-row">
                    <div class="mui-col-xs-8 mui-col-sm-8">
                        <textarea id="content" class="textarea" placeholder="请输入评论内容" maxlength="200"></textarea>
                    </div>
                    <div class="mui-col-xs-4 mui-col-sm-4 padding-left15">
                        <button id="uploadBtn" ng-click="onFile()" class="mui-btn upload-btn">
                            <i class="mui-icon mui-icon-camera"></i>
                        </button>
                    </div>
                </div>

                <form id="newUploadForm0" method="post" enctype="multipart/form-data">
                    <div class="imgUpload">
                        <input type="file" id="fileBtn" name="file" accept="image/*" capture="camera" class="hide">
                    </div>
                </form>
            </div>
            <div class="preview-div">
                <div class="mui-row" id="previewImg">

                </div>
            </div>

            <div class="publish">
                <button class="mui-btn mui-btn-danger publish-btn" ng-click="publish()">
                    发表评价
                </button>
            </div>

        </div>
    </div>

</div>





<!--引入抽取js文件-->
<%@include file="../common/public-js.jsp" %>
<script src="<%=request.getContextPath()%>/appResources/js/common/jquery.form.js" type="text/javascript" charset="UTF-8"></script>


<script type="text/javascript">

    $("body").append(BJW.dialogLoading("正在加载"));//弹窗loading

    var starIndex = 0; //存放星级
    var serviceIndex = 0; //存放星级

    var webApp=angular.module('webApp',[]);
    //订单评价
    webApp.controller('orderGoodsEvaluateCtr',function($scope,$http,$timeout){
        //获取登录用户token
        $scope.userToken = BJW.getLocalStorageToken();
        $scope.orderFood = JSON.parse(localStorage.getItem("orderFood"));
        $scope.serviceFoodPrice = JSON.parse(localStorage.getItem("serviceFoodPrice")); //获取对服务评价
        console.log($scope.serviceFoodPrice);
        console.log($scope.orderFood);
        $scope.orderId = localStorage.getItem("orderId");
        console.log("订单ID：" + $scope.orderId);

        //吊起图片
        $scope.onFile = function () {
            //判断ios
            if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {  //判断iPhone|iPad|iPod|iOS
                var isCheck = window.JSBridge.checkAuthority();
                if (!isCheck) {
                    return false;
                }
            }
            $('#fileBtn').click();
        }

        //发表评价
        $scope.publish = function () {
            console.log(starIndex);
            var evaluateLevel = parseInt($("input[name='evaluate']:checked").val());
            console.log("evaluateLevel: " + evaluateLevel);
            var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g; //emoji 表情正则
            if (evaluateLevel == undefined) {
                mui.toast("请选择一个评分等级.");
                return false;
            }
            if ($scope.serviceFoodPrice == null) {
                if (starIndex == 0) {
                    mui.toast("请给菜品打一个分吧.");
                    return false;
                }
            }
            else {
                if (serviceIndex == 0) {
                    mui.toast("请给服务打一个分吧.");
                    return false;
                }
            }
            if ($("#content").val() == "") {
                mui.toast("请输入评价内容.");
                return false;
            }
            if($("#content").val().trim().match(regRule)) {
                mui.toast("评价内容不支持emoji表情.");
                return false;
            }
            var imgs = "";
            $("img[name='imgs']").each(function () {
                imgs += $(this).attr("imgUrl") + ",";
            });
            console.log(imgs);
            imgs = imgs.substring(0, imgs.length-1);

            var packageCaterId = null;
            if ($scope.orderFood != null) {
                if ($scope.orderFood.foodCategoryId == BJW.foodCategoryId.bamYan || $scope.orderFood.foodCategoryId == BJW.foodCategoryId.setMeal) {
                    packageCaterId = $scope.orderFood.foodCategoryId;
                }
            }

            var arr = {
                type : $scope.serviceFoodPrice == null ? 2 : 5, //评价类型
                evaluateLevel : evaluateLevel, //评价等级
                foodScore : $scope.serviceFoodPrice == null ? starIndex : serviceIndex, //菜品或者服务评分
                content : $("#content").val(), //评价内容
                imgs : imgs, //评价图片
                objectId : $scope.serviceFoodPrice == null ? $scope.orderFood.foodId : 1, //根据type 存放相应的id
                orderId : $scope.orderId, //订单ID
                packageCaterId : packageCaterId //坝坝宴/套餐id
            }
            console.log(arr);
            BJW.ajaxRequestData("post", false, BJW.ip+'/app/evaluate/save', arr, $scope.userToken, function(result){
                if(result.flag==0 && result.code==200){
                    if (BJW.isWeiXin()) {
                        window.history.go(-1);
                    }
                    else {
                        window.location.href = BJW.ip + "/app/page/orderEvaluate?isOpen=1&pageType=2";
                    }
                }
            });

        }

    });

    // 监听tap事件，解决 a标签 不能跳转页面问题
    mui('body').on('tap','a',function(){document.location.href=this.href;});

    //头像上传
    $('#fileBtn').change(function(){
        $("body").append(BJW.uploadDialogLoading("上传中···"));//弹窗loading
        var file = this.files[0];
        if(window.FileReader) {
            var fr = new FileReader();
            fr.onloadend = function(e) {
                $("#newUploadForm0").ajaxSubmit({
                    type: "POST",
                    url:BJW.ip + '/res/upload',
                    success: function(json){
                        console.log(json);
                        if(json.code == 200){
                            var imgHtml = "<div class=\"mui-col-xs-4 mui-col-sm-4 padding-right15\">" +
                                    "<img name=\"imgs\" imgUrl=\"" + json.data.url + "\" src=\"" + BJW.ip + "/" + json.data.url + "\">" +
                                    "<span onclick=\"deleteImg(this)\" class=\"closeImg\">X</span>" +
                                    "</div>";
                            $("#previewImg").append(imgHtml);
                        }else{
                            mui.toast(json.msg);
                        }
                        BJW.closeUploadDialogLoading();//关闭弹窗loading
                    }
                });
            };
            fr.readAsDataURL(file);
        }
    });

    //删除图片
    function deleteImg(obj) {
        $(obj).parent().fadeOut();
        setTimeout(function () {
            $(obj).parent().remove();
        }, 1000);
    }


    mui.init({
        swipeBack: true //启用右滑关闭功能
    });

    //厨师评分
    mui('#icon1').on('tap','i',function(){
        var index = parseInt(this.getAttribute("data-index"));
        var parent = this.parentNode;
        var children = parent.children;
        if(this.classList.contains("mui-icon-star")){
            for(var i=0;i<index;i++){
                children[i].classList.remove('mui-icon-star');
                children[i].classList.add('mui-icon-star-filled');
            }
        }else{
            for (var i = index; i < 5; i++) {
                children[i].classList.add('mui-icon-star')
                children[i].classList.remove('mui-icon-star-filled')
            }
        }
        starIndex = index;
    });

    //服务评分
    mui('#icon2').on('tap','i',function(){
        var index = parseInt(this.getAttribute("data-index"));
        var parent = this.parentNode;
        var children = parent.children;
        if(this.classList.contains("mui-icon-star")){
            for(var i=0;i<index;i++){
                children[i].classList.remove('mui-icon-star');
                children[i].classList.add('mui-icon-star-filled');
            }
        }else{
            for (var i = index; i < 5; i++) {
                children[i].classList.add('mui-icon-star')
                children[i].classList.remove('mui-icon-star-filled')
            }
        }
        serviceIndex = index;
    });

    BJW.closeDialogLoading();//关闭弹窗loading

</script>
</body>

</html>