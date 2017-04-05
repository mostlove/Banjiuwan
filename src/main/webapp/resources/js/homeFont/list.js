



function initData(){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/homeFont/queryAll",
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
        str = "<tr><td colspan='2'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){

            var obj = dataList[i];
            var fontStr = obj.font;
                str+="<tr>" +
                "<td>"+fontStr+"</td>" +
                "<td>" +
                    " <a href='javascript:void(0)' onclick='editFont("+obj.id+",\""+fontStr+"\")' class='btn btn-blue'>编辑</a>" +
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}

function editFont(id,font){
    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="input-group">'+
        '<input class="form-control" type="text" maxlength="100" value="'+font+'" id="fontVal">'+
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
                label: "确认修改",
                className: "btn-danger",
                callback: function () {
                    var font = $("#fontVal").val();
                    if($.trim(font).length == 0){
                        Notify("没有填写数据",'top-right','5000','danger','fa-desktop',true);
                        return false;
                    }
                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/homeFont/update",
                        data : {
                            id:id,
                            font:font
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

