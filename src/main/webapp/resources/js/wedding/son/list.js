



function initData(pageNO,pageSize,name){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/weddingSon/queryList",
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
                "<a href='javascript:void(0)' id='"+obj.id+"' price='"+obj.price+"' name='"+obj.name+"' units='"+obj.units+"' class='btn btn-blue' onclick='editWeddingSon(this)'>修改</a>" +
                "<a href='javascript:void(0)' class='btn btn-danger' onclick='delFood("+obj.id+")'>删除</a>" +
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
                        url : getRootPath()+"/web/weddingSon/delWeddingSon",
                        data : {id:id},
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

function addWeddingSon(){
    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">名称</label>'+
        '               <div class="col-md-8">'+
                '           <input type="text" class="form-control" maxlength="50" name="name" id="name" placeholder="请输入名称">'+
                '           <span class="help-block"></span>'+
            '          </div>'+
        '           </div>'+
        '       </div>'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">单价</label>'+
        '               <div class="col-md-8">'+
                '           <input type="text" class="form-control" maxlength="50" name="price" id="price" placeholder="请输入单价,例如:12.00 (单元：元)">'+
                '           <span class="help-block"></span>'+
            '          </div>'+
        '           </div>'+
        '       </div>'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">计量单位</label>'+
        '               <div class="col-md-8">'+
                '           <input type="text" class="form-control" maxlength="50" name="units" id="units" placeholder="请输入计量单位(例如：桌、份)">'+
                '           <span class="help-block"></span>'+
            '          </div>'+
        '           </div>'+
        '       </div>'+
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "新增婚庆子项",
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

                    var name = $("#name").val();
                    var price = $("#price").val();
                    var units = $("#units").val();
                    if($.trim(name).length == 0){
                        Notify("没有填名称",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    if(price < 0){
                        Notify("请填写正确的单价",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    if(!(regDouble.test(price))){
                        Notify("请填写正确的单价",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    if($.trim(units).length == 0){
                        Notify("没有填写计量单位",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }

                    $.ajax({

                        type:"POST",
                        url:getRootPath()+"/web/weddingSon/addWeddingSon",
                        data:{
                            name:name,
                            price:price,
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

function editWeddingSon(obj){
    var id = $(obj).attr("id");
    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">名称</label>'+
        '               <div class="col-md-8">'+
        '           <input type="text" class="form-control" value="'+$(obj).attr("name")+'" maxlength="50" name="name" id="name" placeholder="请输入名称">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">单价</label>'+
        '               <div class="col-md-8">'+
        '           <input type="text" class="form-control" maxlength="50" value="'+$(obj).attr("price")+'" name="price" id="price" placeholder="请输入单价,例如:12.00 (单元：元)">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">计量单位</label>'+
        '               <div class="col-md-8">'+
        '           <input type="text" class="form-control" maxlength="50" value="'+$(obj).attr("units")+'" name="units" id="units" placeholder="请输入计量单位(例如：桌、份)">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>'+
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "修改婚庆子项",
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

                    var name = $("#name").val();
                    var price = $("#price").val();
                    var units = $("#units").val();
                    if($.trim(name).length == 0){
                        Notify("没有填名称",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    var reg = /^\+?(\d*\.\d{2})$/;
                    var reg_num = /^[0-9]*$/;
                    if(!(regDouble.test(price)) ){
                        Notify("请填写正确的单价",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    if($.trim(units).length == 0){
                        Notify("没有填写计量单位",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }

                    $.ajax({

                        type:"POST",
                        url:getRootPath()+"/web/weddingSon/updateWeddingSon",
                        data:{
                            name:name,
                            price:price,
                            units:units,
                            id:id
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("修改成功", 'top-right', '5000', 'info', 'fa-desktop', true);
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