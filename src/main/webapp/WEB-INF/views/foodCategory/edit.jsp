<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>编辑菜品分类</title>

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
            <a target="iframe" href="<%=request.getContextPath()%>/web/foodCategory/list">菜品分类列表</a>
        </li>
        <li class="active">
            <span>编辑菜品分类</span>
        </li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<div class="page-body">
    <div class="widget">
        <div class="row">
            <div class="col-md-12">
                <div class="well with-header">
                    <div class="header bordered-darkpink">编辑菜品分类</div>
                    <div class="portlet-body">
                        <form  class="form-horizontal" id="dataForm" >
                            <div class="form-body">
                                <div class="form-group border-1">

                                    <div class="inline-form">
                                        <label class="control-label col-md-2">分类名称</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" value="${food.categoryName}"  name="categoryName" id="categoryName" placeholder="请输入名称">
                                            <span class="help-block"></span>
                                        </div>

                                    </div>
                                </div>

                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">未选中图标</label>
                                        <div class="col-md-3">
                                            <img src="<%=request.getContextPath()%>/${food.icon}"  id="iconSrc" style="width: 60px;height: 60px;">
                                            <input class="btn btn-blue" style="display: none" type="button" value="上传图片" id="addIcon">
                                            <input type="hidden" value="${food.icon}" name="icon"  id="icon">
                                            <div>
                                                <input class="btn btn-danger" style="margin-top: 5px" type="button" value="删除" id="deleteIcon">
                                            </div>
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">选中图标</label>
                                        <div class="col-md-3">
                                            <img src="<%=request.getContextPath()%>/${food.selectedIcon}"  id="selectIconIcon" style="width: 60px;height: 60px;">
                                            <input class="btn btn-blue" style="display: none" type="button" value="上传图片" id="addSelectedIcon">
                                            <input type="hidden" value="${food.selectedIcon}" name="selectedIcon"  id="selectedIcon">
                                            <div>
                                                <input class="btn btn-danger" style="margin-top: 5px" type="button" value="删除" id="delectSelectedIcon">
                                            </div>
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group border-1">

                                    <div class="inline-form">
                                        <label class="control-label col-md-2">排序(降序排列)</label>
                                        <div class="col-md-8">
                                            <input type="number" class="form-control" value="${food.seriaNumber}" name="seriaNumber" id="seriaNumber" value="1" placeholder="排序(越大排前面)">
                                            <span class="help-block"></span>
                                        </div>

                                    </div>
                                </div>

                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2"></label>
                                        <div class="col-md-8">
                                            <a href="<%=request.getContextPath()%>/web/foodCategory/list" target="iframe" onclick="return updateHomeBanner()" class="btn btn-info">确认修改</a>
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

    //上传相册
    $("#addSelectedIcon").browser({
        callback:function(images) {
            var path = bjw.base+"/"+images;
            $("#selectIconIcon").attr('src',path);
            $("#selectIconIcon").show("slow");
            $("#selectedIcon").val(images);
            $("#addSelectedIcon").hide();
            $("#delectSelectedIcon").show("slow");
        }
    });

    $("#delectSelectedIcon").click(function(){
        $("#selectIconIcon").hide("slow");
        $("#addSelectedIcon").show("normal");
        $("#selectedIcon").val("");
        $("#delectSelectedIcon").hide();
    });

    //上传相册
    $("#addIcon").browser({
        callback:function(images) {
            var path = bjw.base+"/"+images;
            $("#iconSrc").attr('src',path);
            $("#iconSrc").show("slow");
            $("#icon").val(images);
            $("#addIcon").hide();
            $("#deleteIcon").show("slow");
        }
    });

    $("#deleteIcon").click(function(){
        $("#iconSrc").hide("slow");
        $("#addIcon").show("normal");
        $("#icon").val("");
        $("#deleteIcon").hide();
    });


    $(function() {
//        var path = bjw.base+"/"+$("#banner").val();;
//        $("#imgSrc").attr('src',path);
    });

    // 提交修改Banner
    function  updateHomeBanner(){
        var selectedIcon = $("#selectedIcon").val();
        var icon = $("#icon").val();
        var categoryName = $("#categoryName").val();
        var id = "${food.id}";
        var seriaNumber = $("#seriaNumber").val();
        if($.trim(categoryName).length ==0 || categoryName.length > 150){
            Notify("请填写分类名称",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
        if(selectedIcon.length == 0){
            Notify("请上传选中图标",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
        if(icon.length == 0){
            Notify("请上传未选中图片",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
        var reg =  /^\+?[1-9][0-9]*$/;
        if(!reg.test(seriaNumber)){
            Notify("排序号为正整数",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
        $.ajax({
            type : "POST",
            url : getRootPath()+"/web/foodCategory/updateFoodCategory",
            data :{
                selectedIcon:selectedIcon,
                icon:icon,
                categoryName:categoryName,
                seriaNumber:seriaNumber,
                id:id
            },
            dataType :"json",
            async : false,
            timeout : 5000,
            success : function(json){
                if(json.code == 200){
                    Notify("更新成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                    return true;
                }
                else{
                    Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                    return false;
                }
            }
        })
    }
</script>
</body>
</html>
