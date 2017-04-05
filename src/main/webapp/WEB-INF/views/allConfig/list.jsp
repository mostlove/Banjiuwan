<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>全局配置</title>

    <!-- 引用公用css -->
    <jsp:include page="../common/resources-css.jsp"></jsp:include>
    <link id="beyond-link" href="<%=request.getContextPath()%>/resources/assets/css/beyond.min.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/resources/assets/js/skins.min.js"></script>
    <link href="<%=request.getContextPath()%>/resources/assets/css/skins/gray.min.css" rel="stylesheet" />
    <style>

    </style>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=fEP9DinmyVkK1FcUqcG8AKoQPgKKc1aY"></script>
</head>
<body>
<!-- Page Breadcrumb -->
<div class="page-breadcrumbs">
    <ul class="breadcrumb">
        <li>
        </li>
        <li class="active">
            <span>全局配置</span>
        </li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<div class="page-body">
    <div class="widget">
        <div class="row">
            <div class="col-md-12">
                <div class="well with-header">
                    <div class="header bordered-darkpink">全局配置</div>
                    <div class="portlet-body">
                        <form  class="form-horizontal" id="dataForm" >
                            <div class="form-body">
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">积分配置(多少积分抵扣1元)</label>
                                        <div class="col-md-8">
                                            <input type="number" class="form-control" value="${config.accumulate}" name="accumulate" id="accumulate" placeholder="请设置积分">
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">积分配置(1元换取多少积分)</label>
                                        <div class="col-md-8">
                                            <input type="number" class="form-control" value="${config.yuan}" name="yuan" id="yuan" placeholder="请设置积分">
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">分销提成配置(单位:百分比)</label>
                                        <div class="col-md-8">
                                            <input type="number" class="form-control" value="${config.distribution}" name="distribution" id="distribution" placeholder="设置分销提成百分比">
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">配菜时间(单位:小时)</label>
                                        <div class="col-md-8">
                                            <input type="number" class="form-control" value="${config.garnishTime}" name="garnishTime" id="garnishTime" placeholder="设置配菜时间">
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">时间计算起始点</label>
                                        <div class="col-md-6">
                                            <input type="text" disabled class="form-control" value="${config.currentLocation}" name="currentLocation" id="currentLocation">
                                            <input type="hidden" class="form-control" value="${config.startPoint}" name="startPoint" id="startPoint">
                                            <span class="help-block"></span>
                                        </div>
                                        <div class="col-md-2">
                                            <a href="javascript:void(0)" class="btn btn-blue" onclick="setStartPoint(this)">打开地图</a>
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-body" style="display: none" id="mapDiv">
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <div class="col-md-12" style="padding-top: 15px;">
                                                <div id="allmap" style="height: 500px !important;"></div>
                                                <div id="info" style="margin-bottom:-10px;"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <input type="hidden" value="${config.id}" id="id">
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2"></label>
                                        <div class="col-md-8">
                                            <a href="javascript:location.reload()" target="iframe" onclick="return updateConfig()" class="btn btn-info">确认修改</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<!-- 引用公用js -->
<jsp:include page="../common/resources-js.jsp"></jsp:include>
<!-- 引用富文本 -->
<script src="<%=request.getContextPath()%>/resources/assets/js/editors/summernote/summernote.js"></script>
<!-- 私有js -->
<script>

    //百度地图API功能
    var map = new BMap.Map("allmap");
    map.centerAndZoom("成都市天府广场",15);
    map.addControl(new BMap.NavigationControl());
    map.addControl(new BMap.OverviewMapControl());
    map.addControl(new BMap.ScaleControl());
    map.enableScrollWheelZoom(true);


    //单击地图添加标注
    map.addEventListener("click", function(e) {
        map.clearOverlays();
        marker = new BMap.Marker(e.point); // 创建标注
        map.addOverlay(marker); // 将标注添加到地图中
        map.panTo(e.point);//定位到中心点
        var point = new BMap.Point(e.point.lng,e.point.lat);
        var gc = new BMap.Geocoder();
        gc.getLocation(point, function(rs) {
            var addComp = rs.addressComponents;
            var mapAddress = addComp.province+addComp.city + addComp.district
                    + addComp.street + addComp.streetNumber;
            $("#currentLocation").val(mapAddress);
            $("#startPoint").val(e.point.lng+","+e.point.lat);
            console.debug($("#startPoint").val());
        });

    });


    $(function() {
    });

    // 提交修改Banner
    function  updateConfig(){
        var accumulate = $("#accumulate").val();
        var yuan = $("#yuan").val();
        var id = $("#id").val();
        var distribution = $("#distribution").val();
        var reg = /^\+?[1-9][0-9]*$/;
        if(accumulate <= 0 || yuan <= 0 || accumulate.length <=0 || yuan.length <= 0 || distribution <= 0
        || !reg.test(yuan) || !regDouble.test(distribution) || !reg.test(accumulate)){
            Notify("数据不合法",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
        var startPoint = $("#startPoint").val();
        var currentLocation = $("#currentLocation").val();
        if(startPoint.length == 0 || currentLocation.length  == 0){
            Notify("请选择时间计算起始点",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
        var garnishTime = $("#garnishTime").val();
        if(!regDouble.test(garnishTime)){
            Notify("配菜时间没有设置",'top-right','5000','danger','fa-desktop',true);
            return false;
        }

        $.ajax({
            type : "POST",
            url : getRootPath()+"/web/config/updateConfig",
            data :{
                accumulate:accumulate,
                yuan:yuan,
                id:id,
                distribution:distribution,
                startPoint:startPoint,
                currentLocation:currentLocation,
                garnishTime:garnishTime
            },
            dataType :"json",
            async : false,
            timeout : 5000,
            success : function(json){
                if(json.code == 200){
                    Notify("更新成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                    return true;
                }
                else{
                    Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                    return false;
                }
            }
        })
    }
    var isOpen = false;
    function setStartPoint(obj){
        if(!isOpen){
            // 如果是关闭的
            $(obj).html("收起地图");
            $("#mapDiv").show("slow");
            isOpen = true;
        }else{
            $(obj).html("打开地图")
            $("#mapDiv").hide("slow");
            isOpen = false;
        }
    }

</script>
</body>
</html>
