/**
 *  点击添加图片按钮触发的事件
 * @param obj
 */
//var imgMap = new Map();  // banner集合对象
////上传Banner
//$("#addBanner").browser({
//    callback:function(images) {
//        var path = bjw.base+"/"+images;
//        var mapLength = imgMap.size();
//        console.debug(mapLength);
//        // 以当时长度为键，路径为值
//        imgMap.put(mapLength,images);
//        // 增加标签
//        var imgStr = '<div>' +
//            '               <img src="'+path+'"  style="width: 230px;height: 150px;">'+
//    '                       <input class="btn btn-danger" style="position: relative;top:59px" type="button" value="移除" onclick="removedDiv(this,'+mapLength+')">'+
//            '         </div>';
//        // 在添加按钮前 插入 标签
//        var addObj = $("#addBanner");
//        addObj.before(imgStr);
//        // 判断只能添加 5张图
//
//        if(imgMap.size() >= 5){
//            $("#addBanner").hide();
//        }
//    }
//});
//
//
//function removedDiv(jsObj,key){
//    $(jsObj).parent().hide("slow");
//    imgMap.remove(key);
//    if(imgMap.size() < 5 ){
//        $("#addBanner").show();
//    }
//
//
//}



/**
 *  菜品类型的 Change 事件
 */
function changeFoodCategory(jsObj){
    var category= $(jsObj).val();
    if(category == 0){
        var selectObj = $(jsObj).parent().next().find("select")[0];
        $(selectObj).html("<option value='0'>请选择上一级</option>");
        return;
    }
    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/food/queryByCategory",
        data : {
            category:category
        },
        dataType : "json",
        async : false,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                buildOption(json.data,jsObj);
            }else{
                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
            }
        }
    })
}

function  buildOption(dataArray,jsObj){
    var str = "";
    if(dataArray.length == 0){
        str = "<option value='0'>没有数据</option>";
    }else{
        for (var i=0; i < dataArray.length; i++){
            var obj = dataArray[i];
            str += "<option value='"+obj.id+"'>"+obj.foodName+"("+obj.price+"元/"+obj.units+")</option>";
        }
    }
    var selectObj = $(jsObj).parent().next().find("select")[0];
    $(selectObj).html(str);
}

/**
 *  点击继续添加按钮
 * @param jsObj
 */
function continueAddCategory(jsObj){
    var htmlDiv = '<div class="form-group border-1">'+
        '<div class="inline-form">'+
        '<label class="control-label col-md-2"></label>'+
        '<div>'+
        '<div class="col-md-2">'+
        '<select class="form-control" id="categoryId_food" onchange="changeFoodCategory(this)">' +
        '<option value="0">请选择类型</option>'+
        '<option value="1">凉菜</option>'+
        '<option value="2">热菜</option>'+
        '<option value="3">海河鲜</option>'+
        '<option value="4">素菜</option>'+
        '<option value="5">燕鲍翅</option>'+
        '<option value="6">小吃</option>'+
        '<option value="7">汤</option>'+
        '<option value="8">酒水</option>'+
        '</select>'+
        '<span class="help-block"></span>'+
        '</div>'+
        '<div class="col-md-2">'+
        '<select class="form-control" id="singleFood" name="singleFoodId">'+
        '<option value="0">请选择上一级</option>'+
        '</select>'+
        '<span class="help-block"></span>'+
        '</div>'+
        '<div class="col-md-2">'+
        '<input class="form-control" type="number" name="singleFoodNumber"  placeholder="数量(默认为1)">'+
        '<span class="help-block"></span>'+
        '</div>'+
        '<div class="col-md-2">'+
        '<input type="button" class="btn btn-palegreen" onclick="continueAddCategory(this)" value="继续添加">'+
        '<input type="button" class="btn btn-danger" onclick="removeDiv_(this)" value="移除">'+
        '<span class="help-block"></span>'+
        '</div>'+
        '</div>'+
        '</div>'+
        '</div>';
    var preDiv = $(jsObj).parent().parent().parent().parent();
    $(preDiv).after(htmlDiv);
}

/**
 *  移除当前DIV
 * @param jsObj
 */
function  removeDiv_(jsObj){
    var ids = $("select[name='singleFoodId']");
    if(ids.length == 1){
        Notify("至少保留一个菜品",'top-right','5000','danger','fa-desktop',true);
        return;
    }
    var preDiv = $(jsObj).parent().parent().parent().parent();
    $(preDiv).remove();
}


///**
// * 提交更新
// */
//function updateWedding(){
//
//    var name = $("#name").val(); // 名称
//    var coverImg = $("#coverImg").val();
//    var price = $("#price").val();
//    var recommendationIndex = $("#recommendationIndex").val();
//    var sales = $("#sales").val();
//    var id = $("#id").val();
//    var packageDescription = $("#packageDescription").val(); // 描述
//    var keys = imgMap.keySet(); // 多张Banner图
//
//    var childCategoryIds = new Array();  // 子分类集合
//    $("select[name='childCategory']").each(
//        function(){
//            childCategoryIds.push($(this).val());
//        }
//    );
//
//
//    childCategoryIds = JSON.stringify(childCategoryIds);
//    if($.trim(name).length <= 0){
//        Notify("没有填写名称",'top-right','5000','danger','fa-desktop',true);
//        return false;
//    }
//    if($.trim(coverImg).length <= 0){
//        Notify("没有上传图片",'top-right','5000','danger','fa-desktop',true);
//        return false;
//    }
//
//    if(price <= 0 ){
//        Notify("没有填写价格",'top-right','5000','danger','fa-desktop',true);
//        return false;
//    }
//    if(recommendationIndex > 5){
//        Notify("推荐指数最高为 5",'top-right','5000','danger','fa-desktop',true);
//        return false;
//    }
//
//    if($.trim(packageDescription).length <= 0){
//        Notify("没有填写简介",'top-right','5000','danger','fa-desktop',true);
//        return false;
//    }
//    if(keys.length <= 0 ){
//        Notify("至少上传一张Banner",'top-right','5000','danger','fa-desktop',true);
//        return false;
//    }
//    if(childCategoryIds.length <= 0 ){
//        Notify("至少选择一个子分类",'top-right','5000','danger','fa-desktop',true);
//        return false;
//    }
//    if(sales < 0 ){
//        Notify("销量不能小于0",'top-right','5000','danger','fa-desktop',true);
//        return false;
//    }
//    var imgArr = "";
//    for (var i=0; i<keys.length; i++){
//        imgArr += imgMap.get(keys[i])+",";
//    }
//
//    $.ajax({
//        type : "POST",
//        url : getRootPath()+"/web/wedding/updateWedding",
//        data :{
//            name:name,
//            coverImg:coverImg,
//            price:price,
//            recommendationIndex:recommendationIndex,
//            sales:sales,
//            banners:imgArr,
//            childCategorys:childCategoryIds,
//            packageDescription:packageDescription,
//            id:id
//        },
//        dataType :"json",
//        async : false,
//        timeout : 5000,
//        success : function(json){
//            if(json.code == 200){
//                Notify("更新成功", 'top-right', '5000', 'info', 'fa-desktop', true);
//                return true;
//            }
//            else{
//                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
//                return false;
//            }
//        }
//    })
//
//}
