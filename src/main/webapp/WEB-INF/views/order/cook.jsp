<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>分配厨师</title>

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
            <li>
                <a target="iframe" href="<%=request.getContextPath()%>/web/order/list">订单列表</a>
            </li>
            <li class="active">
                <span>分配厨师</span>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <div class="widget">
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">分配厨师</div>
                        <div class="portlet-body">
                            <form  class="form-horizontal" id="dataForm" >
                                <div class="form-body">

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">主厨师</label>
                                            <div class="col-md-8">
                                                <select id="mainCook" class="form-control">
                                                    <c:forEach items="${cooks}" var="cook">
                                                        <option value="${cook.id}">${cook.realName}</option>
                                                    </c:forEach>
                                                </select>
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">辅助厨师</label>
                                            <div class="col-md-8">
                                                <select id="cook"  multiple="multiple">
                                                    <c:forEach items="${cooks}" var="cook" >
                                                        <option value="${cook.id}">${cook.realName}</option>
                                                    </c:forEach>
                                                </select>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>



                                    <input type="hidden" value="${orderId}" id="orderId">
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/order/list" target="iframe" onclick="return cookSubmit()" class="btn btn-info">提交</a>
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
    <script>
        $(function() {
            $("#cook").select2({
                placeholder: "请选择厨师",
                allowClear: true
            });
        });

    function cookSubmit(){

        var mainCook = $("#mainCook").val();
        var cook = $("#cook").val();
        if(mainCook == 0){
            Notify("未选择主厨师",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
//        if(null == cook || cook.length == 0){
//            Notify("未选择厨师",'top-right','5000','danger','fa-desktop',true);
//            return false;
//        }
        if(null != cook){
            for (var i=0; i < cook.length; i++){
                if(mainCook == cook[i]){
                    Notify("辅助厨师中不能包含主厨师",'top-right','5000','danger','fa-desktop',true);
                    return false;
                }
            }
        }
        cook = JSON.stringify(cook);
        var orderId = $("#orderId").val();
        $.ajax({
            type : "POST",
            url : getRootPath()+"/web/order/cookOrder",
            data :{
                mainCook:mainCook,
                cooks:cook,
                orderId:orderId
            },
            dataType :"json",
            async : false,
            timeout : 5000,
            success : function(json){
                if(json.code == 200){
                    return true;
                }
                else{
                    Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                    return false;
                }
            }
        });

    }




    </script>
</body>
</html>
