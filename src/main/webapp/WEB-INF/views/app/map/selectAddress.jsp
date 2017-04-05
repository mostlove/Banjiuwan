<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>选择地址</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/map/selectAddress.css" charset="UTF-8">
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=KEsjqKjcGICVqaZV82t1IOoh"></script>
    <style>

    </style>
</head>

<body>

    <div class="mui-content">

        <div id="searchBar" class="search-bar">
            <input id="address" placeholder="请输入地址">
            <i class="mui-icon mui-icon-search"></i>
            <a id="cancelBtn" class="cancel-btn">取消</a>
        </div>

        <div id="existing">
            <div class="title-hint">
                当前地址：
            </div>
            <div class="current">
                <div class="mui-row">
                    <div class="mui-col-xs-9 mui-col-sm-9">
                        <div class="mui-ellipsis" id="currentAddress" onclick="getCurrentAddress(this)">
                            <!--loading-->
                            <div class="mui-loading">
                                <div class="mui-spinner">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mui-col-xs-3 mui-col-sm-3">
                        <a onclick="locationMap()" class="again-btn">重新定位</a>
                    </div>
                </div>
            </div>
            <div class="title-hint hide defaultAddress">
                收货地址：
            </div>
            <div class="current defaultAddress selectDefaultAddress" style="display: none;" onclick="getCurrentAddress(this)">
                <p>
                    <span class="user-name"></span>
                    <span class="user-gender"></span>
                    <span class="user-phone"></span>
                </p>
                <p class="address">

                </p>
                <p class="detailAddress">

                </p>
            </div>
            <div class="title-hint">
                附近地址：
            </div>
            <a id="nearby1" class="current mui-ellipsis border-bottom" onclick="getCurrentAddress(this)">
                <!--loading-->
                <div class="mui-loading">
                    <div class="mui-spinner">
                    </div>
                </div>
            </a>
            <a id="nearby2" class="current mui-ellipsis border-bottom" onclick="getCurrentAddress(this)">
                <!--loading-->
                <div class="mui-loading">
                    <div class="mui-spinner">
                    </div>
                </div>
            </a>
            <a id="nearby3" class="current mui-ellipsis border-bottom" onclick="getCurrentAddress(this)">
                <!--loading-->
                <div class="mui-loading">
                    <div class="mui-spinner">
                    </div>
                </div>
            </a>
            <a class="current more-address mui-navigate-right" href="javascript:void(0)" onclick="moreAddress()">
                更多地址
            </a>
        </div>

        <div id="searchAddress">
            <ul class="mui-table-view">

            </ul>
        </div>


    </div>

    <div id="allmap"></div>
    <input id="longitude" type="hidden">
    <input id="latitude" type="hidden">

    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

    <script type="text/javascript">

        mui.init({
            swipeBack: true, //启用右滑关闭功能
        });

        //获取登录用户token
        var userToken = BJW.getLocalStorageToken();
        console.log("token:" + userToken);

        $(function (){
            $("#address").click(function (){
                $("#searchBar").addClass("active-input");
                $("#existing").hide();
                $("#searchAddress").show();
            });

            $("#cancelBtn").click(function (){
                $("#searchBar").removeClass("active-input");
                $("#existing").show();
                $("#searchAddress").hide();
                $("#address").val("");
            });

            //获取默认地址
            if (null != userToken) {
                var arr = {pageNO : 1,pageSize : 100}
                BJW.ajaxRequestData("get", false, BJW.ip+'/app/address/getAddress', arr, userToken , function(result){
                    if(result.flag == 0 && result.code == 200){
                        for (var i = 0; i < result.data.length; i++ ) {
                            if (result.data[i].isDefault == 1) {
                                console.log(result.data[i]);
                                $(".user-name").html(result.data[i].contact);
                                if (result.data[i].gender == 0) {
                                    $(".user-gender").html("先生");
                                }
                                else {
                                    $(".user-gender").html("女士");
                                }
                                $(".user-phone").html(result.data[i].contactPhone);
                                $(".address").html(result.data[i].address);
                                //$(".detailAddress").html(result.data[i].detailAddress);
                                var latOrLng = result.data[i].lngLat.split(",");
                                $(".selectDefaultAddress").attr("lng",latOrLng[0]);
                                $(".selectDefaultAddress").attr("lat",latOrLng[1]);
                                $(".defaultAddress").show();
                                break;
                            }
                        }
                    }
                });
            }

        });

        $('#address').bind('input propertychange', function() {
            mapSearch();
        });

        // 百度地图API功能
        var ak = "s17UeM0d7jGd5SYRblDPbStXsGKuw5Kp";

        var map = new BMap.Map("allmap");
        var gc = new BMap.Geocoder();
        function myFun(result){
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
                        $("#nearby1").html(data.result.pois[0].addr);
                        $("#nearby1").attr("lng", data.result.pois[0].point.x);
                        $("#nearby1").attr("lat", data.result.pois[0].point.y);
                        $("#nearby2").html(data.result.pois[1].addr);
                        $("#nearby2").attr("lng", data.result.pois[1].point.x);
                        $("#nearby2").attr("lat", data.result.pois[1].point.y);
                        $("#nearby3").html(data.result.pois[2].addr);
                        $("#nearby3").attr("lng", data.result.pois[2].point.x);
                        $("#nearby3").attr("lat", data.result.pois[2].point.y);
                        //mui.toast("定位成功!");
                    }else {
                        mui.toast("定位失败!");
                    }
                    console.log(data);
                }
            });

            /*var cityName = result;
            map.setCenter(cityName);
            gc.getLocation(new BMap.Point(result.center.lng, result.center.lat), function(rs){
                var addComp = rs.addressComponents;
                console.log(addComp);
                $("#currentAddress").html(addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);
                //alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
            });*/

        }
        var myCity = new BMap.LocalCity();
        myCity.get(myFun);

        /**定位*/
        function locationMap(){
            myCity.get(myFun);
            $("#currentAddress").html(BJW.loading);
            $("#nearby1").html(BJW.loading);
            $("#nearby2").html(BJW.loading);
            $("#nearby3").html(BJW.loading);
        }

        //检索
        function mapSearch(){

            map.centerAndZoom(point,12);
            var options = {
                onSearchComplete: function(results){
                    console.log(results);
                    // 判断状态是否正确
                    var html = "";
                    if (local.getStatus() == BMAP_STATUS_SUCCESS){
                        for (var i = 0; i < results.getCurrentNumPois(); i ++){
                            html += "<li class=\"mui-table-view-cell\" onclick=\"getSelectAddress(this)\" lat=\"" + results.getPoi(i).point.lat + "\" lng=\"" + results.getPoi(i).point.lng + "\">" +
                                    "<p class=\"address-title\">" + results.getPoi(i).title + "</p>" +
                                    "<p class=\"address-info mui-ellipsis\">" + results.getPoi(i).address + "</p>" +
                                    "</li>"
                        }
                    }
                    $("#searchAddress ul").html(html);
                }
            };
            var local = new BMap.LocalSearch(map, options);
            local.search($("#address").val());
        }

        //点击当前定位和附近地址
        function getCurrentAddress(obj){
            console.log(obj);
            var address = $(obj).html();
            var lat = $(obj).attr("lat");
            var lng = $(obj).attr("lng");
            var arr = {
                lat : lat,
                lng : lng
            }
            localStorage.setItem("selectAddress", address);
            localStorage.setItem("latOrLng", JSON.stringify(arr));
            location.href = BJW.ip + "/app/page/index?isOpen=2";
        }

        //获取搜索之后的点击地址
        function getSelectAddress(obj){
            var address = $(obj).find(".mui-ellipsis").html();
            localStorage.setItem("selectAddress", address);
            location.href = BJW.ip + "/app/page/index?isOpen=2";
        }

        function moreAddress(){
            localStorage.setItem("addressType", 0);
            location.href = BJW.ip + "/app/page/moreAddress";
        }

    </script>
</body>

</html>