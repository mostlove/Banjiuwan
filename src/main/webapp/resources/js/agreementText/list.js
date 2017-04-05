



function initData(){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/agreementText/getAgreementTextList",
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
        str = "<tr><td colspan='2'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
                str+="<tr>" +
                "<td>"+obj.title+"</td>" +
                "<td><a href='"+getRootPath()+"/web/agreementText/editPage?id="+obj.id+"' class='btn btn-info'>查看/编辑</a></td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}





