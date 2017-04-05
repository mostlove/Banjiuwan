



function initData(){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/rechargeConfig/getAllRechargeConfig",
        data :{},
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
    return totalPage;
}

function buildData(dataList){
    console.debug(dataList);
    var str = "";
    if(dataList.length == 0){
        str = "<tr><td colspan='3'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){

            var obj = dataList[i];

            str += "<tr>" +
            "<td>"+obj.balance+"</td>" +
            "<td>"+obj.giveBalance+"</td>" +
            "<td>" +
                " <a href='javascript:void(0)' onclick='updateRechargeConfig("+obj.id+","+obj.balance+","+obj.giveBalance+")'  class='btn btn-blue'>修改</a>" +
                " <a href='javascript:void(0)' onclick='delRechargeConfig("+obj.id+")'  class='btn btn-danger'>删除</a>" +
            "</td>" +
            "</tr>";

            console.debug(str);
        }

    }

    $("#dataDiv").html(str);
}


function addRechargeConfig(){

    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">充值金额</label>'+
        '               <div class="col-md-8">'+
        '           <input type="number" class="form-control" maxlength="50" name="balance" id="balance" placeholder="请输入充值金额">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">赠送金额</label>'+
        '               <div class="col-md-8">'+
        '           <input type="number" class="form-control" value="0" maxlength="50" name="giveBalance" id="giveBalance" placeholder="请输入赠送金额">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "新增充值配置",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {

                }
            },
            success: {
                label: "确定",
                className: "btn-primary",
                callback: function () {
                    var balance = $("#balance").val();
                    var reg =  /^\+?[1-9][0-9]*$/;
                    if(balance <= 0 || !reg.test(balance)  ){
                        Notify("充值金额不正确",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    var giveBalance = $("#giveBalance").val();
                    if(giveBalance < 0 || !reg.test(giveBalance) ){
                        Notify("赠送金额不正确",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }

                    $.ajax({
                        type:"POST",
                        url:getRootPath()+"/web/rechargeConfig/addRechargeConfig",
                        data:{
                            balance:balance,
                            giveBalance:giveBalance
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("添加成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                initData();
                            }
                            else{
                                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                            }
                        }
                    });
                }
            }
        }
    });

}


function updateRechargeConfig(id,balance,giveBalance){


    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">充值金额</label>'+
        '               <div class="col-md-8">'+
        '           <input type="number" class="form-control" value="'+balance+'" maxlength="50" name="balance" id="balance" placeholder="请输入充值金额">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">赠送金额</label>'+
        '               <div class="col-md-8">'+
        '           <input type="number" class="form-control" value="'+giveBalance+'" maxlength="50" name="giveBalance" id="giveBalance" placeholder="请输入赠送金额">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "新增充值配置",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {

                }
            },
            success: {
                label: "确定",
                className: "btn-primary",
                callback: function () {
                    var balance = $("#balance").val();
                    var reg =  /^\+?[1-9][0-9]*$/;
                    if(balance <= 0 || !reg.test(balance)){
                        Notify("充值金额不正确",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    var giveBalance = $("#giveBalance").val();
                    if( !reg.test(giveBalance) || giveBalance < 0){
                        Notify("赠送金额不正确",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    $.ajax({
                        type:"POST",
                        url:getRootPath()+"/web/rechargeConfig/updateRechargeConfig",
                        data:{
                            balance:balance,
                            giveBalance:giveBalance,
                            id:id
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("更新成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                initData();
                            }
                            else{
                                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                            }
                        }
                    });
                }
            }
        }
    });



}

function delRechargeConfig(id){
    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="input-group">'+
        '<span>此操作不可逆,确认删除吗？</span>'+
        '</div>'+
        '</span>'+
        '</div>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "提示框",
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
                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/rechargeConfig/delRechargeConfig",
                        data : {
                            id:id
                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                                initData();
                            }else{
                                Notify(respObj.msg,'top-right','5000','danger','fa-desktop',true);
                                return false;
                            }
                        }
                    });

                }
            }
        }
    });
}



