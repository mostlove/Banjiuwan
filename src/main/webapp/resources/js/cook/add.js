/**
 * Created by Administrator on 2017/3/6 0006.
 */

angular.module("webApp",[]).controller("cookCtrl",function($scope,$http,$timeout){
    $scope.addOrUpdate = "修改厨师";
    if ($("#id").val() == null || $("#id").val() == '') {
        $scope.addOrUpdate = "添加厨师";
        return;
    }
    var arr = {
        id:$("#id").val()
    }
    BJW_WEB.ajaxRequestData("get",BJW_WEB.ip+'/web/cook/getCookByIdForWeb',arr,function(result){
        if(result.code == 200){
            $timeout(function () {
                $scope.cook=result.data;
                $("#gender").find("option[value='"+$scope.cook.gender+"']").attr("selected",true);
                console.log($scope.cook);
            })
        }
    })
});

function  addCook(id){
    var isSuccess = false;
    var realName = $("#realName").val();
    var phoneNumber = $("#phoneNumber").val();
    var age = $("#age").val();
    var email = $("#email").val();
    var gender = $("#gender").val();
    var password = $.md5($("#password").val());

    if(!regularEmail.test(email)){
        Notify("邮箱格式不合法",'top-right','5000','danger','fa-desktop',true);
        return isSuccess;
    }

    if($.trim(realName).length == 0 || $.trim(password).length == 0 ){
        Notify("数据格式不合法",'top-right','5000','danger','fa-desktop',true);
        return isSuccess;
    }
    if(!regularTel.test(phoneNumber)){
        Notify("填写正确的手机号",'top-right','5000','danger','fa-desktop',true);
        return isSuccess;
    }



    var url = "/web/cook/addCook";
    var data = {
        realName:realName,
        phoneNumber:phoneNumber,
        password:password,
        age:age,
        email:email,
        gender:gender
    }
    if (id != null && id != '') {
        url = "/web/cook/updateCook";
        data = {
            realName:realName,
            phoneNumber:phoneNumber,
            password:password,
            age:age,
            email:email,
            gender:gender,
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
                isSuccess =  true;
            }
            else{
                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                isSuccess = false;
            }
        }
    });
    return isSuccess;
}