<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>添加套餐/坝坝宴</title>

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
                <a target="iframe" href="<%=request.getContextPath()%>/web/package/list">套餐/坝坝宴</a>
            </li>
            <li class="active">
                <span>添加套餐/坝坝宴</span>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <div class="widget">
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">添加套餐/坝坝宴</div>
                        <div class="portlet-body">
                            <form  class="form-horizontal" id="dataForm" >
                                <div class="form-body">
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">选择类型</label>
                                            <div class="col-md-8">
                                                <select class="form-control" name="foodCategoryId" id="categoryId">
                                                    <option value="0">请选择类型</option>
                                                    <option value="9">套餐</option>
                                                    <option value="10">坝坝宴</option>
                                                </select>
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">套餐名称</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="name" id="foodName" placeholder="请输入套餐名称">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">计量单位</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="units" id="units" placeholder="请输入计量单位(例如：桌、份)">
                                                 <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">封面图(建议尺寸：600:990)</label>
                                            <div class="col-md-3">
                                                <img src=""  id="imgSrc" style="width: 230px;height: 150px;display: none">
                                                <input class="btn btn-blue" type="button" value="上传图片" id="addImg">
                                                <input type="hidden" name="topBanner" id="coverImg">
                                                <div>
                                                    <input class="btn btn-danger" style="display:none;margin-top: 5px" type="button" value="移除" id="deleteImg">
                                                </div>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">菜品单价</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="price" id="price" placeholder="请输入单价,最大支持小数点后两位(单元：元)"
                                                       onkeyup="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')" onblur="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">促销价</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="promotionPrice" id="promotionPrice" placeholder="请输入促销价,最大支持小数点后两位(单元：元)"
                                                       onkeyup="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')" onblur="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">起订数量</label>
                                            <div class="col-md-8">
                                                <input type="number" class="form-control" value="1" name="leastNumber" id="leastNumber" placeholder="起订数量(默认为1)">
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
                                            <label class="control-label col-md-2">套餐销量</label>
                                            <div class="col-md-8">
                                                <input type="number" class="form-control" value="0" name="sales" id="sales" placeholder="设置销量(默认为0)">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">简介</label>
                                            <div class="col-md-8">
                                                <textarea id="introduction" class="form-control textarea" placeholder="请录入简介" type="text" maxlength="200"  name="introduction"></textarea>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>


                                    <!-- 选择型 多图上传 -->
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">套餐Banner图(建议尺寸：994:764)</label>
                                            <div class="col-md-3">
                                                <input class="btn btn-blue" type="button" style="margin-top: 5px" value="上传图片" id="addBanner">
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 新增 套餐 菜品明细 -->
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">套餐包含菜品</label>
                                            <div>
                                                <div class="col-md-2">
                                                    <select class="form-control" id="categoryId_food" onchange="changeFoodCategory(this)">
                                                        <c:forEach items="${categorys}" var="category">
                                                            <option value="${category.id}">${category.categoryName}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <span class="help-block"></span>
                                                </div>
                                                <div class="col-md-2">
                                                    <select class="form-control" id="singleFood" name="singleFoodId" >
                                                        <c:forEach var="singlefood" items="${singleFoods}">
                                                            <option value="${singlefood.id}">${singlefood.foodName}(${singlefood.price}元/${singlefood.units})</option>
                                                        </c:forEach>
                                                    </select>
                                                    <span class="help-block"></span>
                                                </div>
                                                <div class="col-md-2">
                                                    <input class="form-control" type="number"  name="singleFoodNumber"  placeholder="数量(默认为1)">
                                                    <span class="help-block"></span>
                                                </div>
                                                <div class="col-md-2">
                                                    <input type="button" class="btn btn-palegreen" onclick="continueAddCategory(this)" value="继续添加">
                                                    <span class="help-block"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 以下追加DIV -->

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/package/list" target="iframe" onclick="return addFood()" class="btn btn-info">提交</a>
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
    <script src="<%=request.getContextPath()%>/resources/js/package/add.js"></script>

    <!-- 私有js -->
    <script>
        //调 编辑器
//        $('#content').summernote({
//            height: 500,
//            onImageUpload: function(files, editor, $editable) {
//                sendFile(files, editor, $editable);
//            }
//        });
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
