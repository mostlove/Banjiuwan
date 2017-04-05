<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="utf-8" />
    <title>订单列表(未成交)</title>

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
            <li class="active">订单列表(未成交)</li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <form id="listForm" action="##" class="form-horizontal" method="POST" >
            <div class="widget">
                <!-- 高级查询开始 -->
                <div class="row" <%--style="display: none"--%>>
                    <div class="col-md-12">
                        <div class="well with-header">
                            <div class="header bordered-palegreen">高级查询</div>

                            <div class="portlet-body">
                                <div class="form-body">
                                    <div class="form-group margin-bottom-20">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">订单编号</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control" id="orderNumber" name="orderNumber" placeholder="订单编号" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">联系电话</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control" id="userPhone" name="userPhone" placeholder="联系电话" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">支付方式</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select class="form-control" id="payMethod" name="payMethod">
                                                            <option value="">全部</option>
                                                            <option value="0">微信</option>
                                                            <option value="1">支付宝</option>
                                                            <option value="2">线下</option>
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
                                                    <label class="control-label col-md-3 padding-right-5">订单状态</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <label class="form-control" >未成交</label>
                                                        <input type="hidden" id="status" name="status" value="2001,2009" />
                                                        <%--<select multiple="multiple" id="status" name="status">
                                                            <option value="2001">待支付</option>
                                                            <option value="2002">待确认</option>
                                                            <option value="2003">待服务</option>
                                                            <option value="2004">服务中</option>
                                                            <option value="2005">完成</option>
                                                            <option value="2006">待评价</option>
                                                            <option value="2007">评价完成</option>
                                                            <option value="2008">待接单</option>
                                                            <option value="2009">已取消</option>
                                                        </select>--%>
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
                                            <%--<div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">下单时间</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control searchinput selectTime" readonly id="createTime" name="createTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"  placeholder="入住时间" value="">
                                                    </div>
                                                </div>
                                            </div>--%>
                                        </div>
                                    </div>
                                    <div class="form-group margin-bottom-20">
                                        <div class="row">
                                            <%--<div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">入住日期</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control searchinput selectTime" readonly id="checkInTime" name="checkInTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"  placeholder="入住时间" value="">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">离店日期</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control searchinput selectTime" readonly id="checkOutTime" name="checkOutTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"  placeholder="离店时间" value="">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">是否需要接送服务</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select class="form-control" name="needTransfer">
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>--%>
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
                <input type="hidden" value="${roleId}" id="roleId">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="well with-header">
                            <div class="header bordered-darkpink">
                                订单列表
                                <a class="refresh primary margin-right-20" data-toggle="tooltip" data-placement="bottom" data-original-title="点击刷新" id="refresh-toggler" href="">
                                    <i class="glyphicon glyphicon-refresh"></i>
                                </a>
                                <a href="javascript:void(0)" onclick="exportExcel(1)" class="btn btn-success float-right btn-sm"><i class="fa fa-plus"></i>导出Excel</a>
                            </div>
                            <div class="portlet-body">
                                <table class="table table-hover table-bordered" id="listTable">
                                    <thead>
                                        <tr>
                                            <th>订单号</th>
                                            <th>发起用户</th>
                                            <th>调度员</th>
                                            <th>订单状态</th>
                                            <th>地址</th>
                                            <th>服务时间</th>
                                            <th>订单总价</th>
                                            <th>支付方式</th>
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
    <form id="downLoadForm" style="display: none;"  action="<%=request.getContextPath()%>/web/order/exportExcel" method="POST">
        <input type="text" name="titleArray" id="titleArray">
        <input type="text" name="valueArray" id="valueArray" value="[]">
        <input type="text" name="orderNumber" id="orderNumberTemp">
        <input type="text" name="userPhone" id="userPhoneTemp">
        <input type="text" name="payMethod" id="payMethodTemp">
        <input type="text" name="status" id="statusTemp">
        <input type="text" name="type" id="typeTemp">
        <input type="text" name="startTime" id="startTimeTemp">
        <input type="text" name="endTime" id="endTimeTemp">
    </form>
            <!-- 引用公用js -->
    <jsp:include page="../common/resources-js.jsp"></jsp:include>
    <!-- 私有js -->
    <script src="<%=request.getContextPath()%>/resources/js/order/list.js"></script>
    <script>



//        function initData(pageNO,pageSize,status){
//            var totalPage = 1;
//            $.ajax({
//                type : "POST",
//                url : getRootPath()+"/web/order/getOrders",
//                data :{
//                    status:status,
//                    pageNO:pageNO,
//                    pageSize:pageSize
//                },
//                dataType :"json",
//                async : false,
//                timeout : 5000,
//                success : function(json){
//                    if(json.code == 200){
//                        buildData(json.data.dataList);
//                        totalPage =  json.data.totalPage == 0 ? 1 : json.data.totalPage;
//                    }
//                    else{
//                        Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
//                    }
//                }
//            });
//            return totalPage;
//        }




        $(function(){
/*
            $("#status").select2({
                placeholder: "全部"
            });*/

            addpage(); //加载分页方法


            //返回的数据不为undefind(也就是有数据时),调用$('#pageCon').show();
            $('#pageCon').show();
            var totalpage = initData(1,15,$("#status").val(),null,null,null,null,null,1);

            //数据添加到页面后，调用一下方式
            $.jqPaginator('#pagination', {
                totalPages: totalpage,  //总页数
                visiblePages: 3,  //可见页面
                currentPage: 1,   //当前页面
                onPageChange: function (num, type) {
                    $('#showing').text('共'+totalpage+'页  第1/'+totalpage+'页');
                    if(type != "init"){
                        var status = $("#status").val();
                        var orderNumber = $("#orderNumber").val();
                        var userPhone = $("#userPhone").val();
                        var payMethod = $("#payMethod").val();
                        var startTime = $("#startTime").val();
                        var endTime = $("#endTime").val();
                        //获取第num页数据，
                        initData(num,15,status,orderNumber,userPhone,payMethod,startTime,endTime,1);
                    }
                }
            });

        });
        function sub(){
            var status = $("#status").val();
            var orderNumber = $("#orderNumber").val();
            var userPhone = $("#userPhone").val();
            var payMethod = $("#payMethod").val();
            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            //获取第num页数据，
            initData(1,15,status,orderNumber,userPhone,payMethod,startTime,endTime,1);
        }
    </script>

</body>
</html>
