<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>添加厨师</title>

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
                <a target="iframe" href="<%=request.getContextPath()%>/web/cook/list">厨师列表</a>
            </li>
            <li class="active">
                <span>添加厨师</span>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <div class="widget">
            <!-- 高级查询开始 -->
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">添加用户</div>
                        <div class="portlet-body">
                            <!-- tab切换 -->
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="tabbable">
                                        <ul class="nav nav-tabs" id="myTab">
                                            <li class="tab-red active">
                                                <a id="clickHouseInfo" data-toggle="tab" href="#houseInfo">
                                                    房型信息
                                                </a>
                                            </li>
                                            <li class="tab-red">
                                                <a id="clickHousePhoto" data-toggle="tab" href="#housePhoto">
                                                    房型相册
                                                </a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <!-- 房型信息 -->
                                            <div id="houseInfo" class="tab-pane in active">
                                                <form action="${base}/ctl/house/[#if house.id??]update[#else]save[/#if]" class="form-horizontal" id="dataForm" method="post">
                                                    <div class="form-body">
                                                        <div class="form-group border-1">
                                                            <div class="alert alert-warning fade in">
                                                                <button class="close" data-dismiss="alert">
                                                                    ×
                                                                </button>
                                                                <i class="fa-fw fa fa-warning"></i>
                                                                带 * 的为必填项,房型不可修改.
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">面积<span class="label-hint">(单位：㎡)</span></label>
                                                                <div class="col-md-3">
                                                                    <input type="text" class="form-control" name="acreage" id="acreage" placeholder="请输入面积" maxlength="10">
                                                                    <span class="help-block"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">楼层<span class="label-hint">(例:1-5层)</span></label>
                                                                <div class="col-md-3">
                                                                    <input type="text" class="form-control" name="floor" id="floor" placeholder="请输入楼层" maxlength="20">
                                                                    <span class="help-block"></span>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group border-1">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">可住人数<span class="label-hint">(单位：数量)</span><span class="important">*</span></label>
                                                                <div class="col-md-3">
                                                                    <input type="text" class="form-control" name="peoples" id="peoples" placeholder="请输入可住人数" maxlength="10">
                                                                    <span class="help-block"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">OTA全年平均价<span class="important">*</span></label>
                                                                <div class="col-md-3">
                                                                    <input type="text" class="form-control" name="otaAvgPrice" id="otaAvgPrice" placeholder="请输入OTA全年平均价" maxlength="10">
                                                                    <span class="help-block"></span>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group border-1">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3"> 房间设施<span class="label-hint">(可多选)</span></label>
                                                                <div class="col-md-6 padding-left-5">
                                                                    <div class="form-group">
                                                                        <div class="checkbox">
                                                                            <label>
                                                                                <input name="facilitiesIds" value="" type="checkbox" class="inverted">
                                                                                <span class="text">WIFI</span>
                                                                            </label>
                                                                            <label>
                                                                                <input name="facilitiesIds" value="" type="checkbox" class="inverted" checked>
                                                                                <span class="text">WIFI</span>
                                                                            </label>
                                                                        </div>
                                                                    </div>
                                                                    <span class="help-block"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">备注</label>
                                                                <div class="col-md-3">
                                                                    <textarea type="text" class="form-control textarea" name="remark" id="remark" placeholder="请输入备注" maxlength="200"></textarea>
                                                                    <span class="help-block"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">房型介绍</label>
                                                                <div class="col-md-8">
                                                                    <textarea id="introduce" class="form-control textarea" placeholder="请输入房型介绍" type="text" maxlength="200"  name="introduce"></textarea>
                                                                    <span class="help-block"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3"></label>
                                                                <div class="col-md-8">
                                                                    <button id="submit" type="submit" class="btn btn-success padding-left-50 padding-right-50">提交</button>
                                                                    <a href="javascript:" onclick="self.location=document.referrer;" id="cancel" type="button" class="btn btn-default">返回</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>

                                            <div id="housePhoto" class="tab-pane">
                                                <button id="addImg">上传</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
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
        $('#introduce').summernote({
            height: 500,
            onImageUpload: function(files, editor, $editable) {
                sendFile(files, editor, $editable);
            }
        });
        //上传相册
        $("#addImg").browser({
            type:"hotel",
            callback:function(images) {
                console.debug(images);
            }
        });


        $(function() {

            //房型信息提交
            var dataForm = $('#dataForm');
            var error = $('.alert-danger', dataForm);
            //验证房型是否已经申请过了
            $.validator.addMethod("isHouseExist", function(value,element) {
                var bool = true;
                $.ajax({
                    type:"POST",
                    url:"${base}/ctl/house/verifyHouse",
                    data:{
                        houseTypeId:$("#houseType").val(),
                    },
                    async:false,
                    success:function(json){
                        console.log(json);
                        if(json.data.length > 0){
                            bool = false;
                        }
                    }
                });
                return this.optional(element) || bool;
            }, "该房型已经申请了！");
            dataForm.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-block help-block-error', // default input error message class
                ignore: "",
                rules: {
                    houseTypeId: { required: true,isHouseExist:true},
                    acreage: {isLessThan1:true,isNumber:true},
                    peoples: {required: true,isNumber:true ,isLessThan1:true},
                    otaAvgPrice:{ required:true,isLessThan1:true,isDouble:true},
                },
                messages:{
                    houseTypeId:{required: "请选择房型"},
                    acreage:{isLessThan1:"不能小于1",isNumber:"请输入数字"},
                    peoples:{required: "请输入可住人数"},
                    otaAvgPrice:{ required:"请输入OTA全年平均价",isLessThan1:"不能小于1",isDouble:"请输入正确价格"},
                },
                highlight: function (element) {
                    $(element).closest('.inline-form').addClass('has-error');
                    error.hide();
                },
                unhighlight: function (element) {
                    $(element).closest('.inline-form').removeClass('has-error');
                    error.hide();
                },
                success: function (label) {
                    label.closest('.inline-form').removeClass('has-error');
                    error.hide();
                }
            });

        });
    </script>
</body>
</html>
