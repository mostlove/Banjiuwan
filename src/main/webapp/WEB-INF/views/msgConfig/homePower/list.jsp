<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>首页点菜权限提示语配置</title>

    <!-- 引用公用css -->
    <jsp:include page="../../common/resources-css.jsp"></jsp:include>
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
            <li class="active">首页点菜权限提示语配置</li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">

            <div class="widget">
                <!-- 表格开始 -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="well with-header">
                            <div class="header bordered-darkpink">
                                首页点菜权限提示语配置
                            </div>
                            <div class="portlet-body">
                                <table class="table table-hover table-bordered" id="listTable">
                                    <thead>
                                        <tr>
                                            <th>位置</th>
                                            <th>当前提示语</th>
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

    </div>

    <!-- 引用公用js -->
    <jsp:include page="../../common/resources-js.jsp"></jsp:include>
    <!-- 私有js -->
    <script>

       $(function(){

           $.ajax({
               type : "POST",
               url : getRootPath()+"/web/foodCategory/getCategoryConfigMSG",
               data :{
               },
               dataType :"json",
               async : false,
               timeout : 5000,
               success : function(json){
                   if(json.code == 200){
                       buildData(json.data);
                   }
                   else{
                       Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                   }
               }
           });
       })

        function buildData(data){
            var str = "";
            for (var i=0 ; i<data.length; i++){
                str += '<tr>' +
                        '<td>'+data[i].categoryName+'</td>' +
                        '<td>'+data[i].msg+'</td>' +
                        '<td><a href="javascript:void(0)" onclick="updateConfigMSG('+data[i].id+',\''+data[i].msg+'\')" class="btn btn-blue">修改提示语</a></td>' +
                        '</tr>'
            }
            $("#dataDiv").html(str);
        }


        function updateConfigMSG(id,dataStr){

            var str='<div id="myModal">'+
                    '<div class="form-group">'+
                    '<label></label>'+
                    '<span class="input-icon icon-right">'+
                    '<div class="input-group">'+
                    '<input value="'+dataStr+'" class="form-control" id="msg" />'+
                    '</div>'+
                    '</span>'+
                    '</div>'+
                    '</div>';
            bootbox.dialog({
                message: str,
                title: "修改提示语",
                buttons: {
                    "关闭": {
                        className: "btn-default",
                        callback: function () {
                        }
                    },
                    success: {
                        label: "确认",
                        className: "btn-danger",
                        callback: function () {
                            var msg = $("#msg").val();
                            if(msg.length  == 0){
                                Notify("没有输入提示语",'top-right','5000','danger','fa-desktop',true);
                                return;
                            }
                            $.ajax({
                                type : "POST",
                                url : getRootPath()+"/web/foodCategory/updateBigCategoryConfig",
                                data : {id:id,msg:msg},
                                dataType :"json",
                                async : false,
                                timeout : 5000,
                                success : function(respObj){
                                    var status = respObj.code;
                                    if(status==200){
                                        Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                                        location.reload();
                                    }else{
                                        Notify(respObj.msg,'top-right','5000','danger','fa-desktop',true);
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
