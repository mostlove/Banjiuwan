<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>更多地址</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/map/moreAddress.css" charset="UTF-8">
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=KEsjqKjcGICVqaZV82t1IOoh"></script>
    <style>

    </style>
</head>

<body>

    <div class="mui-content">

        <div id="allmap"></div>
        <div class="address-icon">
            <img class="img1" src="<%=request.getContextPath()%>/appResources/img/icon/address-icon1.png">
            <img class="img2" src="<%=request.getContextPath()%>/appResources/img/icon/address-icon2.png">
        </div>
        <div class="dangWei">
            <img class="img3" src="<%=request.getContextPath()%>/appResources/img/icon/address-icon3.png">
        </div>
        <div class="mapList">
            <ul class="mui-table-view">
                <li class="mui-table-view-cell mui-media" onclick="getSelectAddress(this)">
                    <a href="javascript:;">
                        <img class="mui-media-object mui-pull-left" src="<%=request.getContextPath()%>/appResources/img/icon/address-icon.png">
                        <div class="mui-media-body">
                            <div class="address-title"><span class="current">[当前]</span><span class="mui-ellipsis currentAddress"></span></div>
                            <p class='mui-ellipsis currentDetailAddress'></p>
                            <input class="lat" type='hidden' value="" id="latitude2">
                            <input class="lng" type='hidden' value="" id="longitude2">
                        </div>
                    </a>
                </li>
                <div  id="addressUl">

                </div>
            </ul>
        </div>

    </div>

    <input id="longitude" type="hidden">
    <input id="latitude" type="hidden">

    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>

    <script type="text/javascript">

        $("body").append(BJW.dialogLoading("定位中···"));//弹窗loading

        var addressType = localStorage.getItem("addressType");

        // 百度地图API功能
        var ak = "s17UeM0d7jGd5SYRblDPbStXsGKuw5Kp";

        var map = new BMap.Map("allmap");
        var point = new BMap.Point(104.072366,30.663453);
        var gc = new BMap.Geocoder();
        map.centerAndZoom(point, 18);
        map.enableScrollWheelZoom(); //启用滚轮
        var geolocation = new BMap.Geolocation();
        geolocation.getCurrentPosition(function(r) {
            if(this.getStatus() == BMAP_STATUS_SUCCESS) {
                console.log("经度：" + $("#longitude").val());
                console.log("纬度：" + $("#latitude").val());
                var point2 = new BMap.Point($("#longitude").val(),$("#latitude").val());
                var marker = new BMap.Marker(point2);// 创建标注
                //map.addOverlay(marker);             // 将标注添加到地图中
                map.panTo(point2);
                getMapAddress($("#latitude").val(), $("#longitude").val());
                BJW.closeDialogLoading();//关闭弹窗loading
                //地图拖拽
                map.addEventListener("dragend", function() {
                    map.clearOverlays();
                    //获取中心点的坐标
                    var centerPoint = map.getCenter();
                    var marker1 = new BMap.Marker(centerPoint);// 创建标注
                    //map.addOverlay(marker1);             // 将标注添加到地图中
                    //marker1.disableDragging();
                    console.log(centerPoint.lng + " " + centerPoint.lat);
                    $("#longitude").val(centerPoint.lng);
                    $("#latitude").val(centerPoint.lat);
                    getMapAddress(centerPoint.lat, centerPoint.lng);
                });
            } else {
                alert('failed' + this.getStatus());
            }
        }, {
            enableHighAccuracy: true
        })
        function myFun(result){
            console.log(point);
            point.lng = result.center.lng;
            point.lat = result.center.lat;
            console.log(point);
            $("#longitude").val(result.center.lng);
            $("#latitude").val(result.center.lat);
            $("#longitude2").val(result.center.lng);
            $("#latitude2").val(result.center.lat);
            var marker = new BMap.Marker(result);  // 创建标注
            map.addOverlay(marker);              // 将标注添加到地图中
            map.panTo(result);
        }
        var myCity = new BMap.LocalCity();
        myCity.get(myFun);
        /**定位*/
        function locationMap(){
            myCity.get(myFun);
        }


        /***
         * 获取百度返回地址
         */
        function getMapAddress(lat, lng){
            $.ajax({
                type:"get",
                url: "http://api.map.baidu.com/geocoder/v2/",
                data: {
                    location: lat + "," + lng,
                    output: "json",
                    pois: 1,
                    ak: ak
                },
                dataType:"jsonp",    //跨域json请求一定是jsonp
                success: function (data){
                    if (data.status == 0) {
                        console.log(data.result.formatted_address);
                        console.log(data.result);
                        $(".currentAddress").html(data.result.formatted_address);
                        $(".currentDetailAddress").html(data.result.sematic_description);
                        var html = "";
                        for (var i = 0; i < data.result.pois.length; i++) {
                            html += "<li class=\"mui-table-view-cell mui-media\"  onclick=\"getSelectAddress(this)\">" +
                                        "<a href=\"javascript:;\">" +
                                            "<img class=\"mui-media-object mui-pull-left\" src='" + BJW.ip + "/appResources/img/icon/address-icon.png\'>" +
                                            "<div class=\"mui-media-body\">" +
                                                "<div class=\"address-title\">" + data.result.pois[i].name + "</div>" +
                                                "<p class=\"mui-ellipsis\">" + data.result.pois[i].addr + "</p>" +
                                                    "<input class='lat' type='hidden' value='" + data.result.pois[i].point.y + "'>" +
                                                    "<input class='lng' type='hidden' value='" + data.result.pois[i].point.x + "'>" +
                                            "</div>" +
                                        "</a>" +
                                    "</li>";
                        }
                        $("#addressUl").html(html);
                    }else {
                        mui.toast("定位失败!");
                    }
                    console.log(data);
                }
            });
        }

        //获取搜索之后的点击地址
        function getSelectAddress(obj){
            var address = $(obj).find(".mui-ellipsis").html();
            var lat = $(obj).find(".lat").val();
            var lng = $(obj).find(".lng").val();
            var arr = {
                lat : lat,
                lng : lng
            }
            localStorage.setItem("selectAddress", address);
            localStorage.setItem("latOrLng", JSON.stringify(arr));
            if (addressType == 0) {
                location.href = BJW.ip + "/app/page/index?isOpen=2";
            }
            else {
                location.href = BJW.ip + "/app/page/addAddress?isOpen=1";
            }
        }

        (function($) {
            //阻尼系数
            var deceleration = mui.os.ios?0.003:0.0009;
            $('.mui-scroll-wrapper').scroll({
                bounce: false,
                indicators: true, //是否显示滚动条
                deceleration:deceleration
            });
        })(mui);
        $(function (){
            var height = $(document).height();
            console.log(height);
            $(".mapList").css("minHeight", (height-300) + "px");
        });

    </script>
</body>

</html>