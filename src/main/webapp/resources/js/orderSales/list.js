



function initData(pageNO,pageSize,managerName,startTime,endTime){
    var totalPage = 1;
    var tstartTime = null;
    if(null != startTime && startTime.length > 0){
        tstartTime=new Date(startTime).getTime();
    }
    var tendTime = null;
    if(null != startTime && endTime.length > 0){
        tendTime=new Date(endTime).getTime();
    }
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/order/getOrdersByAccountManager",
        data :{
            pageNO:pageNO,
            pageSize:pageSize,
            managerName:managerName,
            startTime:tstartTime,
            endTime:tendTime
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
            //var user = obj.userName+"("+obj.phoneNumber+")";  //创建人
            var manager = obj.managerName+"("+obj.managerPhone+")";  //客户经理
            var configJSON = JSON.parse(obj.config);
            var config = configJSON.distribution;
            var balance = config / 100 * obj.price;
                str+="<tr>" +
                "<td>"+obj.orderNumber+"</td>" +
                "<td>"+obj.price+"</td>" +
                //"<td>"+user+"</td>" +
                "<td>"+manager+"</td>" +
                "<td >"+config+"</td>" +
                "<td>"+balance+"</td>" +
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
                    var titleArray = ["订单号","订单总价(元)","创建人","客户经理",
                        "提成比例(%)","提成金额(元)","订单创建时间"];
                    var valueArray = ["orderNumber","price","userName","managerName",
                        "config","balance","createTime"];

                    valueArray = JSON.stringify(valueArray);
                    titleArray = JSON.stringify(titleArray);

                    var managerName = $("#managerName").val();
                    var startTime = $("#startTime").val();
                    var endTime = $("#endTime").val();

                    if(startTime.length > 0){
                        var date = new Date(startTime).getTime();
                        $("#startTimeTemp").val(date);
                    }
                    if(endTime.length > 0){
                        var date = new Date(endTime).getTime();
                        $("#endTimeTemp").val(date);
                    }
                    $("#titleArray").val(titleArray);
                    $("#valueArray").val(valueArray);
                    $("#managerNameTemp").val(managerName);

                    $("#downLoadForm").submit();




                }
            }
        }
    });


}



