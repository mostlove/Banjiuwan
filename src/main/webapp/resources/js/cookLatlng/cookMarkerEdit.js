//百度地图API功能
//var map = new BMap.Map("allmap");
////添加地图上的控件
//map.addControl(new BMap.NavigationControl());
//map.addControl(new BMap.OverviewMapControl());
//map.addControl(new BMap.ScaleControl());
////地图显示模式-比如：卫星，三维
///*map.addControl(new BMap.MapTypeControl());*/
//map.centerAndZoom(new BMap.Point(104.073516,30.662801), 12);
//var local;
//map.enableScrollWheelZoom(true);

var map = new BMap.Map("allmap");          // 创建地图实例
var point = new BMap.Point(104.073516,30.662801);  // 创建点坐标
map.centerAndZoom(point, 12);                 // 初始化地图，设置中心点坐标和地图级别
map.enableScrollWheelZoom();
map.addControl(new BMap.NavigationControl());

//
//
$(function() {
	getCookMap();
	//setInterval()循环执行相应 定时器
	setInterval("getCookMap()",5000);
});
//
//
var markerArr = [
	{ title: "华联1", point: "116.364531,40.057003"},
	{ title: "华联2",point: "116.340934,40.013401"},
	{ title: "华润3", point: "116.342213,40.047267"}
];
function getCookMap() {
	$.ajax({
		type:"get",
		url : getRootPath()+"/web/cook/getCacheCookLatLng",
		dataType:"json",
		async : false,
		timeout : 5000,
		success:function(respObj){
			if (respObj.code == 200) {
				map.clearOverlays();
				console.log(respObj.data);
				for (var i = 0; i < respObj.data.length; i++) {
					var avatar = respObj.data[i].mapIcon;
					if (avatar == null || avatar == '') {
						avatar = "resources/img/cook_icon.png";
					}


					var lat = 0;
					var lng = 0;
					if (typeof (respObj.data[i].latLng) != "undefined" &&
						respObj.data[i].latLng != null && respObj.data[i].latLng != '') {
						lat = respObj.data[i].latLng.split(",")[0];
						lng = respObj.data[i].latLng.split(",")[1];
					} else {
						continue;
					}
					var point = new window.BMap.Point(lng, lat);

					//创建信息窗口
					var sContent = "<div>厨师：" + respObj.data[i].realName + "<br>手机：" + respObj.data[i].phoneNumber + "<br></div>";
					// 创建信息窗口对象
					var infoWindow = new window.BMap.InfoWindow(sContent);

					createMark(point,infoWindow,avatar,i);



				}
			}
		}
	});
}

createMark = function(point, info_html,avatar,i){
	var myIcon = new BMap.Icon(getRootPath() + "/" + avatar, new BMap.Size(23, 25), {
		// 指定定位位置。
		// 当标注显示在地图上时，其所指向的地理位置距离图标左上
		// 角各偏移10像素和25像素。您可以看到在本例中该位置即是
		// 图标中央下端的尖角位置。
		offset: new BMap.Size(10, 25),
		// 设置图片偏移。
		// 当您需要从一幅较大的图片中截取某部分作为标注图标时，您
		// 需要指定大图的偏移位置，此做法与css sprites技术类似。
		//imageOffset: new BMap.Size(0, 0 - i * 25),   // 设置图片偏移
		infoWindowAnchor: new BMap.Size(10, 0)

	});
	var marker = new window.BMap.Marker(point,{icon:myIcon});
	map.addOverlay(marker);
	marker.openInfoWindow(info_html);
	marker.addEventListener("mouseover", function(e){
		this.openInfoWindow(info_html);
	});
	//_marker.addEventListener("mouseover", function(e){
	//	this.setTitle("位于: "+node.lng+","+node.lat);
	//});
	return marker;
};

//addmarks = function(nodes){
//	var _nodes = nodes;
//	var _markers = new Array();
//	for(var i=0;i<_nodes.length;i++){
//		var _html = "节点名:"+_node.name;
//		shop_markers.push(createMark(_nodes[i], _html));
//	}
//	myClusterer = new BMapLib.MarkerClusterer(myMap, {markers:shop_markers});
//	myClusterer.setMaxZoom(17);
//	//myClusterer.setStyles(myStyles);
//};


//
//
//function addMarker(respObj){  // 创建图标对象
//
//	// 创建标注对象并添加到地图
//	for(var i = 0; i < respObj.data.length; i++){
//		var point = new BMap.Point(respObj.data[i].latLng.split(",")[1]+5,respObj.data[i].latLng.split(",")[0]+2);
//		var  marker = new BMap.Marker(point);
//		map.addOverlay(marker);
//		//给标注点添加点击事件。使用立即执行函数和闭包
//		(function() {
//			var thePoint = respObj.data[i];
//			marker.addEventListener("click",function(){
//				showInfo(this,thePoint);
//			});
//		})();
//
//	}
//
//}
////显示信息窗口，显示标注点的信息。
//function showInfo(thisMaker,data){
//	var sContent = "<div>厨师：" + data.realName + "<br>手机：" + data.phoneNumber + "<br></div>";
//	var infoWindow = new BMap.InfoWindow(sContent);  // 创建信息窗口对象
//	thisMaker.openInfoWindow(infoWindow);   //图片加载完毕重绘infowindow
//}





//var markerArr = [
//	{ title: "名称：广州火车站", point: "113.264531,23.157003", address: "广东省广州市广州火车站", tel: "12306" },
//	{ title: "名称：广州塔（赤岗塔）", point: "113.330934,23.113401", address: "广东省广州市广州塔（赤岗塔） ", tel: "18500000000" },
//	{ title: "名称：广州动物园", point: "113.312213,23.147267", address: "广东省广州市广州动物园", tel: "18500000000" },
//	{ title: "名称：天河公园", point: "113.372867,23.134274", address: "广东省广州市天河公园", tel: "18500000000" }
//
//];
//
//$(function() {
//	//getCookMap();
//	//setInterval()循环执行相应 定时器
//	setInterval("a()",5000);
//});
//
//function map_init() {
//	var map = new BMap.Map("allmap"); // 创建Map实例
//	var point = new BMap.Point(104.073516,30.662801); //地图中心点，广州市
//	map.centerAndZoom(point, 13); // 初始化地图,设置中心点坐标和地图级别。
//	map.enableScrollWheelZoom(true); //启用滚轮放大缩小
//	//向地图中添加缩放控件
//	var ctrlNav = new window.BMap.NavigationControl({
//		anchor: BMAP_ANCHOR_TOP_LEFT,
//		type: BMAP_NAVIGATION_CONTROL_LARGE
//	});
//	map.addControl(ctrlNav);
//
//	//向地图中添加缩略图控件
//	var ctrlOve = new window.BMap.OverviewMapControl({
//		anchor: BMAP_ANCHOR_BOTTOM_RIGHT,
//		isOpen: 1
//	});
//	map.addControl(ctrlOve);
//
//	//向地图中添加比例尺控件
//	var ctrlSca = new window.BMap.ScaleControl({
//		anchor: BMAP_ANCHOR_BOTTOM_LEFT
//	});
//	map.addControl(ctrlSca);
//
//	//var point = new Array(); //存放标注点经纬信息的数组
//	//var marker = new Array(); //存放标注点对象的数组
//	//var info = new Array(); //存放提示信息窗口对象的数组
//	//for (var i = 0; i < markerArr.length; i++) {
//	//	var p0 = markerArr[i].point.split(",")[0]; //
//	//	var p1 = markerArr[i].point.split(",")[1]; //按照原数组的point格式将地图点坐标的经纬度分别提出来
//	//	point[i] = new window.BMap.Point(p0, p1); //循环生成新的地图点
//	//	marker[i] = new window.BMap.Marker(point[i]); //按照地图点坐标生成标记
//	//	map.addOverlay(marker[i]);
//	//	marker[i].setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
//	//	var label = new window.BMap.Label(markerArr[i].title, { offset: new window.BMap.Size(20, -10) });
//	//	marker[i].setLabel(label);
//	//	info[i] = new window.BMap.InfoWindow("<p style=’font-size:12px;lineheight:1.8em;’>" + markerArr[i].title + "</br>地址：" + markerArr[i].address + "</br> 电话：" + markerArr[i].tel + "</br></p>"); // 创建信息窗口对象
//	//}
//
//	function a(){
//		$.ajax({
//			type:"get",
//			url : getRootPath()+"/web/cook/getCacheCookLatLng",
//			dataType:"json",
//			async : false,
//			timeout : 5000,
//			success:function(respObj){
//				if (respObj.code == 200) {
//					map.clearOverlays();
//
//					for (var i = 0; i < respObj.data.length; i++) {
//						var myIcon = new BMap.Icon(getRootPath() + "/" + respObj.data[i].avatar, new BMap.Size(23, 25), {
//							// 指定定位位置。
//							// 当标注显示在地图上时，其所指向的地理位置距离图标左上
//							// 角各偏移10像素和25像素。您可以看到在本例中该位置即是
//							// 图标中央下端的尖角位置。
//							offset: new BMap.Size(10, 25),
//							// 设置图片偏移。
//							// 当您需要从一幅较大的图片中截取某部分作为标注图标时，您
//							// 需要指定大图的偏移位置，此做法与css sprites技术类似。
//							imageOffset: new BMap.Size(0, 0 - i * 25),   // 设置图片偏移
//							infoWindowAnchor: new BMap.Size(10, 0)
//						});
//						var lat = 0;
//						var lng = 0;
//						if (typeof (respObj.data[i].latLng) != "undefined" &&
//							respObj.data[i].latLng != null && respObj.data[i].latLng != '') {
//							lat = respObj.data[i].latLng.split(",")[0];
//							lng = respObj.data[i].latLng.split(",")[1];
//						} else {
//							continue;
//						}
//
//
//
//						var point = new window.BMap.Point(lng, lat); //循环生成新的地图点
//						var marker = new window.BMap.Marker(point,{icon:myIcon}); //按照地图点坐标生成标记
//						map.addOverlay(marker);
//						//var point = new window.BMap.Point(lng, lat);
//
//						// 创建信息窗口对象
//						//var infoWindow = new BMap.InfoWindow(sContent);
//
//						// 创建标注对象并添加到地图
//						//创建信息窗口
//						var sContent = "<div>厨师：" + respObj.data[i].realName + "<br>手机：" + respObj.data[i].phoneNumber + "<br></div>";
//						/*	var marker = new BMap.Marker(point);*/
//						/*map.addOverlay(marker);*/
//						marker.setAnimation(BMAP_ANIMATION_BOUNCE)
//						//map.panTo(point);//定位到中心点
//						marker.openInfoWindow(new window.BMap.InfoWindow(sContent));
//
//
//					}
//				}
//			}
//		});
//	}
//
//
//
//	a();








	//marker[0].addEventListener("mouseover", function () {
	//	this.openInfoWindow(info[0]);
	//});
	//marker[1].addEventListener("mouseover", function () {
	//	this.openInfoWindow(info[1]);
	//});
	//marker[2].addEventListener("mouseover", function () {
	//	this.openInfoWindow(info[2]);
	//});
//}
////异步调用百度js
//function map_load() {
//	var load = document.createElement("script");
//	load.src = "http://api.map.baidu.com/api?v=1.4&callback=map_init";
//	document.body.appendChild(load);
//}
//window.onload = map_load;
//
//
//
//var ajaxFun() {
//
//}












