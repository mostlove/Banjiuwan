<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>客户经理业绩统计</title>

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
            <li class="active">客户经理业绩统计</li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <form id="listForm" action="##" class="form-horizontal" method="POST" >
            <div class="widget">
                <!-- 高级查询开始 -->
                <div class="row" >
                    <div class="col-md-12">
                        <div class="well with-header">
                            <div class="header bordered-palegreen">高级查询</div>
                            <div class="portlet-body">
                                <div class="form-body">
                                    <div class="form-group margin-bottom-20">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">客户经理姓名</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control" id="managerName" name="managerName" placeholder="客户经理姓名"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">开始时间</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control searchinput selectTime" readonly id="startTime" name="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"  placeholder="开始时间" value="">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">结束时间</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control searchinput selectTime" readonly id="endTime" name="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"  placeholder="结束时间" value="">
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
                                                        <button id="searchBtn" type="button" class="btn btn-blue"><i class="fa fa-search"></i>查询</button>
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
                                客户经理业绩统计
                                <a class="refresh primary margin-right-20" data-toggle="tooltip" data-placement="bottom" data-original-title="点击刷新" id="refresh-toggler" href="">
                                    <i class="glyphicon glyphicon-refresh"></i>
                                </a>
                                <a href="javascript:void(0)" onclick="exportExcel()" class="btn btn-success float-right btn-sm"><i class="fa fa-plus"></i>导出Excel</a>
                            </div>
                            <div class="portlet-body">
                                <table class="table table-hover table-bordered" id="listTable">
                                    <thead>
                                        <tr>
                                            <th>订单号</th>
                                            <th>订单总价(元)</th>
                                            <%--<th>创建人</th>--%>
                                            <th>客户经理</th>
                                            <th>提成比例(%)</th>
                                            <th>提成金额(元)</th>
                                            <th>订单创建时间</th>
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
    <form id="downLoadForm" style="display: none;"  action="<%=request.getContextPath()%>/web/order/exportOrderSalesExcel" method="POST">
        <input type="text" name="titleArray" id="titleArray">
        <input type="text" name="valueArray" id="valueArray" value="[]">
        <input type="text" name="managerName" id="managerNameTemp">
        <input type="text" name="startTime" id="startTimeTemp">
        <input type="text" name="endTime" id="endTimeTemp">
    </form>
    <!-- 引用公用js -->
    <jsp:include page="../common/resources-js.jsp"></jsp:include>
    <!-- 私有js -->
    <script src="<%=request.getContextPath()%>/resources/js/orderSales/list.js"></script>
    <script>

        $(function(){

            addpage(); //加载分页方法


            //返回的数据不为undefind(也就是有数据时),调用$('#pageCon').show();
            $('#pageCon').show();

            var totalpage = initData(1,15,null,null,null);

            //数据添加到页面后，调用一下方式
            $.jqPaginator('#pagination', {
                totalPages: totalpage,  //总页数
                visiblePages: 3,  //可见页面
                currentPage: 1,   //当前页面
                onPageChange: function (num, type) {
                    $('#showing').text('共'+totalpage+'页  第'+num+'/'+totalpage+'页');
                    if(type != "init"){
                        //获取第num页数据，
                        var managerName = $("#managerName").val();
                        var startTime = $("#startTime").val();
                        var endTime = $("#endTime").val();
                        initData(num,15,managerName,startTime,endTime);
                    }
                }
            });

        });

        $("#searchBtn").click(function(){
            var managerName = $("#managerName").val();
            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            var totalpage = initData(1,15,managerName,startTime,endTime);
//            //数据添加到页面后，调用一下方式
            $.jqPaginator('#pagination', {
                totalPages: totalpage,  //总页数
                visiblePages: 3,  //可见页面
                currentPage: 1,   //当前页面
                onPageChange: function (num, type) {
                    $('#showing').text('共'+totalpage+'页  第'+num+'/'+totalpage+'页');
                    if(type != "init"){
                        //获取第num页数据，
                        initData(num,15,managerName,startTime,endTime);
                    }
                }
            });
        })

    </script>

</body>
</html>
