<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>用户详情</title>

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
                <a target="iframe" href="<%=request.getContextPath()%>/user/list">用户列表</a>
            </li>
            <li class="active">
                <span>用户详情</span>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body" ng-app="webApp" ng-controller="userInfoCtrl" ng-cloak>
        <div class="widget">
            <!-- 高级查询开始 -->
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">用户详情</div>
                        <div class="portlet-body">
                            <!-- tab切换 -->
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="tabbable">
                                        <div class="tab-content">
                                            <!-- 房型信息 -->
                                            <div id="houseInfo" class="tab-pane in active">
                                                <form action="#" class="form-horizontal" id="dataForm" method="post">
                                                    <div class="form-body">
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">头像：</label>
                                                                <img src="<%=request.getContextPath()%>/{{user.avatar}}" style="width: 20px;height: 20px">
                                                                <%--<label class="control-label col-md-5 text-align-left">{{order.userAddress.address}}</label>--%>
                                                            </div>

                                                        </div>
                                                        <div class="form-group border-1">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">用户名：</label>
                                                                <label class="control-label col-md-3 text-align-left">{{user.userName}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-2">电话号码：</label>
                                                                <label class="control-label col-md-3 text-align-left">{{user.phoneNumber}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">余额：</label>
                                                                <label class="control-label col-md-3 text-align-left">￥{{user.balance}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-2">积分：</label>
                                                                <label class="control-label col-md-3 text-align-left">{{user.accumulate}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">个性签名：</label>
                                                                <label class="control-label col-md-5 text-align-left">{{user.signature}}</label>
                                                            </div>

                                                        </div>

                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">个人口味：</label>
                                                                <label class="control-label col-md-5 text-align-left">{{user.personalTaste}}</label>
                                                            </div>

                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">喜欢的菜系：</label>
                                                                <label class="control-label col-md-5 text-align-left">{{user.likeCuisine}}</label>
                                                            </div>

                                                        </div>
                                                        <div class="form-group border-1 ">
                                                        <div class="inline-form">
                                                            <label class="control-label col-md-3">备注：</label>
                                                            <label class="control-label col-md-5 text-align-left">{{user.reMarket}}</label>
                                                        </div>

                                                    </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">注册时间：</label>
                                                                <label class="control-label col-md-3 text-align-left">{{createTime}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-2">最后登录时间：</label>
                                                                <label class="control-label col-md-3 text-align-left">{{lastLogin}}</label>
                                                            </div>
                                                        </div>

                                                        <div class="form-group border-1">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3"></label>
                                                                <div class="col-md-8">
                                                                   <%-- <button id="submit" type="submit" class="btn btn-success padding-left-50 padding-right-50">提交</button>--%>
                                                                    <a href="javascript:" class="btn padding-left-50 padding-right-50" onclick="self.location=document.referrer;" id="cancel" type="button" class="btn btn-default">返回</a>
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
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div>
        <input id="id" type="hidden" value="${id}" />
    </div>
    <!-- 引用公用js -->
    <jsp:include page="../common/resources-js.jsp"></jsp:include>
    <script src="<%=request.getContextPath()%>/resources/js/user/info.js"></script>
</body>
</html>
