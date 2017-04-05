



function initData(pageNO,pageSize,foodName,categoryId,isPromotion,isRecommendation,recommendationIndex){
    var totalPage = 1;
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/food/getFood",
        data :{
            pageNO:pageNO,
            pageSize:pageSize,
            foodName:foodName,
            categoryIds:categoryId,
            cat:categoryId,
            isPromotion:isPromotion,
            isRecommendation:isRecommendation,
            recommendationIndex:recommendationIndex
        },
        dataType :"json",
        async : false,
        traditional: true,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                buildData(json.data.dataList);
                totalPage =  json.data.totalPage == 0 ? 1 : json.data.totalPage;
                isPromotionBtn();
                $.jqPaginator('#pagination', {
                    totalPages: totalPage,  //总页数
                    visiblePages: 3,  //可见页面
                    currentPage: 1,   //当前页面
                    onPageChange: function (num, type) {
                        $('#showing').text('共'+totalPage+'页  第'+num+'/'+totalPage+'页');
                        if(type != "init"){
                            //获取第num页数据，
                            initData(num,15,foodName,categoryId,isPromotion,isRecommendation,recommendationIndex);
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
        str = "<tr><td colspan='9'>暂无数据!</td></tr>";
    }
    else{
        var len = dataList.length;
        for (var i=0; i<len; i++){
            var obj = dataList[i];
            var createTime = new Date(obj.createTime).format("yyyy-MM-dd hh:mm:ss");
            var secondFoods = JSON.stringify(obj.secondFoods);
            console.debug(obj);
            var promotion = "促销";
            var isPromotion = "否";
            var isPromotionE = "true";
            if (obj.promotion) {
                promotion = "取消促销";
                isPromotion = "是";
                isPromotionE = "false";
            }
            var recommendation = "推荐";
            var isRecommendation = "否";
            var isRecommendationE = "true";
            if (obj.recommendation) {
                recommendation = "取消推荐";
                isRecommendation = "是"
                isRecommendationE = "false";
            }
            str += "<tr>" +
                "<td><img src='"+getRootPath()+"/"+obj.coverImg+"' style='width: 150px;height: 90px'></td>" +
                "<td>"+obj.foodName+"</td>" +
                "<td>"+obj.price+"</td>" +
                "<td>"+obj.promotionPrice+"</td>" +
                "<td>"+obj.recommendationIndex+"</td>" +
                "<td>"+obj.sales+"</td>" +
                "<td>"+obj.foodCategoryName+"</td>" +
                "<td class='isPromotionE'>"+isPromotion+"</td>" +
                "<td class='isRecommendationE'>"+isRecommendation+"</td>" +
                "<td>"+createTime+"</td>" +
                "<td>" +
                "<a href='javascript:void();' onclick='changeFood("+secondFoods+","+obj.id+")' class='btn btn-info'>设置换一换</a>" +
                "<a href='javascript:void();' onclick='saveEvaluateFun("+obj.id+")' n class='btn btn-info'>评论</a>" +
                "<a href='javascript:void();' isPromotion = '"+isPromotionE+"' promotionId = '"+obj.id+"'  class='btn btn-info promotion_btn'>"+promotion+"</a>" +
                "<a href='javascript:void();' isRecommendation = '"+isRecommendationE+"' recommendationId='"+obj.id+"'  class='btn btn-info recommendation_btn'>"+recommendation+"</a>" +
                "<a href='"+bjw.base+"/web/food/editPage?id="+obj.id+"' class='btn btn-blue'>详情/修改</a>" +
                "<a href='javascript:void();' class='btn btn-danger' onclick=' delFood("+obj.id+","+obj.foodCategoryId+")'>删除</a>" +
                "</td>" +
                "</tr>"
        }
    }
    $("#dataDiv").html(str);
}

var foods = null;

function changeFood(secondFoods,id){

    if(null == foods){
        $.ajax({
            type : "POST",
            url : getRootPath()+"/web/food/queryAllSingleFood",
            data : {id:id},
            dataType :"json",
            async : false,
            timeout : 5000,
            success : function(json){
                var status = json.code;
                if(status==200){
                    foods = json.data;
                }else{
                    Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                    return false;
                }
            }
        });
    }
    // 拼 模态窗
    buildWindows(secondFoods,id);
}

//全局变量
var imgAry = new Array();
var num = 0;
//上传相册
$("#addImg").browser({
    callback:function(images) {
        if (typeof (images) != "undefined" && images != null && images != '') {
            var path = bjw.base+"/"+images;
            imgAry[num] = images;
            $("#imgDiv").append('<div style="width: 114px;height: 72px;float: left;position: relative"><span onclick=\"delImg('+num+',this)\" class=\"closeImg\">X</span><img class="padding-right-5 padding-bottom-5 enlarges" src="'+path+'" style="width: 100%;height: 100%;"></div>');
            bigImg();
            num ++;
        }

    }
});
//上传头像
var avatarImg;
$("#addAvatar").browser({
    callback:function(images) {
        if (typeof (images) != "undefined" && images != null && images != '') {
            var path = bjw.base+"/"+images;
            $("#avatarDiv").empty();
            $("#avatarDiv").append('<img src="'+path+'" style="width: 50px;height: 50px;" id="avatarImg" class="img-circle enlarges">');
            avatarImg = images[0];
            bigImg();
        }

    }
});

function bigImg() {
    $(".enlarges").css("cursor", "pointer");
    $(".enlarges").on("click",function (){
        layer.open({
            type: 1,
            title: false,
            closeBtn: 1,
            skin: 'yourclass',
            shadeClose: true,
            shade: 0.5,
            offset:['100px'],
            area:['800px' , '500px'],
            content: "<img height='100%' width='100%' src='" + $(this).attr("src") + "'/>"
        });
    });
}
function saveEvaluateFun(id) {
    var str='<div id="myModal">'+
        '<div class="form-group">' +
        '<div class="input-group margin-top-5">' +
        '<input class="btn btn-blue" type="button" value="上传头像" onclick="$(\'#addAvatar\').click();">' +
        '</div>' +
        '<div id="avatarDiv" class="input-group margin-top-5">' +
        '</div>'+
        '<label class="margin-top-5" >手机号</label>'+
        '<div class="input-group" style="width: 100%">' +
        '<input type="text" class="form-control" style="width: 50%" id="phoneNumber" name="phoneNumber" maxlength="11" />'+
        '</div>'+
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
        '<input class="btn btn-blue" type="button" value="上传图片" onclick="$(\'#addImg\').click();">' +
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

    var imgs = '';



    bootbox.dialog({
        message: str,
        title: "请进行评价",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {
                    imgAry = new Array();
                }
            },
            success: {
                label: "确认",
                className: "btn-danger",
                callback: function () {
                    if (imgAry.length > 0) {
                        for (var i = 0 ; i < imgAry.length ; i ++ ) {
                            if (typeof (imgAry[i]) != "undefined" && imgAry[i] != null && imgAry[i] != '') {
                                imgs += ","+imgAry[i];
                            }
                        }
                    }
                    var phoneNumber = $("#phoneNumber").val();
                    if (typeof (phoneNumber) == "undefined" || phoneNumber == null || phoneNumber == '') {
                        Notify("输入手机号",'top-right','5000','info','fa-desktop',false);
                        return false;
                    }
                    //手机号验证
                   // var regularTel = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
                    var regularTel = /^1[3|4|5|7|8][0-9]\d{8}$/;

                    if (!regularTel.test(phoneNumber)) {
                        Notify("输入正确的手机号",'top-right','5000','info','fa-desktop',false);
                        return false;
                    }


                    var content = $("#content").val();
                    if(typeof (content) == "undefined" || content == null || content == ''){
                        Notify("请输入评价内容",'top-right','5000','info','fa-desktop',false);
                        return false;
                    }

                    var evaluateLevel = $('input:radio[name="evaluateLevel"]:checked').val();
                    var foodScore = $("input:radio[name='foodScore']:checked").val();

                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/evaluate/save",
                        data : {
                            objectId:id,
                            evaluateLevel:evaluateLevel,
                            type:2,
                            foodScore:foodScore,
                            content : content,
                            imgs:imgs,
                            phoneNumber:phoneNumber,
                            avatar:avatarImg
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
                    imgAry = new Array();
                }
            }
        }
    });
}

function delImg(num,obj) {
    $(obj).parent().remove();
    imgAry.remove(num);
}

function buildWindows(secondFoods,foodId){
    console.debug(secondFoods);
    var str_ = "";
    //if(foods.length > 0){
        for (var i=0; i<foods.length; i++){
            var checked = "";
            for (var j=0; j<secondFoods.length; j++){
                if(foods[i].id == secondFoods[j].id){
                    checked = "checked";
                    console.debug(checked);
                    break;
                }
            }
            str_ += '<label> <input '+checked+'  type="checkbox" name="secondFoodIds" value="'+foods[i].id+'"> <span class="text">'+foods[i].foodName+'</span> </label>';
        }
    //}

    var str='<div id="myModal">'+
        '<div class="form-group">'+
        '<label></label>'+
        '<span class="input-icon icon-right">'+
        '<div class="checkbox">'+str_+'</div>'+
        '</span>'+
        '</div>'+
        '</div>';
    bootbox.dialog({
        message: str,
        title: "绑定换一换",
        buttons: {
            "关闭": {
                className: "btn-default",
                callback: function () {
                }
            },
            success: {
                label: "确认绑定",
                className: "btn-danger",
                callback: function () {
                    var array = new Array();
                    $("input[name='secondFoodIds']:checked").each(function(){
                        var val = $(this).val();
                        array.push(val);
                    });

                    if(array.length == 0){
                        Notify("没有选择任何菜品",'top-right','5000','danger','fa-desktop',true);
                        return;
                    }

                    var secondFoodIds = JSON.stringify(array);

                    $.ajax({
                        type : "POST",
                        url : getRootPath()+"/web/food/bindingSecondFood",
                        data : {
                            foodId:foodId,
                            secondFoodIds:secondFoodIds
                        },
                        dataType :"json",
                        async : false,
                        timeout : 5000,
                        success : function(respObj){
                            var status = respObj.code;
                            if(status==200){
                                Notify("绑定成功",'top-right','5000','info','fa-desktop',true);
                                var foodName = $("#foodName").val();
                                var categoryId = $("#foodCategoryId").val();
                                var isPromotion = $("#isPromotion").val();
                                var isRecommendation = $("#isRecommendation").val();
                                var recommendationIndex = $("#recommendationIndex").val();

                                //获取第num页数据，
                                initData(1,15,foodName,categoryId,isPromotion,isRecommendation,recommendationIndex);
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
                        url : getRootPath()+"/web/food/del",
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

function isPromotionBtn(){
    $(".promotion_btn").click(function(){
        var obj = $(this);
        var isPromotion = obj.attr("isPromotion");
        var id = obj.attr("promotionId");
        console.log(isPromotion)
        console.log(id)

        $.ajax({
            type : "POST",
            url : getRootPath()+"/web/food/updateRecommendationOrPromotion",
            data : {id:id,type:1,bol:isPromotion},
            dataType :"json",
            success : function(data) {
                console.log(data)
                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                if (isPromotion == "true" || isPromotion == true) {
                    obj.parent().prevAll(".isPromotionE").html("是");
                    obj.html("取消促销");
                    obj.attr("isPromotion","false")
                } else {
                    obj.parent().prevAll(".isPromotionE").html("否");
                    obj.html("促销");
                    obj.attr("isPromotion","true")
                }
            }
        });
    });
    $(".recommendation_btn").click(function(){
        var obj = $(this);
        var isRecommendation = obj.attr("isRecommendation");
        var id = obj.attr("recommendationId");
        console.log(isRecommendation)
        console.log(id)
        $.ajax({
            type : "POST",
            url : getRootPath()+"/web/food/updateRecommendationOrPromotion",
            data : {id:id,type:2,bol:isRecommendation},
            dataType :"json",
            success : function(data) {
                console.log(data)
                Notify("操作成功",'top-right','5000','info','fa-desktop',true);
                if (isRecommendation == true || isRecommendation == "true") {
                    obj.parent().prevAll(".isRecommendationE").html("是");
                    obj.html("取消推荐");
                    obj.attr("isRecommendation","false")
                } else {
                    obj.parent().prevAll(".isRecommendationE").html("否");
                    obj.html("推荐");
                    obj.attr("isRecommendation","true")
                }
            }
        });
    });
}