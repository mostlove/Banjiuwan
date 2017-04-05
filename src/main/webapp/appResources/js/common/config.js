var BJW = function () {};
BJW.prototype = {
	ip: 'http://'+window.location.host+'/Banjiuwan',
	//ip: 'http://192.168.118.194:8080/Banjiuwan',
	//手机号码正则表达式
	isMobile : /^(((13[0-9]{1})|(18[0-9]{1})|(17[6-9]{1})|(15[0-9]{1}))+\d{8})$/,
	//电话号码正则表达式
	isPhone : /[0-9-()（）]{7,18}/,
	//身份证正则表达式
	isIHCIard :   /^\d{15}(\d{2}[\d|X])?$/,
	//6-12的密码
	isPwd : /[A-Za-z0-9]{6,20}/,
	//输入的是否为数字
	isNumber : /^[0-9]*$/,
	//输入的只能为数字和字母
	isNumberChar: /^[0-9a-zA-Z]*$/,
	//用户名
	isUserName : /[\w\u4e00-\u9fa5]/,
	isEmoji : /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g, //emoji 表情正则
	//只能输入汉字
	isChinese : /[\u4e00-\u9fa5]/gm,
	getOrderStatus : {
		NOT_PAYMENT : 3001, //未支付
		ALREADY_PAYMENT : 3002, //已经支付
		COMPLETE : 3003, //订单完成
		PENDING_SERVICE : 2003, //待服务
		SERVICEING : 2004, //服务中
		FINISHED : 2005, //完成
		EVALUATED : 2007, //评价已完成
		PENDING_ORDERS : 2008, //待接单
		ORDER_CANCLE : 2009, //订单已取消
	},
	foodCategoryId : {
		setMeal : 9, //套餐ID
		bamYan : 10, //坝坝宴ID
		service : 11, //专业服务
		dinner : 12, //伴餐演奏
		wedding : 13, //婚庆预约
	},
	//清空购物车传入的类型ID
	clearCarType : {
		singleFood : 1, //单点
		packageCater : 2, //套餐
		babaYan : 3, //坝坝宴
		wedding : 4, //婚庆
		act : 5, //伴餐演奏
		service : 6, //专业服务
	},
	judgeCategory : function (categoryId){
		var str = "";
		switch (categoryId){
			case 1:
				str = "凉菜";
				break;
			case 2:
				str = "热菜";
				break;
			case 3:
				str = "海河鲜";
				break;
			case 4:
				str = "素菜";
				break;
			case 5:
				str = "燕鲍翅";
				break;
			case 6:
				str = "小吃";
				break;
			case 7:
				str = "汤";
				break;
			case 8:
				str = "酒水";
				break;
			case 9:
				str = "套餐";
				break;
			case 10:
				str = "坝坝宴";
				break;
			case 11:
				str = "专业服务";
				break;
			case 12:
				str = "伴餐演奏";
				break;
			case 13:
				str = "婚庆预约";
				break;
			case 14:
				str = "实时菜价";
				break;
			default:
				str = "无分类";
				break;
		}
		return str;
	},
	//获取url中的参数
	getUrlParam : function(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.search.substr(1).match(reg); //匹配目标参数
		if(r != null){
			return unescape(r[2]);
		}else{
			return null; //返回参数值
		}
	},
	//时间戳转日期
	timeStampConversion : function (timestamp){
		var d = new Date(timestamp);    //根据时间戳生成的时间对象
		var date = (d.getFullYear()) + "-" +
			(d.getMonth() + 1) + "-" +
			(d.getDate())+ " " +
			(d.getHours()) + ":" +
			(d.getMinutes()) + ":" +
			(d.getSeconds());
		return date;
	},
	//日期转换为时间戳
	getTimeStamp : function (time){
		time=time.replace(/-/g, '/');
		var date=new Date(time);
		return date.getTime();
	},
	mergeArray : function (arr1, arr2){
		for (var i = 0 ; i < arr1.length ; i ++ ){
			for(var j = 0 ; j < arr2.length ; j ++ ){
				if (arr1[i].id === arr2[j].id){
					arr1.splice(i,1); //利用splice函数删除元素，从第i个位置，截取长度为1的元素
				}
			}
		}
		return arr1;
	},
	isFei : "<img class=\"xingxing\" src=\"http://" + window.location.host + "/Banjiuwan/appResources/img/icon/xing-icon.png\"/>",
	isMan : "<img class=\"xingxing\" src=\"http://" + window.location.host + "/Banjiuwan/appResources/img/icon/xing-icon-active.png\"/>",
	//遮罩层
	shade : function(){
		var html = '<div class="alertShade"></div>';
		$("body").append(html);
	},
	//关闭遮罩层
	closeShade : function(){
		$('.alertShade').remove();
	},
	//关闭弹出
    closeAletDialog : function(){
        $('.aletDialog').hide();
    },
	//停留几秒的弹出窗
	toast : function(str){
		var html = '<div class="layerBox">'+
				'<div class="layerMessage">'+str+'</div>'+
			'</div>';
		$("body").append(html);
		setTimeout(function(){
			$('.layerBox').remove();
		},1500)

	},
	//行内loading
	loading : "<div class=\"mui-loading\"><div class=\"mui-spinner\"></div></div>",
	//弹窗loading
	dialogLoading : function (text){
		var html = "";
		if (BJW.isWeiXin()) {
			html = "<div class=\"whiteMask\">" +
				"<div class=\"blackMask\">" +
				"<div class=\"loading-bar\">" +
				"<div class=\"mui-row\">" +
				"<div class=\"mui-col-xs-12 mui-col-sm-12\">" +
				"<div class=\"loadingImg\"><img src=\"" + BJW.ip + "/appResources/img/icon/loading.gif\"/></div>" +
				"<span class=\"loading-hint\">" + text + "</span>" +
				"</div>" +
				"</div>" +
				"</div>" +
				"</div>" +
				"</div>";
		}
		return html;
	},
	//关闭弹窗loading
	closeDialogLoading : function (){
		$(".whiteMask").remove();
	},
	//上传弹窗loading
	uploadDialogLoading : function (text){
		var html = "<div class=\"whiteMask\">" +
				"<div class=\"blackMask\">" +
				"<div class=\"loading-bar\">" +
				"<div class=\"mui-row\">" +
				"<div class=\"mui-col-xs-12 mui-col-sm-12\">" +
				"<div class=\"loadingImg\"><img src=\"" + BJW.ip + "/appResources/img/icon/loading.gif\"/></div>" +
				"<span class=\"loading-hint\">" + text + "</span>" +
				"</div>" +
				"</div>" +
				"</div>" +
				"</div>" +
				"</div>";
		return html;
	},
	//关闭弹窗loading
	closeUploadDialogLoading : function (){
		$(".whiteMask").remove();
	},
	//加入购物车loading
	carLoading : function (){
		//<img src=\"" + BJW.ip + "/appResources/img/icon/loading.gif\"/>
		var html = "<div class=\"carLoading\"><div class=\"loadingImg\"></div></div>";
		return html;
	},
	//关闭加入购物车loading
	closeCarLoading : function (){
		$(".carLoading").remove();
	},
	//获取移动端Token
	getToken: function (){
		try {
			return window.JSBridge.getDeviceToken();
		}catch (error){
			return "";
		}
	},
	//获取设备类型
	getDevice: function (){
		try {
			return window.JSBridge.getDeviceType();
		}catch (error){
			return "";
		}
	},
	//关闭移动端loading
	closeMoveLoading : function () {
		try {
			return window.JSBridge.closeLoading();
		}catch (error){
			return "";
		}
	},
	//获取用户登录token
	getUserToken : function () {
		try {
			return window.JSBridge.getToken();
		}catch (error){
			return "";
		}
	},
	//注销用户登录token
	removeUserToken : function () {
		try {
			return window.JSBridge.removeToken();
		}catch (error){
			return "";
		}
	},
	//本地储存--用户登录Token
	getLocalStorageToken: function (){
		var token = localStorage.getItem('userToken');
		if (token == null) {
			try {
				var tempToken = window.JSBridge.getToken();
				localStorage.setItem("userToken", tempToken);
				return tempToken;
			}catch (error){
				return null;
			}
		}
		else {
			return token;
		}
	},
	//本地储存--厨师登录Token
	getLocalStorageCookToken: function (){
		var token = localStorage.getItem('cookToken');
		if (token == null) {
			try {
				var tempToken = window.JSBridge.getToken();
				localStorage.setItem("cookToken", tempToken);
				return tempToken;
			}catch (error){
				return null;
			}
		}
		else {
			return token;
		}
	},
	isWeiXin : function (){
		var ua = window.navigator.userAgent.toLowerCase();
		if(ua.match(/MicroMessenger/i) == 'micromessenger'){
			return true;
		}else{
			return false;
		}
	},
	//获取用户信息
	getUserInfo : function(){
		return JSON.parse(localStorage.getItem("loginUserInfo"));
	},
	//获取用户Id
	getUserId : function(){
		var userId='';
			//判断用户在没记住密码的情况下是否登录过
		var sloginUserId=JSON.parse(sessionStorage.getItem('loginUserId'));
		if(sloginUserId != undefined && sloginUserId != null && sloginUserId != ""){
			userId = sloginUserId;
		}
		return userId;	
	},
	getServiceUserInfo : function (token){

	},
	checkLogin : function (callback) {
		$.ajax({
			url: HCI.ip + "/ctl/login/checkLogin",
			success: function (result) {
				callback(result);
			}
		});	
	},
	//微信支付appId
	wxAppId : "wxedb9473980fbecfe",
	//微信端--微信支付调起
	wechatPay : function (appId, timeStamp, nonceStr, prepayId, signType, paySign, jumpUrl) {
		if (typeof WeixinJSBridge == "undefined"){
			if( document.addEventListener ){
				document.addEventListener('WeixinJSBridgeReady', BJW.onBridgeReady, false);
			}else if (document.attachEvent){
				document.attachEvent('WeixinJSBridgeReady', BJW.onBridgeReady);
				document.attachEvent('onWeixinJSBridgeReady', BJW.onBridgeReady);
			}
		}else{
			BJW.onBridgeReady(appId, timeStamp, nonceStr, prepayId, signType, paySign, jumpUrl);
		}
	},
	//微信端--微信支付签名
	onBridgeReady : function (appId, timeStamp, nonceStr, prepayId, signType, paySign, jumpUrl) {
		WeixinJSBridge.invoke(
			'getBrandWCPayRequest', {
				"appId" : appId,     //公众号名称，由商户传入
				"timeStamp" : timeStamp,         //时间戳，自1970年以来的秒数
				"nonceStr" : nonceStr, //随机串
				"package" : prepayId,
				"signType" : signType,         //微信签名方式：
				"paySign" : paySign //微信签名
			},
			function(res){
				//alert(JSON.stringify(res));
				if(res.err_msg == "get_brand_wcpay_request:ok" ) {// 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
					//mui.alert("支付成功.");
					if (jumpUrl == null) {
						location.reload();
					}
					else {
						location.href = BJW.ip + jumpUrl;
					}
				}
				else {
					mui.alert("支付失败.");
				}
			}
		);
	},
	//ajax请求数据  get/post方式
	ajaxRequestData : function(method,async,requestUrl,arr,token,callback){
		$.ajax({
			type: method,
			async: async,
			url: requestUrl,
			data: arr,
			//dataType:"jsonp",    //跨域json请求一定是jsonp
			headers: {
				"token":token,
			},
			success:function(json){
				console.log(json);
				if(json.flag==0 && json.code ==200){
					if (callback) {
						callback(json);
					}
				}
				else if(json.code == 1005){
					//localStorage.clear();//清空所有本地储存
					localStorage.removeItem("userToken");
					BJW.removeUserToken();
					mui.confirm('未登录，是否前往登录？', '', ["确认","取消"], function(e) {
						if (e.index == 0) {
							location.href = BJW.ip + "/app/page/login?redirectUrl=" + window.location.href;
						} else {
							//location.href = "javascript:history.go(-1)";
						}
					});

				}
				else if (json.code == 1011) {
					mui.alert(json.msg);
				}
				else if (json.code == 1007) {
					mui.alert(json.msg);
				}
				else if (json.code == 202) {
					mui.alert(json.msg);
				}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				console.log("请求出错了...");
			}
		})
	},
	//厨师端用
	cookAjaxRequestData : function(method,async,requestUrl,arr,token,callback){
		$.ajax({
			type: method,
			async: async,
			url: requestUrl,
			data: arr,
			//dataType:"jsonp",    //跨域json请求一定是jsonp
			headers: {
				"token":token,
			},
			success:function(json){
				console.log(json);
				if(json.flag==0 && json.code ==200){
					if (callback) {
						callback(json);
					}
				}
				else if(json.code == 1005){
					localStorage.clear();//清空所有本地储存
					mui.confirm('未登录，是否前往登录？', '', ["确认","取消"], function(e) {
						if (e.index == 0) {
							location.href = BJW.ip + "/app/page/cookLogin?redirectUrl=" + window.location.href;
						} else {
							//location.href = "javascript:history.go(-1)";
						}
					});
				}
				else if (json.code == 1011) {
					mui.alert(json.msg);
				}
				else if (json.code == 1007) {
					mui.alert(json.msg);
				}
				else if (json.code == 202) {
					mui.alert(json.msg);
				}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				console.log("请求出错了...");
			}
		})
	},
};

var BJW = new BJW();

//点击body关闭弹出
$('body').on('click', "#popupBanner", function(){
	BJW.closeShade();
});

Date.prototype.format = function (fmt) { //author: meizz
	var o = {
		"M+": this.getMonth() + 1, //月份
		"d+": this.getDate(), //日
		"h+": this.getHours(), //小时
		"m+": this.getMinutes(), //分
		"s+": this.getSeconds(), //秒
		"q+": Math.floor((this.getMonth() + 3) / 3), //季度
		"S": this.getMilliseconds() //毫秒
	};
	if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for (var k in o)
		if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}