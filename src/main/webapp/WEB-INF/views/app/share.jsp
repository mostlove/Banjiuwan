<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>分享</title>
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <!--自定义css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/view/share.css" charset="UTF-8">
    <style>

    </style>

</head>

<body>

    <div class="mui-content">

        <div class="context">
            <input type="number" id="phoneNumber" oninput="if(value.length>11)value=value.slice(0,11)" class="phone-input" placeholder="请输入手机号码">
            <button class="submitBtn" onclick="shareBtn()">立即下载</button>
        </div>
    </div>

    <!--引入抽取js文件-->
    <%@include file="common/public-js.jsp" %>

    <script type="text/javascript">
        var code = "${code}";
        function shareBtn(){
            var phoneNumber = $("#phoneNumber").val();
            if(!BJW.isMobile.test(phoneNumber)){
                mui.toast("请输入正确的手机号");
                return ;
            }
            if(code.length == 0){
                mui.toast("提交失败");
                return;
            }
            $.ajax({
                type : "POST",
                url : "<%=request.getContextPath()%>/app/user/distribution",
                data :{
                    phoneNumber:phoneNumber,
                    code:code
                },
                dataType :"json",
                async : false,
                timeout : 5000,
                success : function(json){
                    if(json.code == 200){
                        mui.toast("提交成功");
                    }
                    else{
                        mui.toast("提交失败");
                    }
                }
            });

        }

    </script>
</body>

</html>