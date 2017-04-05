/**
 * Created by Administrator on 2016/12/13.
 */
/**
 * 下拉框
 */
$(function(){
    $(".elseRight").on("click",function(){
        $(".pulldown").slideToggle(200)
    });
    $(".pulldown li").on("click",function(){
        var n=$(this).text();
        $(".elseRight1").text(n);
        $(this).siblings().removeClass("add");
        $(this).addClass("add");
        $(this).siblings().children("span").hide();
        $(this).children("span").show();
    })
});