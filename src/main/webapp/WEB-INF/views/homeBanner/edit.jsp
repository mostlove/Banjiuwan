<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>查看/编辑首页轮播图</title>

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
            <a target="iframe" href="<%=request.getContextPath()%>/web/homeBanner/list">Banner列表</a>
        </li>
        <li class="active">
            <span>查看/编辑首页轮播图</span>
        </li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<div class="page-body">
    <div class="widget">
        <div class="row">
            <div class="col-md-12">
                <div class="well with-header">
                    <div class="header bordered-darkpink">查看/编辑首页轮播图</div>
                    <div class="portlet-body">
                        <form  class="form-horizontal" id="dataForm" >
                            <div class="form-body">
                                <div class="form-group border-1">

                                    <div class="inline-form">
                                        <label class="control-label col-md-2">标题</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" value="${homeBanner.title}" name="title" id="title" placeholder="请输入标题 150个字以内">
                                            <span class="help-block"></span>
                                        </div>

                                    </div>
                                </div>

                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2"> 类型(类型编辑无效)</label>
                                        <div class="col-md-6 padding-left-5">
                                            <div class="form-group">
                                                <div class="checkbox">
                                                    <label disabled>
                                                        <input name="type"  value="0" type="radio" <c:if test="${homeBanner.type == 0}">checked</c:if>>
                                                        <span class="text">首页轮播</span>
                                                    </label>
                                                    <label>
                                                        <input name="type"  value="1" type="radio" <c:if test="${homeBanner.type == 1}">checked</c:if> >
                                                        <span class="text">首页弹出(建议尺寸：600:990)</span>
                                                    </label>
                                                    <label disabled>
                                                        <input name="type"  value="2" type="radio" <c:if test="${homeBanner.type == 2}">checked</c:if> >
                                                        <span class="text">发现板块</span>
                                                    </label>
                                                    <label disabled>
                                                        <input name="type"  value="3" type="radio" <c:if test="${homeBanner.type == 3}">checked</c:if> >
                                                        <span class="text">实时菜价</span>
                                                    </label>
                                                </div>
                                            </div>
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">上传图片(建议尺寸(除弹出图外)：810:480)</label>
                                        <div class="col-md-3">
                                            <img src=""  id="imgSrc" style="width: 230px;height: 150px;">
                                            <input class="btn btn-blue" style="display: none" type="button" value="上传图片" id="addImg">
                                            <input type="hidden" name="banner" value="${homeBanner.banner}" id="banner">
                                            <div>
                                                <input class="btn btn-danger" style="margin-top: 5px" type="button" value="删除" id="deleteImg">
                                            </div>
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">内容</label>
                                        <div class="col-md-8">
                                            <textarea id="content" class="form-control textarea" placeholder="请输入内容" type="text" maxlength="200"  name="content">${homeBanner.content}</textarea>
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2"></label>
                                        <div class="col-md-8">
                                            <a href="<%=request.getContextPath()%>/web/homeBanner/list" target="iframe" onclick="return updateHomeBanner()" class="btn btn-info">确认修改</a>
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
    //上传相册
    $("#addImg").browser({
        callback:function(images) {
            var path = bjw.base+"/"+images;
            $("#imgSrc").attr('src',path);
            $("#imgSrc").show("slow");
            $("#banner").val(images);
            $("#addImg").hide();
            $("#deleteImg").show("slow");
        }
    });

    $("#deleteImg").click(function(){
        $("#imgSrc").hide("slow");
        $("#addImg").show("normal");
        $("#banner").val("");
        $("#deleteImg").hide();
    });


    $(function() {
        var path = bjw.base+"/"+$("#banner").val();;
        $("#imgSrc").attr('src',path);
    });

    // 提交修改Banner
    function  updateHomeBanner(){
        var title = $("#title").val();
        var content = $("#content").code();
        var banner = $("#banner").val();
        var id = "${homeBanner.id}";
        if(title.length ==0 || title.length > 150){
            Notify("请填写标题",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
        if(content.length == 0){
            Notify("请输入内容",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
        if(banner.length == 0){
            Notify("请上传图片",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
        $.ajax({
            type : "POST",
            url : getRootPath()+"/web/homeBanner/updateHomeBanner",
            data :{
                title:title,
                content:content,
                banner:banner,
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
