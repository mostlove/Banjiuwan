<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>查看/编辑专业服务</title>

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
                <a target="iframe" href="javascript:void(0)">查看/编辑专业服务</a>
            </li>
            <li class="active">
                <span>查看/编辑专业服务</span>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <div class="widget">
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">查看/编辑专业服务</div>
                        <div class="portlet-body">
                            <form  class="form-horizontal" id="dataForm" >
                                <div class="form-body">


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">服务员(男)单价</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${service.manServicePrice}" name="man_service_price" id="manServicePrice" placeholder="请输入单价,最大支持小数点后两位(单元：元)"
                                                       onkeyup="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')" onblur="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">服务员(女)单价</label>
                                            <input type="hidden" value="${service.id}" id="id">
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${service.womanServicePrice}" name="womanServicePrice" id="womanServicePrice" placeholder="请输入单价,最大支持小数点后两位(单元：元)"
                                                       onkeyup="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')" onblur="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">餐具单价</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="${service.tablewarePrice}" name="tablewarePrice" id="tablewarePrice" placeholder="请输入单价,最大支持小数点后两位(单元：元)"
                                                       onkeyup="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')" onblur="this.value=this.value.replace(/[^\d+(\.\d{2})$]/g,'')">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">服务理念</label>
                                            <div class="col-md-8">
                                                <textarea id="serviceIdea" class="form-control textarea" placeholder="请输入服务理念 250字以内" type="text" maxlength="250"  name="serviceIdea">${service.serviceIdea}</textarea>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">服务流程</label>
                                            <div class="col-md-8">
                                                <textarea id="serviceFlow" class="form-control textarea" placeholder="请输入服务流程" type="text"   name="serviceFlow">${service.serviceFlow}</textarea>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">服务标准</label>
                                            <div class="col-md-8">
                                                <textarea id="serviceStandard" class="form-control textarea" placeholder="请输入服务标准" type="text" name="serviceStandard">${service.serviceStandard}</textarea>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>


                                    <!-- 选择型 多图上传 -->
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">Banner图(建议尺寸：994:764)</label>
                                            <input type="hidden" value="${service.banners}" id="hiddenBanners">
                                            <div class="col-md-8">
                                                <input class="btn btn-blue" type="button" style="margin-top: 5px" value="上传图片" id="addBanner">
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/special/service" target="iframe" onclick="return updateService()" class="btn btn-info">确认更新</a>
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
        $('#serviceFlow').summernote({
            height: 500,
            onImageUpload: function(files, editor, $editable) {
                sendFile(files, editor, $editable);
            }
        });
        $('#serviceStandard').summernote({
            height: 500,
            onImageUpload: function(files, editor, $editable) {
                sendFile(files, editor, $editable);
            }
        });


        var imgMaps = new Map();
        $(function() {
            var banners = $("#hiddenBanners").val().split(",");
            for (var i=0; i < banners.length; i++){
                imgMaps.put(i,banners[i]);
            }
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
        function  updateService(){


            var manServicePrice = $("#manServicePrice").val();
            var womanServicePrice = $("#womanServicePrice").val();
            var tablewarePrice = $("#tablewarePrice").val();
            var serviceIdea = $("#serviceIdea").val(); // 服务理念
            var serviceFlow = $("#serviceFlow").code(); // 服务流程
            var serviceStandard = $("#serviceStandard").code(); // 服务标准
            var keys = imgMaps.keySet(); // 多张Banner图
            var id= $("#id").val();

            if(manServicePrice < 0 || womanServicePrice < 0 || tablewarePrice < 0
            || !regDouble.test(manServicePrice) || !regDouble.test(womanServicePrice) || !regDouble.test(tablewarePrice)){
                Notify("单价填写不对",'top-right','5000','danger','fa-desktop',true);
                return false;
            }

            if($.trim(serviceIdea).length <= 0){
                Notify("没有填写主料",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(serviceFlow).length <= 0){
                Notify("没有填写辅料",'top-right','5000','danger','fa-desktop',true);
                return false;
            }
            if($.trim(serviceStandard).length <= 0){
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
                url : getRootPath()+"/web/specialService/update",
                data :{
                    serviceIdea:serviceIdea,
                    serviceFlow:serviceFlow,
                    serviceStandard:serviceStandard,
                    womanServicePrice:womanServicePrice,
                    tablewarePrice:tablewarePrice,
                    manServicePrice:manServicePrice,
                    banners:imgArr,
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
