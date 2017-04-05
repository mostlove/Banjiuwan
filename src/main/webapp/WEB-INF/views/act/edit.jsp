<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>查看/编辑伴餐演奏</title>

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
                <a target="iframe" href="<%=request.getContextPath()%>/web/act/list">伴餐演奏</a>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <div class="widget">
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">查看/编辑伴餐演奏</div>
                        <div class="portlet-body">
                            <form  class="form-horizontal" id="dataForm" >
                                <div class="form-body">

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">伴餐演奏名称</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${act.name}" name="foodName" id="foodName" placeholder="请输入伴餐演奏名称">
                                                <input type="hidden" value="${act.id}" name="id" id="id">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">计量单位</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${act.units}" name="units" id="units" placeholder="请输入计量单位(例如：桌、份)">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">销量</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${act.sales}" name="sales" id="sales" placeholder="请输入销量">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">菜品封面图</label>
                                            <div class="col-md-3">
                                                <img src="<%=request.getContextPath()%>/${act.topBanner}"  id="imgSrc" style="width: 230px;height: 150px;">
                                                <div>
                                                    <input class="btn btn-danger" style="margin-top: 5px" type="button" value="移除" id="deleteImg">
                                                </div>
                                                <input class="btn btn-blue" type="button" style="display: none" value="上传图片" id="addImg">
                                                <input type="hidden" value="${act.topBanner}" name="coverImg" id="coverImg">

                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">伴餐演奏单价</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${act.price}" name="price" id="price" placeholder="请输入伴餐演奏单价,最大支持小数点后两位(单元：元)"
                                                       onkeyup="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')" onblur="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">推荐指数</label>
                                            <div class="col-md-8">
                                                <input type="number" class="form-control" value="${act.recommendationIndex}" name="recommendationIndex" id="recommendationIndex" placeholder="设置推荐指数 最高为5">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>



                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">备注</label>
                                            <div class="col-md-8">
                                                <textarea id="introduction" class="form-control textarea" placeholder="请输入简介" type="text" maxlength="200"  name="introduction">${act.remarks}</textarea>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>


                                    <!-- 选择型 多图上传 -->
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">Banner图</label>
                                            <input type="hidden" value="${act.banners}" id="hiddenBanners">
                                            <div class="col-md-3">
                                                <input class="btn btn-blue" type="button" style="margin-top: 5px" value="上传图片" id="addBanner">
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">擅长节目</label>
                                            <div class="col-md-8">
                                                <textarea id="programmes" class="form-control textarea"  type="text" name="programmes">${act.programmes}</textarea>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>





                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/act/list" target="iframe" onclick="return updateFood()" class="btn btn-info">确认修改</a>
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
    <jsp:include page="../common/resources-js.jsp"></jsp:include>
    <!-- 引用富文本 -->
    <script src="<%=request.getContextPath()%>/resources/assets/js/editors/summernote/summernote.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/package/edit.js"></script>
    <!-- 私有js -->
    <script>

        $('#programmes').summernote({
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

        var imgMaps = new Map();


        $(function() {
            var banners = $("#hiddenBanners").val().split(",");
            for (var i=0; i < banners.length; i++){
                imgMaps.put(i,banners[i]);
            }
            // 初始化数据
            // 设置多banners
            initBanners();
        });





        function initBanners(){

            var keys = imgMaps.keySet();
            var imgStr = "";
            for(var i=0; i<keys.length; i++ ){
                imgStr += '<div>' +
                        '               <img src="'+bjw.base+"/"+imgMaps.get(keys[i])+'"  style="width: 230px;height: 150px;">'+
                        '                   <div>'+
                        '                       <input class="btn btn-danger" style="margin-top: 5px" type="button" value="移除" onclick="removeDiv(this,'+keys[i]+')">'+
                        '                  </div>' +
                        '         </div>';
            }
            // 在添加按钮前 插入 标签
            var addObj = $("#addBanner");
            addObj.before(imgStr);
            if(imgMaps.size() >= 5 ){
                $("#addBanner").hide();
            }else{
                $("#addBanner").show();
            }
        }

        function removeDiv(jsObj,key){
            $(jsObj).parent().parent().hide("slow");
            imgMaps.remove(key);
            if(imgMaps.size() < 5 ){
                $("#addBanner").show();
            }
        }


        $("#addBanner").browser({
            callback:function(images) {
                var path = bjw.base+"/"+images;
                var mapLength = imgMaps.size();
                // 以当时长度为键，路径为值
                imgMaps.put(mapLength,images);
                // 增加标签
                var imgStr = '<div>' +
                        '               <img src="'+path+'"  style="width: 230px;height: 150px;">'+
                        '                   <div>'+
                        '                       <input class="btn btn-danger" style="margin-top: 5px" type="button" value="移除" onclick="removeDiv(this,'+mapLength+')">'+
                        '                  </div>' +
                        '         </div>';
                // 在添加按钮前 插入 标签
                var addObj = $("#addBanner");
                addObj.before(imgStr);
                // 判断只能添加 5张图
                if(imgMaps.size() >= 5){
                    $("#addBanner").hide();
                }
            }
        });



        // 提交更新菜品
        function  updateFood(){


            var foodName = $("#foodName").val();
            var units = $("#units").val(); // 计量单位
            var sales = $("#sales").val(); // 计量单位
            var coverImg = $("#coverImg").val();
            var price = $("#price").val();
            var recommendationIndex = $("#recommendationIndex").val();
            var introduction = $("#introduction").val(); // 简介
            var keys = imgMaps.keySet(); // 多张Banner图
            var programmes = $("#programmes").code();
            var id = $("#id").val();

            if($.trim(foodName).length <= 0){
                Notify("没有填写名称",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(units).length <= 0){
                Notify("没有填写计量单位",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if(price <= 0 || !regDouble.test(price) ){
                Notify("没有填写价格",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if(recommendationIndex > 5 || recommendationIndex <= 0){
                Notify("推荐指数最高为 5",'top-right','5000','danger','fa-desktop',true);
                return false;
            }

            if($.trim(introduction).length <= 0){
                Notify("没有填写简介",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if(keys.length <= 0 ){
                Notify("至少上传一张Banner",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            var imgArr = "";
            for (var i=0; i<keys.length; i++){
                imgArr += imgMaps.get(keys[i])+",";
            }
            $.ajax({
                type : "POST",
                url : getRootPath()+"/web/act/updateAct",
                data :{
                    name:foodName,
                    topBanner:coverImg,
                    price:price,
                    recommendationIndex:recommendationIndex,
                    remarks:introduction,
                    banners:imgArr,
                    sales:sales,
                    units:units,
                    programmes:programmes,
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
