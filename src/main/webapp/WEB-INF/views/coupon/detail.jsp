<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>优惠券管理</title>

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
            <li class="active">优惠券使用统计</li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">

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
                                                    <label class="control-label col-md-3 padding-right-5">用户名/手机号</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <input type="text" class="form-control" id="phoneNumber" placeholder="用户名/手机号" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">类型</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select class="form-control" name="type" id="type">
                                                            <option value="">全部</option>
                                                            <option value="0">优惠券</option>
                                                            <option value="1">现金券</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5">使用状态</label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <select class="form-control" name="isValid" id="isValid">
                                                            <option value="">全部</option>
                                                            <option value="0">已使用</option>
                                                            <option value="1">未使用</option>
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
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 padding-right-5"></label>
                                                    <div class="col-md-8 padding-left-5">
                                                        <button id="search" type="button" onclick="sub();" class="btn btn-blue"><i class="fa fa-search"></i>查询</button>
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
                                优惠券使用统计
                                <a class="refresh primary margin-right-20" data-toggle="tooltip" data-placement="bottom" data-original-title="点击刷新" id="refresh-toggler" href="">
                                    <i class="glyphicon glyphicon-refresh"></i>
                                </a>
                                <a href="javascript:void(0)" onclick="exportExcel()" class="btn btn-success float-right btn-sm"><i class="fa fa-plus"></i>导出Excel</a>
                            </div>

                            <div class="portlet-body">
                                <table class="table table-hover table-bordered" id="listTable">
                                    <thead>
                                        <tr>
                                            <th>用户名</th>
                                            <th>面值</th>
                                            <th>类型</th>
                                            <th>最低消费使用</th>
                                            <th>有效时间</th>
                                            <th>是否使用</th>
                                            <th>说明</th>
                                        </tr>
                                    </thead>
                                    <tbody id="dataDiv"  >

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 表格结束 -->
            </div>

    </div>
    <form id="downLoadForm" style="display: none;"  action="<%=request.getContextPath()%>/web/coupon/exportCouponUseDetail" method="POST">
        <input type="text" name="titleArray" id="titleArray">
        <input type="text" name="valueArray" id="valueArray" value="[]">
        <input type="text" name="phoneNumber" id="phoneNumberTemp">
        <input type="text" name="type" id="typeTemp">
        <input type="text" name="isValid" id="isValidTemp">
        <input type="text" name="startTime" id="startTimeTemp">
        <input type="text" name="endTime" id="endTimeTemp">
    </form>
    <!-- 引用公用js -->
    <jsp:include page="../common/resources-js.jsp"></jsp:include>
    <!-- 私有js -->
    <script src="<%=request.getContextPath()%>/resources/js/coupon/detail.js"></script>
    <script>



        $(function(){

            addpage(); //加载分页方法


            //返回的数据不为undefind(也就是有数据时),调用$('#pageCon').show();
            $('#pageCon').show();

            var totalpage = initData(null,null,null,null,null,1,15);

            //数据添加到页面后，调用一下方式
            $.jqPaginator('#pagination', {
                totalPages: totalpage,  //总页数
                visiblePages: 3,  //可见页面
                currentPage: 1,   //当前页面
                onPageChange: function (num, type) {
                    $('#showing').text('共'+totalpage+'页  第1/'+totalpage+'页');
                    if(type != "init"){
                        var phoneNumber = $("#phoneNumber").val();
                        var type = $("#type").val();
                        var isValid = $("#isValid").val();
                        var startTimes = $("#startTime").val();
                        var endTimes = $("#endTime").val();
                        var startTime = null;
                        var endTime = null;
                        if (typeof (startTimes) != "undefined" && startTimes != null && startTimes != "") {
                            startTime = getTime(startTimes);
                        }
                        if (typeof (endTimes) != "undefined" && endTimes != null && endTimes != "") {
                            endTime = getTime(endTimes);
                        }
                        //获取第num页数据，
                        initData(type,phoneNumber,startTime,endTime,isValid,num,15);
                    }
                }
            });

        });
        function sub(){
            var phoneNumber = $("#phoneNumber").val();
            var type = $("#type").val() == "" ? null : $("#type").val();
            var isValid = $("#isValid").val() == "" ? null : $("#isValid").val();
            var startTimes = $("#startTime").val();
            var endTimes = $("#endTime").val();
            var startTime = null;
            var endTime = null;
            if (typeof (startTimes) != "undefined" && startTimes != null && startTimes != "") {
                startTime = Number(new Date(startTimes).getTime()) / 1000;
            }
            if (typeof (endTimes) != "undefined" && endTimes != null && endTimes != "") {
                endTime = Number(new Date(endTimes).getTime()) / 1000 + 3600 * 24;
            }
            //获取第num页数据，
            initData(type,phoneNumber,startTime,endTime,isValid,1,15);
        }
    </script>

</body>
</html>
