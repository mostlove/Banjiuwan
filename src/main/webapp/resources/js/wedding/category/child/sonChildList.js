



function initData(pageNO,pageSize,childCategoryId){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/weddingSonChild/queryPage",
        data :{
            pageNO:pageNO,
            pageSize:pageSize,
            childCategoryId:childCategoryId
        },
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                buildData(json.data.dataList,childCategoryId);
                totalPage =  json.data.totalPage == 0 ? 1 : json.data.totalPage;
            }
            else{
                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
            }
        }
    });
    return totalPage;
}

function buildData(dataList,childCategoryId){
    var str = "";
    if(dataList.length == 0){
        str = "<tr><td colspan='5'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var createTime = new Date(obj.createTime).format("yyyy-MM-dd hh:mm:ss");
            str += "<tr>" +
                "<td>"+obj.name+"</td>" +
                "<td>"+obj.units+"</td>" +
                "<td>"+obj.price+"</td>" +
                "<td>"+createTime+"</td>" +
                "<td>" +
                "<a href='javascript:void(0)' class='btn btn-danger' onclick='delFood("+obj.id+","+childCategoryId+")'>删除</a>" +
                "</td>" +
                "</tr>"
        }
    }
    $("#dataDiv").html(str);
}


function delFood(id,childCategoryId){
    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="input-group">'+
        '<span id="name" >删除后可能会影响到其他数据并且不可逆,确认删除吗？</span>'+
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
                        url : getRootPath()+"/web/weddingSonChild/del",
                        data : {id:id},
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                                initData(1,15,childCategoryId);
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

