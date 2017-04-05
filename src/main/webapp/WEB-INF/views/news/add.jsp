<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>添加精品生活</title>

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
                <a target="iframe" href="<%=request.getContextPath()%>/web/news/list">菜品列表</a>
            </li>
            <li class="active">
                <span>添加精品生活</span>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <div class="widget">
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">添加精品生活</div>
                        <div class="portlet-body">
                            <form  class="form-horizontal" id="dataForm" >
                                <div class="form-body">

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">标题</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="title" id="title" placeholder="请输入标题(150字以内)" maxlength="150">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">封面图(建议尺寸：810:4800)</label>
                                            <div class="col-md-3">
                                                <img src=""  id="imgSrc" style="width: 230px;height: 150px;display: none">
                                                <input class="btn btn-blue" type="button" value="上传图片" id="addImg">
                                                <input type="hidden" name="coverImg" id="coverImg">
                                                <div>
                                                    <input class="btn btn-danger" style="display:none;margin-top: 5px" type="button" value="移除" id="deleteImg">
                                                </div>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">小图标</label>
                                            <div class="col-md-3">
                                                <img src=""  id="iconSrc" style="width: 230px;height: 150px;display: none">
                                                <input class="btn btn-blue" type="button" value="上传图片" id="addIcon">
                                                <input type="hidden" name="icon" id="icon">
                                                <div>
                                                    <input class="btn btn-danger" style="display:none;margin-top: 5px" type="button" value="移除" id="deleteIcon">
                                                </div>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>



                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">推荐指数</label>
                                            <div class="col-md-8">
                                                <input type="number" class="form-control" name="recommendationIndex" id="recommendationIndex" placeholder="设置推荐指数 最高为5">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">内容</label>
                                            <div class="col-md-8">
                                                <textarea id="content" class="form-control textarea"  type="text"   name="content"></textarea>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/news/list" target="iframe" onclick="return addNews()" class="btn btn-info">提交</a>
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
    <script src="<%=request.getContextPath()%>/resources/js/news/add.js"></script>

    <!-- 私有js -->
    <script>
        //调 编辑器
        $('#content').summernote({
            height: 500,
            onImageUpload: function(files, editor, $editable) {
                sendFile(files, editor, $editable);
            }
        });
        //上传ICON
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


        $(function() {



        });






    </script>
</body>
</html>
