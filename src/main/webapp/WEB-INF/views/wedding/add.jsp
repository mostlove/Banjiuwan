<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <title>添加婚庆预约</title>

    <!-- 引用公用css -->
    <jsp:include page="../common/resources-css.jsp"></jsp:include>
    <link id="beyond-link" href="<%=request.getContextPath()%>/resources/assets/css/beyond.min.css" rel="stylesheet"
          type="text/css"/>
    <script src="<%=request.getContextPath()%>/resources/assets/js/skins.min.js"></script>
    <link href="<%=request.getContextPath()%>/resources/assets/css/skins/gray.min.css" rel="stylesheet"/>
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
        <li class="active">
            <span>添加婚庆预约</span>
        </li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<div class="page-body">
    <div class="widget">
        <div class="row">
            <div class="col-md-12">
                <div class="well with-header">
                    <div class="header bordered-darkpink">添加婚庆预约</div>
                    <div class="portlet-body">
                        <form class="form-horizontal" id="dataForm">
                            <div class="form-body">

                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">名称</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" name="name" id="name"
                                                   placeholder="请输入名称">
                                            <span class="help-block"></span>
                                        </div>

                                    </div>
                                </div>

                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">封面图(建议尺寸：374:200)</label>
                                        <div class="col-md-3">
                                            <img src="" id="imgSrc" style="width: 230px;height: 150px;display: none">
                                            <input class="btn btn-blue" type="button" value="上传图片" id="addImg">
                                            <input type="hidden" name="topBanner" id="coverImg">
                                            <div>
                                                <input class="btn btn-danger" style="display:none;margin-top: 5px"
                                                       type="button" value="移除" id="deleteImg">
                                            </div>
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">单价</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" name="price" id="price"
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
                                                   id="recommendationIndex" placeholder="设置推荐指数 最高为5">
                                            <span class="help-block"></span>
                                        </div>

                                    </div>
                                </div>

                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">销量</label>
                                        <div class="col-md-8">
                                            <input type="number" class="form-control" value="0" name="sales" id="sales"
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
                                                      name="packageDescription"></textarea>
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>

                                <!-- 选择型 多图上传 -->
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">Banner图(建议尺寸：994:764)</label>
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
                                                <select name="weddingCategory" class="weddingCategory" onchange="weddingCategoryChange(this)" style="width: 230px">
                                                    <option value="0">选择分类</option>
                                                    <c:forEach items="${cates}" var="category">
                                                        <option value="${category.id}">${category.categoryName}</option>
                                                    </c:forEach>
                                                </select>
                                                <select name="childCategory" class="childCategory" onclick="childCategoryChange(this)" style="width: 230px">
                                                    <option value="0">选择子分类</option>
                                                </select>
                                                <input type="button" class="btn btn-blue" onclick="addCategory(this)"
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
                                            <a href="<%=request.getContextPath()%>/web/wedding/list" target="iframe"
                                               onclick="return addWedding()" class="btn btn-info">提交</a>
                                            <a href="javascript:" onclick="self.location=document.referrer;" id="cancel"
                                               type="button" class="btn btn-default">返回</a>
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
<script src="<%=request.getContextPath()%>/resources/js/wedding/add.js"></script>

<!-- 私有js -->
<script>


    var weddingCategory = null;

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
                '<select name="weddingCategory" class="weddingCategory" onchange="weddingCategoryChange(this)" style="width: 230px">'+optionHtml+'</select>' +
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



    function removedImg(obj) {
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


    var weddingSonList = null;
    /**
     * 配置子项 点击事件
     * @param jsObj
     */
    function configBtn(jsObj) {


        if (null == weddingSonList) {
            // 如果对象没有，则发起请求  获取子项对象
            $.ajax({
                type: "POST",
                url: getRootPath() + "/web/weddingSon/queryAllWeddingSon",
                data: {},
                dataType: "json",
                async: false,
                timeout: 5000,
                success: function (json) {
                    if (json.code == 200) {
                        weddingSonList = json.data;
                    } else {
                        Notify(json.msg, 'top-right', '5000', 'danger', 'fa-desktop', true);
                        return;
                    }
                }
            })
        }
        buildChlidren(jsObj);
    }

    function buildChlidren(jsObj) {

        var optionHtml = "";
        if (weddingSonList.length == 0) {
            optionHtml = "<option value='0'>暂无子项</option>";
        } else {
            for (var i = 0; i < weddingSonList.length; i++) {
                optionHtml += "<option value='" + weddingSonList[i].id + "'>" + weddingSonList[i].name + "(" + weddingSonList[i].price + " 元/" + weddingSonList[i].units + ")</option>";
            }
        }


        var htmlDiv = '<div class="form-group border-1">' +
                '<div class="inline-form">' +
                '<label class="control-label col-md-2"></label>' +
                '<div class="col-md-4">' +
                '<select class="form-control" name="categoryId" id="categoryId">' + optionHtml + '</select>' +
                '<span class="help-block"></span>' +
                '</div>' +
                '<div class="col-md-4">' +
                '<input class="btn btn-danger" value="移除此子项" type="button" onclick="removeConfig(this)">' +
                '<span class="help-block"></span>' +
                '</div>' +
                '</div>' +
                '</div>';


        var topDiv = $(jsObj).parent().parent().parent().parent();
        $(topDiv).after(htmlDiv);
    }

    function removeConfig(jsObj) {
        var topDiv = $(jsObj).parent().parent().parent();
        topDiv.remove();
    }


    //上传相册
    $("#addImg").browser({
        callback: function (images) {
            var path = bjw.base + "/" + images;
            $("#imgSrc").attr('src', path);
            $("#imgSrc").show("slow");
            $("#coverImg").val(images);
            $("#addImg").hide();
            $("#deleteImg").show("slow");
        }
    });

    $("#deleteImg").click(function () {
        $("#imgSrc").hide("slow");
        $("#addImg").show("normal");
        $("#coverImg").val("");
        $("#deleteImg").hide();
    });


    $(function () {


    });


</script>
</body>
</html>
