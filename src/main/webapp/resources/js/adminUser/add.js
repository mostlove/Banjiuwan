/**
 * Created by Administrator on 2017/3/6 0006.
 */

angular.module("webApp",[]).controller("adminUserCtrl",function($scope,$http,$timeout){
    $scope.addOrUpdate = "修改管理";
    if ($("#id").val() == null || $("#id").val() == '') {
        $scope.addOrUpdate = "添加管理";
        return;
    }
    var arr = {
        id:$("#id").val()
    }
    BJW_WEB.ajaxRequestData("get",BJW_WEB.ip+'/web/user/getAdminUserByIdForWeb',arr,function(result){
        if(result.code == 200){
            $timeout(function () {
                $scope.adminUser=result.data;
                $("#roleId").find("option[value='"+$scope.adminUser.roleId+"']").attr("selected",true);
                console.log($scope.adminUser);
            })
        }
    })
});

function  addAdminUser(id){
    var roleId = $("#roleId").val();
    var userName = $("#userName").val();
    var phoneNumber = $("#phoneNumber").val();
    var password = $.md5($("#password").val());
    if(roleId == 0  ){
        Notify("请选择角色",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if($.trim(userName).length == 0 || $.trim(password).length == 0 ){
        Notify("数据格式不合法",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if(!regularTel.test(phoneNumber)){
        Notify("填写正确的手机号",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    var isOK = false;
    var url = "/web/user/addAdminUser";
    var data = {
        userName:userName,
        phoneNumber:phoneNumber,
        password:password,
        roleId:roleId
    }
    if (id != null && id != '') {
        url = "/web/user/updateAdminUser";
        data = {
            userName:userName,
            phoneNumber:phoneNumber,
            password:password,
            roleId:roleId,
            id:id
        }
    }

    $.ajax({
        type : "POST",
        url : getRootPath()+url,
        data :data,
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                isOK= true;
            }
            else{
                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                isOK= false;
            }
        }
    });

    return isOK;

}