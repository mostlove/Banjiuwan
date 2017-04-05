<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>订单详情</title>

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
                <a target="iframe" href="<%=request.getContextPath()%>/web/order/list">订单列表</a>
            </li>
            <li class="active">
                <span>订单详情</span>
            </li>
        </ul>
    </div>
    <!-- /Page Breadcrumb -->
    <div class="page-body" ng-app="webApp" ng-controller="orderInfoCtrl" ng-cloak>
        <div class="widget">
            <!-- 高级查询开始 -->
            <div class="row">
                <div class="col-md-12">
                    <div class="well with-header">
                        <div class="header bordered-darkpink">订单详情</div>
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
                                                        <div class="form-group border-1">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">订单编号：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.orderNumber}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">订单状态：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{orderStatus}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">名字：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.user.userName}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">电话：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.userAddress.contactPhone}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">地址：</label>
                                                                <label class="control-label col-md-5 text-align-left">{{order.userAddress.address}}</label>
                                                            </div>

                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">支付方式：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{payMethod}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">主厨：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.mainCook.realName}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">客户经理：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{managerUserName}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">服务时间：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{serviceDate}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">下单时间：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{createTime}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">派单时间：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{dispatchTime}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">完成时间：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{overTime}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">总金额(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.price}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">应付金额(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.otherPay}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">会员卡抵扣(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.balance}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">积分抵扣(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.accumulate}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">现金券抵扣(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.cashCoupon}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">优惠券抵扣(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.coupon}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">菜品金额(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.foodPrice}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">酒水金额(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.winePrice}}</label>
                                                            </div>
                                                        </div>


                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">交通费(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.transportationCost}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">溢价(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.premium}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">服务员费(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{waiterPrice}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">客用餐具费(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{tablewarePrice}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">男服务员人数：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{waiterManNum}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">女服务员人数：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{waiterWomanNum}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">餐具套数：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{tablewareNum}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">庆典金额(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.specialWeddingPrice}}</label>
                                                            </div>
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-1">服务费(￥)：</label>
                                                                <label class="control-label col-md-2 text-align-left">{{order.serviceCost}}</label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">庆典详情：</label>
                                                                <label class="control-label col-md-5 text-align-left" ng-bind-html="order.specialWeddingDetail| trustHtml"></label>
                                                            </div>

                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">菜品详情：</label>
                                                                <label class="control-label col-md-5 text-align-left" ng-bind-html="order.foodNameDetail| trustHtml"></label>
                                                            </div>

                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">伴餐详情：</label>
                                                                <label class="control-label col-md-5 text-align-left" ng-bind-html="order.specialActDetail| trustHtml"></label>
                                                            </div>

                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">套餐详情：</label>
                                                                <label class="control-label col-md-5 text-align-left" ng-bind-html="order.packageDetail| trustHtml"></label>
                                                            </div>

                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">坝坝宴详情：</label>
                                                                <label class="control-label col-md-5 text-align-left" ng-bind-html="order.baBaYanDetail| trustHtml"></label>
                                                            </div>

                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">用户备注：</label>
                                                                <label class="control-label col-md-7 text-align-left">{{order.reMarket}}</label>
                                                            </div>

                                                        </div>
                                                        <div class="form-group border-1 ">
                                                            <div class="inline-form">
                                                                <label class="control-label col-md-3">后台备注：</label>
                                                                <label class="control-label col-md-7 text-align-left" ng-bind-html="reMarketAdmin| trustHtml"></label>
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
    <script src="<%=request.getContextPath()%>/resources/js/order/info.js"></script>
</body>
</html>
