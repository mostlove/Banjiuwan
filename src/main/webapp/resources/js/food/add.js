/**
 *  点击添加图片按钮触发的事件
 * @param obj
 */
var imgMap = new Map();  // banner集合对象
//上传Banner
$("#addBanner").browser({
    callback:function(images) {
        var path = bjw.base+"/"+images;
        var mapLength = imgMap.size();
        console.debug(mapLength);
        // 以当时长度为键，路径为值
        imgMap.put(mapLength,images);
        // 增加标签
        var imgStr = '<div>' +
            '               <img src="'+path+'"  style="width: 230px;height: 150px;">'+
    '                       <input class="btn btn-danger" style="position: relative;top:59px" type="button" value="移除" onclick="removeDiv(this,'+mapLength+')">'+
            '         </div>';
        // 在添加按钮前 插入 标签
        var addObj = $("#addBanner");
        addObj.before(imgStr);
        // 判断只能添加 5张图

        if(imgMap.size() >= 5){
            $("#addBanner").hide();
        }
    }
});


function removeDiv(jsObj,key){
    //$(jsObj).parent().parent().hide("slow");
    $(jsObj).parent().hide("slow");
    imgMap.remove(key);
    if(imgMap.size() < 5 ){
        $("#addBanner").show();
    }


}

$("#price").keyup(function(){
    $("#promotionPrice").val($(this).val());
})

// 提交新增菜品
function  addFood(){

    var categoryId = $("#categoryId").val();
    var foodName = $("#foodName").val();
    var units = $("#units").val(); // 计量单位
    var coverImg = $("#coverImg").val();
    var price = $("#price").val();
    var promotionPrice = $("#promotionPrice").val();
    var recommendationIndex = $("#recommendationIndex").val();
    var sales = $("#sales").val();
    var marinade = $("#marinade").val(); // 主料
    var accessories = $("#accessories").val(); // 辅料
    var introduction = $("#introduction").val(); // 简介
    var keys = imgMap.keySet(); // 多张Banner图


    if(0 == categoryId){
        Notify("没有选择菜品类型",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if($.trim(foodName).length <= 0){
        Notify("没有填写菜品名称",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if($.trim(coverImg).length <= 0){
        Notify("没有上传封面图",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if($.trim(units).length <= 0){
        Notify("没有填写计量单位",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if(price == 0 || promotionPrice == 0 ||!regDouble.test(price) || !regDouble.test(promotionPrice)){
        Notify("没有填写价格",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if(recommendationIndex > 5 || recommendationIndex <= 0){
        Notify("推荐指数为 1-5",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if($.trim(marinade).length <= 0){
        Notify("没有填写主料",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if($.trim(accessories).length <= 0){
        Notify("没有填写辅料",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if($.trim(introduction).length <= 0){
        Notify("没有填写简介",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if(keys.length <= 0 ){
        Notify("至少上传一张Banner",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if(sales < 0 ){
        Notify("销量不能小于0",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    var imgArr = "";
    for (var i=0; i<keys.length; i++){
        imgArr += imgMap.get(keys[i])+",";
    }

    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/food/addFood",
        data :{
            foodCategoryId:categoryId,
            foodName:foodName,
            coverImg:coverImg,
            price:price,
            promotionPrice:promotionPrice,
            recommendationIndex:recommendationIndex,
            sales:sales,
            marinade:marinade,
            accessories:accessories,
            introduction:introduction,
            banners:imgArr,
            units:units
        },
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                Notify("添加成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                return true;
            }
            else{
                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                return false;
            }
        }
    })
}


