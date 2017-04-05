



function initData(){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/timeConfig/queryAllTimeConfig",
        data :{
        },
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                buildData(json.data);
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
        str = "<tr><td colspan='3'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){

            var obj = dataList[i];
                str+="<tr>" +
                "<td>"+obj.time+"</td>" +
                "<td>"+obj.price+"</td>" +
                "<td>" +
                    " <a href='javascript:void(0)' onclick='editTimeConfig("+obj.id+","+obj.price+")' class='btn btn-blue'>编辑溢价</a>" +
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}

function editTimeConfig(id,price){
    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="input-group">'+
        '<input class="form-control" type="text" maxlength="100" value="'+price+'" id="fontVal">'+
        '</div>'+
        '</span>'+
        '</div>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "输入溢价",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {
                }
            },
            success: {
                label: "确认修改",
                className: "btn-danger",
                callback: function () {
                    var priced = $("#fontVal").val();
                    if(priced == price){
                        return true;
                    }
                    if(!regDouble.test(priced)){
                        Notify("价格输入错误",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/timeConfig/updateTimeConfig",
                        data : {
                            price:priced,
                            id:id
                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                                initData();
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

