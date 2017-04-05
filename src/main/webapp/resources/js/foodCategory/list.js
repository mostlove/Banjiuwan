



function initData(){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/foodCategory/queryAll",
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
    console.debug(dataList);
    var str = "";
    if(dataList.length == 0){
        str = "<tr><td colspan='5'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var isShow = obj.isShow == 0 ? "不显示" : "显示";
            var isShowBtn = obj.isShow == 0 ?
                "<a href='javascript:void(0)' onclick='setShow("+obj.id+","+obj.isShow+")' class='btn btn-info'>设置显示</a>" :
                "<a href='javascript:void(0)' onclick='setShow("+obj.id+","+obj.isShow+")' class='btn btn-info'>设置不显示</a>" ;
                str+="<tr>" +
                "<td><img src='"+getRootPath()+"/"+obj.selectedIcon+"' style='width: 60px;height: 60px'></td>" +
                "<td><img src='"+getRootPath()+"/"+obj.icon+"' style='width: 60px;height: 60px'></td>" +
                "<td>"+obj.categoryName+"</td>" +
                "<td>"+obj.seriaNumber+"</td>" +
                "<td>"+isShow+"</td>" +
                "<td>" +
                    " <a href='"+getRootPath()+"/web/foodCategory/editPage?id="+obj.id+"' class='btn btn-blue'>编辑</a>" +isShowBtn+
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}

function setShow(id,isShow){

    var showMsg = isShow == 0 ? "确认设置为显示吗？" : "确认设置为不显示吗？";
    var show = isShow == 0 ? 1 : 0;

    var str='<div id="myModal">' +
        '<form  class="form-horizontal" >' +
        '   <div class="form-body">'+
        '       <div class="form-group border-1">'+
        '           <div class="inline-form">'+
        '               <div class="col-md-12">'+
        '               <span class="help-block">'+showMsg+'</span>'+
        '               </div>'+
        '           </div>'+
        '       </div>' +
        '   </div>' +
        '</form>'+
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
                label: "确定",
                className: "btn-primary",
                callback: function () {
                    $.ajax({
                        type:"POST",
                        url:getRootPath()+"/web/foodCategory/updateFoodCategory",
                        data:{
                            id:id,
                            isShow:show
                        },
                        dataType:"json",
                        async:false,
                        timeout:5000,
                        success : function(json){
                            if(json.code == 200){
                                Notify("设置成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                                initData();
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

