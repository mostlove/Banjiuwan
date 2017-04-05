



function initData(pageNO,pageSize){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/callMyAM/getCallMyAM",
        data :{
            pageNO:pageNO,
            pageSize:pageSize
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
        str = "<tr><td colspan='4'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var createTime = new Date(obj.createTime).format("yyyy-MM-dd hh:mm:ss");
            var isHandle = obj.isHandle == 0 ? "未处理" : "已处理";
            var btn =  obj.isHandle == 0 ? "<a href='javascript:void()' onclick='handleCall("+obj.id+")' class='btn btn-info '>标记处理</a>" :
                "<a href='javascript:void(0)' disabled class='btn btn-info '>已处理</a>";
                str+="<tr>" +
                "<td>"+obj.phoneNumber+"</td>" +
                "<td>"+createTime  +"</td>" +
                "<td>"+isHandle+"</td>" +
                "<td>"+btn+"</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}



function handleCall(id){

    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <div class="col-md-12">'+
            '               <span class="help-block">确认此操作吗？</span>'+
        '               </div>'+
        '           </div>'+
        '       </div>' +
        '   </div>' +
        '</form>'+
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
                label: "确定",
                className: "btn-primary",
                callback: function () {
                    $.ajax({
                        type:"POST",
                        url:getRootPath()+"/web/callMyAM/updateCallMyAM",
                        data:{
                            id:id,
                            isHandle:1
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("标记成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                initData(1,15);
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