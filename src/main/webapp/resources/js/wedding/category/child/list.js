

var tempCategoryId = null;
var categoryName = null;
function setValue(category){
    categoryName = category;
}

function initData(pageNO,pageSize,name,categoryId){
    tempCategoryId = categoryId;
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/weddingChildCategory/queryPage",
        data :{
            pageNO:pageNO,
            pageSize:pageSize,
            name:name,
            categoryId:categoryId
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
                "<td><img src='"+getRootPath()+"/"+obj.img+"' style='width: 150px;height: 90px'></td>" +
                "<td>"+obj.name+"</td>" +
                "<td>"+categoryName+"</td>" +
                "<td>"+createTime+"</td>" +
                "<td>" +
                "<a href='"+bjw.base+"/web/wedding/category/child/sonChildlist?weddingSonCategoryId="+obj.id+"'    class='btn btn-info' >查看配置</a>" +
                "<a href='javascript:void(0)' onclick='bindSonChildCategory("+obj.id+")'  class='btn btn-info' >绑定配置</a>" +
                "<a href='"+bjw.base+"/web/wedding/category/child/edit?weddingCategoryId="+tempCategoryId+"&img="+obj.img+"&categoryName="+categoryName+"&id="+obj.id+"&name="+obj.name+"'   class='btn btn-blue' >修改</a>" +
                "<a href='javascript:void(0)' class='btn btn-danger' onclick='delChildCategory("+obj.id+")'>删除</a>" +
                "</td>" +
                "</tr>"
        }
    }
    $("#dataDiv").html(str);
}


function delChildCategory(id){
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
                        url : getRootPath()+"/web/weddingChildCategory/del",
                        data : {id:id},
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                                initData(1,15,null,tempCategoryId);
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


function addChildCategory(){
    var categoryName = $("#categoryName").val();
    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">名称</label>'+
        '               <div class="col-md-8">'+
                '           <input type="text" class="form-control" maxlength="50" name="categoryName" id="categoryName" placeholder="请输入名称">'+
                '           <span class="help-block"></span>'+
            '          </div>'+
        '           </div>'+
        '       </div>' +
                '<div class="form-group border-1">'+
                    '<div class="inline-form">'+
                        '<label class="control-label col-md-2">图片</label>'+
                        '<div class="col-md-3">'+
                            '<img src=""  id="imgSrc" style="width: 230px;height: 150px;display: none">'+
                            '<input class="btn btn-blue" type="button" value="上传图片" id="uploadChildImg" >'+
                            '<input type="hidden" name="childImg" id="childImg">'+
                            '<div>'+
                                '<input class="btn btn-danger" style="display:none;margin-top: 5px" type="button" value="移除" id="removedChildImg">'+
                            '</div>'+
                            '<span class="help-block"></span>'+
                        '</div>'+
                    '</div>'+
                '</div>'+
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "向 <span style='color: red'>"+categoryName+"</span>分类 新增子分类",
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



                    $.ajax({

                        type:"POST",
                        url:getRootPath()+"/web/weddingCategory/add",
                        data:{
                            categoryName:categoryName
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("添加成功", 'top-right', '5000', 'info', 'fa-desktop', true);
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


/**
 * 绑定子项
 */
var allSon = null;
function bindSonChildCategory(childCategoryId){

    if(null == allSon){
        $.ajax({
            type:"POST",
            url:getRootPath()+"/web/weddingSon/queryAllWeddingSon",
            data:{},
            dataType:"json",
            async:false,
            timeout:5000,
            success : function(json){
                if(json.code == 200){
                    allSon = json.data;
                }
                else{
                    Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                    return;
                }
            }
        });
    }

    var optionHtml = "";
    if(allSon.length == 0){
        optionHtml = "<option value='0'>暂无数据</option>"
    }else{
        for (var i=0 ; i<allSon.length; i++){
            optionHtml += "<option value='"+allSon[i].id+"'>"+allSon[i].name+"("+allSon[i].price+"元/"+allSon[i].units+")</option>"
        }
    }


    buildHtmlDiv(optionHtml,childCategoryId);
}

function buildHtmlDiv(optionHtml,childCategoryId){

    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-4">选择绑定的配置</label>'+
        '               <div class="col-md-8">'+
        '           <select id="weddingSonId">'+optionHtml+'</select>'+
        '           <span class="help-block"></span>'+
        '          </div>'+
        '           </div>'+
        '       </div>' +
        '   </div>' +
        '</form>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "绑定配置",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {

                }
            },
            success: {
                label: "确定绑定",
                className: "btn-primary",
                callback: function () {

                    var weddingSonId = $("#weddingSonId").val();
                    if(weddingSonId == 0){
                        Notify("绑定失败", 'top-right', '5000', 'info', 'fa-desktop', true);
                        return;
                    }

                    $.ajax({
                        type:"POST",
                        url:getRootPath()+"/web/weddingSonChild/bind",
                        data:{
                            weddingSonId:weddingSonId,
                            childCategoryId:childCategoryId
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("绑定成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                
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












function editWeddingCategory(obj){
    var id = $(obj).attr("id");
    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <label class="control-label col-md-2">名称</label>'+
        '               <div class="col-md-8">'+
        '           <input type="text" class="form-control" value="'+$(obj).attr("categoryName")+'" maxlength="50" name="categoryName" id="categoryName" placeholder="请输入名称">'+
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

                    var categoryName = $("#categoryName").val();
                    if($.trim(categoryName).length == 0){
                        Notify("没有填名称",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }

                    $.ajax({

                        type:"POST",
                        url:getRootPath()+"/web/weddingCategory/update",
                        data:{
                            categoryName:categoryName,
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