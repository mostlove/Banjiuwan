/**
 * Created by Administrator on 2017/3/6 0006.
 */



function  addWaiter(){

    var name = $("#name").val();
    var gender = $("#gender").val();


    if($.trim(name).length == 0 ){
        Notify("数据格式不合法",'top-right','5000','danger','fa-desktop',true);
        return false;
    }



    var url = "/web/waiter/addWaiter";
    var data = {
        name:name,
        gender:gender
    }
    $.ajax({
        type : "POST",
        url : getRootPath()+url,
        data :data,
        dataType :"json",
        async : false,
        timeout : 5000,
        success : function(json){
            if(json.code == 200){
                return true;
            }
            else{
                Notify(json.msg,'top-right','5000','danger','fa-desktop',true);
                return false;
            }
        }
    });


}