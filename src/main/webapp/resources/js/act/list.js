



function initData(pageNO,pageSize,name){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/act/queryList",
        data :{
            pageNO:pageNO,
            pageSize:pageSize,
            name:name
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
        str = "<tr><td colspan='9'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var createTime = new Date(obj.createTime).format("yyyy-MM-dd hh:mm:ss");
            str += "<tr>" +
                "<td><img src='"+getRootPath()+"/"+obj.topBanner+"' style='width: 150px;height: 90px'></td>" +
                "<td>"+obj.name+"</td>" +
                "<td>"+obj.price+"</td>" +
                "<td>"+obj.sales+"</td>" +
                "<td>"+obj.recommendationIndex+"</td>" +
                "<td>"+obj.remarks+"</td>" +
                "<td>"+judgeCategory(obj.foodCategoryId)+"</td>" +
                "<td>"+createTime+"</td>" +
                "<td>" +
                "<a href='"+bjw.base+"/web/act/editPage?id="+obj.id+"' class='btn btn-info'>详情/修改</a>" +
                "<a href='javascript:void();' class='btn btn-danger' onclick=' delFood("+obj.id+")'>删除</a>" +
                "</td>" +
                "</tr>"
        }
    }
    $("#dataDiv").html(str);
}


function delFood(id){
    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="input-group">'+
        '<span id="name" >此操作不可逆,确认删除吗？</span>'+
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
                        url : getRootPath()+"/web/act/delAct",
                        data : {id:id},
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                                initData(1,15);
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