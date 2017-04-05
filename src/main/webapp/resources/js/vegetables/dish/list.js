



function initData(pageNO,pageSize,vegetablesName){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/vegetablesHouse/getVegetablesHouse",
        data :{
            vegetableName:vegetablesName,
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
        str = "<tr><td colspan='3'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
                str+="<tr>" +
                "<td>"+obj.dishName+"</td>" +
                "<td>"+obj.units+"</td>" +
                "<td>" +
                "   <a href='javascript:void(0)' onclick='editVegetablesHouse(\""+obj.dishName+"\",\""+obj.units+"\","+obj.id+")' class='btn btn-info '>编辑</a>" +
                    "<a href='javascript:void(0)' onclick='delVegetablesHouse("+obj.id+")' class='btn btn-danger '>删除</a>" +
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}


function editVegetablesHouse(dishName,units,id){

    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">菜品名称</label>'+
        '               <div class="col-md-8">'+
        '           <input type="text" class="form-control" maxlength="100" value="'+dishName+'" name="dishName" id="dishName" placeholder="请输入名称">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">规格</label>'+
        '               <div class="col-md-8">'+
        '           <input type="text" class="form-control" maxlength="50" value="'+units+'" name="units" id="units" placeholder="请输入规格">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "修改菜品",
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

                    var dishName = $("#dishName").val();
                    var units = $("#units").val();
                    if(dishName.length == 0 || units.length == 0){
                        Notify("数据不合法",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }

                    $.ajax({
                        type:"POST",
                        url:getRootPath()+"/web/vegetablesHouse/updateVegetablesHouse",
                        data:{
                            dishName:dishName,
                            units:units,
                            id:id
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("更新成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                initData(1,15,null);
                                return true;
                            }
                            else{
                                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
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
 *  新增菜品
 */
function addVegetablesHouse(){

    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">菜品名称</label>'+
        '               <div class="col-md-8">'+
        '           <input type="text" class="form-control" maxlength="100" name="dishName" id="dishName" placeholder="请输入名称">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">规格</label>'+
        '               <div class="col-md-8">'+
        '           <input type="text" class="form-control" maxlength="50" name="units" id="units" placeholder="请输入规格">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "新增菜品",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {

                }
            },
            success: {
                label: "确定新增",
                className: "btn-primary",
                callback: function () {

                    var dishName = $("#dishName").val();
                    var units = $("#units").val();
                    if(dishName.length == 0 || units.length == 0){
                        Notify("数据不合法",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }

                    $.ajax({
                        type:"POST",
                        url:getRootPath()+"/web/vegetablesHouse/addVegetablesHouse",
                        data:{
                            dishName:dishName,
                            units:units
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("添加成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                initData(1,15,null);
                                return true;
                            }
                            else{
                                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                                return false;
                            }
                        }
                    });
                }
            }



        }
    });

}










function delVegetablesHouse(id){
    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="input-group">'+
        '<span id="name" >此操作可能会影响到实时菜价,确认删除吗？</span>'+
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
                        url : getRootPath()+"/web/vegetablesHouse/delVegetablesHouse",
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
                                initData(1,15,null);
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

