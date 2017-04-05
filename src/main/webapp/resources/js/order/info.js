/**
 * Created by lzh on 2017/3/14.
 */

angular.module('webApp',[]).controller('orderInfoCtrl',function($scope,$http,$timeout){
    var arr={
        id:$("#id").val()
    };
    $scope.getOrderInfo=function () {
        BJW_WEB.ajaxRequestData("post",BJW_WEB.ip+'/web/order/info',arr,function(result){
            $scope.createTime;
            $scope.serviceDate;
            $scope.overTime;
            $scope.dispatchTime;
            if(result.code == 200){
                $timeout(function () {

                    $scope.order=result.data;
                    if ($scope.order.createTime != null) {
                        $scope.createTime = BJW_WEB.timeStampConversion($scope.order.createTime);
                    }
                    if ($scope.order.serviceDate != null) {
                        $scope.serviceDate = BJW_WEB.timeStampConversion($scope.order.serviceDate);
                    }
                    if ($scope.order.overTime != null) {
                        $scope.overTime = BJW_WEB.timeStampConversion($scope.order.overTime);
                    }
                    if ($scope.order.dispatchTime != null) {
                        $scope.dispatchTime = BJW_WEB.timeStampConversion($scope.order.dispatchTime);
                    }
                    var orderDetail = JSON.parse(JSON.parse($scope.order.orderDetail));
                    console.log(orderDetail);
                    //服务员费
                    $scope.waiterPrice = 0;
                    //男服务员人数
                    $scope.waiterManNum = 0;
                    //女服务员人数
                    $scope.waiterWomanNum = 0;
                    //餐具费
                    $scope.tablewarePrice = 0;
                    //餐具数量
                    $scope.tablewareNum = 0;
                    angular.forEach(orderDetail,function(data){
                        if (data.foodCategoryId == 11) {
                            //男服务员
                            if (data.foodId == 1) {
                                $scope.waiterManNum = data.number;
                                $scope.waiterPrice += data.price * data.number;
                            }
                            //女服务员
                            if (data.foodId == 2) {
                                $scope.waiterWomanNum = data.number;
                                $scope.waiterPrice += data.price * data.number;
                            }
                            //餐具
                            if (data.foodId == 3) {
                                $scope.tablewareNum = data.number;
                                $scope.tablewarePrice += data.price * data.number;
                            }
                        }
                        console.log("foodId:"+data.foodId);
                    });

                    $scope.payMethod = "微信支付";
                    if ($scope.order.payMethod == 1) {
                        $scope.payMethod = "支付宝支付";
                    }
                    if ($scope.order.payMethod == 2) {
                        $scope.payMethod = "线下支付";
                    }


                    //订单状态
                    $scope.orderStatus = "待支付";
                    $scope.status = $scope.order.status;
                    if (null == $scope.status || $scope.status == "") {
                        $scope.status = 2001;
                    }

                    $scope.orderStatus = orderStatus($scope.status);
                    //switch ($scope.status) {
                    //    case 2001:$scope.orderStatus = "待支付";break;
                    //    case 2002:$scope.orderStatus = "待确认";break;
                    //    case 2003:$scope.orderStatus = "待服务";break;
                    //    case 2004:$scope.orderStatus = "服务中";break;
                    //    case 2005:$scope.orderStatus = "完成";break;
                    //    case 2006:$scope.orderStatus = "待评价";break;
                    //    case 2007:$scope.orderStatus = "评价完成";break;
                    //    case 2008:$scope.orderStatus = "待接单";break;
                    //    case 2009:$scope.orderStatus = "订单已取消";break;
                    //}
                    $scope.managerUserName = $scope.order.managerUser == null ? "" :  $scope.order.managerUser;



                    $scope.reMarketAdmin = "";
                    if (typeof ($scope.order.reMarketAdmin) != "undefined" && $scope.order.reMarketAdmin != null) {
                        var reMarketAdminAry = $scope.order.reMarketAdmin.split(";");
                        for (var i = 0 ; i < reMarketAdminAry.length ; i ++) {
                            $scope.reMarketAdmin = $scope.reMarketAdmin + reMarketAdminAry[i] + "</br>";
                        }
                    }

                })
            }
        })
    }
    $scope.getOrderInfo();
}).filter('trustHtml', function ($sce) {
    return function (input) {
        return $sce.trustAsHtml(input);
    }
});


function orderStatus(status){
    var statusStr = "";
    switch (status){
        case 2001:
            statusStr = "待支付";
            break;
        case 2002:
            statusStr = "待确认";
            break;
        case 2003:
            statusStr = "待服务";
            break;
        case 2004:
            statusStr = "服务中";
            break;
        case 2005:
            statusStr = "服务完成";
            break;
        case 2006:
            statusStr = "待评价";
            break;
        case 2007:
            statusStr = "评价完成";
            break;
        case 2008:
            statusStr = "待接单";
            break;
        case 2009:
            statusStr = "退款中";
            break;
        case 2010:
            statusStr = "退款成功";
            break;
        default:
            statusStr = "暂无";
            break;
    }
    return statusStr;
}