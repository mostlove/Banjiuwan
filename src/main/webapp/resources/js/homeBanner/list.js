



function initData(){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/homeBanner/getBanners",
        data :{
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
            var wz = "";
            if(obj.type == 0){
                wz = "首页轮播图";
            }
            else if(obj.type == 1){
                wz = "首页弹出图";
            }
            else if (obj.type == 2){
                wz = "发现板块";
            }
            else if (obj.type == 3){
                wz = "实时菜价";
            }
                str+="<tr>" +
                "<td><img src='"+getRootPath()+"/"+obj.banner+"' style='width: 300px;height: 166px'></td>" +
                "<td>"+wz+"</td>" +
                "<td>"+obj.title+"</td>" +
                "<td>"+createTime+"</td>" +
                "<td>" +
                "   <a href='"+getRootPath()+"/web/homeBanner/edit?id="+obj.id+"' class='btn btn-info'>详情/编辑</a>" +
                    " <a href='javascript:void(0)' onclick='delBanner("+obj.id+")' class='btn btn-danger'>删除</a>" +
                "</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}

function delBanner(id){

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
                        url : getRootPath()+"/web/homeBanner/delBanner",
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