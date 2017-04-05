



function initData(pageNO,pageSize,vegetablesName,time){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/vegetablesPrice/getVegetablesPrice",
        data :{
            vegetableName:vegetablesName,
            time:time,
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
        str = "<tr><td colspan='5'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var jsonObj = JSON.stringify(obj);
            var createTime = new Date(obj.time).format("yyyy-MM-dd");
                str+="<tr>" +
                "<td>"+obj.dishName+"</td>" +
                "<td>"+obj.units+"</td>" +
                "<td>"+createTime+"</td>" +
                "<td>"+obj.price+"</td>" +
                "<td>" +
                "   <a href='javascript:void(0)' onclick='editVegetablesPrice("+jsonObj+")' class='btn btn-info '>编辑</a>" +
                    "<a href='javascript:void(0)' onclick='delVegetablesPrice("+obj.id+")' class='btn btn-danger '>删除</a>" +
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}

var dish = null;

function editVegetablesPrice(jsonObj){

    if(null == dish){
        $.ajax({
            type:"POST",
            url:getRootPath()+"/web/vegetablesHouse/getAllVegetablesHouse",
            data:{
            },
            dataType:"json",
            async:false,
            timeout:5000,
            success : function(json){
                if(json.code == 200){
                    dish = json.data;
                }
                else{
                    return false;
                }
            }
        });
    }


    var optionHtml = "";

    if(null== dish || dish.length == 0){
        optionHtml = "<option value='0'>暂无菜品</option>";
    }
    else{
        for (var i=0; i<dish.length; i++){
            var checked = "";
            if(jsonObj.vegetablesId == dish[i].id){
                checked = "selected";
            }
            optionHtml += "<option "+checked+" value='"+dish[i].id+"'>"+dish[i].dishName+"</option>";
        }
    }

    var time = new Date(jsonObj.time).format("yyyy-MM-dd");
    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">选择菜品</label>'+
        '               <div class="col-md-8">'+
        '           <select id="vegetablesId" class="form-control">'+optionHtml+'</select>'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">输入价格</label>'+
        '               <div class="col-md-8">'+
        '           <input type="number" class="form-control" maxlength="50" value="'+jsonObj.price+'" name="price" id="price" placeholder="输入价格">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">选择时间</label>'+
        '               <div class="col-md-8">'+
        '           <input type="date" class="form-control" value="'+time+'"  name="time" id="time">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "新增实时菜价",
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

                    var vegetablesId = $("#vegetablesId").val();
                    var price = $("#price").val();
                    var time = $("#time").val();
                    time = new Date(time.replace(/-/g,'/')).getTime();
                    var id = jsonObj.id;
                    if(0 == vegetablesId){
                        Notify("选择菜品",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    if(0 >= price || !regDouble.test(price)){
                        Notify("输入单价",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    if(0 == time){
                        Notify("时间输入不合法",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    $.ajax({
                        type:"POST",
                        url:getRootPath()+"/web/vegetablesPrice/updateVegetablesPrice",
                        data:{
                            vegetablesId:vegetablesId,
                            price:price,
                            timeLong:time,
                            id:id
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("更新成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                initData(1,15,null,null);
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




function addVegetablesPrice(){


    if(null == dish){
        $.ajax({
            type:"POST",
            url:getRootPath()+"/web/vegetablesHouse/getAllVegetablesHouse",
            data:{
            },
            dataType:"json",
            async:false,
            timeout:5000,
            success : function(json){
                if(json.code == 200){
                    dish = json.data;
                }
                else{
                    return false;
                }
            }
        });
    }


    var optionHtml = "";

    if(null== dish || dish.length == 0){
        optionHtml = "<option value='0'>暂无菜品</option>";
    }
    else{
        for (var i=0; i<dish.length; i++){
            optionHtml += "<option value='"+dish[i].id+"'>"+dish[i].dishName+"</option>";
        }
    }


    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">选择菜品</label>'+
        '               <div class="col-md-8">'+
        '           <select id="vegetablesId" class="form-control">'+optionHtml+'</select>'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">输入价格</label>'+
        '               <div class="col-md-8">'+
        '           <input type="number" class="form-control" maxlength="50" name="price" id="price" placeholder="输入价格">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">选择时间</label>'+
        '               <div class="col-md-8">'+
        '           <input type="date" class="form-control"  name="time" id="time">'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "新增实时菜价",
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

                    var vegetablesId = $("#vegetablesId").val();
                    var price = $("#price").val();
                    var time = $("#time").val();
                    time = new Date(time.replace(/-/g,'/')).getTime();
                    if(0 == vegetablesId){
                        Notify("选择菜品",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    if(0 >= price || !regDouble.test(price)){
                        Notify("输入正确单价",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    if(0 == time){
                        Notify("时间输入不合法",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }
                    $.ajax({
                        type:"POST",
                        url:getRootPath()+"/web/vegetablesPrice/addVegetablesPrice",
                        data:{
                            vegetablesId:vegetablesId,
                            price:price,
                            timeLong:time
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("添加成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                initData(1,15,null,null);
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






function delVegetablesPrice(id){
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
                        url : getRootPath()+"/web/vegetablesPrice/delVegetablesPrice",
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

