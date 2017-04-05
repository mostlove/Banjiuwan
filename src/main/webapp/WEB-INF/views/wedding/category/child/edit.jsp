<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>编辑子类</title>

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
                <a target="iframe" href="javascript:void(0)">子类列表</a>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <div class="widget">
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">编辑子类</div>
                        <div class="portlet-body">
                            <form  class="form-horizontal" id="dataForm" >
                                <div class="form-body">

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">名称</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${name}" name="name" id="name" placeholder="请输入名称">
                                                <input type="hidden" value="${id}" name="id" id="id">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">图片</label>
                                            <div class="col-md-3">
                                                <img src="<%=request.getContextPath()%>/${img}"  id="imgSrc" style="width: 230px;height: 150px;">
                                                <div>
                                                    <input class="btn btn-danger" style="margin-top: 5px" type="button" value="移除" id="deleteImg">
                                                </div>
                                                <input class="btn btn-blue" type="button" style="display: none" value="上传图片" id="addImg">
                                                <input type="hidden" value="${img}" name="coverImg" id="coverImg">

                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/wedding/category/child/list?weddingCategoryId=${weddingCategoryId}&categoryName=${categoryName}" target="iframe" onclick="return updateChildCategory()" class="btn btn-info">确认修改</a>
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

    <div id="divHtml">

    </div>

    <!-- 引用公用js -->
    <jsp:include page="../../../common/resources-js.jsp"></jsp:include>
    <!-- 引用富文本 -->
    <script src="<%=request.getContextPath()%>/resources/assets/js/editors/summernote/summernote.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/package/edit.js"></script>
    <!-- 私有js -->
    <script>
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

        var imgMaps = new Map();


        $(function() {

        });

        // 提交更新
        function  updateChildCategory(){


            var name = $("#name").val();
            var img = $("#coverImg").val();
            var id = $("#id").val();

            if($.trim(name).length <= 0){
                Notify("没有填写名称",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(img).length <= 0){
                Notify("没有上传图片",'top-right','5000','danger','fa-desktop',true);
                return false;
            }


            $.ajax({
                type : "POST",
                url : getRootPath()+"/web/weddingChildCategory/update",
                data :{
                    name:name,
                    img:img,
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
