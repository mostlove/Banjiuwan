<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--Basic Scripts-->
<script src="<%=request.getContextPath()%>/resources/assets/js/jquery-2.0.3.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/assets/js/bootstrap.min.js"></script>

<!--Beyond Scripts-->
<script src="<%=request.getContextPath()%>/resources/assets/js/beyond.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/assets/js/datetime/bootstrap-timepicker.js"></script>
<!-- validate -->
<script src="<%=request.getContextPath()%>/resources/assets/js/jquery-validation/js/jquery.validate.min.js"></script>

<!-- laydate -->
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/assets/js/layer/layer.js"></script>

<!-- select2 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/assets/js/select2-4.03/js/select2.js"></script>
<%--<script type="text/javascript" src="<%=request.getContextPath()%>/resources/assets/js/select2-4.03/select2.full.js"></script>--%>
<%--<script type="text/javascript" src="<%=request.getContextPath()%>/resources/assets/js/select2/js/select2.js"></script>--%>


<!--时间控件-->
<script src="<%=request.getContextPath()%>/resources/assets/My97DatePicker/WdatePicker.js"></script>



<!-- 文件上传框架 -->
<script src="<%=request.getContextPath()%>/resources/assets/fileupload/js/fileinput.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resources/assets/fileupload/js/fileinput_locale_zh.js" type="text/javascript"></script>

<!-- bootbox -->
<script src="<%=request.getContextPath()%>/resources/assets/bootbox/bootbox.min.js"></script>

<!-- 公共方法 -->
<script src="<%=request.getContextPath()%>/resources/js/commons.js"></script>
<!-- 分页JS -->
<script src="<%=request.getContextPath()%>/resources/js/jqPaginator.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jqPage.js"></script>
<!-- 弹出提示框-->
<script src="<%=request.getContextPath()%>/resources/assets/js/toastr/toastr.js"></script>
<%--angularjs 配置--%>
<script src="<%=request.getContextPath()%>/resources/js/angular.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/config.js"></script>
<script>

    function getRootPath(){
        //代表访问项目的根目录
        return '<%=request.getContextPath()%>';
    }

</script>
