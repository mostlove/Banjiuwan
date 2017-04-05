<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>地址管理</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/person/addAddress.css" charset="UTF-8">
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=KEsjqKjcGICVqaZV82t1IOoh"></script>
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="addAddressCtr" ng-cloak>
    <div class="mui-content">
        <ul class="mui-table-view">
            <li class="mui-table-view-cell">
                <span class="item-title">联系人</span>
                <input class="mui-pull-right person-input" type="text" placeholder="您的姓名" maxlength="10" id="contact" value="{{address.contact}}">
            </li>
            <li class="mui-table-view-cell">
                <span class="item-title">性别</span>
                <div class="mui-pull-right" id="isGenderHtml">

                </div>
            </li>
            <li class="mui-table-view-cell">
                <span class="item-title">联系电话</span>
                <input class="mui-pull-right person-input" type="text" placeholder="请输入您的联系方式" maxlength="11" onKeypress="return (/[\d.]/.test(String.fromCharCode(event.keyCode)))" id="contactPhone" value="{{address.contactPhone}}">
            </li>
            <li class="mui-table-view-cell" style="padding: 14px;">
                <a ng-click="moreAddress()">
                    <span>收货地址</span>
                    <span class="mui-pull-right">
                        <span class="mui-ellipsis" id="currentAddress" ng-if="address.address == '' || address.address == null">
                            <div class="mui-loading">
                                <div class="mui-spinner">
                                </div>
                            </div>
                        </span>
                        <span class="mui-ellipsis" id="currentAddress" ng-if="address.address != '' && address.address != null">{{address.address}}</span>
                        <i class="mui-icon mui-icon-arrowright right-jian"></i>
                    </span>
                </a>
            </li>
            <li class="mui-table-view-cell">
                <span class="item-title">详细地址</span>
                <input class="mui-pull-right person-input" type="text" placeholder="请输入详细地址(如门牌号等)" maxlength="50" id="detailAddress" value="{{address.detailAddress}}">
            </li>
        </ul>

        <div class="default-bar">
            <div class="mui-input-row mui-checkbox mui-left">
                <label>设置为默认地址</label>
                <span ng-if="address.isDefault == 0 || address.isDefault == null"><input name="checkbox" value="1" type="checkbox"></span>
                <span ng-if="address.isDefault == 1"><input name="checkbox" value="1" type="checkbox" checked></span>
            </div>
        </div>
    </div>

    <div class="add-address-div">
        <a class="mui-btn add-address-btn" ng-click="addAddress()">保存</a>
    </div>
    <input id="longitude" type="hidden">
    <input id="latitude" type="hidden">
    <div id="allmap"></div>
    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

   <%-- <div id="popUpMap" class="hide">
        <%@include file="../common/map.jsp" %>
    </div>--%>

    <script type="text/javascript">

        var addId = localStorage.getItem("addressId");

        //获取选择地图的地址
        var selectAddress = localStorage.getItem("selectAddress");//获取选择地址
        var latOrLng = JSON.parse(localStorage.getItem("latOrLng"));//获取选择地址的经纬度
        console.log(selectAddress);
        console.log(latOrLng);


        $("body").append(BJW.dialogLoading("正在加载"));//弹窗loading

        if (selectAddress == null && addId == null) {
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
        else if (selectAddress != null) {
            $("#currentAddress").html(selectAddress);
            $("#longitude").val(latOrLng.lng);
            $("#latitude").val(latOrLng.lat);
        }

        var webApp=angular.module('webApp',[]);
        //地址管理
        webApp.controller('addAddressCtr',function($scope,$http,$timeout){
            $scope.address = null;
            //获取登录用户token
            $scope.userToken = BJW.getLocalStorageToken();
            console.log("token:" + $scope.userToken);
            //获取修改地址
            $scope.addressId = localStorage.getItem("addressId");
            console.log("addressId:" + $scope.addressId);

            var manHtml = "<div class=\"mui-input-row mui-radio mui-left man\">" +
                                "<label id=\"man\">先生</label>" +
                                "<input name=\"radio\" value=\"0\" type=\"radio\" checked>" +
                            "</div>" +
                            "<div class=\"mui-input-row mui-radio mui-left female\">" +
                                "<label>女士</label>" +
                                "<input name=\"radio\" value=\"1\" type=\"radio\">" +
                            "</div>";
            var womanHtml = "<div class=\"mui-input-row mui-radio mui-left man\">" +
                                "<label id=\"man\">先生</label>" +
                                "<input name=\"radio\" value=\"0\" type=\"radio\">" +
                            "</div>" +
                            "<div class=\"mui-input-row mui-radio mui-left female\">" +
                                "<label>女士</label>" +
                                "<input name=\"radio\" value=\"1\" type=\"radio\" checked>" +
                            "</div>";



            if ($scope.addressId != null) {
                BJW.ajaxRequestData("get", false, BJW.ip+'/app/address/queryAddressById',{id:$scope.addressId}, $scope.userToken , function(result){
                    if(result.flag == 0 && result.code == 200){
                        $scope.address = result.data;
                        $("#currentAddress").html(result.data.address);
                        var lngLat = result.data.lngLat.split(",");
                        console.log("lngLat："+lngLat);
                        $("#longitude").val(lngLat[0]);
                        $("#latitude").val(lngLat[1]);
                        if (result.data.gender == 0) {
                            $("#isGenderHtml").html(manHtml);
                        }
                        else {
                            $("#isGenderHtml").html(womanHtml);
                        }
                    }
                    else {
                        mui.toast("获取失败.");
                    }
                });
            }
            else {
                $("#isGenderHtml").html(manHtml);
            }

            //跳转更多地址
            $scope.moreAddress = function () {
                if (BJW.isWeiXin()) {
                    //$("#popUpMap").fadeIn();
                    localStorage.setItem("addressType", 1);
                    location.href = BJW.ip + "/app/page/moreAddress";
                }
                else {
                    try {

                        window.JSBridge.openAddressPage();
                    }catch (error){
                    }
                }
            }

            //保存
            $scope.addAddress = function (){

                var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g; //emoji 表情正则

                if ($("#contact").val().trim() == '' || $("#contact").val() == null) {
                    $("#contact").val("");
                    mui.toast("联系人不能为空.");
                    return false;
                }
                else if($("#contact").val().trim().match(regRule)) {
                    mui.toast("联系人不支持emoji表情.");
                    return false;
                }
                else if (!BJW.isUserName.test($("#contact").val().trim())) {
                    mui.toast("请输入正确的联系人.");
                    return false;
                }
                else if ($("#contactPhone").val().trim() == '' || $("#contactPhone").val() == null) {
                    $("#contactPhone").val("");
                    mui.toast("请输入您的联系方式.");
                    return false;
                }
                else if($("#contactPhone").val().trim().match(regRule)) {
                    mui.toast("联系方式不支持emoji表情.");
                    return false;
                }
                else if (!BJW.isMobile.test($("#contactPhone").val().trim())) {
                    mui.toast("请输入正确手机号.");
                    return false;
                }
                else if ($("#detailAddress").val().trim() == '' || $("#detailAddress").val() == null) {
                    mui.toast("请输入您的详细地址.");
                    return false;
                }
                else if($("#detailAddress").val().trim().match(regRule)) {
                    mui.toast("详细地址不支持emoji表情.");
                    return false;
                }
                //获取性别
                var gender = 0;
                $("input[name='radio']").each(function (){
                    var value = this.checked?"true":"false";
                    if (value == "true") {
                        gender = this.value;
                    }
                });
                console.log("gender：" + gender);
                //获取是否是默认地址
                var isDefault = 0;
                $("input[name='checkbox']").each(function (){
                    var value = this.checked?"true":"false";
                    if (value == "true") {
                        isDefault = 1;
                    }
                });
                console.log("isDefault：" + isDefault);
                //提交
                var arr = {
                    addressId : $scope.addressId,
                    gender : gender,
                    isDefault : isDefault,
                    contact : $("#contact").val(),
                    contactPhone : $("#contactPhone").val(),
                    address : $("#currentAddress").html(),
                    detailAddress : $("#detailAddress").val(),
                    lngLat : $("#longitude").val() + "," +  $("#latitude").val()
                }
                console.log(arr);
                //添加
                if ($scope.address == null) {
                    BJW.ajaxRequestData("post", false, BJW.ip+'/app/address/addAddress',arr, $scope.userToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            localStorage.removeItem("selectAddress");
                            localStorage.removeItem("latOrLng");
                            window.location.href = BJW.ip + "/app/page/address?isOpen=1&pageType=2";
                        }
                    });
                }
                //修改
                else {
                    BJW.ajaxRequestData("post", false, BJW.ip+'/app/address/updateAddress',arr, $scope.userToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            localStorage.removeItem("selectAddress");
                            localStorage.removeItem("latOrLng");
                            window.location.href = BJW.ip + "/app/page/address?isOpen=1&pageType=2";
                        }
                    });
                }


            }

        });

        //解决移动端弹出键盘input弹窗头痛问题
        var h = document.body.scrollHeight;
        window.onresize = function(){
            if (document.body.scrollHeight < h) {
                document.getElementsByClassName("add-address-div")[0].style.display = "none";
            }else{
                document.getElementsByClassName("add-address-div")[0].style.display = "block";
            }
        };


        //移动端调用地址方法
        function setAddress(address, lat, lng) {
            $("#currentAddress").html(address);
            $("#latitude").val(lat);
            $("#longitude").val(lng);
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

        setTimeout(function () {
            BJW.closeDialogLoading();//关闭弹窗loading
        }, 500);
    </script>
</body>

</html>