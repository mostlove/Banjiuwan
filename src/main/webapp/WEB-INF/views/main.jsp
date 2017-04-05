<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <title>主页面</title>
    <!-- 引用公用css -->
    <jsp:include page="common/resources-css.jsp"></jsp:include>
    <link id="beyond-link" href="<%=request.getContextPath()%>/resources/assets/css/beyond.min.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/resources/assets/js/skins.min.js"></script>
    <link href="<%=request.getContextPath()%>/resources/assets/css/skins/gray.min.css" rel="stylesheet" />
    <style>
        .item{ width: 100%;padding: 50px 10px;color: #fff;text-align: center; box-sizing: border-box;}
        .item i{font-size: 30px;margin-right: 5px;}
        .item span{ font-size: 30px; }
        .item div{font-size: 20px;margin-top: 5px}
        .color1{ background: #E46F61; }
        .color1:hover{ background: #DF5138; }
        .color2{ background: #60D295;}
        .color2:hover{ background: #58C88D; }
        .color3{ background: #7CBAE5 }
        .color3:hover{ background: #73AFD9; }
        .color4{ background: #687f85; }
        .color4:hover{ background: #257085; }

        /**覆盖样式*/
        .widget-header{margin: 0}
        .tickets-container .tickets-list .ticket-item .ticket-user{line-height: 30px}
    </style>
</head>
<body>
    <div class="page-body">
        <div class="row">
            <div class="col-xs-12 padding-bottom-10">
                <input type="hidden" value="${user.roleId}" id="roleId">
                <span class="margin-right-10">欢迎 <a href="<%=request.getContextPath()%>/ctl/hotel/edit">${user.userName}</a> 进入办酒碗后台管理系统!</span>
            </div>
        </div>
        <div class="widget">
            <div class="row" id="rowDiv">
                <div class="col-xs-12 weather">
                    <iframe allowtransparency="true"
                            frameborder="0" width="575"
                            height="96" scrolling="no"
                            src="//tianqi.2345.com/plugin/widget/index.htm?s=2&z=1&t=0&v=0&d=5&bd=0&k=000000&f=000000&q=1&e=1&a=1&c=54511&w=575&h=96&align=center"></iframe>
                </div>
            </div>

        </div>

        <!-- 消息公告 -->

    </div>

    <!-- 引用公用js -->
    <jsp:include page="common/resources-js.jsp"></jsp:include>
    <!-- 私有js -->

    <script>

        $(function(){
            var roleId = $("#roleId").val();
            if(roleId == 1 || roleId == 5 || roleId == 4){

                $.ajax({
                    type : "POST",
                    url : "<%=request.getContextPath()%>/web/order/countOrder",
                    data : {},
                    dataType :"json",
                    async : false,
                    timeout : 5000,
                    success : function(respObj){
                        var status = respObj.code;
                        if(status==200){
                            var str = '<div class="row">'+
                                    '<div class="col-md-3">'+
                                    '<div class="item color1">'+
                                    '<i class="fa fa-file-text-o"></i>'+
                                    '<span>'+respObj.data.pendingCount+'</span>'+
                                    '<div>订单待处理</div>'+
                                    '</div>'+
                                    '</div>'+
                                    '<div class="col-md-3">'+
                                    '<div class="item color2">'+
                                    '<i class="fa fa-file-text-o"></i>'+
                                    '<span>'+respObj.data.pendCount+'</span>'+
                                    '<div>订单已处理</div>'+
                                    '</div>'+
                                    '</div>'+
                                    '<div class="col-md-3">'+
                                    '<div class="item color3">'+
                                    ' <i class="fa fa-suitcase"></i>'+
                                    '<span>'+respObj.data.pendingCall+'</span>'+
                                    '<div>咨询未处理</div>'+
                                    '</div>'+
                                    '</div>'+
                                    '<div class="col-md-3">'+
                                    '<div class="item color4">'+
                                    ' <i class="fa fa-suitcase"></i>'+
                                    '<span>'+respObj.data.applicationRefund+'</span>'+
                                    '<div>申请退款</div>'+
                                    '</div>'+
                                    '</div>'+
                                    '</div>';
                            $("#rowDiv").after(str);
                        }else{
                            Notify(respObj.msg,'top-right','5000','danger','fa-desktop',true);
                        }
                    }
                });

            }

        })

    </script>
</body>
</html>
