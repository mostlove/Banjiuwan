<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>菜品评论列表</title>

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
            <li class="active">菜品评论列表</li>
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
                                                    <label class="control-label col-md-3 padding-right-5">用户类型</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select id="userType" class="form-control" name="userType">
                                                            <option value="">全部</option>
                                                            <option value="1">普通用户</option>
                                                            <option value="2">管理员</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">是否通过</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select id="isPass" class="form-control" name="isPass">
                                                            <option value="">全部</option>
                                                            <option value="1">已通过</option>
                                                            <option value="0">未通过</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">评价等级</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select id="evaluateLevel" class="form-control" name="evaluateLevel">
                                                            <option value="">全部</option>
                                                            <option value="1">好评</option>
                                                            <option value="2">中评</option>
                                                            <option value="3">差评</option>
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
                                                    <label class="control-label col-md-3 padding-right-5">类别</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select id="foodCategoryId" class="form-control" name="foodCategoryId">
                                                            <option value="">全部</option>
                                                            <c:forEach items="${categorys}" var="category">
                                                                <option value="${category.id}">${category.categoryName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">菜名</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select id="objectId" multiple="multiple" name="objectId"></select>
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
                            </div>
                            <div class="portlet-body">
                                <table class="table table-hover table-bordered" id="listTable">
                                    <thead>
                                        <tr>
                                            <th>菜品名称</th>
                                            <th>评价等级</th>
                                            <th>评价内容</th>
                                            <th>菜品评分</th>
                                            <th>菜品类别</th>
                                            <th>是否通过</th>
                                            <th>评价人类型</th>
                                            <th>评价人</th>
                                            <th>评价时间</th>
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
    <script src="<%=request.getContextPath()%>/resources/js/evaluate/evaluateFoodList.js"></script>
    <script>

        $(function(){
            ajaxFood(null);
            $("#foodCategoryId").change(function(){
                var foodCategoryId = $(this).val();
                ajaxFood(foodCategoryId);
            });

            addpage(); //加载分页方法


            //返回的数据不为undefind(也就是有数据时),调用$('#pageCon').show();
            $('#pageCon').show();

            var totalpage = initData(1,15,null,null,null,null,null);

            //数据添加到页面后，调用一下方式
            $.jqPaginator('#pagination', {
                totalPages: totalpage,  //总页数
                visiblePages: 3,  //可见页面
                currentPage: 1,   //当前页面
                onPageChange: function (num, type) {
                    $('#showing').text('共'+totalpage+'页  第'+num+'/'+totalpage+'页');
                    if(type != "init"){
                        var userType = $("#userType").val();
                        var evaluateLevel = $("#evaluateLevel").val();
                        var isPass = $("#isPass").val();
                        var foodCategoryId = $("#foodCategoryId").val();
                        var objectId = $("#objectId").val();

                        //获取第num页数据，
                        initData(num,15,userType,evaluateLevel,isPass,foodCategoryId,objectId);
                    }
                }
            });

        });
        function sub(){
            var userType = $("#userType").val();
            var evaluateLevel = $("#evaluateLevel").val();
            var isPass = $("#isPass").val();
            var foodCategoryId = $("#foodCategoryId").val();
            var objectId = $("#objectId").val();

            //获取第num页数据，
            initData(1,15,userType,evaluateLevel,isPass,foodCategoryId,objectId);
        }

        function ajaxFood(foodCategoryId){
            $.ajax({
                type : "POST",
                url : getRootPath()+"/web/food/queryByCategory",
                data : {
                    category:foodCategoryId
                },
                dataType :"json",
                async : false,
                timeout : 5000,
                success : function(respObj){
                    var status = respObj.code;
                    if(status==200){
                        var data = new Array();
                        console.debug(respObj.data)
                        for (var i = 0 ; i < respObj.data.length ; i ++) {
                            var a = {
                                id:respObj.data[i].id,
                                text:respObj.data[i].foodName
                            }
                            data[i]=a;
                        }

                        $("#objectId").empty();

                        $("#objectId").select2({
                            data: data,
                            placeholder: "全部",
                            allowClear:true
                        });

                      /*  var data = [{ id: 0, text: 'enhancement' }, { id: 1, text: 'bug' }, { id: 2, text: 'duplicate' }, { id: 3, text: 'invalid' }, { id: 4, text: 'wontfix' }];
                        $("#objectId").select2({
                            data: data,
                            placeholder:'请选择',
                            allowClear:true
                        })*/
                    }else{
                        Notify(respObj.msg,'top-right','5000','danger','fa-desktop',true);
                        return false;
                    }
                }
            });
        }
    </script>

</body>
</html>
