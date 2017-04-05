



function initData(pageNO,pageSize,status,orderNumber,userPhone,payMethod,startTime,endTime,type){
    if (typeof (status) == "undefined" || status == null) {
        status = '';
    }
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/order/getOrders",
        data :{
            status:status,
            orderNumber:orderNumber,
            userPhone:userPhone,
            payMethods:payMethod,
            type:type,
            startTime:startTime,
            endTime:endTime,
            pageNO:pageNO,
            pageSize:pageSize
        },
        dataType :"json",
        async : false,
        traditional: true,
        timeout : 5000,
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
                            initData(num,15,status,orderNumber,userPhone,payMethod,startTime,endTime,1);
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
    var roleId = $("#roleId").val();
    //console.log(roleId);
    var str = "";
    if(dataList.length == 0){
        str = "<tr><td colspan='10'>暂无数据!</td></tr>";
    }
    else{
       // console.log(dataList)
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var createTime = new Date(obj.createTime).format("yyyy-MM-dd hh:mm");
            var serviceTime = new Date(obj.serviceDate).format("yyyy-MM-dd hh:mm");
            var user = obj.userName+"("+obj.userPhone+")";
            var adminUser = obj.adminName == null ? "暂无" : obj.adminName+"("+obj.adminPhone+")";
            var cooks = JSON.stringify(obj.cooks);
            var diaoDuBtn = "";
            var cancelOrderBtn = "";
            if(roleId == 5){
                if(obj.status == 2001){
                    //diaoDuBtn = "<a href='javascript:void(0)' disabled class='btn mui-btn-grey'>分配厨师</a>";
                    diaoDuBtn = "";
                }
                else if(obj.status == 2002){
                    diaoDuBtn = "<a href='"+bjw.base+"/web/order/cookPage?serviceDate="+obj.serviceDate+"&id="+obj.id+"' class='btn btn-blue'>分配厨师</a>";
                }else{
                    diaoDuBtn = "<a href='javascript:void(0)' onclick='checkCook("+cooks+")' class='btn btn-blue'>查看厨师</a>";
                }
            }else{
                if(obj.status == 2001){
                    diaoDuBtn = "";
                }
                else if(obj.status == 2002){
                    diaoDuBtn = "";
                }else{
                    diaoDuBtn = "<a href='javascript:void(0)' onclick='checkCook("+cooks+")' class='btn btn-blue'>查看厨师</a>";
                }
            }
            if(roleId == 1 && obj.status == 2009){
                // 超级管理
                //cancelOrderBtn = "<a href='"+bjw.base+"/web/refund/refundSubmit?orderId="+obj.id+"' onclick='refundSubmit()' class='btn btn-danger' target='_blank'>取消订单</a>";
                cancelOrderBtn = "<a href='javascript:void(0)' onclick='refundSubmit("+obj.id+")' class='btn btn-danger' target='_blank'>确认取消/退款</a>";
            }
            if(roleId == 1 ){
                if(obj.status == 2002){
                    diaoDuBtn = "<a href='"+bjw.base+"/web/order/cookPage?serviceDate="+obj.serviceDate+"&id="+obj.id+"' class='btn btn-blue'>分配厨师</a>";
                }else{
                    diaoDuBtn = "<a href='javascript:void(0)' onclick='checkCook("+cooks+")' class='btn btn-blue'>查看厨师</a>";
                }
            }
            //评价
            var saveEvaluate = "<a href='javascript:void(0)' onclick='saveEvaluateFun("+obj.id+")' class='btn btn-info '>评价</a>";
            //财务收款
            var getMoney = "<a href='javascript:void(0)' onclick='getMoneyOrSaveReMarket("+obj.id+",1)' class='btn btn-info '>收款</a>";
            var saveReMarket = "<a href='javascript:void(0)' onclick='getMoneyOrSaveReMarket("+obj.id+",0)' class='btn btn-info '>追加备注</a>";


            if (roleId != 2 && roleId != 1) {
                getMoney = "";
            } else {
                if(obj.isConfirm == 1){
                    getMoney = "";
                }
            }

            var upd_url = "<a href='javascript:void(0)' onclick='updEnable("+obj.id+",false)' class='btn btn-danger '>扔进回收站</a>";
            var cook_url = "<a href='"+bjw.base+"/web/order/orderInfoWeb?id="+obj.id+"' onclick='' class='btn btn-info'>查看详情</a>";
            if (!obj.enable) {
                diaoDuBtn = "";
                cook_url = "";
                getMoney = "";
                saveEvaluate = "";
                saveReMarket = "";
                upd_url = "<a href='javascript:void(0)' onclick='updEnable("+obj.id+",true)' class='btn btn-danger '>还原</a>";
            }
            //var btn = '<button onclick="choseCook('+obj.serviceDate+')" type="button" class="btn btn-blue" id="model_button" data-toggle="modal" data-target="#myModal">'+diaoDuBtn+'</button>';

            var payMethod = "未支付";
            if(obj.payMethod == 0 ){
                payMethod = "微信支付";
            }
            else if(obj.payMethod == 1 ){
                payMethod = "支付宝支付";
            }else if(obj.payMethod == 2){
                payMethod = "线下支付";
            }else if(obj.payMethod == 3){
                payMethod = "公众号支付";
            }else if(obj.payMethod == 4){
                payMethod = "无";
            }
                str+="<tr>" +
                "<td>"+obj.orderNumber+"</td>" +
                "<td>"+user+"</td>" +
                "<td>"+adminUser+"</td>" +
                "<td>"+orderStatus(obj.status)+"</td>" +
                "<td >"+obj.address+"</td>" +
                "<td >"+serviceTime+"</td>" +
                "<td >"+obj.price+"</td>" +
                "<td >"+payMethod+"</td>" +
                "<td>"+createTime+"</td>" +
                "<td>" + cook_url + saveEvaluate + saveReMarket + getMoney + diaoDuBtn + upd_url + cancelOrderBtn+
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}

function refundSubmit(id){

    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="checkbox">确认取消订单并退款吗?</div>'+
        '</span>'+
        '</div>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "取消订单",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {
                }
            },
            success:{
                label: "确认",
                className: "btn-danger",
                callback: function () {
                    window.open(getRootPath()+"/web/refund/refundSubmit?orderId="+id+"");
                }
            }
        }
    });


}

function checkCook(cooks){

    if(cooks.length == 0){
        Notify("没有厨师",'top-right','5000','danger','fa-desktop',true);
        return;
    }
    var str_ = "";
    for (var i=0 ; i< cooks.length; i++){
        var checked = "";
        if(cooks[i].isMain == 1){
            checked = "checked";
        }
        str_ += '<label> <input '+checked+' type="checkbox"  > <span class="text">'+cooks[i].realName+'</span> </label>';
    }


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
        title: "查看厨师(选中的则主厨师)",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {

                }
            }
        }
    });

}





function  distributionCook(orderId){



}

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



var timeConfig = null;

/**
 *  查看 设置 排班
 * @param cookId
 * @constructor
 */
function Scheduling(cookId,timeConfigArr){

    if(null == timeConfig){
        $.ajax({
            type : "POST",
            url : getRootPath()+"/web/timeConfig/queryAllTimeConfig",
            data : {},
            dataType :"json",
            async : false,
            timeout : 5000,
            success : function(respObj){
                var status = respObj.code;
                if(status==200){
                    timeConfig = respObj.data;
                }else{
                    Notify(respObj.msg,'top-right','5000','danger','fa-desktop',true);
                    return false;
                }
            }
        });

    }
    buildCheckBok(timeConfig,cookId,timeConfigArr);
}


/**
 *  生成多选框
 * @param dataArr
 */
function  buildCheckBok(dataArr,cookId,timeConfigArr){

    var str_ = "";
    for (var i=0; i<dataArr.length; i++){
        var checked = "";
        for (var j=0; j<timeConfigArr.length; j++){
            if(dataArr[i].id == timeConfigArr[j].timeConfigId){
                checked = "checked";
            }
        }

        str_ += '<label> <input '+checked+' type="checkbox" name="times" value="'+dataArr[i].id+'"> <span class="text">'+dataArr[i].time+'</span> </label>'
    }

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
                    var array = new Array();
                    $("input[name='times']:checked").each(function(){
                        var val = $(this).val();
                        array.push(val);
                    });
                    var times = JSON.stringify(array);

                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/cook/setTimeConfig",
                        data : {
                            cookId:cookId,
                            times:times
                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                                initData(1,15,null,null);
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


function getMoneyOrSaveReMarket(id,type){
    var placeholder = "请输入收款备注 250字以内";
    var msg = "确认收款";
    var msg2 = "收款成功";
    if (type == 0) {
        placeholder = "请输入追加备注 250字以内";
        msg = "确认追加";
        msg2 = "追加成功";
    }
    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<div class="input-group" style="width: 100%">'+
        '<textarea id="reMarket" class="form-control textarea" placeholder="'+placeholder+'" ' +
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
                label: msg,
                className: "btn-danger",
                callback: function () {
                    var reMarket = $("#reMarket").val();
                    if (type == 0) {
                       if(typeof (reMarket) == "undefined" || reMarket == null || reMarket == ''){
                           Notify("请输入备注",'top-right','5000','info','fa-desktop',false);
                       }
                    }
                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/order/saveReMarket",
                        data : {
                            id:id,
                            reMarket:reMarket,
                            type:type
                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify(msg2,'top-right','5000','info','fa-desktop',true);
                                var statuss = $("#status").val();
                                var orderNumber = $("#orderNumber").val();
                                var userPhone = $("#userPhone").val();

                                var payMethod = $("#payMethod").val();
                                //获取第num页数据，
                                initData(1,15,statuss,orderNumber,userPhone,payMethod,1);
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

//全局变量
var imgAry = new Array();
var num = 0;
//上传相册
$("#addImg").browser({
    callback:function(images) {
        if (typeof (images) != "undefined" && images != null && images != '') {
            var path = bjw.base+"/"+images[0];
            imgAry[num] = images;
            $("#imgDiv").append('<div style="width: 114px;height: 72px;float: left;position: relative"><span onclick=\"delImg('+num+',this)\" class=\"closeImg\">X</span><img class="padding-right-5 padding-bottom-5 enlarges" src="'+path+'" style="width: 100%;height: 100%;"></div>');
            bigImg();
            num ++;
        }
    }
});



//上传头像
var avatarImg;
$("#addAvatar").browser({
    callback:function(images) {
        if (typeof (images) != "undefined" && images != null && images != '') {
            var path = bjw.base+"/"+images;
            $("#avatarDiv").empty();
            $("#avatarDiv").append('<img src="'+path+'" style="width: 50px;height: 50px;" id="avatarImg" class="img-circle enlarges">');
            avatarImg = images[0];
            bigImg();
        }

    }
});



function bigImg() {
    $(".enlarges").css("cursor", "pointer");
    $(".enlarges").on("click",function (){
        layer.open({
            type: 1,
            title: false,
            closeBtn: 1,
            skin: 'yourclass',
            shadeClose: true,
            shade: 0.5,
            offset:['100px'],
            area:['800px' , '500px'],
            content: "<img height='100%' width='100%' src='" + $(this).attr("src") + "'/>"
        });
    });
}
function saveEvaluateFun(id) {
    var str='<div id="myModal">'+
        '<div class="form-group">' +
        '<div class="input-group margin-top-5">' +
        '<input class="btn btn-blue" type="button" value="上传头像" onclick="$(\'#addAvatar\').click();">' +
        '</div>' +
        '<div id="avatarDiv" class="input-group margin-top-5">' +
        '</div>'+
        '<label class="margin-top-5" >手机号</label>'+
        '<div class="input-group" style="width: 100%">' +
        '<input type="text" class="form-control" style="width: 50%" id="phoneNumber" name="phoneNumber" maxlength="11" />'+
        '</div>'+
        '<label class="margin-top-5" >评价等级</label>' +
        '<div class="input-group" style="width: 100%">' +
        '<label class="checkbox-inline"><input name="evaluateLevel" checked type="radio" value="1" /><span class="text">好评</span></label>' +
        '<label class="checkbox-inline"><input name="evaluateLevel" type="radio" value="2" /><span class="text">中评</span></label>' +
        '<label class="checkbox-inline"><input name="evaluateLevel" type="radio" value="3" /><span class="text">差评</span></label>' +
        '</div>' +
        '<label class="margin-top-5" >服务评分</label>' +
        '<div class="input-group" style="width: 100%">' +
        '<label class="checkbox-inline"><input name="serviceScore" checked type="radio" value="5" /><span class="text">5分</span></label>' +
        '<label class="checkbox-inline"><input name="serviceScore" type="radio" value="4" /><span class="text">4分</span></label>' +
        '<label class="checkbox-inline"><input name="serviceScore" type="radio" value="3" /><span class="text">3分</span></label>' +
        '<label class="checkbox-inline"><input name="serviceScore" type="radio" value="2" /><span class="text">2分</span></label>' +
        '<label class="checkbox-inline"><input name="serviceScore" type="radio" value="1" /><span class="text">1分</span></label>' +
        '</div>'+
        '<label class="margin-top-5" >厨师评分</label>' +
        '<div class="input-group" style="width: 100%">' +
        '<label class="checkbox-inline"><input name="cookScore" checked type="radio" value="5" /><span class="text">5分</span></label>' +
        '<label class="checkbox-inline"><input name="cookScore" type="radio" value="4" /><span class="text">4分</span></label>' +
        '<label class="checkbox-inline"><input name="cookScore" type="radio" value="3" /><span class="text">3分</span></label>' +
        '<label class="checkbox-inline"><input name="cookScore" type="radio" value="2" /><span class="text">2分</span></label>' +
        '<label class="checkbox-inline"><input name="cookScore" type="radio" value="1" /><span class="text">1分</span></label>' +
        '</div>' +
        '<div class="input-group margin-top-5">' +
        '<input class="btn btn-blue" type="button" value="上传图片" onclick="$(\'#addImg\').click();">' +
        '</div>' +
        '<div id="imgDiv" style="width:100%;" class="input-group margin-top-5">' +
        '</div>'+
        '<label class="margin-top-5" >评价内容</label>'+
        '<div class="input-group" style="width: 100%">'+
        '<textarea id="content" class="form-control textarea" placeholder="请输入评价内容 250字以内" ' +
        ' type="text" maxlength="250" style="width: 100%;resize:none;"  name="content"></textarea>'+
        '</div>'+
        '</div>'+
        '</div>';

    var imgs = '';



    bootbox.dialog({
        message: str,
        title: "请进行评价",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {
                    imgAry = new Array();
                }
            },
            success: {
                label: "确认",
                className: "btn-danger",
                callback: function () {

                    if (imgAry.length > 0) {
                        for (var i = 0 ; i < imgAry.length ; i ++ ) {
                            if (typeof (imgAry[i]) != "undefined" && imgAry[i] != null && imgAry[i] != '') {
                                imgs += ","+imgAry[i];
                            }
                        }
                    }

                    var phoneNumber = $("#phoneNumber").val();
                    if (typeof (phoneNumber) == "undefined" || phoneNumber == null || phoneNumber == '') {
                        Notify("输入手机号",'top-right','5000','info','fa-desktop',false);
                        return false;
                    }
                    //手机号验证
                    // var regularTel = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
                    var regularTel = /^1[3|4|5|7|8][0-9]\d{8}$/;

                    if (!regularTel.test(phoneNumber)) {
                        Notify("输入正确的手机号",'top-right','5000','info','fa-desktop',false);
                        return false;
                    }

                    var content = $("#content").val();
                    if(typeof (content) == "undefined" || content == null || content == ''){
                        Notify("请输入评价内容",'top-right','5000','info','fa-desktop',false);
                        return false;
                    }

                    var evaluateLevel = $('input:radio[name="evaluateLevel"]:checked').val();
                    var serviceScore = $("input:radio[name='serviceScore']:checked").val();
                    var cookScore = $("input:radio[name='cookScore']:checked").val();
                    console.log("imgs:"+imgs);
                    console.log("evaluateLevel:"+evaluateLevel);
                    console.log("serviceScore:"+serviceScore);
                    console.log("cookScore:"+cookScore);
                    console.log("content:"+content);

                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/evaluate/save",
                        data : {
                            objectId:id,
                            orderId:id,
                            evaluateLevel:evaluateLevel,
                            type:1,
                            serviceScore:serviceScore,
                            cookScore:cookScore,
                            content : content,
                            imgs:imgs,
                            phoneNumber:phoneNumber,
                            avatar:avatarImg

                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("评价成功",'top-right','5000','info','fa-desktop',true);
                                var statuss = $("#status").val();
                                var orderNumber = $("#orderNumber").val();
                                var userPhone = $("#userPhone").val();

                                var payMethod = $("#payMethod").val();
                                //获取第num页数据，
                                initData(1,15,statuss,orderNumber,userPhone,payMethod,1);
                            }else{
                                Notify(respObj.msg,'top-right','5000','danger','fa-desktop',true);
                                return false;
                            }
                        }
                    });
                    imgAry = new Array();
                }
            }
        }
    });
}

function delImg(num,obj) {
    $(obj).parent().remove();
    imgAry.remove(num);
}

function updEnable(id,isValid){
    var msg = isValid == false ? "是否放入回收站？" : "是否还原？";
    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="input-group">'+
        '<span id="name" >'+msg+'</span>'+
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
                        url : getRootPath()+"/web/order/updateIsEnable",
                        data : {
                            id:id,
                            isEnable:isValid
                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                                var statuss = $("#status").val();
                                var orderNumber = $("#orderNumber").val();
                                var userPhone = $("#userPhone").val();

                                var payMethod = $("#payMethod").val();
                                //获取第num页数据，
                                initData(1,15,statuss,orderNumber,userPhone,payMethod,isValid?0:1);
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

/**
 *  导出Excel表格
 */
function exportExcel(type){


    var str_ = '<label> <input checked  type="checkbox" value="orderNumber" name="orderColumns"><span class="text">订单号</span></label>' +
        '<label> <input checked type="checkbox" value="status" name="orderColumns"><span class="text">订单状态</span></label>' +
        '<label> <input checked type="checkbox" value="userName" name="orderColumns"><span class="text">创建人</span></label>' +
        '<label> <input checked type="checkbox" value="userPhone" name="orderColumns"><span class="text">创建人电话</span></label>' +
        '<label> <input checked type="checkbox" value="address" name="orderColumns"><span class="text">服务地址</span></label>' +
        '<label> <input checked type="checkbox" value="payMethod" name="orderColumns"><span class="text">支付方式</span></label>' +
        '<label> <input checked type="checkbox" value="mainCook" name="orderColumns"><span class="text">主厨</span></label>' +
        '<label> <input checked type="checkbox" value="serviceDate" name="orderColumns"><span class="text">服务时间</span></label>'+
        '<label> <input checked type="checkbox" value="createTime" name="orderColumns"><span class="text">下单时间</span></label>'+
        '<label> <input checked type="checkbox" value="overTime" name="orderColumns"><span class="text">完成时间</span></label>'+
        '<label> <input checked type="checkbox" value="dispatchTime" name="orderColumns"><span class="text">派单时间</span></label>'+
        '<label> <input checked type="checkbox" value="price" name="orderColumns"><span class="text">订单总金额</span></label>'+
        '<label> <input checked type="checkbox" value="otherPay" name="orderColumns"><span class="text">应付金额</span></label>'+
        '<label> <input checked type="checkbox" value="foodPrice" name="orderColumns"><span class="text">菜品金额</span></label>'+
        '<label> <input checked type="checkbox" value="winePrice" name="orderColumns"><span class="text">酒水金额</span></label>'+
        '<label> <input checked type="checkbox" value="transportationCost" name="orderColumns"><span class="text">交通费用</span></label>'+
        '<label> <input checked type="checkbox" value="premium" name="orderColumns"><span class="text">溢价</span></label>'+
        '<label> <input checked type="checkbox" value="waiterPrice" name="orderColumns"><span class="text">服务员费</span></label>'+
        '<label> <input checked type="checkbox" value="tablewarePrice" name="orderColumns"><span class="text">客用餐具费</span></label>'+
        '<label> <input checked type="checkbox" value="waiterManNum" name="orderColumns"><span class="text">男服务员人数</span></label>'+
        '<label> <input checked type="checkbox" value="waiterWomanNum" name="orderColumns"><span class="text">女服务员人数</span></label>'+
        '<label> <input checked type="checkbox" value="tablewareNum" name="orderColumns"><span class="text">餐具套数</span></label>'+
        '<label> <input checked type="checkbox" value="specialWeddingPrice" name="orderColumns"><span class="text">庆典金额</span></label>'+
        '<label> <input checked type="checkbox" value="serviceCost" name="orderColumns"><span class="text">服务费</span></label>'+
        '<label> <input checked type="checkbox" value="specialWeddingDetail" name="orderColumns"><span class="text">庆典详情</span></label>'+
        '<label> <input checked type="checkbox" value="foodNameDetail" name="orderColumns"><span class="text">菜品详情</span></label>'+
        '<label> <input checked type="checkbox" value="specialActDetail" name="orderColumns"><span class="text">伴餐详情</span></label>'+
        '<label> <input checked type="checkbox" value="baBaYanDetail" name="orderColumns"><span class="text">坝坝宴详情</span></label>'+
        '<label> <input checked type="checkbox" value="packageDetail" name="orderColumns"><span class="text">套餐详情</span></label>'+
        '<label> <input checked type="checkbox" value="reMarket" name="orderColumns"><span class="text">用户备注</span></label>'+
        '<label> <input checked type="checkbox" value="reMarketAdmin" name="orderColumns"><span class="text">后台管理备注</span></label>';
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
                    var valueArray = new Array();
                    var titleArray = new Array();

                    $("input[name='orderColumns']:checked").each(function(){
                        var val = $(this).val();
                        valueArray.push(val);
                        titleArray.push($(this).next().html())
                    });
                    if(titleArray.length == 0){
                        Notify("没有选择任何列",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    valueArray = JSON.stringify(valueArray);
                    titleArray = JSON.stringify(titleArray);
                    var status = $("#status").val();
                    var orderNumber = $("#orderNumber").val();
                    var userPhone = $("#userPhone").val();
                    var payMethod = $("#payMethod").val();
                    var startTime = $("#startTime").val();
                    var endTime = $("#endTime").val();

                    $("#titleArray").val(titleArray);
                    $("#valueArray").val(valueArray);
                    $("#statusTemp").val(status);
                    $("#orderNumberTemp").val(orderNumber);
                    $("#userPhoneTemp").val(userPhone);
                    $("#payMethodTemp").val(payMethod);
                    $("#typeTemp").val(type);
                    $("#startTimeTemp").val(startTime);
                    $("#endTimeTemp").val(endTime);

                    $("#downLoadForm").submit();

                    //$.ajax({
                    //    type : "POST",
                    //    url : getRootPath()+"/web/order/exportExcel",
                    //    data :{
                    //        valueArray:valueArray,
                    //        titleArray:titleArray,
                    //        status:status,
                    //        orderNumber:orderNumber,
                    //        userPhone:userPhone,
                    //        payMethod:payMethod,
                    //        type:type
                    //    },
                    //    dataType :"json",
                    //    async : false,
                    //    timeout : 5000,
                    //    traditional: true,
                    //    success : function(json){
                    //
                    //    }
                    //});


                }
            }
        }
    });


}


