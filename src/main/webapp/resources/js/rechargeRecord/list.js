



function initData(pageNO,pageSize,phoneNumber,userName, payMethod, status,startTime,endTime){
    var totalPage = 1;
    payMethod = payMethod == 2 ? null : payMethod;
    status = status == 2 ? null : status;


    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/rechargeRecord/getRechargeRecords",
        data :{
            phoneNumber:phoneNumber,
            userName:userName,
            pageNO:pageNO,
            pageSize:pageSize,
            payMethod:payMethod,
            status:status,
            startTime:startTime,
            endTime:endTime
        },
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                buildData(json.data.dataList);
                totalPage =  json.data.totalPage == 0 ? 1 : json.data.totalPage;
            }
            else{
                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
            }
        }
    });
    return totalPage;
}

function buildData(dataList){
    var str = "";
    if(dataList.length == 0){
        str = "<tr><td colspan='8'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var createTime = new Date(obj.createTime).format("yyyy-MM-dd hh:mm:ss");
            var status = obj.status == 0 ? "未支付" : "支付成功";
            var payMethod = obj.payMethod == 0 ? "微信支付" : "支付宝支付";

                str+="<tr>" +
                "<td>"+obj.user.userName+"</td>" +
                "<td>"+obj.user.phoneNumber+"</td>" +
                "<td>"+obj.balance+"</td>" +
                "<td>"+obj.giveBalance+"</td>" +
                "<td>"+obj.outTradeNo+"</td>" +
                "<td>"+status+"</td>" +
                "<td >"+payMethod+"</td>" +
                "<td>"+createTime+"</td>" +
                /*"<td>"+obj.reMarket+"</td>" +*/
                "<td>" +
                "<a href='javascript:void(0)' onclick='saveReMarket("+obj.id+")' class='btn btn-info '>追加备注</a>" +
                "<a href='javascript:void(0)' onclick='getReMarket("+obj.id+")' class='btn btn-info '>查看备注</a>" +
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}


function saveReMarket(id){
    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<div class="input-group" style="width: 100%">'+
        '<textarea id="reMarket" class="form-control textarea" placeholder="请输入追加备注 250字以内" ' +
        ' type="text" maxlength="250" style="width: 100%;resize:none;"  name="reMarket"></textarea>'+
        '</div>'+
        '</div>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "请填写备注",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {
                }
            },
            success: {
                label: "确认追加",
                className: "btn-danger",
                callback: function () {
                    var reMarket = $("#reMarket").val();
                    if(typeof (reMarket) == "undefined" || reMarket == null || reMarket == ''){
                        Notify("请输入备注",'top-right','5000','info','fa-desktop',false);
                    }
                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/rechargeRecord/saveReMarket",
                        data : {
                            id:id,
                            reMarket:reMarket
                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("追加成功",'top-right','5000','info','fa-desktop',true);
                                //var statuss = $("#status").val();
                                //var orderNumber = $("#orderNumber").val();
                                //var userPhone = $("#userPhone").val();
                                //
                                //var payMethod = $("#payMethod").val();
                                ////获取第num页数据，
                                //initData(1,15,statuss,orderNumber,userPhone,payMethod,1);
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


function getReMarket(id){
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/rechargeRecord/getInfo",
        data : {
            id:id
        },
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(respObj){
            var status = respObj.code;
            if(status==200){

                var str='<div id="myModal">'+
                    '<div class="form-group">'+
                    '<label></label>'+
                    '<div class="input-group" style="width: 100%">'+ respObj.data.reMarket +
                    /*'<textarea id="reMarket" class="form-control textarea" placeholder="请输入追加备注 250字以内" ' +
                    ' type="text" maxlength="250" style="width: 100%;resize:none;"  name="reMarket"></textarea>'+*/
                    '</div>'+
                    '</div>'+
                    '</div>';
                bootbox.dialog({
                    message: str,
                    title: "请填写备注",
                    buttons: {
                        "关闭": {
                            className: "btn-default",
                            callback: function () {
                            }
                        }
                    }
                });
            }else{
                Notify(respObj.msg,'top-right','5000','danger','fa-desktop',true);
                return false;
            }
        }
    });
}

/**
 *  导出 数据
 */
function exportData(){
    var str_ = '<label> <input checked  type="checkbox" value="userName" name="rechargeRecordColoum"><span class="text">用户名</span></label>' +
        '<label> <input checked type="checkbox" value="phoneNumber" name="rechargeRecordColoum"><span class="text">手机号</span></label>' +
        '<label> <input checked type="checkbox" value="balance" name="rechargeRecordColoum"><span class="text">充值金额</span></label>' +
        '<label> <input checked type="checkbox" value="giveBalance" name="rechargeRecordColoum"><span class="text">赠送金额</span></label>' +
        '<label> <input checked type="checkbox" value="payMethod" name="rechargeRecordColoum"><span class="text">支付方式</span></label>' +
        '<label> <input checked type="checkbox" value="status" name="rechargeRecordColoum"><span class="text">交易状态</span></label>' +
        '<label> <input checked type="checkbox" value="createTime" name="rechargeRecordColoum"><span class="text">充值时间</span></label>' +
        '<label> <input checked type="checkbox" value="outTradeNo" name="rechargeRecordColoum"><span class="text">订单交易号</span></label>';

    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="checkbox">'+str_+'</div>'+
        '</span>'+
        '</div>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "选择导出列",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {
                }
            },
            success: {
                label: "确认导出",
                className: "btn-danger",
                callback: function () {
                    var array = new Array();
                    var titleArr = new Array();

                    $("input[name='rechargeRecordColoum']:checked").each(function(){

                        var val = $(this).val();
                        array.push(val);
                        titleArr.push($(this).next().html())
                    });
                    var rechargeRecordColoum = JSON.stringify(array);
                    var titleArrJSON = JSON.stringify(titleArr);
                    var userName = $("#userName").val();
                    var phoneNumber = $("#phoneNumber").val();
                    var payMethod = $("#payMethod").val();
                    var status = $("#status").val();
                    var startTime = $("#startTime").val();
                    var endTime = $("#endTime").val();
                    phoneNumber = phoneNumber.length == 0 ? null : phoneNumber;
                    userName = userName.length == 0 ? null : userName;

                    $("#titlesArr").val(titleArrJSON);
                    $("#columnsArr").val(rechargeRecordColoum);
                    $("#userNameTemp").val(userName);
                    $("#phoneNumberTemp").val(phoneNumber);
                    $("#payMethodTemp").val(payMethod == 2 ? null : payMethod);
                    $("#statusTemp").val(status == 2 ? null : status);
                    $("#startTimeTemp").val(startTime.length == 0 ? null : new Date(startTime).getTime());
                    $("#endTimeTemp").val(endTime.length == 0 ? null : new Date(endTime).getTime());
                    $("#downLoadForm").submit();


                    //$.ajax({
                    //    type : "POST",
                    //    url : getRootPath()+"/web/rechargeRecord/downLoadRechargeRecord",
                    //    data : {
                    //        titlesArr:titleArrJSON,
                    //        columnsArr:rechargeRecordColoum,
                    //        userName:userName,
                    //        phoneNumber:phoneNumber,
                    //        payMethod:payMethod,
                    //        status:status,
                    //        startTime:startTime.length == 0 ? null : new Date(startTime).getTime(),
                    //        endTime:endTime.length == 0 ? null : new Date(endTime).getTime()
                    //    },
                    //    dataType :"json",
                    //    async : false,
                    //    timeout : 5000,
                    //    success : function(respObj){
                    //
                    //    }
                    //});

                }
            }
        }
    });

}





