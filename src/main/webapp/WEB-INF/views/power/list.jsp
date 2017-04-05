<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>权限管理</title>

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
        </li>
        <li class="active">
            <span>权限管理</span>
        </li>
    </ul>
</div>
<!-- /Page Breadcrumb -->
<div class="page-body">
    <div class="widget">
        <div class="row">
            <div class="col-md-12">
                <div class="well with-header">
                    <div class="header bordered-darkpink">权限管理</div>
                    <div class="portlet-body">
                        <form  class="form-horizontal" id="dataForm" >
                            <div class="form-body">
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">选择角色</label>
                                        <div class="col-md-8">
                                            <select id="roleId" class="form-control">
                                                <option value="0">选择角色</option>
                                                <option value="1">平台管理员</option>
                                                <option value="2">财务</option>
                                                <option value="3">客服</option>
                                                <option value="4">客户经理</option>
                                                <option value="5">调度员</option>
                                            </select>
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2">权限设置</label>
                                        <div class="col-md-8" id="setPower">
                                            <span class="help-block"></span>
                                        </div>
                                    </div>
                                </div>



                                <div class="form-group border-1">
                                    <div class="inline-form">
                                        <label class="control-label col-md-2"></label>
                                        <div class="col-md-8">
                                            <a href="javascript:location.reload()" target="iframe" onclick="return updateRoleConfig()" class="btn btn-info">确认修改</a>
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




    $(function() {
    });




    $("#roleId").change(function(){

        var roleId = $("#roleId").val();
        if(roleId == 0){
            $("#setPower").html("");
        }
        else{
            $.ajax({
                type : "POST",
                url : getRootPath()+"/web/role/getRole",
                data :{
                    roleId:roleId
                },
                dataType :"json",
                async : false,
                timeout : 5000,
                success : function(json){
                    if(json.code == 200){
                        buildSetPower(json.data);
                    }
                    else{
                        Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                        return false;
                    }
                }
            })
        }
    });

    function buildSetPower(data){
        var menus = data.menus;
        var roleMenus = data.role.menus;
        var str = "";
        for (var i=0; i<menus.length; i++){
            var checked = "";
            for (var j=0; j<roleMenus.length; j++){
                if(roleMenus[j].id == menus[i].id){
                    checked = "checked";
                    break;
                }
            }
            str += '<label> <input '+checked+' type="checkbox" name="times" value="'+menus[i].id+'"> <span class="text">'+menus[i].menuName+'</span></label>&nbsp;&nbsp;&nbsp;&nbsp;'
        }
        $("#setPower").html(str);
    }



    // 提交
    function  updateRoleConfig(){
        var roleId = $("#roleId").val();
        if(roleId ==0 ){
            Notify("没有选择角色",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
        var array = new Array();
        $("input[name='times']:checked").each(function(){
            var val = $(this).val();
            array.push(val);
        });
        var roleMenusArr = JSON.stringify(array);

        $.ajax({
            type : "POST",
            url : getRootPath()+"/web/role/updatePower",
            data :{
                roleMenusArr:roleMenusArr,
                roleId:roleId
            },
            dataType :"json",
            async : false,
            timeout : 5000,
            success : function(json){
                if(json.code == 200){
                    Notify("更新成功,重新登录生效", 'top-right', '5000', 'info', 'fa-desktop', true);
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
