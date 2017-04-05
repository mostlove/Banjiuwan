<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>添加管理</title>

    <!-- 引用公用css -->
    <jsp:include page="../common/resources-css.jsp"></jsp:include>
    <link id="beyond-link" href="<%=request.getContextPath()%>/resources/assets/css/beyond.min.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/resources/assets/js/skins.min.js"></script>
    <link href="<%=request.getContextPath()%>/resources/assets/css/skins/gray.min.css" rel="stylesheet" />
    <style>

    </style>
</head>
<body ng-app="webApp" ng-controller="adminUserCtrl" ng-cloak>
    <!-- Page Breadcrumb -->
    <div class="page-breadcrumbs">
        <ul class="breadcrumb">
            <li>
                <a target="iframe" href="<%=request.getContextPath()%>/web/adminUser/list">管理列表</a>
            </li>
            <li class="active">
                <span>{{addOrUpdate}}</span>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body"  >
        <div class="widget">
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">{{addOrUpdate}}</div>
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
                                            <label class="control-label col-md-2">姓名</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="userName" value="{{adminUser.userName}}" id="userName" placeholder="请输入" maxlength="150">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">电话号码</label>
                                            <div class="col-md-8">
                                                <input type="number" class="form-control"  value="{{adminUser.phoneNumber}}" name="phoneNumber" id="phoneNumber" placeholder="输入电话号码">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">设置密码</label>
                                            <div class="col-md-8">
                                                <input id="password" class="form-control" placeholder="输入密码" value="{{adminUser.password}}"  type="password"  name="password"/>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/adminUser/list" target="iframe" onclick="return addAdminUser(${id})" class="btn btn-info">提交</a>
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
    <div>
        <input value="${id}" type="hidden" id="id" />
    </div>
    <!-- 引用公用js -->
    <jsp:include page="../common/resources-js.jsp"></jsp:include>
    <!-- 引用富文本 -->
    <script src="<%=request.getContextPath()%>/resources/assets/js/editors/summernote/summernote.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/jQuery.md5.js"></script>
    <!-- 私有js -->
    <script src="<%=request.getContextPath()%>/resources/js/adminUser/add.js"></script>
</body>
</html>
