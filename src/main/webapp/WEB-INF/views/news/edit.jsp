<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>查看/编辑精品生活</title>

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
                <a target="iframe" href="<%=request.getContextPath()%>/web/news/list">精品生活列表</a>
            </li>
            <li class="active">
                <span>查看/编辑精品生活</span>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <div class="widget">
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">查看/编辑精品生活</div>
                        <div class="portlet-body">
                            <form  class="form-horizontal" id="dataForm" >
                                <div class="form-body">

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">标题</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${news.title}" name="title" id="title" placeholder="请输入标题">
                                                <input type="hidden" value="${news.id}" name="id" id="id">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">封面图(建议尺寸：810:480)</label>
                                            <div class="col-md-3">
                                                <img src="<%=request.getContextPath()%>/${news.img}"  id="imgSrc" style="width: 230px;height: 150px;">
                                                <div>
                                                    <input class="btn btn-danger" style="margin-top: 5px" type="button" value="移除" id="deleteImg">
                                                </div>
                                                <input class="btn btn-blue" type="button" style="display: none" value="上传图片" id="addImg">
                                                <input type="hidden" value="${news.img}" name="coverImg" id="coverImg">

                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">小图标</label>
                                            <div class="col-md-3">
                                                <img src="<%=request.getContextPath()%>/${news.icon}"  id="iconSrc" style="width: 230px;height: 150px;">
                                                <div>
                                                    <input class="btn btn-danger" style="margin-top: 5px" type="button" value="移除" id="deleteIcon">
                                                </div>
                                                <input class="btn btn-blue" type="button" style="display: none" value="上传图片" id="addIcon">
                                                <input type="hidden" value="${news.icon}" name="icon" id="icon">
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">推荐指数</label>
                                            <div class="col-md-8">
                                                <input type="number" class="form-control" value="${news.recommendationIndex}" name="recommendationIndex" id="recommendationIndex" placeholder="设置推荐指数 最高为5">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">内容</label>
                                            <div class="col-md-8">
                                                <textarea id="content" class="form-control textarea"  type="text"   name="content">${news.content}</textarea>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/news/list" target="iframe" onclick="return updateNews()" class="btn btn-info">确认修改</a>
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
        //调 编辑器
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





        // 提交更新菜品
        function  updateNews(){


            var title = $("#title").val();
            var img = $("#coverImg").val();
            var icon = $("#icon").val(); //
            var recommendationIndex = $("#recommendationIndex").val();
            var id = $("#id").val();
            var content = $("#content").code();


            if($.trim(title).length <= 0){
                Notify("没有填写标题",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(img).length <= 0){
                Notify("没有上传图片",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if(recommendationIndex > 5 || recommendationIndex <= 0){
                Notify("推荐指数最高为 5",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(icon).length <= 0){
                Notify("没有上传小图标",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(content).length <= 0){
                Notify("没有填写内容",'top-right','5000','danger','fa-desktop',true);
                return false;
            }


            $.ajax({
                type : "POST",
                url : getRootPath()+"/web/news/updateNews",
                data :{
                    title:title,
                    img:img,
                    icon:icon,
                    recommendationIndex:recommendationIndex,
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
