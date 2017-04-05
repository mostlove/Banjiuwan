



function initData(pageNO,pageSize){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/package/getData",
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
        str = "<tr><td colspan='10'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var createTime = new Date(obj.createTime).format("yyyy-MM-dd hh:mm:ss");
            str += "<tr>" +
                "<td><img src='"+getRootPath()+"/"+obj.topBanner+"' style='width: 150px;height: 90px'></td>" +
                "<td>"+obj.name+"</td>" +
                "<td>"+obj.price+"</td>" +
                "<td>"+obj.promotionPrice+"</td>" +
                "<td>"+obj.leastNumber+"</td>" +
                "<td>"+obj.recommendationIndex+"</td>" +
                "<td>"+obj.sales+"</td>" +
                "<td>"+judgeCategory(obj.foodCategoryId)+"</td>" +
                "<td>"+createTime+"</td>" +
                "<td>" +
                "<a href='"+bjw.base+"/web/package/editPage?id="+obj.id+"' class='btn btn-info'>详情/修改</a>" +
               /* "<a href='javascript:void();' onclick='saveEvaluateFun("+obj.id+","+obj.foodCategoryId+")' class='btn btn-blue'>评价</a>" +*/
                "<a href='javascript:void(0);' class='btn btn-danger' onclick=' delFood("+obj.id+","+obj.foodCategoryId+")'>删除</a>" +
                "</td>" +
                "</tr>"
        }
    }
    $("#dataDiv").html(str);
}


function saveEvaluateFun(id,foodCategoryId) {
    var str='<div id="myModal">'+
        '<div class="form-group">' +
        '<label class="margin-top-5" >评价等级</label>' +
        '<div class="input-group" style="width: 100%">' +
        '<label class="checkbox-inline"><input name="evaluateLevel" checked type="radio" value="1" /><span class="text">好评</span></label>' +
        '<label class="checkbox-inline"><input name="evaluateLevel" type="radio" value="2" /><span class="text">中评</span></label>' +
        '<label class="checkbox-inline"><input name="evaluateLevel" type="radio" value="3" /><span class="text">差评</span></label>' +
        '</div>' +
        '<label class="margin-top-5" >菜品评分</label>' +
        '<div class="input-group" style="width: 100%">' +
        '<label class="checkbox-inline"><input name="foodScore" checked type="radio" value="5" /><span class="text">5分</span></label>' +
        '<label class="checkbox-inline"><input name="foodScore" type="radio" value="4" /><span class="text">4分</span></label>' +
        '<label class="checkbox-inline"><input name="foodScore" type="radio" value="3" /><span class="text">3分</span></label>' +
        '<label class="checkbox-inline"><input name="foodScore" type="radio" value="2" /><span class="text">2分</span></label>' +
        '<label class="checkbox-inline"><input name="foodScore" type="radio" value="1" /><span class="text">1分</span></label>' +
        '</div>' +
        '<div class="input-group margin-top-5">' +
        '<input class="btn btn-blue" type="button" value="上传图片" onclick="$(\'#addImg\').click();" id="addImg">' +
        '</div>' +
        '<div id="imgDiv" class="input-group margin-top-5">' +
        '</div>'+
        '<label class="margin-top-5" >评价内容</label>'+
        '<div class="input-group" style="width: 100%">'+
        '<textarea id="content" class="form-control textarea" placeholder="请输入评价内容 250字以内" ' +
        ' type="text" maxlength="250" style="width: 100%;resize:none;"  name="content"></textarea>'+
        '</div>'+
        '</div>'+
        '</div>';

    var imgs;
    var num = 0;
    //上传相册
    $("#addImg").browser({
        callback:function(images) {
            if (typeof (images) != "undefined" && images != null && images != '') {
                var path = bjw.base+"/"+images;
                if (num == 0) {
                    imgs = images;
                    num++;
                } else {
                    imgs = imgs+","+images;
                    num++;
                }
                $("#imgDiv").append('<img class="padding-right-5 padding-bottom-5" src="'+path+'" style="width: 110px;height: 70px;">');
            }

        }
    });


    bootbox.dialog({
        message: str,
        title: "请进行评价",
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
                    var type = 3;
                    if (foodCategoryId == 9) {
                        type = 4;
                    }

                    var content = $("#content").val();
                    if(typeof (content) == "undefined" || content == null || content == ''){
                        Notify("请输入评价内容",'top-right','5000','info','fa-desktop',false);
                    }

                    var evaluateLevel = $('input:radio[name="evaluateLevel"]:checked').val();
                    var foodScore = $("input:radio[name='foodScore']:checked").val();

                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/evaluate/save",
                        data : {
                            objectId:id,
                            evaluateLevel:evaluateLevel,
                            type:type,
                            foodScore:foodScore,
                            content : content,
                            imgs:imgs,

                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("评价成功",'top-right','5000','info','fa-desktop',true);
                                //var statuss = $("#status").val();
                                //var orderNumber = $("#orderNumber").val();
                                //var userPhone = $("#userPhone").val();
                                //
                                //var payMethod = $("#payMethod").val();
                                ////获取第num页数据，
                                //initData(1,15,statuss,orderNumber,userPhone,payMethod,1);
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
function delFood(id,foodCategoryId){
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
                        url : getRootPath()+"/web/package/delPackage",
                        data : {id:id,foodCategoryId:foodCategoryId},
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                                initData(1,15);
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

function judgeCategory(categoryId){

    var str = "";
    switch (categoryId){
        case 1:
            str = "凉菜";
            break;
        case 2:
            str = "热菜";
            break;
        case 3:
            str = "海河鲜";
            break;
        case 4:
            str = "素菜";
            break;
        case 5:
            str = "燕鲍翅";
            break;
        case 6:
            str = "小吃";
            break;
        case 7:
            str = "汤";
            break;
        case 8:
            str = "酒水";
            break;
        case 9:
            str = "套餐";
            break;
        case 10:
            str = "坝坝宴";
            break;
        case 11:
            str = "专业服务";
            break;
        case 12:
            str = "伴餐演奏";
            break;
        case 13:
            str = "婚庆预约";
            break;
        case 14:
            str = "实时菜价";
            break;
        default:
            str = "无分类";
            break;
    }
    return str;
}