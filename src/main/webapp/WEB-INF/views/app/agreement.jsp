<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>
        <c:if test="${agreement.id == 1}">
            充值协议
        </c:if>
        <c:if test="${agreement.id == 2}">
            用户注册协议
        </c:if>
    </title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/appResources/css/mui.min.css" />
    <style>
        .mui-content{
            background: #fff;
        }
        .mui-content .mui-scroll{
            padding: 20px;
        }
        .mui-content .mui-scroll p.title{
            text-align: center;
            color: #4D4D4D;
            font-size: 18px;
        }
    </style>
</head>
<body>
<div class="mui-content mui-scroll-wrapper">
    <div class="mui-scroll">
        <div class="serviceprotocol">
            <p class="title">${agreement.title}</p>
            <div class="servicecontent">
                ${agreement.content}
            </div>
        </div>
    </div>
</div>


<script src="<%=request.getContextPath()%>/appResources/js/common/jquery-2.1.0.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/appResources/js/common/mui.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

    mui.init({
        swipeBack: true //启用右滑关闭功能
    });

    var  options={
        scrollY:true,
        scrollX:false,
        startY:0,
        startX:0,
        indicators:false,
        deceleration:0.0005,
        bounce:true
    }
    mui('.mui-scroll-wrapper').scroll(options);

    function getData(){
        $.ajax({
            type:"get",
            url:"",
            async:true,
            data:{},
            dataType:'json',
            success:function(){

            }
        });
    }

</script>
</body>
</html>
