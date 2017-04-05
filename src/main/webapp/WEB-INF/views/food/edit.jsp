<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>查看/编辑菜品</title>

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
                <a target="iframe" href="<%=request.getContextPath()%>/web/food/list">菜品列表</a>
            </li>
            <%--<li class="active">--%>
                <%--<span>添加用户</span>--%>
            <%--</li>--%>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <div class="widget">
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">查看/编辑菜品</div>
                        <div class="portlet-body">
                            <form  class="form-horizontal" id="dataForm" >
                                <div class="form-body">
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">选择类型</label>
                                            <div class="col-md-8">
                                                <select name="categoryId" id="categoryId">
                                                    <c:forEach items="${categorys}" var="category">
                                                        <option value="${category.id}">${category.categoryName}</option>
                                                    </c:forEach>
                                                </select>
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">菜品名称</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${food.foodName}" name="foodName" id="foodName" placeholder="请输入菜品名称">
                                                <input type="hidden" value="${food.id}" name="id" id="id">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">计量单位</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${food.units}" name="units" id="units" placeholder="请输入计量单位(例如：桌、份)">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">菜品封面图(建议尺寸：994:764)</label>
                                            <div class="col-md-3">
                                                <img src="<%=request.getContextPath()%>/${food.coverImg}"  id="imgSrc" style="width: 230px;height: 150px;">
                                                <div>
                                                    <input class="btn btn-danger" style="margin-top: 5px" type="button" value="移除" id="deleteImg">
                                                </div>
                                                <input class="btn btn-blue" type="button" style="display: none" value="上传图片" id="addImg">
                                                <input type="hidden" value="${food.coverImg}" name="coverImg" id="coverImg">

                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">菜品单价</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${food.price}" name="price" id="price" placeholder="请输入菜品单价,最大支持小数点后两位(单元：元)"
                                                       onkeyup="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')" onblur="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">促销价</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${food.promotionPrice}" name="promotionPrice" id="promotionPrice" placeholder="请输入促销价,最大支持小数点后两位(单元：元)"
                                                       onkeyup="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')" onblur="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">推荐指数</label>
                                            <div class="col-md-8">
                                                <input type="number" class="form-control" value="${food.recommendationIndex}" name="recommendationIndex" id="recommendationIndex" placeholder="设置推荐指数 最高为5">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">菜品销量</label>
                                            <div class="col-md-8">
                                                <input type="number" class="form-control" value="${food.sales}" name="sales" id="sales" placeholder="设置销量(默认为0)">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">主料</label>
                                            <div class="col-md-8">
                                                <textarea  id="marinade"  class="form-control textarea" placeholder="请录入主料" type="text" maxlength="200"  name="marinade">${food.marinade}</textarea>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">辅料</label>
                                            <div class="col-md-8">
                                                <textarea id="accessories" class="form-control textarea" placeholder="请录入辅料" type="text" maxlength="200"  name="accessories">${food.accessories}</textarea>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">简介</label>
                                            <div class="col-md-8">
                                                <textarea id="introduction" class="form-control textarea" placeholder="请录入简介" type="text" maxlength="200"  name="introduction">${food.introduction}</textarea>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>


                                    <!-- 选择型 多图上传 -->
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">菜品Banner图(建议尺寸：994:764)</label>
                                            <input type="hidden" value="${food.banners}" id="hiddenBanners">
                                            <div class="col-md-3">
                                                <input class="btn btn-blue" type="button" style="margin-top: 5px" value="上传图片" id="addBanner">
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/food/list" target="iframe" onclick="return updateFood()" class="btn btn-info">确认修改</a>
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
        <%--var categoryId = "${food.foodCategoryId}";--%>
        $(function() {
            var banners = $("#hiddenBanners").val().split(",");
            for (var i=0; i < banners.length; i++){
                imgMaps.put(i,banners[i]);
            }
            // 初始化数据
            var ca = "${food.foodCategoryId}";
            $("#categoryId option").each(function(){
                if(ca == $(this).val()){
                    $(this).attr("selected",true);
                }
            })
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


            var categoryId = $("#categoryId").val();
            var foodName = $("#foodName").val();
            var units = $("#units").val(); // 计量单位
            var coverImg = $("#coverImg").val();
            var price = $("#price").val();
            var promotionPrice = $("#promotionPrice").val();
            var recommendationIndex = $("#recommendationIndex").val();
            var sales = $("#sales").val();
            var marinade = $("#marinade").val(); // 主料
            var accessories = $("#accessories").val(); // 辅料
            var introduction = $("#introduction").val(); // 简介
            var keys = imgMaps.keySet(); // 多张Banner图
            var id= $("#id").val();

            if(0 == categoryId){
                Notify("没有选择菜品类型",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(foodName).length <= 0){
                Notify("没有填写菜品名称",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(coverImg).length <= 0){
                Notify("没有上传封面图",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(units).length <= 0){
                Notify("没有填写计量单位",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if(price == 0 || promotionPrice == 0 || !regDouble.test(price) || !regDouble.test(promotionPrice)){
                Notify("没有填写价格",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if(recommendationIndex > 5 || recommendationIndex <= 0){
                Notify("推荐指数最高为 1-5",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(marinade).length <= 0){
                Notify("没有填写主料",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(accessories).length <= 0){
                Notify("没有填写辅料",'top-right','5000','danger','fa-desktop',true);
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
            if(sales < 0 ){
                Notify("销量不能小于0",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            var imgArr = "";
            for (var i=0; i<keys.length; i++){
//                imgArr.push();
                imgArr += imgMaps.get(keys[i])+",";
            }

//            var imgJson = JSON.stringify(imgArr);

            $.ajax({
                type : "POST",
                url : getRootPath()+"/web/food/updateFood",
                data :{
                    foodCategoryId:categoryId,
                    foodName:foodName,
                    coverImg:coverImg,
                    price:price,
                    promotionPrice:promotionPrice,
                    recommendationIndex:recommendationIndex,
                    sales:sales,
                    marinade:marinade,
                    accessories:accessories,
                    introduction:introduction,
                    banners:imgArr,
                    units:units,
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
