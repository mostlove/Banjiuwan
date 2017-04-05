<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>地址管理</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/person/address.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="addressCtr" ng-cloak>
<div class="mui-content">
    <div class="not-address" ng-if="addressList.length == 0 || addressList == null">
        暂无收货地址
    </div>
    <div ng-if="orderEdit == null">
        <ul ng-if="addressList.length != 0 && addressList != null" class="mui-table-view">
            <li class="mui-table-view-cell" ng-repeat="address in addressList">
                <div class="mui-slider-right mui-disabled">
                    <a class="mui-btn mui-btn-red" ng-click="deleteAddress(this,address.id)">
                        <div>
                            <i class="mui-icon mui-icon-trash"></i>
                            <div>删除</div>
                        </div>
                    </a>
                </div>
                <div class="mui-slider-handle" ng-click="updateAddress(address.id)">
                    <div class="user-name">
                        {{address.contact}}
                        <span class="user-phone">
                            {{address.contactPhone}}
                        </span>
                    </div>
                    <div class="address">
                        <span class="default-hint" ng-if="address.isDefault == 1">【默认】</span>
                        {{address.address}}<br>
                        {{address.detailAddress}}
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- 填写订单选择地址 -->
    <div ng-if="orderEdit == 1 && orderEdit != null">
        <ul ng-if="addressList.length != 0 && addressList != null" class="mui-table-view">
            <li class="mui-table-view-cell" ng-repeat="address in addressList" ng-click="selectAddress()">
                <div class="mui-input-row mui-radio mui-left">
                    <label class="selectLabel">
                        <div class="mui-slider-handle">
                            <div class="user-name notAf">
                                {{address.contact}}
                            <span class="user-phone">
                                {{address.contactPhone}}
                            </span>
                            </div>
                            <div class="address">
                                <span class="default-hint" ng-if="address.isDefault == 1">【默认】</span>
                                {{address.address}}<br>
                                {{address.detailAddress}}
                            </div>
                        </div>
                    </label>
                    <input ng-if="selectOrderAddress.id != address.id" name="selectAddress" type="radio" id="{{address.id}}" gender="{{address.gender}}" address="{{address.address}}" detailAddress="{{address.detailAddress}}" contact="{{address.contact}}" contactPhone="{{address.contactPhone}}">
                    <input ng-if="selectOrderAddress.id == address.id" checked name="selectAddress" type="radio" id="{{address.id}}" gender="{{address.gender}}" address="{{address.address}}" detailAddress="{{address.detailAddress}}" contact="{{address.contact}}" contactPhone="{{address.contactPhone}}">

                </div>
            </li>
        </ul>
    </div>

</div>

<div class="add-address-div">
    <a class="mui-btn add-address-btn" ng-click="addAddress()">新增收货地址</a>
</div>



<!--引入抽取js文件-->
<%@include file="../common/public-js.jsp" %>

<script type="text/javascript">


    $("body").append(BJW.dialogLoading("加载中···"));//弹窗loading

    var webApp=angular.module('webApp',[]);
    //地址管理
    webApp.controller('addressCtr',function($scope,$http,$timeout){
        $scope.orderEdit = localStorage.getItem("orderEdit");//orderEdit 来自订单编辑选择地址
        console.log($scope.orderEdit);
        $scope.addressList = null;
        //获取登录用户token
        $scope.userToken = BJW.getLocalStorageToken();
        console.log("token:" + $scope.userToken);
        var arr = {
            pageNO : 1,
            pageSize : 100
        }
        BJW.ajaxRequestData("get", false, BJW.ip+'/app/address/getAddress', arr, $scope.userToken , function(result){
            if(result.flag == 0 && result.code == 200){
                if (result.data.length < 1) {
                    $scope.addressList = null
                }
                $scope.addressList = result.data;
                console.log($scope.addressList);
            }
        });

        //获取上一次订单选择的地址
        $scope.selectOrderAddress = JSON.parse(localStorage.getItem("selectOrderAddress"));
        console.log($scope.selectOrderAddress);

        //修改
        $scope.updateAddress = function (id){
            localStorage.setItem("addressId", id);
            window.location.href = BJW.ip + "/app/page/addAddress?isOpen=1&needLocation=0";
        }

        //新增
        $scope.addAddress = function (){
            localStorage.removeItem('addressId');
            window.location.href = BJW.ip + "/app/page/addAddress?isOpen=1&needLocation=1";
        }

        //删除
        $scope.deleteAddress = function (obj,id){
            mui.confirm('确认删除该地址？', '温馨提示', ["确认","取消"], function(e) {
                if (e.index == 0) {
                    var arr = {
                        id : id
                    }
                    BJW.ajaxRequestData("post", false, BJW.ip+'/app/address/delAddress',arr, $scope.userToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            //$(obj).parent().parent().remove();
                            window.location.href = BJW.ip + "/app/page/address?isOpen=1&pageType=1";
                        }
                    });
                } else {
                    //console.log("取消了...");
                }
            });
        }

        //订单选择地址
        $scope.selectAddress = function (){
            $("input[name='selectAddress']").each(function (){
                var value = this.checked?"true":"false";
                if (value == "true") {
                    var array = {
                        detailAddress : $(this).attr("detailAddress"),
                        address : $(this).attr("address"),
                        contact : $(this).attr("contact"),
                        contactPhone : $(this).attr("contactPhone"),
                        gender : $(this).attr("gender"),
                        id : $(this).attr("id"),
                    }
                    console.log(array);
                    localStorage.setItem("selectOrderAddress", JSON.stringify(array));
                    location.href = BJW.ip + "/app/page/orderEdit?isOpen=1&pageType=2";
                }
            });
        }

    });

    mui.init({
        swipeBack: true //启用右滑关闭功能
    });

    setTimeout(function (){
        BJW.closeDialogLoading();//关闭弹窗loading
    },500);


</script>
</body>

</html>