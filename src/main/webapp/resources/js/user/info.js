/**
 * Created by lzh on 2017/3/14.
 */

angular.module('webApp',[]).controller('userInfoCtrl',function($scope,$http,$timeout){
    var arr={
        id:$("#id").val()
    };
    $scope.getOrderInfo=function () {
        BJW_WEB.ajaxRequestData("get",BJW_WEB.ip+'/web/user/queryUserById',arr,function(result){
            $scope.createTime;
            $scope.lastLogin;
            if(result.code == 200){
                $timeout(function () {
                    $scope.user=result.data;
                    if ($scope.user.updateTime != null) {
                        $scope.createTime = BJW_WEB.timeStampConversion($scope.user.createTime);
                    }
                    if ($scope.user.lastLogin != null) {
                        $scope.lastLogin = BJW_WEB.timeStampConversion($scope.user.lastLogin);
                    }
                    console.log($scope.user);
                })
            }
        })
    }
    $scope.getOrderInfo();
});