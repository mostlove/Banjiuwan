<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>查看/编辑婚庆</title>

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
                <a target="iframe" href="<%=request.getContextPath()%>/web/wedding/list">婚庆预约</a>
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
                                            <label class="control-label col-md-2">名称</label>
                                            <div class="col-md-8">
                                                <input type="hidden" value="${wedding.id}" id="id">
                                                <input type="text" value="${wedding.name}" class="form-control" name="name" id="name"
                                                       placeholder="请输入名称">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">封面图(建议尺寸：374:200)</label>
                                            <div class="col-md-3">
                                                <img src="<%=request.getContextPath()%>/${wedding.coverImg}"  id="imgSrc" style="width: 230px;height: 150px;">
                                                <div>
                                                    <input class="btn btn-danger" style="margin-top: 5px" type="button" value="移除" id="deleteImg">
                                                </div>
                                                <input class="btn btn-blue" type="button" style="display: none" value="上传图片" id="addImg">
                                                <input type="hidden" value="${wedding.coverImg}" name="coverImg" id="coverImg">

                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">单价</label>
                                            <div class="col-md-8">
                                                <input type="text" value="${wedding.price}" class="form-control" name="price" id="price"
                                                       placeholder="请输入单价,最大支持小数点后两位(单元：元)"
                                                       onkeyup="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')"
                                                       onblur="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">推荐指数</label>
                                            <div class="col-md-8">
                                                <input type="number" class="form-control" name="recommendationIndex"
                                                       id="recommendationIndex" placeholder="设置推荐指数 最高为5" value="${wedding.recommendationIndex}">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">销量</label>
                                            <div class="col-md-8">
                                                <input type="number" class="form-control" value="${wedding.sales}" name="sales" id="sales"
                                                       placeholder="设置销量(默认为0)">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">描述</label>
                                            <div class="col-md-8">
                                            <textarea id="packageDescription" class="form-control textarea"
                                                      placeholder="请输入描述" type="text" maxlength="200"
                                                      name="packageDescription">${wedding.packageDescription}</textarea>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 选择型 多图上传 -->
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">Banner图(建议尺寸：994:764)</label>
                                            <input type="hidden" value="${wedding.banners}" id="hiddenBanners">
                                            <div class="col-md-3">
                                                <input class="btn btn-blue" type="button" style="margin-top: 5px" value="上传图片" id="addBanner">
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 子项配置 -->
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">配置子项类</label>
                                            <div class="col-md-6">
                                                <div style="margin-bottom: 5px">
                                                    <select class="weddingCategory" onchange="weddingCategoryChange(this)" style="width: 230px">
                                                        <option value="0">选择分类</option>
                                                        <c:forEach items="${cates}" var="category">
                                                            <option value="${category.id}">${category.categoryName}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <select name="childCategory" class="childCategory" onclick="childCategoryChange(this)" style="width: 230px">
                                                        <option value="0">选择子分类</option>
                                                    </select>
                                                    <input type="button" class="btn btn-blue" id="categoryBtn" onclick="addCategory(this)"
                                                           value="增加分类"/>
                                                </div>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/wedding/list" target="iframe" onclick="return updateWedding()" class="btn btn-info">确认修改</a>
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
    <script src="<%=request.getContextPath()%>/resources/js/wedding/edit.js"></script>
    <!-- 私有js -->
    <script>

        var weddingCategory = null;

        // 初始化修改分类
        var weddingChildCategories = "${wedding.weddingChildCategories}";

        function initChildCategory(){
            var categoryDivHtml = "";
            var jQueryObj = $("#categoryBtn");
            if(null == weddingCategory){
                $.ajax({
                    type : "POST",
                    url : getRootPath()+"/web/weddingCategory/queryAll",
                    data : {},
                    dataType : "json",
                    async : false,
                    timeout : 5000,
                    success : function(json){
                        if(json.code == 200){
                            weddingCategory = json.data;
                        }else{
                            Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                            return;
                        }
                    }
                })
            }
            var categorySize = "${fn:length(wedding.weddingChildCategories)}";
            if(categorySize > 0){

                <c:forEach items="${wedding.weddingChildCategories}" var="weddingChildCategorie">
                var categoryId = "${weddingChildCategorie.weddingCategoryId}";
                var id = "${weddingChildCategorie.id}";
                var name = "${weddingChildCategorie.name}";
                var weddingCategoryName = "${weddingChildCategorie.weddingCategoryName}";
                categoryDivHtml +=
                        '<div class="form-group border-1">'+
                        '<div class="inline-form">'+
                        '<label class="control-label col-md-2"></label>'+
                        '<div class="col-md-6">'+
                        '<div style="margin-bottom: 5px">'+
                        '<select disabled=disabled class="weddingCategory" onchange="weddingCategoryChange(this)" style="width: 230px">' +
                            '<option value="'+categoryId+'">'+weddingCategoryName+'</option>' +
                        '</select>'+
                        '<select disabled=disabled name="childCategory" class="childCategory" onclick="childCategoryChange(this)" style="width: 230px">'+
                        '<option value="'+id+'" >'+name+'</option>'+
                        '</select>'+
                        '<input type="button" class="btn btn-blue" style="margin-left: 5px" onclick="addCategory(this)" value="增加分类"/>' +
                        '<input type="button" class="btn btn-danger" style="margin-left: 5px" onclick="removedCategory(this)" value="移除分类"/>'+
                        '</div>'+
                        '<span class="help-block"></span>'+
                        '</div>'+
                        '</div>'+
                        '</div>';
                </c:forEach>
            }
            var topDiv = jQueryObj.parent().parent().parent().parent();
            $(topDiv).after(categoryDivHtml);
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

        var imgMaps = new Map();


        $(function() {
            var banners = $("#hiddenBanners").val().split(",");
            for (var i=0; i < banners.length; i++){
                imgMaps.put(i,banners[i]);
            }
            // 设置多banners
            initBanners();
            // 初始化 子项管理
            initChildCategory();
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

        function addCategory(jsObj) {
            var jQueryObj = $(jsObj);
            if(null == weddingCategory){
                $.ajax({
                    type : "POST",
                    url : getRootPath()+"/web/weddingCategory/queryAll",
                    data : {},
                    dataType : "json",
                    async : false,
                    timeout : 5000,
                    success : function(json){
                        if(json.code == 200){
                            weddingCategory = json.data;
                        }else{
                            Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                            return;
                        }
                    }
                })
            }
            var optionHtml = buildWeddingCategoryOption(weddingCategory);
            var configDivHtml =
                    '<div class="form-group border-1">' +
                    '<div class="inline-form">' +
                    '<label class="control-label col-md-2"></label>' +
                    '<div class="col-md-6">' +
                    '<div style="margin-bottom: 5px">' +
                    '<select class="weddingCategory" onchange="weddingCategoryChange(this)" style="width: 230px">'+optionHtml+'</select>' +
                    '<select name="childCategory" class="childCategory" onclick="childCategoryChange(this)" style="width: 230px">' +
                    '<option value="0">选择子分类</option>' +
                    '</select>' +
                    '<input type="button" class="btn btn-blue" style="margin-left: 5px" onclick="addCategory(this)" value="增加分类"/>' +
                    '<input type="button" class="btn btn-danger" style="margin-left: 5px" onclick="removedCategory(this)" value="移除分类"/>' +
                    '</div>' +
                    '<span class="help-block"></span>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
            var topDiv = jQueryObj.parent().parent().parent().parent();
            $(topDiv).after(configDivHtml);
        };


        function buildWeddingCategoryOption(dataList){
            var optionHtml = "<option value='0'>选择分类</option>";
            if(dataList.length == 0){
                optionHtml = "<option value='0'>暂无数据</option>";
            }else{
                for(var i=0; i<dataList.length; i++){
                    optionHtml += "<option value='"+dataList[i].id+"'>"+dataList[i].categoryName+"</option>";
                }
            }
            return optionHtml;
        }

        // 分类change事件
        function weddingCategoryChange(jsObj){

            var jQueryObj = $(jsObj);
            var categoryId = jQueryObj.val();
            if(categoryId == 0){
                return;
            }
            $.ajax({
                type : "POST",
                url : getRootPath()+"/web/weddingChildCategory/queryAllChildCategory",
                data : {
                    categoryId:categoryId
                },
                dataType : "json",
                async : false,
                timeout : 5000,
                success : function(json){
                    if(json.code == 200){
                        buildChildCategoryOption(jsObj,json.data);
                    }else{
                        Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                }
            })
        }

        function buildChildCategoryOption(jsObj,dataList){

            var optionHtml = "";
            if(dataList.length == 0){
                optionHtml = "<option value='0'>暂无数据</option>";
            }else{
                for(var i=0; i<dataList.length; i++){
                    optionHtml += "<option value='"+dataList[i].id+"'>"+dataList[i].name+"</option>";
                }
            }
            var childSelect = $(jsObj).next();
            $(childSelect).html(optionHtml);
        }

        // 选择子分类的 change事件
        function childCategoryChange(jsObj){
            var categorySelect = $(jsObj).prev();
            var categoryId = $(categorySelect).val();
            if(categoryId == 0){
                Notify("请选择上一级分类", 'top-right', '5000', 'danger', 'fa-desktop', true);
            }
        }

        // 移除分类
        function removedCategory(jsObj) {
            var jQueryObj = $(jsObj);
            var topDiv = jQueryObj.parent().parent().parent().parent();
            $(topDiv).remove();
        }

        /**
         * 提交更新
         */
        function updateWedding(){

            var name = $("#name").val(); // 名称
            var coverImg = $("#coverImg").val();
            var price = $("#price").val();
            var recommendationIndex = $("#recommendationIndex").val();
            var sales = $("#sales").val();
            var id = $("#id").val();
            var packageDescription = $("#packageDescription").val(); // 描述
            var keys = imgMaps.keySet(); // 多张Banner图

            var childCategoryIds = new Array();  // 子分类集合
            $("select[name='childCategory']").each(
                    function(){
                        childCategoryIds.push($(this).val());
                    }
            );


            childCategoryIds = JSON.stringify(childCategoryIds);
            if($.trim(name).length <= 0){
                Notify("没有填写名称",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(coverImg).length <= 0){
                Notify("没有上传图片",'top-right','5000','danger','fa-desktop',true);
                return false;
            }

            if(price <= 0 || !regDouble.test(price)){
                Notify("没有填写价格",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if(recommendationIndex > 5 || recommendationIndex <= 0){
                Notify("推荐指数最高为 5",'top-right','5000','danger','fa-desktop',true);
                return false;
            }

            if($.trim(packageDescription).length <= 0){
                Notify("没有填写简介",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if(keys.length <= 0 ){
                Notify("至少上传一张Banner",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if(childCategoryIds.length <= 0 ){
                Notify("至少选择一个子分类",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if(sales < 0 ){
                Notify("销量不能小于0",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            var imgArr = "";
            for (var i=0; i<keys.length; i++){
                imgArr += imgMaps.get(keys[i])+",";
            }

            $.ajax({
                type : "POST",
                url : getRootPath()+"/web/wedding/updateWedding",
                data :{
                    name:name,
                    coverImg:coverImg,
                    price:price,
                    recommendationIndex:recommendationIndex,
                    sales:sales,
                    banners:imgArr,
                    childCategorys:childCategoryIds,
                    packageDescription:packageDescription,
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
