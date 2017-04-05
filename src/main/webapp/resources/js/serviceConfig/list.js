



function initData(){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/serviceConfig/getServiceConfigList",
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
                "<td>"+obj.price+"</td>" +
                "<td>"+obj.addPrice+"</td>" +
                "<td>" +
                    " <a href='javascript:void(0)' onclick='editServiceConfig("+obj.id+","+obj.price+","+obj.addPrice+")' class='btn btn-blue'>编辑</a>" +
                    " <a href='javascript:void(0)' onclick='delTimeConfig("+obj.id+")' class='btn btn-danger'>删除</a>" +
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}

function editServiceConfig(id,price,addPrice){
    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">订单总价小于</label>'+
        '               <div class="col-md-8">'+
        '           <input type="number" class="form-control" value="'+price+'" name="price" id="price" placeholder="请输入">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">服务费</label>'+
        '               <div class="col-md-8">'+
        '           <input type="number" class="form-control" value="'+addPrice+'" name="addPrice" id="addPrice" placeholder="请输入">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "修改服务费",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {

                }
            },
            success: {
                label: "确定修改",
                className: "btn-primary",
                callback: function () {


                    var addPrice_ = $("#addPrice").val();
                    var price_ = $("#price").val();
                    if(addPrice_ <= 0 || addPrice_.length == 0
                        || price_ <= 0 || price_.length == 0){
                        Notify("数据不合法",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }

                    $.ajax({

                        type:"POST",
                        url:getRootPath()+"/web/serviceConfig/updateServiceConfig",
                        data:{
                            addPrice:addPrice_,
                            price:price_,
                            id:id
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("修改成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                initData();
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


function addServiceConfig(){
    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">订单总价小于</label>'+
        '               <div class="col-md-8">'+
        '           <input type="number" class="form-control"  name="price" id="price" placeholder="请输入">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">服务费</label>'+
        '               <div class="col-md-8">'+
        '           <input type="number" class="form-control"  name="addPrice" id="addPrice" placeholder="请输入">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "新增配置",
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

                    var addPrice = $("#addPrice").val();
                    var price = $("#price").val();
                    if(addPrice <= 0 || addPrice.length == 0
                            || price <= 0 || price.length == 0){
                        Notify("数据不合法",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }

                    $.ajax({

                        type:"POST",
                        url:getRootPath()+"/web/serviceConfig/addServiceConfig",
                        data:{
                            addPrice:addPrice,
                            price:price
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("操作成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                initData();
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

function  delTimeConfig(id){
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
                        url : getRootPath()+"/web/serviceConfig/delServiceConfig",
                        data : {id:id},
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

