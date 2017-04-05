



function initData(pageNO,pageSize,operateTypes,userName, toOperateTypes,startTime,endTime){
    var totalPage = 1;

    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/log/list",
        data :{
            operateTypes:operateTypes,
            userName:userName,
            pageNO:pageNO,
            pageSize:pageSize,
            toOperateTypes:toOperateTypes,
            startTimes:startTime,
            endTimes:endTime
        },
        dataType :"json",
        async : false,
        timeout : 5000,
        traditional: true,
        success : function(json){
            if(json.code == 200){
                buildData(json.data.dataList);
                totalPage =  json.data.totalPage == 0 ? 1 : json.data.totalPage;
                //数据添加到页面后，调用一下方式
                $.jqPaginator('#pagination', {
                    totalPages: totalPage,  //总页数
                    visiblePages: 3,  //可见页面
                    currentPage: 1,   //当前页面
                    onPageChange: function (num, type) {
                        $('#showing').text('共'+totalPage+'页  第1/'+totalPage+'页');
                        if(type != "init"){
                            //获取第num页数据，
                            //initData(num,15,operateTypes,userName, toOperateTypes,startTime,endTime)
                            initData(num,15,operateTypes,userName,toOperateTypes,startTime,endTime);
                        }
                    }
                });
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

                str+="<tr>" +
                "<td>"+operateTypeFun(obj.operateType)+"</td>" +
                "<td>"+toOperateTypeFun(obj.toOperateType)+"</td>" +
                "<td>"+obj.describe+"</td>" +
                "<td>"+obj.userName+"</td>" +
                "<td >"+obj.ip+"</td>" +
                "<td>"+createTime+"</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}


function operateTypeFun(type) {
    if (type == 0) {
        return "插入数据";
    } else if(type == 1) {
        return "更新数据";
    } else if(type == 2) {
        return "查询数据";
    } else if(type == 3) {
        return "删除数据";
    }
}


function toOperateTypeFun(type){
    if (type == 0) {
        return "厨师";
    } else if(type == 1) {
        return "普通用户";
    } else if(type == 2) {
        return "后台用户";
    } else if(type == 3) {
        return "菜品";
    } else if(type == 4) {
        return "菜品类型";
    } else if(type == 5) {
        return "套餐/坝坝宴";
    } else if(type == 6) {
        return "订单";
    } else if(type == 7) {
        return "banner";
    } else if(type == 8) {
        return "专业服务";
    } else if(type == 9) {
        return "伴餐演奏";
    } else if(type == 10) {
        return "婚庆";
    } else if(type == 11) {
        return "婚庆--区域管理";
    } else if(type == 12) {
        return "婚庆--配置管理";
    } else if(type == 13) {
        return "订单溢价";
    } else if(type == 14) {
        return "交通配置";
    } else if(type == 15) {
        return "全局配置";
    } else if(type == 16) {
        return "服务费配置";
    } else if(type == 17) {
        return "充值参数配置";
    } else if(type == 18) {
        return "权限配置";
    } else if(type == 19) {
        return "首页字体配置";
    }
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





