<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>修改个人资料</title>
    <!--引入抽取css文件-->
    <%@include file="../common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/person/personData.css" charset="UTF-8">
    <style>

    </style>

</head>

<body ng-app="webApp" ng-controller="personDataCtr" ng-cloak>
    <div class="mui-content">

        <ul class="mui-table-view">
            <li class="mui-table-view-cell">
                <%--<a href="#picture">--%>
                <a href="javascript:void(0)" ng-click="choseAvatar()">
                    <span class="head-title">头像</span>
                    <img id="avatar1" ng-if="userInfo.avatar == null || userInfo.avatar == ''" class="mui-media-object mui-pull-right" src="<%=request.getContextPath()%>/appResources/img/icon/default-head.png">
                    <img id="avatar2" ng-if="userInfo.avatar != null" class="mui-media-object mui-pull-right" ng-src="<%=request.getContextPath()%>/{{userInfo.avatar}}">
                </a>
            </li>
            <li class="mui-table-view-cell">
                <span class="item-title">昵称</span>
                <input id="userName" class="mui-pull-right person-input" type="text" placeholder="未填写" maxlength="10" value="{{userInfo.userName}}">
            </li>
            <li class="mui-table-view-cell">
                <span class="item-title">口味</span>
                <input id="personalTaste" class="mui-pull-right person-input" type="text" placeholder="未填写" maxlength="15" value="{{userInfo.personalTaste}}">
            </li>
            <li class="mui-table-view-cell">
                <span>喜爱菜系</span>
                <a class="mui-pull-right" ng-click="initCuisine()">
                    <span ng-if="userInfo.likeCuisine != null && userInfo.likeCuisine != ''" id="notSelectCuisine">{{userInfo.likeCuisine}}</span>
                    <span ng-if="userInfo.likeCuisine == null || userInfo.likeCuisine == ''" id="notSelectCuisine">还未选择您喜欢的菜系</span>
                    <span id="selectedCuisine" class="hide">{{userInfo.likeCuisine}}</span>
                    <i class="mui-icon mui-icon-arrowright"></i>
                </a>
            </li>
            <li class="mui-table-view-cell">
                <span class="item-title">个性签名</span>
                <input id="signature" class="mui-pull-right person-input" type="text" placeholder="未填写" maxlength="15" value="{{userInfo.signature}}">
            </li>
        </ul>
        <br>
        <input type="hidden" id="avatar" name="avatar" value="{{userInfo.avatar}}">

        <form id="newUploadForm0" method="post" enctype="multipart/form-data">
            <div class="imgUpload">
                <input id="fileBtn" type="file" name="file" accept="image/jpg,image/jpeg,image/png,image/gif" class="hide"/>
            </div>
        </form>

    </div>

    <div class="save-div">
        <a class="mui-btn save-btn" ng-click="submitData()">保存</a>
    </div>


    <div id="picture" class="mui-popover mui-popover-action mui-popover-bottom">
        <ul class="mui-table-view">
            <li class="mui-table-view-cell">
                <a onclick="$('#fileBtn').click();mui('#picture').popover('toggle');">从相册选择</a>
            </li>
        </ul>
        <ul class="mui-table-view">
            <li class="mui-table-view-cell">
                <a href="#picture"><b>取消</b></a>
            </li>
        </ul>
    </div>

    <div id="cuisine" class="mui-popover mui-popover-action mui-popover-bottom">
        <form class="mui-input-group">
            <div id="cuisineDiv">
                <div class="mui-input-row mui-checkbox">
                    <label>鲁菜</label>
                    <input name="checkbox1" value="鲁菜" type="checkbox" >
                </div>
                <div class="mui-input-row mui-checkbox">
                    <label>川菜</label>
                    <input name="checkbox1" value="川菜" type="checkbox" >
                </div>
                <div class="mui-input-row mui-checkbox">
                    <label>粤菜</label>
                    <input name="checkbox1" value="粤菜" type="checkbox" >
                </div>
                <div class="mui-input-row mui-checkbox">
                    <label>闽菜</label>
                    <input name="checkbox1" value="闽菜" type="checkbox" >
                </div>
                <div class="mui-input-row mui-checkbox">
                    <label>苏菜</label>
                    <input name="checkbox1" value="苏菜" type="checkbox" >
                </div>
                <div class="mui-input-row mui-checkbox">
                    <label>浙菜</label>
                    <input name="checkbox1" value="浙菜" type="checkbox" >
                </div>
                <div class="mui-input-row mui-checkbox">
                    <label>湘菜</label>
                    <input name="checkbox1" value="湘菜" type="checkbox" >
                </div>
                <div class="mui-input-row mui-checkbox">
                    <label>徽菜</label>
                    <input name="checkbox1" value="徽菜" type="checkbox" >
                </div>
            </div>
            <div class="btn-bar">
                <a href="#cuisine" class="mui-btn cancel-btn">取消</a>
                <a href="javascript:selectCuisine()" class="mui-btn confirm-btn">确认</a>
            </div>
        </form>
    </div>


    <!--引入抽取js文件-->
    <%@include file="../common/public-js.jsp" %>
    <script src="<%=request.getContextPath()%>/appResources/js/common/jquery.form.js" type="text/javascript" charset="UTF-8"></script>


    <script type="text/javascript">

        $("body").append(BJW.dialogLoading("加载中···"));//弹窗loading

        var webApp=angular.module('webApp',[]);
        //修改资料
        webApp.controller('personDataCtr',function($scope,$http,$timeout){
            $scope.userInfo = null;
            $scope.isWei = BJW.isWeiXin();//是否是微信
            //获取登录用户token
            $scope.userToken = BJW.getLocalStorageToken();
            BJW.ajaxRequestData("get", false, BJW.ip+'/app/user/getInfo',{}, $scope.userToken , function(result){
                if(result.flag==0 && result.code==200){
                    $scope.userInfo = result.data;
                    console.log($scope.userInfo);
                }
            });

            //初始化菜系
            $scope.initCuisine = function (){
                //弹出菜单的显示、隐藏
                mui('#cuisine').popover('toggle');
                if ($scope.userInfo.likeCuisine != null) {
                    var array = $scope.userInfo.likeCuisine.split(",");
                    console.log(array);
                    $(".mui-input-group input").each(function (){
                        for (var i = 0; i < array.length; i++) {
                            if (array[i] == this.value) {
                                console.log(array[i] + "=======" + this.value);
                                this.setAttribute("checked",true);
                            }
                        }
                    });
                }
            }

            // 下拉弹起
            $scope.choseAvatar = function (){

                //判断ios
                if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {  //判断iPhone|iPad|iPod|iOS
                    var isCheck = window.JSBridge.checkAuthority();
                    if (!isCheck) {
                        return false;
                    }
                }

                if($scope.isWei){
                    mui('#picture').popover('toggle');
                }
                else{
                    $('#fileBtn').click();
                }
            }

            //保存
            $scope.submitData = function (){

                console.log("正则:" + BJW.isUserName.test($("#userName").val().trim()));

                var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g; //emoji 表情正则

                if ($("#userName").val().trim() == '' || $("#userName").val() == null) {
                    $("#userName").val("");
                    mui.toast("昵称不能为空.");
                    return false;
                }
                else if (!BJW.isUserName.test($("#userName").val().trim())) {
                    mui.toast("请输入正确的昵称.");
                    return false;
                }
                else if($("#userName").val().trim().match(regRule)) {
                    mui.toast("昵称不支持emoji表情.");
                    return false;
                }
                else if ($("#personalTaste").val().trim() == '' || $("#personalTaste").val() == null) {
                    $("#personalTaste").val("");
                    mui.toast("请写一个自己喜欢的口味.");
                    return false;
                }
                else if (!BJW.isChinese.test($("#personalTaste").val().trim())) {
                    mui.toast("口味只能输入汉字.");
                    return false;
                }
                else if($("#personalTaste").val().trim().match(regRule)) {
                    mui.toast("口味不支持emoji表情.");
                    return false;
                }
                else if($("#signature").val().trim().match(regRule)) {
                    mui.toast("个性签名不支持emoji表情.");
                    return false;
                }
                else if ($("#selectedCuisine").html() == '') {
                    mui.toast("还未选择您喜欢的菜系.");
                    return false;
                }
                var arr = {
                    avatar : $("#avatar").val(),
                    userName : $("#userName").val(),
                    personalTaste : $("#personalTaste").val(),
                    likeCuisine : $("#selectedCuisine").html(),
                    signature : $("#signature").val()
                }
                BJW.ajaxRequestData("post", false, BJW.ip+'/app/user/update',arr, $scope.userToken , function(result){
                    console.log(result);
                    if(result.flag == 0 && result.code == 200){
                        mui.toast("保存成功.");
                        location.href = BJW.ip + "/app/page/my?isOpen=0&pageType=2";
                    }
                });
            }

        });

        //解决移动端弹出键盘input弹窗头痛问题
        var h = document.body.scrollHeight;
        window.onresize = function(){
            if (document.body.scrollHeight < h) {
                document.getElementsByClassName("save-div")[0].style.display = "none";
            }else{
                document.getElementsByClassName("save-div")[0].style.display = "block";
            }
        };

        mui.init({
            swipeBack: true //启用右滑关闭功能
        });

        //确认勾选菜系
        function selectCuisine(){
            var selectCuisineHtml = "";
            $(".mui-input-group input").each(function (){
                var value = this.checked?"true":"false";
                if (value == "true") {
                    selectCuisineHtml += this.value + ",";
                }
            });
            console.debug(selectCuisineHtml.substring(0,selectCuisineHtml.length-1));
            if (selectCuisineHtml.length < 1) {
                $("#notSelectCuisine").show();
                $("#selectedCuisine").hide();
                $("#selectedCuisine").html("");
            }
            else {
                $("#notSelectCuisine").hide();
                $("#selectedCuisine").html(selectCuisineHtml.substring(0,selectCuisineHtml.length-1));
                $("#selectedCuisine").show();
            }
            //弹出菜单的显示、隐藏
            mui('#cuisine').popover('toggle');

        }

        //头像上传
        $('#fileBtn').change(function(){
            $("body").append(BJW.uploadDialogLoading("上传中···"));//弹窗loading
            var file = this.files[0];
            if(window.FileReader) {
                var fr = new FileReader();
                fr.onloadend = function(e) {
                    $('#avatar1').attr('src',e.target.result);
                    $('#avatar2').attr('src',e.target.result);
                    $("#newUploadForm0").ajaxSubmit({
                        type: "POST",
                        url:BJW.ip + '/res/upload',
                        success: function(json){
                            console.log(json);
                            if(json.code == 200){
                                $("#avatar").val(json.data.url);
                            }else{
                                mui.toast(json.msg);
                            }
                            BJW.closeUploadDialogLoading();//关闭弹窗loading
                        }
                    });
                };
                fr.readAsDataURL(file);
            }
            //弹出菜单的显示、隐藏
//            mui('#picture').popover('toggle');
        });

        setTimeout(function (){
            BJW.closeDialogLoading();//关闭弹窗loading
        },500);

    </script>
</body>

</html>