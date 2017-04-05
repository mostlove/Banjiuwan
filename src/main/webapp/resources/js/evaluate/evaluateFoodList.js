



function initData(pageNO,pageSize,userType,evaluateLevel,isPass,foodCategoryId,objectId){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/evaluate/getFoodListForWeb",
        data :{
            pageNO:pageNO,
            pageSize:pageSize,
            objectIds:objectId,
            foodCategoryIds:foodCategoryId,
            isPass:isPass,
            userType:userType,
            evaluateLevel:evaluateLevel
        },
        dataType :"json",
        async : false,
        traditional: true,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                buildData(json.data.dataList);
                totalPage =  json.data.totalPage == 0 ? 1 : json.data.totalPage;
                updateIsPass();
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
        str = "<tr><td colspan='9'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){



            var obj = dataList[i];
            var createTime = new Date(obj.createTime).format("yyyy-MM-dd hh:mm:ss");

            //评价等级
            var evaluateLevel = "好评";
            if(obj.evaluateLevel == 2) {
                evaluateLevel = "中评";
            }
            if(obj.evaluateLevel == 3) {
                evaluateLevel = "差评";
            }

            var userType = "普通用户";
            if(obj.userType == 2) {
                userType = "管理员";
            }
            var isPassMsg = "否";
            var isPassMsgBtn = "通过";
            var isPassInt = 1;
            if (obj.pass == 1) {
                isPassMsg = "是";
                isPassMsgBtn = "取消通过";
                isPassInt = 0;
            }

            console.debug(obj);
            str += "<tr>" +
                "<td>"+obj.foodName+"</td>" +
                "<td>"+evaluateLevel+"</td>" +
                "<td>"+obj.content+"</td>" +
                "<td>"+obj.foodScore+"</td>" +
                //"<td>"+judgeCategory(obj.foodCategoryId)+"</td>" +
                "<td>"+obj.categoryName+"</td>" +
                "<td class='isPassMsg'>"+isPassMsg+"</td>" +
                "<td>"+userType+"</td>" +
                "<td>"+obj.userName+"</td>" +
                "<td>"+createTime+"</td>" +
                "<td>" +
                "<a href='javascript:void();' isPass='"+isPassInt+"' EId='"+obj.id+"' class='btn btn-info isPassBtn'>"+isPassMsgBtn+"</a>" +
                "<a href='javascript:void();' onclick=queryImg(\'"+obj.imgs+"\') class='btn btn-info'>查看图片</a>" +
                "</td>" +
                "</tr>"
        }
    }
    $("#dataDiv").html(str);
}


function queryImg(imgs) {

    var str='<div id="myModal">'+
            '<div class="form-group">' +
            '<div id="imgDiv" style="width:100%;" class="input-group margin-top-5">';
    if(imgs != null && imgs != '') {
       var img = imgs.split(",");
        for (var i = 0; i < img.length ; i ++) {
            str += '<img class="padding-right-5 padding-bottom-5" src="'+getRootPath()+"/"+img[i]+'" style="width: 114px;height: 72px;float: left;">';
        }
    } else {
        str += "无";
    }
           str += '</div>'+
            '</div>'+
            '</div>';
    bootbox.dialog({
        message: str,
        title: "评价图片",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {
                }
            }
        }
    });
}


function updateIsPass(){
    $(".isPassBtn").click(function(){
        var obj = $(this);
        var id = obj.attr("EId");
        var isPass = obj.attr("isPass");
        $.ajax({
            type : "POST",
            url : getRootPath()+"/web/evaluate/updateIsPass",
            data : {
                id:id,
                isPass:isPass
            },
            dataType :"json",
            async : false,
            timeout : 5000,
            success : function(respObj){
                var status = respObj.code;
                if(status==200){
                    Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                    if (isPass == 0) {
                        obj.attr("isPass",1);
                        obj.html("通过");
                        obj.parent().prevAll(".isPassMsg").html("否");
                    } else {
                        obj.attr("isPass",0);
                        obj.html("取消通过");
                        obj.parent().prevAll(".isPassMsg").html("是");
                    }

                }else{
                    Notify(respObj.msg,'top-right','5000','danger','fa-desktop',true);
                    return false;
                }
            }
        });
    });

}

function judgeCategory(categoryId){

    var str = "";
    switch (categoryId){
        case 1:
            str = "凉菜";
            break;
        case 2:
            str = "热菜";
            break;
        case 3:
            str = "海河鲜";
            break;
        case 4:
            str = "素菜";
            break;
        case 5:
            str = "燕鲍翅";
            break;
        case 6:
            str = "小吃";
            break;
        case 7:
            str = "汤";
            break;
        case 8:
            str = "酒水";
            break;
        case 9:
            str = "套餐";
            break;
        case 10:
            str = "坝坝宴";
            break;
        case 11:
            str = "专业服务";
            break;
        case 12:
            str = "伴餐演奏";
            break;
        case 13:
            str = "婚庆预约";
            break;
        case 14:
            str = "实时菜价";
            break;
        default:
            str = "无分类";
            break;
    }
    return str;



}
