<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>添加优惠券</title>

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
                <a target="iframe" href="<%=request.getContextPath()%>/web/coupon/list">优惠券管理</a>
            </li>
            <li class="active">
                <span>添加优惠券</span>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <div class="widget">
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">添加优惠券</div>
                        <div class="portlet-body">
                            <form  class="form-horizontal" id="dataForm" >
                                <div class="form-body">
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">类型</label>
                                            <div class="col-md-8">
                                                <select id="type" onchange="changeCouponType()">
                                                    <option value="100">选择类型</option>
                                                    <option value="0">优惠券</option>
                                                    <option value="1">现金券</option>
                                                </select>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">面值</label>
                                            <div class="col-md-8">
                                                <input type="number" id="face_value" placeholder="输入面值 例如(100)"  class="form-control">
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1" id="need_spendDiv" style="display: none">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">满多少使用</label>
                                            <div class="col-md-8">
                                                <input type="number"  id="need_spend" placeholder="设置满多少钱可使用此优惠券 例如(300)" class="form-control">
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">使用区间</label>
                                            <div class="col-md-8">
                                                <select id="useInterval" multiple="multiple">
                                                    <c:forEach items="${categorys}" var="category">
                                                        <option value="${category.id}">${category.categoryName}</option>
                                                    </c:forEach>
                                                </select>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/coupon/list" target="iframe" onclick="return addCoupon()" class="btn btn-info">提交</a>
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
        function changeCouponType(){
            var type = $("#type").val();
            if(type == 1){
                $("#need_spendDiv").hide("slow");
            }
            else if(type == 0){
                $("#need_spendDiv").show("slow");
            }
            else{
                $("#need_spendDiv").hide("slow");
            }
        }


        $(function() {

            $("#useInterval").select2({
                placeholder: "请选择",
                allowClear: true
            });

        });

        function addCoupon(){
            var type = $("#type").val();
            var face_value = $("#face_value").val();
            var need_spend = $("#need_spend").val();
            var useInterval = $("#useInterval").val();

            if(type == 100){
                Notify("没有选择类型",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            var reg = /^\d{1,100000}$/;
            if(!reg.test(face_value) || face_value == 0){
                Notify("面值输入不合法",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if(type == 0){
                if(!reg.test(need_spend) || need_spend == 0){
                    Notify("满付输入不合法",'top-right','5000','danger','fa-desktop',true);
                    return false;
                }
            }

            useInterval = JSON.stringify(useInterval);

            $.ajax({
                type : "POST",
                url : getRootPath()+"/web/coupon/addCoupon",
                data :{
                    type:type,
                    faceValue:face_value,
                    useInterval:useInterval,
                    needSpend:need_spend
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
