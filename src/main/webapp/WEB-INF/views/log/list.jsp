<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>充值记录列表</title>

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
            <li class="active">充值记录列表</li>
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
                                                    <label class="control-label col-md-3 padding-right-5">操作人</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control" name="userName" id="userName" placeholder="用户名" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">操作动作类型</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select class="form-control" name="operateTypes" id="operateTypes">
                                                            <option value="">全部</option>
                                                            <option value="0">插入数据</option>
                                                            <option value="2">更新数据</option>
                                                            <option value="3">查询数据</option>
                                                            <option value="4">删除数据</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">被操作类型</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select id="toOperateType" name="toOperateType" class="form-control">
                                                            <option value="" selected>全部</option>
                                                            <option value="0">厨师</option>
                                                            <option value="1">普通用户</option>
                                                            <option value="2">后台用户</option>
                                                            <option value="3">菜品</option>
                                                            <option value="6">订单</option>
                                                            <option value="13">订单溢价</option>
                                                            <option value="14">交通配置</option>
                                                            <option value="15">全局配置</option>
                                                            <option value="16">服务费配置</option>
                                                            <option value="17">充值参数配置</option>
                                                            <option value="18">权限配置</option>
                                                            <option value="19">首页字体配置</option>
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
                                                        <button id="search" type="button" class="btn btn-blue"><i class="fa fa-search"></i>查询</button>
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
                                操作日志列表
                               <%-- <a href="javascript:void(0)" onclick="exportData()" class="btn btn-success float-right btn-sm"><i class="fa fa-plus"></i>导出数据</a>--%>
                            </div>
                            <div class="portlet-body">
                                <table class="table table-hover table-bordered" id="listTable">
                                    <thead>
                                        <tr>
                                            <th>操作动作类型</th>
                                            <th>被操作类型</th>
                                            <th>操作描述</th>
                                            <th>操作人姓名</th>
                                            <th>ip地址</th>
                                            <th>记录时间</th>
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
    <script src="<%=request.getContextPath()%>/resources/js/log/list.js"></script>
    <script>

        $(function(){

            addpage(); //加载分页方法


            //返回的数据不为undefind(也就是有数据时),调用$('#pageCon').show();
            $('#pageCon').show();

            initData(1,15,null,null,null,null,null);

            //数据添加到页面后，调用一下方式
//            $.jqPaginator('#pagination', {
//                totalPages: totalpage,  //总页数
//                visiblePages: 3,  //可见页面
//                currentPage: 1,   //当前页面
//                onPageChange: function (num, type) {
//                    $('#showing').text('共'+totalpage+'页  第1/'+totalpage+'页');
//                    if(type != "init"){
//
//                        var userName = $("#userName").val();
//                        var operateTypes = $("#operateTypes").val();
//                        var toOperateType = $("#toOperateType").val();
//                        var startTime = $("#startTime").val();
//                        var endTime = $("#endTime").val();
//                        userName = userName.length == 0 ? null : userName;
//                        //获取第num页数据，
//                        initData(num,15,operateTypes,userName,toOperateType,
//                                startTime.length == 0 ? null : new Date(startTime).getTime(),
//                                startTime.length == 0 ? null : new Date(endTime).getTime());
//                    }
//                }
//            });


            $("#search").click(function(){

                var userName = $("#userName").val();
                var operateTypes = $("#operateTypes").val();
                var toOperateType = $("#toOperateType").val();
                var startTime = $("#startTime").val();
                var endTime = $("#endTime").val();
                userName = userName.length == 0 ? null : userName;
                //获取第num页数据，
                initData(1,15,operateTypes,userName,toOperateType,startTime,endTime);
//                $.jqPaginator('#pagination', {
//                    totalPages: totalpage,  //总页数
//                    visiblePages: 3,  //可见页面
//                    currentPage: 1,   //当前页面
//                    onPageChange: function (num, type) {
//                        $('#showing').text('共'+totalpage+'页  第1/'+totalpage+'页');
//                        if(type != "init"){
//
//                            var userName = $("#userName").val();
//                            var operateTypes = $("#operateTypes").val();
//                            var toOperateType = $("#toOperateType").val();
//                            var startTime = $("#startTime").val();
//                            var endTime = $("#endTime").val();
//                            userName = userName.length == 0 ? null : userName;
//                            //获取第num页数据，
//                            initData(num,15,operateTypes,userName,toOperateType,
//                                    startTime.length == 0 ? null : new Date(startTime).getTime(),
//                                    startTime.length == 0 ? null : new Date(endTime).getTime());
//                        }
//                    }
//                });
            })

        });



    </script>

</body>
</html>
