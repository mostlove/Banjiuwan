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
        // 以当时长度为键，路径为值
        imgMap.put(mapLength,images);
        // 增加标签
        var imgStr = '<div>' +
            '               <img src="'+path+'"  style="width: 230px;height: 150px;">'+
    '                       <input class="btn btn-danger" style="position: relative;top:59px" type="button" value="移除" onclick="removedDiv(this,'+mapLength+')">'+
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


function removedDiv(jsObj,key){
    $(jsObj).parent().hide("slow");
    imgMap.remove(key);
    if(imgMap.size() < 5 ){
        $("#addBanner").show();
    }


}

// 提交新增
function  addWedding(){

    var back = false;
    var name = $("#name").val(); // 名称
    var coverImg = $("#coverImg").val();
    var price = $("#price").val();
    var recommendationIndex = $("#recommendationIndex").val();
    var sales = $("#sales").val();
    var packageDescription = $("#packageDescription").val(); // 描述
    var keys = imgMap.keySet(); // 多张Banner图

    var childCategoryIds = new Array();  // 子分类集合
    $("select[name='childCategory']").each(
        function(){
            childCategoryIds.push($(this).val());
        }
    );
    var weddingCategoryArr = new Array(); // 大分类集合
    $("select[name='weddingCategory']").each(
        function(){
            weddingCategoryArr.push($(this).val());
        }
    );

    if(weddingCategoryArr.length == 1 && weddingCategoryArr[0] == 0){
        Notify("至少有一个正确的配置项",'top-right','5000','danger','fa-desktop',true);
        return false;
    }

    var sortArr = weddingCategoryArr.sort();

    for (var i=0; i<sortArr.length; i++){
        if(sortArr[i+1] == sortArr.length){
            break;
        }
        if(sortArr[i] == sortArr[i+1]){
            Notify("配置项类型不能重复",'top-right','5000','danger','fa-desktop',true);
            return false;
        }
    }

    childCategoryIds = JSON.stringify(childCategoryIds);
    if($.trim(name).length <= 0){
        Notify("没有填写名称",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if($.trim(coverImg).length <= 0){
        Notify("没有上传图片",'top-right','5000','danger','fa-desktop',true);
        return false;
    }

    if(price <= 0 || !regDouble.test(price) ){
        Notify("没有填写价格",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if(recommendationIndex > 5 || recommendationIndex <= 0){
        Notify("推荐指数最高为 5",'top-right','5000','danger','fa-desktop',true);
        return false;
    }

    if($.trim(packageDescription).length <= 0){
        Notify("没有填写简介",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if(keys.length <= 0 ){
        Notify("至少上传一张Banner",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if(childCategoryIds.length <= 0 ){
        Notify("至少选择一个子分类",'top-right','5000','danger','fa-desktop',true);
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
        url : getRootPath()+"/web/wedding/addWedding",
        data :{
            name:name,
            coverImg:coverImg,
            price:price,
            recommendationIndex:recommendationIndex,
            sales:sales,
            banners:imgArr,
            childCategorys:childCategoryIds,
            packageDescription:packageDescription
        },
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                Notify("添加成功", 'top-right', '5000', 'info', 'fa-desktop', true);
                back = true;
            }
            else{
                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                return false;
            }
        }
    })
    return back;
}






