<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>婚庆预约-分类管理</title>

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
                <a target="iframe" href="javascript:void(0)" onclick="self.location=document.referrer;">返回上一级</a>
            </li>
            <li class="active">婚庆预约-分类管理</li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
        <form id="listForm" action="##" class="form-horizontal" method="POST" >
            <div class="widget">

                <!-- 表格开始 -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="well with-header">
                            <div class="header bordered-darkpink">
                                婚庆预约-配置管理
                                <a class="refresh primary margin-right-20" data-toggle="tooltip" data-placement="bottom" data-original-title="点击刷新" id="refresh-toggler" href="">
                                    <i class="glyphicon glyphicon-refresh"></i>
                                </a>
                                <a href="javascript:void(0);" onclick="bindSonChild(${weddingSonCategoryId})"  class="btn btn-palegreen float-right"><i class="fa fa-plus"></i>绑定子项</a>
                            </div>
                            <div class="portlet-body">
                                <table class="table table-hover table-bordered" id="listTable">
                                    <thead>
                                        <tr>
                                            <th>名称</th>
                                            <th>计量单位</th>
                                            <th>单价</th>
                                            <th>创建时间</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                    <tbody id="dataDiv">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 表格结束 -->
            </div>
        </form>
    </div>

    <!-- 引用公用js -->
    <jsp:include page="../../../common/resources-js.jsp"></jsp:include>
    <!-- 私有js -->
    <script src="<%=request.getContextPath()%>/resources/js/wedding/category/child/sonChildList.js"></script>
    <script>



        $(function(){



            var weddingSonCategoryId = "${weddingSonCategoryId}";
            var totalpage = initData(1,15,weddingSonCategoryId);
            addpage(); //加载分页方法
            //返回的数据不为undefind(也就是有数据时),调用$('#pageCon').show();
            $('#pageCon').show();

            //数据添加到页面后，调用一下方式
            $.jqPaginator('#pagination', {
                totalPages: totalpage,  //总页数
                visiblePages: 3,  //可见页面
                currentPage: 1,   //当前页面
                onPageChange: function (num, type) {
                    $('#showing').text('共'+totalpage+'页  第'+num+'/'+totalpage+'页');
                    if(type != "init"){
                        //获取第num页数据，
                        initData(num,15,weddingSonCategoryId);
                    }
                }
            });

        });




        /**
         * 绑定子项
         */
        var allSon = null;
        function bindSonChild(childCategoryId){

            if(null == allSon){
                $.ajax({
                    type:"POST",
                    url:getRootPath()+"/web/weddingSon/queryAllWeddingSon",
                    data:{},
                    dataType:"json",
                    async:false,
                    timeout:5000,
                    success : function(json){
                        if(json.code == 200){
                            allSon = json.data;
                        }
                        else{
                            Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                            return;
                        }
                    }
                });
            }

            var optionHtml = "";
            if(allSon.length == 0){
                optionHtml = "<option value='0'>暂无数据</option>"
            }else{
                for (var i=0 ; i<allSon.length; i++){
                    optionHtml += "<option value='"+allSon[i].id+"'>"+allSon[i].name+"("+allSon[i].price+"元/"+allSon[i].units+")</option>"
                }
            }


            buildHtmlDiv(optionHtml,childCategoryId);
        }

        function buildHtmlDiv(optionHtml,childCategoryId){

            var str='<div id="myModal">' +
                    '<form  class="form-horizontal" >' +
                    '   <div class="form-body">'+
                    '       <div class="form-group border-1">'+
                    '           <div class="inline-form">'+
                    '               <label class="control-label col-md-4">选择绑定的子项</label>'+
                    '               <div class="col-md-8">'+
                    '           <select id="weddingSonId">'+optionHtml+'</select>'+
                    '           <span class="help-block"></span>'+
                    '          </div>'+
                    '           </div>'+
                    '       </div>' +
                    '   </div>' +
                    '</form>'+
                    '</div>';
            bootbox.dialog({
                message: str,
                title: "绑定子项",
                buttons: {
                    "关闭": {
                        className: "btn-default",
                        callback: function () {

                        }
                    },
                    success: {
                        label: "确定绑定",
                        className: "btn-primary",
                        callback: function () {

                            var weddingSonId = $("#weddingSonId").val();
                            if(weddingSonId == 0){
                                Notify("绑定失败", 'top-right', '5000', 'info', 'fa-desktop', true);
                                return;
                            }

                            $.ajax({
                                type:"POST",
                                url:getRootPath()+"/web/weddingSonChild/bind",
                                data:{
                                    weddingSonId:weddingSonId,
                                    childCategoryId:childCategoryId
                                },
                                dataType:"json",
                                async:false,
                                timeout:5000,
                                success : function(json){
                                    if(json.code == 200){
                                        Notify("绑定成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                        initData(1,15,childCategoryId);
                                    }
                                    else{
                                        Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                                    }
                                }
                            });
                        }
                    }
                }
            });

        }


    </script>

</body>
</html>
