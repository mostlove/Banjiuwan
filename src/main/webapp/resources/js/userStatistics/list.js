



function initData(pageNO,pageSize,userName,mobile,startTime,endTime){
    var totalPage = 1;
    var tstartTime = null;

    if(null != startTime && startTime.length > 0){
        console.debug(tstartTime)
        tstartTime=new Date(startTime).getTime();
    }
    var tendTime = null;
    if(null != startTime && endTime.length > 0){
        console.debug(tendTime)
        tendTime=new Date(endTime).getTime();
    }


    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/user/getUserConsumptionStatistics",
        data :{
            pageNO:pageNO,
            pageSize:pageSize,
            userName:userName,
            mobile:mobile,
            startTime:tstartTime,
            endTime:tendTime
        },
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                buildData(json.data.dataList);
                totalPage =  json.data.totalPage == 0 ? 1 : json.data.totalPage;
                $.jqPaginator('#pagination', {
                    totalPages: totalPage,  //总页数
                    visiblePages: 3,  //可见页面
                    currentPage: 1,   //当前页面
                    onPageChange: function (num, type) {
                        $('#showing').text('共'+totalPage+'页  第'+num+'/'+totalPage+'页');
                        if(type != "init"){
                            var userName = $("#userName").val();
                            var mobile = $("#mobile").val();
                            //获取第num页数据，
                            initData(num,15,userName,mobile);
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
        str = "<tr><td colspan='11'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
                str+="<tr>" +
                "<td>"+obj.userName+"</td>" +
                "<td>"+obj.phoneNumber+"</td>" +
                "<td>"+obj.sumRecharge  +"</td>" +
                "<td>"+obj.sumGiveRecharge+"</td>" +
                "<td >"+obj.memberBalance+"</td>" +
                "<td>"+obj.memberSumConsumption+"</td>" +
                "<td>"+obj.couponBalance+"</td>" +
                "<td>"+obj.couponSumConsumption+"</td>" +
                "<td>" + obj.cashCouponBalance+"</td>" +
                "<td>" + obj.cashCouponSumConsumption+"</td>" +
                "<td>" + obj.countSumConsumption+"</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}



function sendCoupon(userId){

    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">选择类型</label>'+
        '               <div class="col-md-8">'+
            '               <select class="form-control" id="type" onchange="changeType(this)">' +
            '                   <option value="100">请选择类型</option>' +
            '                   <option value="0">优惠券</option>' +
            '                   <option value="1">现金券</option>' +
            '               </select>'+
            '               <span class="help-block"></span>'+
        '               </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">选择券</label>'+
        '               <div class="col-md-8">'+
            '               <select class="form-control" id="coupon">' +
            '                   <option value="0">请选择类型</option>' +
            '               </select>'+
            '               <span class="help-block"></span>'+
        '               </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">有效天数</label>'+
        '               <div class="col-md-8">'+
            '               <input type="number" placeholder="输入有效天数" id="days" class="form-control">'+
            '               <span class="help-block"></span>'+
        '               </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">券说明</label>'+
        '               <div class="col-md-8">'+
            '               <input type="text" maxlength="10" placeholder="输入券说明 (10字以内)" id="text" class="form-control">'+
            '               <span class="help-block"></span>'+
        '               </div>'+
        '           </div>'+
        '       </div>' +
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "发放优惠券",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {

                }
            },
            success: {
                label: "确定新增",
                className: "btn-primary",
                callback: function () {

                    var days = $("#days").val();
                    var couponId = $("#coupon").val();
                    var text = $("#text").val();
                    if(couponId == 0){
                        Notify("没有选择券",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    if(text.length > 10){
                        Notify("券说明过长",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    if(days == 0){
                        Notify("有效天数不合法",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }

                    $.ajax({
                        type:"POST",
                        url:getRootPath()+"/web/userCoupon/sendCoupon",
                        data:{
                            userId:userId,
                            days:days,
                            couponId:couponId,
                            text:text
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("发放成功", 'top-right', '5000', 'info', 'fa-desktop', true);
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

/**
 *  导出Excel表格
 */
function exportExcel(type){

    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="checkbox">是否导出？</div>'+
        '</span>'+
        '</div>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "导出提示",
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
                    var titleArray = ["用户名","电话","累计充值金额","累计赠送金额",
                        "会员卡余额","会员卡累计消费金额","优惠券余额","优惠券累计消费",
                        "现金券余额","现金券累计消费","总累计消费"];
                    var valueArray = ["userName","phoneNumber","sumRecharge","sumGiveRecharge",
                        "memberBalance","memberSumConsumption","couponBalance",
                        "couponSumConsumption","cashCouponBalance","cashCouponSumConsumption",
                        "countSumConsumption"];

                    valueArray = JSON.stringify(valueArray);
                    titleArray = JSON.stringify(titleArray);
                    var userName = $("#userName").val();
                    var mobile = $("#mobile").val();

                    $("#titleArray").val(titleArray);
                    $("#valueArray").val(valueArray);
                    $("#mobileTemp").val(mobile);
                    $("#userNameTemp").val(userName);

                    $("#downLoadForm").submit();




                }
            }
        }
    });


}
