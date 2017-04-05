



function initData(type,pageNO,pageSize){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/coupon/queryAllCoupon",
        data :{
            pageNO:pageNO,
            pageSize:pageSize,
            type:type
        },
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                buildData(json.data.dataList);
                totalPage = json.data.totalPage == 0 ? 1 : json.data.totalPage;
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
        str = "<tr><td colspan='6'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){

            var obj = dataList[i];
            var type = obj.type == 0 ? "优惠券" : "现金券";
            var useInterval = "";
            if(obj.categories.length > 0){
                for (var j=0; j<obj.categories.length; j++){
                    useInterval += obj.categories[j].categoryName +"|";
                }
            }else{
                useInterval = "暂无";
            }
            var needSpend =  obj.needSpend == null ? "暂无" : "消费"+obj.needSpend+"才能使用";
            var newUserCouponBtn = "";
            if(null == obj.isNewUserCoupon){
                newUserCouponBtn = "<a href='javascript:void(0)' onclick='setNewUserCoupon("+obj.id+")' class='btn btn-blue'>设置注册赠送</a>"
            }
            else{
                newUserCouponBtn = "<a href='javascript:void(0)' onclick='cancelNewUserCoupon("+obj.id+")' class='btn btn-warning'>取消注册赠送</a>";
            }
            var days = obj.days == null? "无" : obj.days;
            str += "<tr>" +
            "<td>"+obj.faceValue+"</td>" +
            "<td>"+type+"</td>" +
            "<td>"+needSpend+"</td>" +
            "<td>"+useInterval+"</td>" +
            "<td>"+days+"</td>" +
            "<td>" +
                " <a href='javascript:void(0)' onclick='delCoupon("+obj.id+")'  class='btn btn-danger'>删除</a>" +newUserCouponBtn+
            "</td>" +
            "</tr>";

            console.debug(str);
        }

    }

    $("#dataDiv").html(str);
}

function cancelNewUserCoupon(couponId){

    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="input-group">'+
        '<span>确认取消注册时，赠送此优惠券吗？</span>'+
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
                        url : getRootPath()+"/web/coupon/delNewUserCoupon",
                        data : {
                            couponId:couponId,
                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                                initData(null,1,15);
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

function setNewUserCoupon(couponId){

    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="input-group">'+
        '<input type="number" id="days" class="form-control" placeholder="输入有效天数">'+
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
                    var days = $("#days").val();
                    var reg = /^\+?[1-9][0-9]*$/;
                    if(days <= 0 || !reg.test(days) ){
                        Notify("请输入有效的有效天数",'top-right','5000','danger','fa-desktop',true);
                        return ;
                    }

                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/coupon/setNewUserCoupon",
                        data : {
                            couponId:couponId,
                            days:days
                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                                initData(null,1,15);
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

function delCoupon(id){
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
                        url : getRootPath()+"/web/coupon/delCoupon",
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
                                initData(null,1,15);
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



