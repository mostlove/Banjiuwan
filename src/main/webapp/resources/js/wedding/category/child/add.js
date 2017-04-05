


function removedDiv(jsObj,key){
    $(jsObj).parent().parent().hide("slow");
    imgMap.remove(key);
    if(imgMap.size() < 5 ){
        $("#addBanner").show();
    }


}

// 提交
function  addChildCategory(){


    var weddingCategoryId = $("#categoryId").val();
    var name = $("#name").val();
    var coverImg = $("#coverImg").val();
    if($.trim(name).length <= 0){
        Notify("没有填写名称",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if($.trim(coverImg).length <= 0){
        Notify("没有上传图片",'top-right','5000','danger','fa-desktop',true);
        return false;
    }

    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/weddingChildCategory/add",
        data :{
            weddingCategoryId:weddingCategoryId,
            name:name,
            img:coverImg
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






