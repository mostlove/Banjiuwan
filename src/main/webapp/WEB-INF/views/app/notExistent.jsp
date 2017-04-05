<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>404</title>
    <!--引入抽取css文件-->
    <%@include file="common/public-css.jsp" %>
    <style>
        body{
            background: #fff;
            width: 100%;
            height: 100%;
            position: absolute;
        }
        .error-bar{
            position: absolute;
            top:30%;
            left:50%;
            transform: translate(-50%, -50%);
            -webkit-transform: translate(-50%, -50%);
            -moz-transform: translate(-50%, -50%);
            -os-transform: translate(-50%, -50%);
            background: transparent !important;
            text-align: center;
        }
        .error-bar img{
            width: 80px;
            height: 80px;
        }
        .error-bar p{
            font-size: 14px;
            margin-top: 10px;
        }

    </style>

</head>

<body>

    <div class="error-bar">
        <img src="<%=request.getContextPath()%>/appResources/img/icon/notExistent.png">
        <p>您访问的不存在</p>
    </div>

    <!--引入抽取js文件-->
    <%@include file="common/public-js.jsp" %>

    <script type="text/javascript">

    </script>
</body>

</html>