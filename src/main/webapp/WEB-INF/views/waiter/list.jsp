<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>服务员管理</title>

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
            <li class="active">服务员管理</li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <form id="listForm" action="##" class="form-horizontal" method="POST" >
            <div class="widget">
                <!-- 高级查询开始 -->
                <!-- 高级查询结束 -->
                <!-- 表格开始 -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="well with-header">
                            <div class="header bordered-darkpink">
                                服务员列表
                                <a href="<%=request.getContextPath()%>/web/waiter/addPage" class="btn btn-success float-right btn-sm"><i class="fa fa-plus"></i>新增服务员</a>
                            </div>
                            <div class="portlet-body">
                                <table class="table table-hover table-bordered" id="listTable">
                                    <thead>
                                        <tr>
                                            <th>姓名</th>
                                            <th>性别</th>
                                            <th>注册时间</th>
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

    <!-- 引用公用js -->
    <jsp:include page="../common/resources-js.jsp"></jsp:include>
    <!-- 私有js -->
    <script src="<%=request.getContextPath()%>/resources/js/waiter/list.js"></script>
    <script>

        $(function(){

            addpage(); //加载分页方法


            //返回的数据不为undefind(也就是有数据时),调用$('#pageCon').show();
            $('#pageCon').show();

            var totalpage = initData(1,15,null);

            //数据添加到页面后，调用一下方式
            $.jqPaginator('#pagination', {
                totalPages: totalpage,  //总页数
                visiblePages: 3,  //可见页面
                currentPage: 1,   //当前页面
                onPageChange: function (num, type) {
                    $('#showing').text('共'+totalpage+'页  第1/'+totalpage+'页');
                    if(type != "init"){
                        //获取第num页数据，
                        initData(num,15,null);
                    }
                }
            });

        });

    </script>

</body>
</html>
