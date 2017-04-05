



function initData(pageNO,pageSize,phoneNumber,userName){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/cook/getCooks",
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
        str = "<tr><td colspan='9'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var createTime = new Date(obj.createTime).format("yyyy-MM-dd hh:mm:ss");
            var gender = obj.gender == 0 ? "男" : "女";
            var isValid = obj.isValid == 0 ? "无效" : "有效";
            var btnStr =  obj.isValid == 0 ? "解冻账户" : "冻结账户";
            var timeConfigArr = JSON.stringify(obj.cookTimeConfigs);
            var isOnline = obj.isOnline == 0 ? "不在线" : "在线";
                str+="<tr>" +
                "<td>"+obj.realName+"</td>" +
                "<td>"+obj.phoneNumber+"</td>" +
                "<td>"+obj.email+"</td>" +
                "<td>"+obj.age+"</td>" +
                "<td>"+gender+"</td>" +
                "<td>"+isOnline+"</td>" +
                "<td >"+isValid+"</td>" +
                "<td>"+createTime+"</td>" +
                "<td>" +
                "   <a href='javascript:void(0)' onclick='Scheduling("+obj.id+","+timeConfigArr+")' class='btn btn-info '>设置/查看排班</a>" +
                "   <a href='"+getRootPath()+"/web/cook/editPage?id="+obj.id+"' class='btn btn-info '>详情/编辑</a>" +
                    "<a href='javascript:void(0)' onclick='delCook("+obj.id+","+obj.isValid+")' class='btn btn-danger '>"+btnStr+"</a>" +
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
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
                            flag:2
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

