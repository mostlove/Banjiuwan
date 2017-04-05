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
//    $(jsObj).parent().parent().hide("slow");
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

var categorys = null;

/**
 *  点击继续添加按钮
 * @param jsObj
 */
function continueAddCategory(jsObj){
    if(null == categorys){

        $.ajax({
            type : "POST",
            url : getRootPath()+"/web/foodCategory/queryAll",
            data : {
            },
            dataType : "json",
            async : false,
            timeout : 5000,
            success : function(json){
                if(json.code == 200){
                    categorys = json.data;
                }else{
                    Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                }
            }
        })
    }
    var option = "<option value='0'>请选择类型</option>";

    for (var i=0; i < categorys.length; i++){
        option += "<option value='"+categorys[i].id+"'>"+categorys[i].categoryName+"</option>";
    }

    var htmlDiv = '<div class="form-group border-1">'+
        '<div class="inline-form">'+
        '<label class="control-label col-md-2"></label>'+
        '<div>'+
        '<div class="col-md-2">'+
        '<select class="form-control" id="categoryId_food" onchange="changeFoodCategory(this)">'+
        option+
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
// *  菜品选择 事件
// * @param jsObj
// */
//function changeSingleFood(jsObj){
//
//}
//
///**
// * 数量的 失去焦点事件
// * @param jsObj
// */
//function blurNumber(jsObj){
//
//}


