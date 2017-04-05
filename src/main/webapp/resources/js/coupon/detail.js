/**
 * Created by Administrator on 2017/3/16 0016.
 */
function initData(type,phoneNumber,startTime,endTime,isValid,pageNO,pageSize){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/coupon/queryCouponUserDetail",
        data :{
            pageNO:pageNO,
            pageSize:pageSize,
            type:type,
            phoneNumber:phoneNumber,
            startTime:startTime,
            endTime:endTime,
            isValid:isValid
        },
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                buildData(json.data.dataList);
                totalPage = json.data.totalPage == 0 ? 1 : json.data.totalPage;
                $.jqPaginator('#pagination', {
                    totalPages: totalPage,  //总页数
                    visiblePages: 3,  //可见页面
                    currentPage: 1,   //当前页面
                    onPageChange: function (num, type) {
                        $('#showing').text('共'+totalpage+'页  第1/'+totalpage+'页');
                        if(type != "init"){
                            //获取第num页数据，
                            initData(type,phoneNumber,startTime,endTime,isValid,num,15);
                        }
                    }
                });
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
        str = "<tr><td colspan='7'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var type = obj.type == 0 ? "优惠券" : "现金券";
            var needSpend =  obj.needSpend == null ? "暂无" : "消费"+obj.needSpend+"才能使用";
            var user = obj.userName +"("+obj.phoneNumber+")";
            var startTime = new Date(obj.startTime * 1000).format("yyyy-MM-dd");
            var endTime = new Date(obj.endTime * 1000).format("yyyy-MM-dd");
            var time = startTime +"到"+ endTime;
            var isValid = obj.isValid == 0 ? "已使用" : "未使用";
            console.debug(obj.startTime);
            str += "<tr>" +
                "<td>"+user+"</td>" +
                "<td>"+obj.faceValue+"</td>" +
                "<td>"+type+"</td>" +
                "<td>"+needSpend+"</td>" +
                "<td>"+time+"</td>" +
                "<td>"+isValid+"</td>" +
                "<td>"+obj.text+"</td>" +
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
        '<div class="form-group">'+
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
                    var titleArray = ["用户名","面值","类型","最低消费使用",
                        "有效时间","是否使用","说明"];
                    var valueArray = ["userName","faceValue","type","needSpend",
                        "startTime","isValid","text"];

                    valueArray = JSON.stringify(valueArray);
                    titleArray = JSON.stringify(titleArray);

                    var phoneNumber = $("#phoneNumber").val();
                    var type = $("#type").val();
                    var isValid = $("#isValid").val();
                    var startTimes = $("#startTime").val();
                    var endTimes = $("#endTime").val();
                    var startTime = null;
                    var endTime = null;
                    if (typeof (startTimes) != "undefined" && startTimes != null && startTimes != "") {
                        startTime = getTime(startTimes);
                    }
                    if (typeof (endTimes) != "undefined" && endTimes != null && endTimes != "") {
                        endTime = getTime(endTimes);
                    }

                    $("#titleArray").val(titleArray);
                    $("#valueArray").val(valueArray);
                    $("#phoneNumberTemp").val(phoneNumber);
                    $("#typeTemp").val(type);
                    $("#isValidTemp").val(isValid);
                    $("#startTimeTemp").val(startTime);
                    $("#endTimeTemp").val(endTime);

                    $("#downLoadForm").submit();




                }
            }
        }
    });


}