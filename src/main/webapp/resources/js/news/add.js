

// 提交新增精品生活
function  addNews(){


    var title = $("#title").val();
    var img = $("#coverImg").val();
    var icon = $("#icon").val(); //
    var recommendationIndex = $("#recommendationIndex").val();
    var content = $("#content").code();


    if($.trim(title).length <= 0){
        Notify("没有填写标题",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if($.trim(img).length <= 0){
        Notify("没有上传图片",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if(recommendationIndex > 5 || recommendationIndex <= 0){
        Notify("推荐指数最高为 5",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if($.trim(icon).length <= 0){
        Notify("没有上传小图标",'top-right','5000','danger','fa-desktop',true);
        return false;
    }
    if($.trim(content).length <= 0){
        Notify("没有填写内容",'top-right','5000','danger','fa-desktop',true);
        return false;
    }


    $.ajax({
        type : "POST",
        url : getRootPath()+"/web/news/add",
        data :{
            title:title,
            img:img,
            icon:icon,
            recommendationIndex:recommendationIndex,
            content:content
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


