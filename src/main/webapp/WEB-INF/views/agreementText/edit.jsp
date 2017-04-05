<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>查看/编辑</title>

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
            <a target="iframe" href="<%=request.getContextPath()%>/web/agreementText/list">返回列表</a>
        </li>
        <li class="active">
            <span>查看/编辑</span>
        </li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<div class="page-body">
    <div class="widget">
        <div class="row">
            <div class="col-md-12">
                <div class="well with-header">
                    <div class="header bordered-darkpink">查看/编辑</div>
                    <div class="portlet-body">
                        <form  class="form-horizontal" id="dataForm" >
                            <div class="form-body">
                                <div class="form-group border-1">

                                    <div class="inline-form">
                                        <label class="control-label col-md-2">标题</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" value="${agreementText.title}" name="title" id="title" placeholder="请输入标题 150个字以内">
                                            <span class="help-block"></span>
                                        </div>

                                    </div>
                                </div>

                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">内容</label>
                                        <div class="col-md-8">
                                            <textarea id="content" class="form-control textarea" placeholder="请输入内容" type="text" maxlength="200"  name="content">${agreementText.content}</textarea>
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" value="${agreementText.id}" id="agreementTextId">
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2"></label>
                                        <div class="col-md-8">
                                            <a href="<%=request.getContextPath()%>/web/agreementText/list" target="iframe" onclick="return updateText()" class="btn btn-info">确认修改</a>
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
    $('#content').summernote({
        height: 500,
        onImageUpload: function(files, editor, $editable) {
            sendFile(files, editor, $editable);
        }
    });

    // 提交修改Banner
    function  updateText(){
        var title = $("#title").val();
        var id = $("#agreementTextId").val();
        var content = $("#content").code();
        if(title.length ==0 || title.length > 150){
            Notify("请填写标题",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
        if(content.length == 0){
            Notify("请输入内容",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
        $.ajax({
            type : "POST",
            url : getRootPath()+"/web/agreementText/update",
            data :{
                title:title,
                content:content,
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
