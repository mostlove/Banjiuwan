<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>菜品列表(促销)</title>

    <!-- 引用公用css -->
    <jsp:include page="../common/resources-css.jsp"></jsp:include>
    <link id="beyond-link" href="<%=request.getContextPath()%>/resources/assets/css/beyond.min.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/resources/assets/js/skins.min.js"></script>
    <link href="<%=request.getContextPath()%>/resources/assets/css/skins/gray.min.css" rel="stylesheet" />
    <style>

    </style>
</head>
<body>
    <!-- Page Breadcrumb -->
    <div class="page-breadcrumbs">
        <ul class="breadcrumb">
            <li class="active">菜品列表(促销)</li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <form id="listForm" action="##" class="form-horizontal" method="POST" >
            <div class="widget">
                <!-- 高级查询开始 -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="well with-header">
                            <div class="header bordered-palegreen">高级查询</div>

                            <div class="portlet-body">
                                <div class="form-body">
                                    <div class="form-group margin-bottom-20">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">菜名</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control" id="foodName" name="foodName" placeholder="菜名" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">推荐指数</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select class="form-control" id="recommendationIndex" name="recommendationIndex">
                                                            <option value="">全部</option>
                                                            <option value="1">1</option>
                                                            <option value="2">2</option>
                                                            <option value="3">3</option>
                                                            <option value="4">4</option>
                                                            <option value="5">5</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">类别</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select id="foodCategoryId" multiple="multiple" name="foodCategoryId">
                                                            <c:forEach items="${categorys}" var="category">
                                                                <option value="${category.id}">${category.categoryName}</option>
                                                            </c:forEach>
                                                            <%--<option value="1">凉菜</option>--%>
                                                            <%--<option value="2">热菜</option>--%>
                                                            <%--<option value="3">海河鲜</option>--%>
                                                            <%--<option value="4">素菜</option>--%>
                                                            <%--<option value="5">燕鲍翅</option>--%>
                                                            <%--<option value="6">小吃</option>--%>
                                                            <%--<option value="7">汤</option>--%>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group margin-bottom-20">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">是否促销</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select class="form-control" id="isPromotion" name="isPromotion">
                                                            <option value="">全部</option>
                                                            <option value="1">是</option>
                                                            <option value="0">否</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">是否推荐</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <label class="form-control" >是</label>
                                                        <input value="1" id="isRecommendation" type="hidden"/>
                                                        <%--<select class="form-control" id="isRecommendation" name="isRecommendation">
                                                            <option value="">全部</option>
                                                            <option value="1">是</option>
                                                            <option value="0">否</option>
                                                        </select>--%>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group margin-bottom-20">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5"></label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <button id="search" type="button" onclick="sub()" class="btn btn-blue"><i class="fa fa-search"></i>查询</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <!-- 高级查询结束 -->
                <!-- 表格开始 -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="well with-header">
                            <div class="header bordered-darkpink">
                                菜品列表
                                <a class="refresh primary margin-right-20" data-toggle="tooltip" data-placement="bottom" data-original-title="点击刷新" id="refresh-toggler" href="">
                                    <i class="glyphicon glyphicon-refresh"></i>
                                </a>
                                <a href="<%=request.getContextPath()%>/web/food/addPage" class="btn btn-success float-right btn-sm"><i class="fa fa-plus"></i>新增菜品</a>
                            </div>
                            <div class="portlet-body">
                                <table class="table table-hover table-bordered" id="listTable">
                                    <thead>
                                        <tr>
                                            <th>封面图</th>
                                            <th>菜品名称</th>
                                            <th>单价</th>
                                            <th>促销价</th>
                                            <th>推荐指数</th>
                                            <th>销量</th>
                                            <th>类别</th>
                                            <th>是否促销</th>
                                            <th>是否推荐</th>
                                            <th>创建时间</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                    <tbody id="dataDiv">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 表格结束 -->
            </div>
        </form>
    </div>
    <input class="btn btn-blue" type="hidden" value="上传图片" id="addImg">
    <!-- 引用公用js -->
    <jsp:include page="../common/resources-js.jsp"></jsp:include>
    <!-- 私有js -->
    <script src="<%=request.getContextPath()%>/resources/js/food/list.js"></script>
    <script>

        $(function(){
            $("#foodCategoryId").select2({
                placeholder: "全部"
            });

            addpage(); //加载分页方法


            //返回的数据不为undefind(也就是有数据时),调用$('#pageCon').show();
            $('#pageCon').show();

            var totalpage = initData(1,15,null,null,null,$("#isRecommendation").val(),null);

            //数据添加到页面后，调用一下方式
            $.jqPaginator('#pagination', {
                totalPages: totalpage,  //总页数
                visiblePages: 3,  //可见页面
                currentPage: 1,   //当前页面
                onPageChange: function (num, type) {
                    $('#showing').text('共'+totalpage+'页  第'+num+'/'+totalpage+'页');
                    if(type != "init"){
                        var foodName = $("#foodName").val();
                        var categoryId = $("#foodCategoryId").val();
                        var isPromotion = $("#isPromotion").val();
                        var isRecommendation = $("#isRecommendation").val();
                        var recommendationIndex = $("#recommendationIndex").val();

                        //获取第num页数据，
                        initData(num,15,foodName,categoryId,isPromotion,isRecommendation,recommendationIndex);
                    }
                }
            });

        });
        function sub(){
            var foodName = $("#foodName").val();
            var categoryId = $("#foodCategoryId").val();
            var isPromotion = $("#isPromotion").val();
            var isRecommendation = $("#isRecommendation").val();
            var recommendationIndex = $("#recommendationIndex").val();
            //获取第num页数据，
            initData(1,15,foodName,categoryId,isPromotion,isRecommendation,recommendationIndex);
        }
    </script>

</body>
</html>
