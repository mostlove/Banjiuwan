



function initData(pageNO,pageSize,phoneNumber,userName){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/user/getAdminUser",
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
        str = "<tr><td colspan='6'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var createTime = new Date(obj.createTime).format("yyyy-MM-dd hh:mm:ss");
            var isValid = obj.isValid == 0 ? "无效" : "有效";
            var btnStr =  obj.isValid == 0 ? "解冻账户" : "冻结账户";
            var qrCodeBtn = "";
            if(obj.roleId == 4){
                qrCodeBtn = "<a href='"+getRootPath()+"/web/user/buildQrCode?code="+obj.code+"' class='btn mui-btn-green'>生成二维码并下载</a>";
            }
                str+="<tr>" +
                "<td>"+obj.userName+"</td>" +
                "<td>"+obj.phoneNumber+"</td>" +
                "<td>"+roleName(obj.roleId)+"</td>" +
                "<td >"+isValid+"</td>" +
                "<td>"+createTime+"</td>" +
                "<td>" +
                "   <a href='"+getRootPath()+"/web/adminUser/editPage?id="+obj.id+"' class='btn btn-info '>详情/编辑</a>" +
                    "<a href='javascript:void(0)' onclick='delCook("+obj.id+","+obj.isValid+")' class='btn btn-danger '>"+btnStr+"</a>" +
                    ""+qrCodeBtn+"" +
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}




function roleName(roleId){
    var name = "";
    switch (roleId){
        case 1:
            name = "平台管理员";
            break;
        case 2:
            name = "财务";
            break;
        case 3:
            name = "客服";
            break;
        case 4:
            name = "客户经理";
            break;
        case 5:
            name = "调度员";
            break;
        default:
            name = "数据异常";
            break;
    }
    return name;
}



var timeConfig = null;



function delCook(id,isValid){
    var msg = isValid == 0 ? "确认解冻吗？" : "确认冻结吗？";
    var value = isValid == 0 ? 1 : 0;
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
                        url : getRootPath()+"/web/user/updateIsValid",
                        data : {
                            id:id,
                            isValid:value,
                            flag:1
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

