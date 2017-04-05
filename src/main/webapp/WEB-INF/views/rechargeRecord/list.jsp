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
                                                    <label class="control-label col-md-3 padding-right-5">用户名</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control" name="userName" id="userName" placeholder="用户名" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">手机号</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="联系人" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">支付方式</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select id="payMethod" class="form-control">
                                                            <option value="2" selected>全部</option>
                                                            <option value="0">微信支付</option>
                                                            <option value="1">支付宝支付</option>
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
                                                    <label class="control-label col-md-3 padding-right-5">支付状态</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select class="form-control" name="status" id="status">
                                                            <option value="2">全部</option>
                                                            <option value="0">未支付</option>
                                                            <option value="1">已支付</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">起始充值时间</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control searchinput selectTime" readonly id="startTime" name="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"  placeholder="充值起始时间" value="">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">充值截至时间</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control searchinput selectTime" readonly id="endTime" name="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"  placeholder="充值截至时间" value="">
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
                                充值记录列表
                                <a href="javascript:void(0)" onclick="exportData()" class="btn btn-success float-right btn-sm"><i class="fa fa-plus"></i>导出数据</a>
                            </div>
                            <div class="portlet-body">
                                <table class="table table-hover table-bordered" id="listTable">
                                    <thead>
                                        <tr>
                                            <th>用户名</th>
                                            <th>手机号</th>
                                            <th>充值金额</th>
                                            <th>赠送金额</th>
                                            <th>订单交易号</th>
                                            <th>充值状态</th>
                                            <th>支付方式</th>
                                            <th>充值时间</th>
                                            <%--<th>备注</th>--%>
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

    <form id="downLoadForm" style="display: none;"  action="<%=request.getContextPath()%>/web/rechargeRecord/downLoadRechargeRecord" method="POST">
        <input type="text" name="titlesArr" id="titlesArr">
        <input type="text" name="columnsArr" id="columnsArr" value="[]">
        <input type="text" name="str" id="str" value="123">
        <input type="text" name="userName" id="userNameTemp">
        <input type="text" name="phoneNumber" id="phoneNumberTemp">
        <input type="text" name="payMethod" id="payMethodTemp">
        <input type="text" name="status" id="statusTemp">
        <input type="text" name="startTime" id="startTimeTemp">
        <input type="text" name="endTime" id="endTimeTemp">
    </form>
    <!-- 引用公用js -->
    <jsp:include page="../common/resources-js.jsp"></jsp:include>
    <!-- 私有js -->
    <script src="<%=request.getContextPath()%>/resources/js/rechargeRecord/list.js"></script>
    <script>

        $(function(){

            addpage(); //加载分页方法


            //返回的数据不为undefind(也就是有数据时),调用$('#pageCon').show();
            $('#pageCon').show();

            var totalpage = initData(1,15,null,null);

            //数据添加到页面后，调用一下方式
            $.jqPaginator('#pagination', {
                totalPages: totalpage,  //总页数
                visiblePages: 3,  //可见页面
                currentPage: 1,   //当前页面
                onPageChange: function (num, type) {
                    $('#showing').text('共'+totalpage+'页  第1/'+totalpage+'页');
                    if(type != "init"){

                        var userName = $("#userName").val();
                        var phoneNumber = $("#phoneNumber").val();
                        var payMethod = $("#payMethod").val();
                        var status = $("#status").val();
                        var startTime = $("#startTime").val();
                        var endTime = $("#endTime").val();
                        phoneNumber = phoneNumber.length == 0 ? null : phoneNumber;
                        userName = userName.length == 0 ? null : userName;
                        //获取第num页数据，
                        initData(num,15,phoneNumber,userName,payMethod,status,
                                startTime.length == 0 ? null : new Date(startTime).getTime(),
                                startTime.length == 0 ? null : new Date(endTime).getTime());
                    }
                }
            });


            $("#search").click(function(){

                var userName = $("#userName").val();
                var phoneNumber = $("#phoneNumber").val();
                var payMethod = $("#payMethod").val();
                var status = $("#status").val();
                var startTime = $("#startTime").val();
                var endTime = $("#endTime").val();
                var totalpage = initData(1,15,phoneNumber,userName,payMethod,status,
                        startTime.length == 0 ? null : new Date(startTime).getTime(),
                        startTime.length == 0 ? null : new Date(endTime).getTime());
                $.jqPaginator('#pagination', {
                    totalPages: totalpage,  //总页数
                    visiblePages: 3,  //可见页面
                    currentPage: 1,   //当前页面
                    onPageChange: function (num, type) {
                        $('#showing').text('共'+totalpage+'页  第1/'+totalpage+'页');
                        if(type != "init"){

                            var userName = $("#userName").val();
                            var phoneNumber = $("#phoneNumber").val();
                            var payMethod = $("#payMethod").val();
                            var status = $("#status").val();
                            var startTime = $("#startTime").val();
                            var endTime = $("#endTime").val();
                            console.debug(startTime);
                            phoneNumber = phoneNumber.length == 0 ? null : phoneNumber;
                            userName = userName.length == 0 ? null : userName;
                            //获取第num页数据，
                            initData(num,15,phoneNumber,userName,payMethod,status,
                                    startTime.length == 0 ? null : new Date(startTime).getTime(),
                                    startTime.length == 0 ? null : new Date(endTime).getTime());
                        }
                    }
                });
            })

        });



    </script>

</body>
</html>
