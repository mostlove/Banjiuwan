



function initData(pageNO,pageSize){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/transportationCost/queryConfig",
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
    var str = "";
    if(dataList.length == 0){
        str = "<tr><td colspan='3'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){

            var obj = dataList[i];
                str+="<tr>" +
                "<td>"+obj.distance+"</td>" +
                "<td>"+obj.price+"</td>" +
                "<td>" +
                    " <a href='javascript:void(0)' onclick='editConfig("+obj.id+","+obj.distance+","+obj.price+")' class='btn btn-blue'>编辑</a>" +
                    " <a href='javascript:void(0)' onclick='delConfig("+obj.id+")' class='btn btn-danger'>删除</a>" +
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}

function delConfig(id){
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
                        url : getRootPath()+"/web/transportationCost/delConfig",
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
                            }
                        }
                    });

                }
            }
        }
    });
}

function editConfig(id,distance,price){
    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-4">距离(单位：千米)</label>'+
        '               <div class="col-md-8">'+
        '           <input type="number" id="distance" value="'+distance+'" class="form-control">'+
        '           <span class="help-block"></span>'+
        '               </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-4">价格(单位：元)</label>'+
        '               <div class="col-md-8">'+
        '           <input type="number" value="'+price+'" id="price" class="form-control">'+
        '           <span class="help-block"></span>'+
        '               </div>'+
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
                label: "确定添加",
                className: "btn-primary",
                callback: function () {

                    var distance = $("#distance").val();
                    var price = $("#price").val();
                    if(distance <= 0 || 0 >= price || !regDouble.test(price)){
                        Notify("数据不合法", 'top-right', '5000', 'danger', 'fa-desktop', true);
                        return;
                    }
                    $.ajax({
                        type:"POST",
                        url:getRootPath()+"/web/transportationCost/updateConfig",
                        data:{
                            distance:distance,
                            price:price,
                            id:id
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("修改成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                initData(1,15);
                            }
                            else{
                                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                            }
                        }
                    });
                }
            }
        }
    });
}


function addConfig(){
    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-4">距离(单位：千米)</label>'+
        '               <div class="col-md-8">'+
                '           <input type="number" id="distance" class="form-control">'+
                '           <span class="help-block"></span>'+
        '               </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-4">价格(单位：元)</label>'+
        '               <div class="col-md-8">'+
                '           <input type="number" id="price" class="form-control">'+
                '           <span class="help-block"></span>'+
        '               </div>'+
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
                label: "确定添加",
                className: "btn-primary",
                callback: function () {

                    var distance = $("#distance").val();
                    var price = $("#price").val();
                    if(distance <= 0 || 0 >= price  || !regDouble.test(price)){
                        Notify("数据不合法", 'top-right', '5000', 'danger', 'fa-desktop', true);
                        return;
                    }
                    $.ajax({
                        type:"POST",
                        url:getRootPath()+"/web/transportationCost/add",
                        data:{
                            distance:distance,
                            price:price
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("添加成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                initData(1,15);
                            }
                            else{
                                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                            }
                        }
                    });
                }
            }
        }
    });
}

