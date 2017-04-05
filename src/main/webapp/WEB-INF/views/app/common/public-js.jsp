<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--MUI.min.js-->
<script src="<%=request.getContextPath()%>/appResources/js/common/mui.min.js"></script>
<script src="<%=request.getContextPath()%>/appResources/js/common/mui.zoom.js"></script>
<script src="<%=request.getContextPath()%>/appResources/js/common/mui.previewimage.js"></script>
<script src="<%=request.getContextPath()%>/appResources/js/common/jquery-2.1.0.js" type="text/javascript" charset="UTF-8"></script>
<script src="<%=request.getContextPath()%>/appResources/js/common/swiper.min.js" type="text/javascript" charset="UTF-8"></script>
<script src="<%=request.getContextPath()%>/appResources/js/common/angular.min.js" type="text/javascript" charset="UTF-8"></script>
<script src="<%=request.getContextPath()%>/appResources/js/common/config.js" type="text/javascript" charset="UTF-8"></script>
<script src="<%=request.getContextPath()%>/appResources/js/common/jquery.fly.min.js" type="text/javascript" charset="UTF-8"></script>

<script>

    var serviceConfigList = null;//存放服务费配置列表
    var lastServiceConfigPrice = 0; //存放上一个服务费

    //加入购物车特效
    //$('.mui-btn-numbox-plus').on('click', addCart);

    /**
     * 购物车添加、减数量
     * @param event null:关闭特效  event:开启特效, event如果是减传入的值：就作为逻辑判断
     * @param obj 当前点击对象
     * @param flag 0：减 1：加
     * @param foodId 商品ID / 婚庆ID
     * @param foodCategoryId 商品分类ID
     * @param childCategoryId 如果是婚庆的分类 则字段必须要有，子分类ID
     * @param weddingSonId 如果是婚庆的分类 则字段必须要有，子项ID
     * @param shopCarId 购物车ID 如果有购物车ID 直接更新数字
     * @param price 商品单价
     * @param redirectUrl 作为登录返回地址
     */
    function addOrReduceShopCar(event, obj, flag, foodId, foodCategoryId, childCategoryId, weddingSonId, shopCarId, price, redirectUrl){
        var userToken = BJW.getLocalStorageToken(); //获取本地存储token
        console.log("来自公共加入购物车方法打印：" + userToken);

        if (userToken == null) {
            mui.confirm('未登录，是否前往登录？', '', ["确认","取消"], function(e) {
                if (e.index == 0) {
                    console.log(redirectUrl);
                    localStorage.setItem("redirectUrl", redirectUrl);
                    location.href = BJW.ip + "/app/page/login?redirectUrl=" + redirectUrl;
                } else {
                    //mui.toast("加入失败.");
                }
            });
            return false;
        }

        $("body").append(BJW.carLoading());//加入购物车loading

        //获取当前购物车总价
        var shoppingCarTotalPrice = parseFloat($("#shoppingCarTotal").html());
        //获取当前购物车总数量
        var shoppingCarTotalNumber = parseInt($("#shoppingCar").html());
        //获取商品输入框当前数量 -- 添加用
        var prevNumber = parseInt($(obj).prev().val());
        //获取商品输入框当前数量 -- 减少用
        var nextNumber = parseInt($(obj).next().val());
        //传入的价格
        price = parseFloat(price);

        console.log("商品ID：" + foodId);
        console.log("商品分类ID：" + foodCategoryId);
        console.log("传入商品单价：" + price);
        console.log("当前加入商品购物车数量【点击减才能获取】：" + nextNumber);
        console.log("获取当前购物车总价：" + shoppingCarTotalPrice);
        console.log("获取当前购物车总数量：" + shoppingCarTotalNumber);

        var arr = {
            flag : flag,
            foodId : foodId, //商品ID
            foodCategoryId : foodCategoryId, //商品分类ID
            childCategoryId : childCategoryId, //如果是婚庆的分类 则字段必须要有，子分类ID
            weddingSonId : weddingSonId,//如果是婚庆的分类 则字段必须要有，子项ID
            shopCarId : shopCarId,//购物车ID 如果有购物车ID 直接更新数字
        }
        console.log("********arr********");
        console.log(arr);
        console.log("********arr********");

        //判断是增或减
        if (flag == 0) {
            if (nextNumber < 1) {
                $(obj).next().val(0);
                $(obj).attr("disabled", true);
                //mui.toast("");
                BJW.closeCarLoading();//关闭carLoading
                return false;
            }
            else {
                //减
                if (foodId != 3 && nextNumber == 1) {
                    $(obj).attr("disabled", true);
                    if (event == 1) {
                        BJW.closeCarLoading();//关闭carLoading
                        mui.confirm('是否删除此商品？', '', ["确认","取消"], function(e) {
                            if (e.index == 0) {
                                BJW.ajaxRequestData("post", true, BJW.ip+'/app/shopCar/updateShop', arr, userToken , function(result){
                                    if(result.flag == 0 && result.code == 200){
                                        $(obj).next().val((nextNumber - 1));//减少数量
                                        $("input[inputFood=inputFood_" + foodId + "]").val((nextNumber - 1));
                                        $("input[inputFood=weddingSonId_" + weddingSonId + "]").val((nextNumber - 1));
                                        $("#shoppingCar").html((shoppingCarTotalNumber - 1)); //底部减少数量
                                        var sum = (shoppingCarTotalPrice - price);
                                        $("#shoppingCarTotal").html(sum.toFixed(2)); //底部减少价钱
                                        //mui.toast("减少成功.");
                                        $(obj).parent().parent().parent().parent().fadeOut();

                                        //计算服务费
                                        countServiceConfig(sum, 0);
                                    }
                                });
                            } else {
                                $(obj).removeAttr("disabled");
                            }
                        });
                    }
                    else {
                        BJW.ajaxRequestData("post", true, BJW.ip+'/app/shopCar/updateShop', arr, userToken , function(result){
                            if(result.flag == 0 && result.code == 200){
                                $(obj).next().val((nextNumber - 1));//减少数量
                                $("input[inputFood=inputFood_" + foodId + "]").val((nextNumber - 1));
                                $("input[inputFood=weddingSonId_" + weddingSonId + "]").val((nextNumber - 1));
                                $("#shoppingCar").html((shoppingCarTotalNumber - 1)); //底部减少数量
                                var sum = (shoppingCarTotalPrice - price);
                                $("#shoppingCarTotal").html(sum.toFixed(2)); //底部减少价钱
                                //mui.toast("减少成功.");
                                BJW.closeCarLoading();//关闭carLoading

                                //计算服务费
                                countServiceConfig(sum, 0);
                            }
                        });
                    }

                }
                else {
                    BJW.ajaxRequestData("post", true, BJW.ip+'/app/shopCar/updateShop', arr, userToken , function(result){
                        if(result.flag == 0 && result.code == 200){
                            $(obj).next().val((nextNumber - 1));//减少数量
                            $("input[inputFood=inputFood_" + foodId + "]").val((nextNumber - 1));
                            $("input[inputFood=weddingSonId_" + weddingSonId + "]").val((nextNumber - 1));
                            $("#shoppingCar").html((shoppingCarTotalNumber - 1)); //底部减少数量
                            var sum = (shoppingCarTotalPrice - price);
                            $("#shoppingCarTotal").html(sum.toFixed(2)); //底部减少价钱
                            //mui.toast("减少成功.");
                            BJW.closeCarLoading();//关闭carLoading

                            //计算服务费
                            countServiceConfig(sum, 0);
                        }
                    });
                }
            }

        }
        //增
        else {
            if (event != null) {
                var offset = $('#shoppingCar').offset(),flyer = $('<div class="parabolic">1</div>');
                console.log(offset);
                console.log("event.pageX：" + event.pageX);
                console.log("event.pageY：" + event.pageY);
                flyer.fly({
                    start: {
                        left: event.pageX - 50,
                        top: event.pageY - 50
                    },
                    end: {
                        left: offset.left + 10,
                        top: offset.top + 15,
                        width: 0,
                        height: 0
                    },onEnd : function (){
                        //抛物完成后
                        $(".parabolic").fadeOut();

                        console.log("************服务费列表*************");
                        console.log(serviceConfigList);

                        //加入购物车逻辑
                        BJW.ajaxRequestData("post", true, BJW.ip+'/app/shopCar/updateShop', arr, userToken , function(result){
                            if(result.flag == 0 && result.code == 200){
                                $(obj).prev().val((prevNumber + 1));//添加数量
                                $("input[inputFood=inputFood_" + foodId + "]").val((prevNumber + 1));
                                $("input[inputFood=weddingSonId_" + weddingSonId + "]").val((prevNumber + 1));
                                $("#shoppingCar").html((shoppingCarTotalNumber + 1)); //底部增加数量
                                var sum = (shoppingCarTotalPrice + price);
                                $("#shoppingCarTotal").html(sum.toFixed(2)); //底部增加价钱
                                //mui.toast("加入成功.");
                                BJW.closeCarLoading();//关闭carLoading
                                $(obj).prev().prev().removeAttr("disabled");

                                //计算服务费
                                countServiceConfig(sum, 1);
                            }
                        });


                    }
                });
            }
            else {
                //加入购物车逻辑
                BJW.ajaxRequestData("post", true, BJW.ip+'/app/shopCar/updateShop', arr, userToken , function(result){
                    if(result.flag == 0 && result.code == 200){
                        $(obj).prev().val((prevNumber + 1));//添加数量
                        $("input[inputFood=inputFood_" + foodId + "]").val((prevNumber + 1));
                        $("input[inputFood=weddingSonId_" + weddingSonId + "]").val((prevNumber + 1));
                        $("#shoppingCar").html((shoppingCarTotalNumber + 1)); //底部增加数量
                        var sum = (shoppingCarTotalPrice + price);
                        $("#shoppingCarTotal").html(sum.toFixed(2)); //底部增加价钱
                        //mui.toast("加入成功.");
                        BJW.closeCarLoading();//关闭carLoading
                        $(obj).prev().prev().removeAttr("disabled");

                        //计算服务费
                        countServiceConfig(sum, 1);
                    }
                });
            }
        }
    }

    //计算服务费
    function countServiceConfig(totalMoney, flag) {
        console.log("计算服务费传入的总金额：" + totalMoney);
        var temp = 0;
        var bool = false; // 判断是否满足服务费配置
        var bool1 = false;
        totalMoney = totalMoney - lastServiceConfigPrice;
        for (var i = 0; i < serviceConfigList.length; i++) {
            if (totalMoney >= temp && totalMoney <= serviceConfigList[i].price) {
                //服务费
                lastServiceConfigPrice = serviceConfigList[i].addPrice;
                bool1 = true;
                temp = serviceConfigList[i].price;
                bool = false;
                $("#shoppingCarTotal").html((totalMoney + lastServiceConfigPrice).toFixed(2));
                break;
            }
            else {
                bool = true;
                lastServiceConfigPrice = 0;
            }
        }
        $("#maxServicePrice").html(lastServiceConfigPrice);
        if (bool && !bool1 || totalMoney <= 0) {
            $("#shoppingCarTotal").html((totalMoney).toFixed(2));
            $("#carServiceHint").hide();
        }
        else {
            $("#carServiceHint").show();
        }
       /* if (flag == 1) {

        } else {
            $("#shoppingCarTotal").html((totalMoney + lastServiceConfigPrice).toFixed(2));
        }*/
        if (totalMoney <= 0) {
            $("#shoppingCarTotal").html(0);
            lastServiceConfigPrice = 0;
            $("#carServiceHint").hide();
        }
        /*else {
            lastServiceConfigPrice = tempServicePrice;
        }*/

    }

    if (BJW.isWeiXin()) {
        $("#tabBottom").show(); //用户端
        $("#tabBottom2").show();//厨师端
        $(".car-bottom").css("bottom", 50 + "px");
        $(".detail-header").show();
    }
    else {
        //$("#tabBottom").show();
        //$(".mui-content").css("paddingBottom", 0 + "px");
    }

    //获取用户token
    //var token = BJW.getLocalStorageToken();

    /*阻止用户双击使屏幕上滑*/
    var agent = navigator.userAgent.toLowerCase();        //检测是否是ios
    var iLastTouch = null;                                //缓存上一次tap的时间
    if (agent.indexOf('iphone') >= 0 || agent.indexOf('ipad') >= 0)
    {
        document.body.addEventListener('touchend', function(event)
        {
            var iNow = new Date()
                    .getTime();
            iLastTouch = iLastTouch || iNow + 1 /** 第一次时将iLastTouch设为当前时间+1 */ ;
            var delta = iNow - iLastTouch;
            if (delta < 500 && delta > 0)
            {
                event.preventDefault();
                return false;
            }
            iLastTouch = iNow;
        }, false);
    }

</script>