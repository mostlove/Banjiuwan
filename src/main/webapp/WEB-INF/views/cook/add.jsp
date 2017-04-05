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
<body ng-app="webApp" ng-controller="cookCtrl" ng-cloak>
    <!-- Page Breadcrumb -->
    <div class="page-breadcrumbs">
        <ul class="breadcrumb">
            <li>
                <a target="iframe" href="<%=request.getContextPath()%>/web/cook/list">厨师列表</a>
            </li>
            <li class="active">
                <span>{{addOrUpdate}}</span>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body">
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
                                            <label class="control-label col-md-2">姓名</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="{{cook.realName}}" name="realName" id="realName" placeholder="请输入真实姓名" maxlength="150">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">电话号码</label>
                                            <div class="col-md-8">
                                                <input type="number" class="form-control" value="{{cook.phoneNumber}}" name="phoneNumber" id="phoneNumber" placeholder="输入电话号码">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">邮箱</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" value="{{cook.email}}" name="email" id="email" placeholder="输入邮箱">
                                                <span class="help-block"></span>
                                            </div>

                                        </div>
                                    </div>


                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">设置密码</label>
                                            <div class="col-md-8">
                                                <input id="password" class="form-control" placeholder="输入密码" value="{{cook.password}}" type="password"  name="password"/>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">年龄</label>
                                            <div class="col-md-8">
                                                <input id="age" value="18" class="form-control" value="{{cook.age}}" type="number"  name="age"/>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2">性别</label>
                                            <div class="col-md-8">
                                                <select class="form-control" id="gender" name="gender">
                                                    <option value="0">先生</option>
                                                    <option value="1">女士</option>
                                                </select>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group border-1">
                                        <div class="inline-form">
                                            <label class="control-label col-md-2"></label>
                                            <div class="col-md-8">
                                                <a href="<%=request.getContextPath()%>/web/cook/list" target="iframe" onclick="return addCook(${id})" class="btn btn-info">提交</a>
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
    <script src="<%=request.getContextPath()%>/resources/js/cook/add.js"></script>
</body>
</html>
