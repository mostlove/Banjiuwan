



function initData(pageNO,pageSize,phoneNumber,startTime,endTime){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/accumulateDetail/getAccumulateDetail",
        data :{
            pageNO:pageNO,
            pageSize:pageSize,
            phoneNumber:phoneNumber,
            startTime:startTime,
            endTime:endTime
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
        str = "<tr><td colspan='6'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var createTime = new Date(obj.createTime).format("yyyy-MM-dd hh:mm:ss");
            var type = obj.type == 1 ? "新增" : "减去";
                str+="<tr>" +
                "<td>"+obj.userName+"</td>" +
                "<td>"+obj.phoneNumber+"</td>" +
                "<td>"+type+"</td>" +
                "<td>"+obj.accumulate+"</td>" +
                "<td >"+obj.reason+"</td>" +
                "<td>"+createTime+"</td>" +
                "</tr>";
        }
    }
    $("#dataDiv").html(str);
}




/**
 *  导出Excel表格
 */
function exportExcel(){

    var str='<div id="myModal">'+
        '<div class="form-group">'  +
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="checkbox">是否导出？</div>'+
        '</span>'+
        '</div>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "导出提示",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {
                }
            },
            success: {
                label: "确认导出",
                className: "btn-danger",
                callback: function () {
                    var titleArray = ["用户名","手机号","类型","变动积分",
                        "消息来源","创建时间"];
                    var valueArray = ["userName","phoneNumber","type","accumulate",
                        "reason","createTime"];

                    valueArray = JSON.stringify(valueArray);
                    titleArray = JSON.stringify(titleArray);

                    var phoneNumber = $("#phoneNumber").val();
                    var startTime = $("#startTime").val();
                    var endTime = $("#endTime").val();
                    if(startTime.length != 0 ){
                        startTime = new Date(startTime).getTime();
                    }
                    if(endTime.length != 0 ){
                        endTime = new Date(endTime).getTime();
                    }

                    $("#titleArray").val(titleArray);
                    $("#valueArray").val(valueArray);
                    $("#phoneNumberTemp").val(phoneNumber);
                    $("#endTimeTemp").val(endTime);
                    $("#startTimerTemp").val(startTime);

                    $("#downLoadForm").submit();




                }
            }
        }
    });


}


