



function initData(pageNO,pageSize){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/mapList/queryMapList",
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
    //console.debug(dataList);
    var str = "";
    if(dataList.length == 0){
        str = "<tr><td colspan='2'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){

            var obj = dataList[i];
                str+="<tr>" +
                "<td>"+obj.reMarket+"</td>" +
                "<td>" +
                    " <a href='"+bjw.base+"/web/mapList/editPage?id="+obj.id+"'  class='btn btn-blue'>查看/编辑</a>" +
                    " <a href='javascript:void(0)' onclick='delMapList("+obj.id+")'  class='btn btn-danger'>删除</a>" +
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}

function delMapList(id){
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
                        url : getRootPath()+"/web/mapList/delMapList",
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
function setInside(){
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/foodCategory/queryAllBigCategory",
        data : {},
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(respObj){
            var status = respObj.code;
            if(status==200){
                buildChecked(respObj.data)
            }else{
                Notify(respObj.msg,'top-right','5000','danger','fa-desktop',true);
                return false;
            }
        }
    });
}

function buildChecked(data){

    var str_ = "";
    for (var i=0; i<data.length; i++){
        var checked = "";
        if(data[i].isInside == 1){
            checked = "checked";
        }
        str_ += '<label> <input '+checked+' type="checkbox" name="bigCategoryIds" value="'+data[i].id+'"> <span class="text">'+data[i].categoryName+'</span> </label>';
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
        title: "选择圈内可点菜品",
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
                    $("input[name='bigCategoryIds']:checked").each(function(){
                        var val = $(this).val();
                        array.push(val);
                    });
                    var bigCategoryIds = JSON.stringify(array);

                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/foodCategory/updateBigCategory",
                        data : {
                            bigCategoryIds:bigCategoryIds
                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
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

