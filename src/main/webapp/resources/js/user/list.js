



function initData(pageNO,pageSize,phoneNumber,userName){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/user/getUsers",
        data :{
            phoneNumber:phoneNumber,
            userName:userName,
            pageNO:pageNO,
            pageSize:pageSize
        },
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                console.debug(json.data)
                buildData(json.data.dataList);
                totalPage =  json.data.totalPage == 0 ? 1 : json.data.totalPage;
                $.jqPaginator('#pagination', {
                    totalPages: totalPage,  //总页数
                    visiblePages: 3,  //可见页面
                    currentPage: 1,   //当前页面
                    onPageChange: function (num, type) {
                        $('#showing').text('共'+totalPage+'页  第1/'+totalPage+'页');
                        if(type != "init"){
                            //获取第num页数据，
                            initData(num,15,phoneNumber,userName);
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
        str = "<tr><td colspan='10'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var createTime = new Date(obj.createTime).format("yyyy-MM-dd hh:mm:ss");
            var lastTime = new Date(obj.lastLogin).format("yyyy-MM-dd hh:mm:ss");
            var personalTaste = obj.personalTaste == null ? "无" : obj.personalTaste;
            var likeCuisine = obj.likeCuisine == null ? "无" : obj.likeCuisine;
            var btnStr = obj.isValid == 0 ? "解冻账户" : "冻结账户" ;
            var adminName = obj.adminName == null ? "无" : obj.adminName;
                str+="<tr>" +
                "<td>"+obj.userName+"</td>" +
                "<td>"+obj.phoneNumber+"</td>" +
                "<td>"+personalTaste  +"</td>" +
                "<td>"+likeCuisine+"</td>" +
                "<td class='price'>￥"+obj.balance+"</td>" +
                "<td>"+obj.accumulate+"</td>" +
                "<td>"+adminName+"</td>" +
                "<td>"+createTime+"</td>" +
                "<td>"+lastTime+"</td>" +
                "<td>" +
                "   <a href='"+getRootPath()+"/web/user/edit?id="+obj.id+"' class='btn btn-info '>详情</a>" +
                    "<a href='javascript:void(0)' onclick='saveReMarket("+obj.id+")' class='btn btn-info '>追加备注</a>" +
                    "<a href='javascript:void()' onclick='sendCoupon("+obj.id+")' class='btn btn-info '>发放优惠/现金券</a>" +
                    "<a href='javascript:void()' class='btn btn-danger' onclick='delUser("+obj.id+","+obj.isValid+")'>"+btnStr+"</a>" +
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}

function delUser(id,isValid){
    var str_ = isValid == 0 ? "解冻账户" : "冻结账户" ;
    var str='<div id="myModal">'+
        '<span class="form-group">'+
        '<label></label>'+
        '<span>确认'+str_+'?</span> ' +
        '</div>'+
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

                    var valid = isValid == 0 ? 1 : 0;
                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/user/updateIsValid",
                        data : {
                            id:id,
                            isValid:valid,
                            flag:0
                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                                var totalpage = initData(1,15,null,null);
                                //数据添加到页面后，调用一下方式
                                $.jqPaginator('#pagination', {
                                    totalPages: totalpage,  //总页数
                                    visiblePages: 3,  //可见页面
                                    currentPage: 1,   //当前页面
                                    onPageChange: function (num, type) {
                                        $('#showing').text('共'+totalpage+'页  第1/'+totalpage+'页');
                                        if(type != "init"){
                                            //获取第num页数据，
                                            initData(num,15,null,null);
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
            }
        }
    });

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
                        url : getRootPath()+"/web/user/saveReMarket",
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
                    $(".btn-primary").attr("disabled",true);
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
                    if(text.length == 0){
                        Notify("券说明必须填写",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    if(days <= 0){
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
                                return true;
                            }
                            else{
                                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                                return false;
                            }
                        }
                    });
                    $(".btn-primary").attr("disabled",false);
                }
            }
        }
    });

}

function changeType(obj){
    var type = $(obj).val();

    $.ajax({

        type:"POST",
        url:getRootPath()+"/web/coupon/queryAllCouponByType",
        data:{
            type:type
        },
        dataType:"json",
        async:false,
        timeout:5000,
        success : function(json){
            if(json.code == 200){
                buildOption(json.data);
            }
            else{

            }
        }
    });

}

function buildOption(dataList){
    var str = "";
    if(dataList.length == 0){
        str = "<option value='0'>暂无数据</option>"
    }else{
        for (var i=0; i<dataList.length; i++){

            var name = dataList[i].type == 0 ? "满"+dataList[i].needSpend+"元,抵扣"+dataList[i].faceValue : "面值"+dataList[i].faceValue+"现金券";
            str += "<option value='"+dataList[i].id+"'>"+name+"</option>";
        }
    }
    $("#coupon").html(str);
}


/**
 *  导出Excel表格
 */
function exportExcel(){

    var str='<div id="myModal">'+
        '<div class="form-group">'  +
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
                    var titleArray = ["用户名","手机号","个人口味","喜欢菜系",
                        "余额","积分","注册时间","最后登录"];
                    var valueArray = ["userName","phoneNumber","personalTaste","likeCuisine",
                        "balance","accumulate","createTime","lastLogin"];

                    valueArray = JSON.stringify(valueArray);
                    titleArray = JSON.stringify(titleArray);

                    var userName = $("#userName").val();
                    var phoneNumber = $("#phoneNumber").val();

                    $("#titleArray").val(titleArray);
                    $("#valueArray").val(valueArray);
                    $("#phoneNumberTemp").val(phoneNumber);
                    $("#userNameTemp").val(userName);

                    $("#downLoadForm").submit();
                }
            }
        }
    });


}