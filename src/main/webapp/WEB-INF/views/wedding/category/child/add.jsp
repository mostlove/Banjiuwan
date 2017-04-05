<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>添加区域配置</title>

    <!-- 引用公用css -->
    <jsp:include page="../../../common/resources-css.jsp"></jsp:include>
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
                <a target="iframe" href="javascript:void(0)" onclick="self.location=document.referrer;">返回上一级</a>
            </li>
            <li class="active">
                <span>添加区域配置</span>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <div class="widget">
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">添加区域配置</div>
                        <div class="portlet-body">
                            <form  class="form-horizontal" id="dataForm" >
                                <div class="form-body">

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">上一级名称</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${categoryName}" disabled="disabled">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">区域名称</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="name" id="name" placeholder="请输入子分类名称">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">图片</label>
                                            <div class="col-md-3">
                                                <img src=""  id="imgSrc" style="width: 230px;height: 150px;display: none">
                                                <input class="btn btn-blue" type="button" value="上传图片" id="addImg">
                                                <input type="hidden" name="topBanner" id="coverImg">
                                                <input type="hidden" name="categoryId" id="categoryId" value="${weddingCategoryId}">
                                                <div>
                                                    <input class="btn btn-danger" style="display:none;margin-top: 5px" type="button" value="移除" id="deleteImg">
                                                </div>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/wedding/category/child/list?weddingCategoryId=${weddingCategoryId}&categoryName=${categoryName}" target="iframe" onclick="return addChildCategory()" class="btn btn-info">提交</a>
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
    <jsp:include page="../../../common/resources-js.jsp"></jsp:include>
    <!-- 引用富文本 -->
    <script src="<%=request.getContextPath()%>/resources/assets/js/editors/summernote/summernote.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/wedding/category/child/add.js"></script>

    <!-- 私有js -->
    <script>






        function removedImg(obj){
            var jQueryObj = $(obj);
            jQueryObj.hide(); // 隐藏删除
            var topDiv = jQueryObj.parent().parent();
            var img = $(topDiv).find("img")[0];
            $(img).hide('slow');
            var addBtn = $(topDiv).find('input')[2];
            var imgInput = $(topDiv).find('input')[3];
            var configBtn = $(topDiv).find('input')[5];// 配置按钮
            $(addBtn).show();
            $(imgInput).val("");
            $(configBtn).hide('slow');
        }




        //上传相册
        $("#addImg").browser({
            callback:function(images) {
                var path = bjw.base+"/"+images;
                $("#imgSrc").attr('src',path);
                $("#imgSrc").show("slow");
                $("#coverImg").val(images);
                $("#addImg").hide();
                $("#deleteImg").show("slow");
            }
        });

        $("#deleteImg").click(function(){
            $("#imgSrc").hide("slow");
            $("#addImg").show("normal");
            $("#coverImg").val("");
            $("#deleteImg").hide();
        });








    </script>
</body>
</html>
