<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>查看/编辑地图围栏</title>

    <!-- 引用公用css -->
    <jsp:include page="../common/resources-css.jsp"></jsp:include>
    <link id="beyond-link" href="<%=request.getContextPath()%>/resources/assets/css/beyond.min.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/resources/assets/js/skins.min.js"></script>
    <link href="<%=request.getContextPath()%>/resources/assets/css/skins/gray.min.css" rel="stylesheet" />
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=fEP9DinmyVkK1FcUqcG8AKoQPgKKc1aY"></script>
    <style>

    </style>
</head>
<body>
    <!-- Page Breadcrumb -->
    <div class="page-breadcrumbs">
        <ul class="breadcrumb">
            <li>
                <a target="iframe" href="<%=request.getContextPath()%>/web/food/list">地图围栏列表</a>
            </li>
            <%--<li class="active">--%>
                <%--<span>添加用户</span>--%>
            <%--</li>--%>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <div class="widget">
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">查看/编辑地图围栏</div>
                        <div class="portlet-body">
                            <form  class="form-horizontal" id="dataForm" >
                                <div class="form-body">
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <div class="col-md-12" style="padding-top: 15px;">
                                                <div id="allmap" style="height: 500px !important;"></div>
                                                <div id="info" style="margin-bottom:-10px;"></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <div class="col-md-12" style="padding-top: 15px;">
                                                <label class="control-label col-md-2">备注：</label>
                                                <div class="col-md-8">
                                                    <input type="text" value="${mapList.reMarket}" name="remarks" id="remarks" placeholder="请添加备注" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <input type="hidden" value="${mapList.id}" name="id" id="id">
                                    <input type="hidden" value='${mapList.mapList}' name="markerList" id="markerList">
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/mapList/list" target="iframe" onclick="return updateMapList()" class="btn btn-info">确认修改</a>
                                                <a href="javascript:" onclick="self.location=document.referrer;" id="cancel" type="button" class="btn btn-default">返回</a>
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
    <script src="<%=request.getContextPath()%>/resources/js/mapList/cityMarkerEdit.js"></script>
    <script>
//        findAddress();
    </script>
</body>
</html>
