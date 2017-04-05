



function initData(pageNO,pageSize){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/userAddress/getUserAddress",
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
            var isMan = obj.gender == 0 ? "先生" : "女士";
                str+="<tr>" +
                "<td>"+obj.contact+"("+isMan+")</td>" +
                "<td>"+obj.contactPhone+"</td>" +
                "<td>"+obj.address+"</td>" +
                "<td>"+obj.detailAddress+"</td>" +
                "<td>"+createTime  +"</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}



