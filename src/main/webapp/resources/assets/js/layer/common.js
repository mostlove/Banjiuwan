/**
 * Common	公共JS
 * author	王程
 * Version  1.0.1
 * 
 * explain	：
 * 
 * 1>方法中带有[]的参数是非必传参数
 * 
 */

/**
 * TODO layer 弹窗
 * @param url 窗体与载入的URL地址
 * @param title 窗体的标题	default:提示框
 * @param width 窗体宽度	default:660px
 * @param height 窗体高度	default:400px
 * @param [infoMation] 窗口显示后回调
 * @param [full]	弹出全屏 defalut:false
 * @param [isShadeClose] 是否可通过遮罩层关闭窗口  default：false
 * @param [successCallBack] 窗口显示完毕后回调
 * @param [closeCallBack] 窗体关闭后回调
 */
function showDialog(url, title, width, height,infoMation,full, isShadeClose,successCallBack,closeCallBack) {
	if (url == '' || url == null) {
		return;
	}
	if (title == '' || title == null) {
		title = "提示框";
	}
	if (width == '' || width == null) {
		width = '660';
	}
	if (height == '' || height == null) {
		height = '400';
	}
	if(!arguments[6]){
		isShadeClose = false;
	}
	 if(!arguments[4]){
		 full = false;
	 }

	$.get(url, {
		"_" : Math.random()
	}, function(result) {
		//scrollbar: false,		//禁止浏览器滚动条
		var index = layer.open({
			type : 1,
			title : title,
			shadeClose : isShadeClose,
			area : [ width + "px", height + "px" ],
			shade : 0.8,
			content : result,		//窗体展示内容
			shift:0,				//动画 1-6
			success:function(){		//弹出窗弹出会回调
				$(".layui-layer-shade").css({
					"z-index":"1900"
				});
				$(".layui-layer").css({
					"z-index":"1910"
				});
				
				if(successCallBack != null && typeof(eval(successCallBack)) == "function"){
					successCallBack();
				}
				
			},
			end : function(){	//弹出窗关闭后回调
				$(".select2-drop").remove();
				$(".select2-drop-mask").remove();
				if(closeCallBack != null && typeof(eavl(closeCallBack)) == "function"){
					closeCallBack();
				}
			}
		});

		if (infoMation != null && typeof (eval(infoMation)) == "function") {
			infoMation();
		}

		if(full){
			layer.full(index);
		}
		
	});
	
}


var jtspruce = {
	    defaultHotelImage : "hotel.jpg",
		contextPath: "<%=request.getContextPath()%>",
		getLoginUser : localStorage.getItem("user"),
	    getLoginUserId : function () {
	        var value = localStorage.getItem('user');
	        if (value!=null && value!=undefined) {
	            var user = JSON.parse(value);
	            return user.userID;
	        }
	        window.location.href = jtspruce.contextPath + '/logout';
	    },
		handleString : function (size, str) {
	        if (str == undefined || str == null) {
	            return "";
	        }
			if (str.length > size) {
				return str.substring(0, size-2)+"...";
			}
			return str;
		},
	    handUrlParams : function (name, url) {
	        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	        var r = window.location.search.substr(1).match(reg);
	        if (r != null) {
	            return (r[2]);
	        }
	        return null;
	    },
	    getFormData : function(formID) {
			var data = {};
			var input = $('#' + formID).find(':input:not(:button)');
			$.each(input, function(i, n) {
				if ($(n).is(':radio')) {
					if ($(n).is(':checked')) {
						data[$(n).attr('name')] = $(n).val();
					}
				} else if ($(n).is(':checkbox')) {
					if ($(n).is(':checked')) {
						var name = data[$(n).attr('name')];
						if (!name) {
							name = new Array();
						}
						name.push($(n).val());
						data[$(n).attr('name')] = name;
					}
				} else {
					data[$(n).attr('name')] = $(n).val();
				}
			});
			return data;
		},
		setFormData : function(formID, data) {
			var input = $('#' + formID).find(':input:not(:button)');
			$.each(input, function(i, n) {
				if ($(n).is(':radio')) {
					if ($(n).val() == data[$(n).attr('name')]) {
						$(n).attr('checked', true);
						console.log($(n).attr('name'));
					} else {
						$(n).attr('checked', false);
					}
				} else if ($(n).is(':checkbox')) {
					var arr = data[$(n).attr('name')];
					if ($.isArray(arr) && $.inArray($(n).val(), arr) != -1) {
						$(n).attr('checked', true);
					} else {
						$(n).attr('checked', false);
					}
				} else {
					$(n).val(data[$(n).attr('name')]);
				}
			})
		},
		pagination: function(pagination, total, limit, offset, url) {
			$.jqPaginator('#' + pagination, {
	            totalCounts: total,
	            pageSize : limit,
	            visiblePages : 5,
	            currentPage : offset/limit+1,
	            onPageChange : function(num, type) {
	            	if (type != 'init') {
	            		window.open(jtspruce.contextPath + url + '?offset=' + (num - 1)*limit + '&limit='+limit+'&t=' + new Date().getTime(), '_self');
	            	}
	        	}
	        });
		}
	}