var mapId = $("#id").val();
//存放坐标
var arrayList = new Array();
//作为下标
var num = 0;
//折线
var polyline;
//作为用户有没有点击查询按钮
var bool = false;

$(function() {
	$("#cancel").click(function() {
		//window.location.href = getRootPath()+"/web/cityMarker/cityMarkerList";
	});
	
	//判断是否是修改
	//alert(mapId);
	if(mapId != null && mapId!=""){

		bool = true;
		//var mapCityName = "成都市";
		local = new BMap.LocalSearch(map, {
			renderOptions : {map : map}
		});
		//local.search(mapCityName);
		//local.searchInBounds("呜呜呜呜呜呜呜呜", map.getBounds());
		//修改
		//console.log($("#markerList").val());
		var json=$("#markerList").val();
		var obj = eval('(' + json + ')');
		//console.log(obj);
		for(var str in obj){ 
			console.log(str+'='+obj[str]);
			arrayList[num++] = str+','+obj[str];
			marker = new BMap.Marker(new BMap.Point(str,obj[str])); // 创建标注
			map.addOverlay(marker); // 将标注添加到地图中
		}
		polyLine(arrayList);
	}
});
//百度地图API功能
var map = new BMap.Map("allmap");
//添加地图上的控件
map.addControl(new BMap.NavigationControl());
map.addControl(new BMap.OverviewMapControl());
map.addControl(new BMap.ScaleControl());
//地图显示模式-比如：卫星，三维
/*map.addControl(new BMap.MapTypeControl());*/
map.centerAndZoom(new BMap.Point(104.073516,30.662801), 18);
var local;
//function findAddress() {
//	bool = true;
//	var addressMap = $('#addressMap').val();
//	if(addressMap!="全部"&&addressMap!=""){
//		local = new BMap.LocalSearch(map, {
//			renderOptions : {map : map}
//		});
//		local.search(addressMap);
//	}else{
//		layer.msg('请选择标注的城市');
//	}
//}
map.enableScrollWheelZoom(true);
var marker;// 标注
// 用经纬度设置地图中心点--当前位置
function theLocation() {
	
}

//单击地图添加标注
map.addEventListener("click", function(e) {
	if(!e.overlay){

		console.log("1");
		marker = new BMap.Marker(e.point); // 创建标注
		map.addOverlay(marker); // 将标注添加到地图中
		map.panTo(e.point);//定位到中心点
		arrayList[num++] = e.point.lng+","+e.point.lat;
		document.getElementById("info").innerHTML = "经纬度：(" + e.point.lng + ","
			+ e.point.lat + ")</br>";
		polyLine(arrayList);
	}else{
		if(e.overlay.point!=undefined){
			map.removeOverlay(e.overlay);
			for (var i = 0; i < arrayList.length; i++) {
				var nums = arrayList[i].split(",");
				if(e.overlay.point.lng==nums[0]&&e.overlay.point.lat==nums[1]){
					arrayList.splice(i,1);
					polyLine(arrayList);
					num--;
					i--;
					break;
				}
			}
		}
	}
});

//清除当前已标注
function clearAddress(){
	map.clearOverlays();
	arrayList.length = 0;
	num = 0;
}

//生成折线
function polyLine(array){
	map.removeOverlay(polyline);
	var pointList = new Array();
	for (var i = 0; i < array.length; i++) {
		/*if(array[i]==undefined){
			continue;
		}*/
		var nums = array[i].split(",");
		pointList[i] = new BMap.Point(nums[0],nums[1]);
		//判断大于1添加最后 一个与第一个链接
		if(i>1){
			var numsTow = array[0].split(",");
			pointList[i+1] = new BMap.Point(numsTow[0],numsTow[1]);
		}
	}
	//console.log(pointList);
	polyline = new BMap.Polyline(pointList,  
		{strokeColor:"blue", strokeWeight:10, strokeOpacity:0.5}  //蓝色、宽度为6
	);
	//polyline.setStrokeStyle("dashed");//虚线
	map.addOverlay(polyline);
}

//预加载
function editMap(point){
	var marker = new BMap.Marker(point);
	map.addOverlay(marker);
}

function updateMapList(){
	console.debug(arrayList);
	if(arrayList.length < 3){
		layer.msg('标注至少三个点');
		return false;
	}else if($("#remarks").val()==""||$("#remarks").val()==null){
		layer.msg('请填写备注');
		return false;
	}
	//封装json数据
	console.log(arrayList);
	var temp ="{";
	for (var i = 0; i < arrayList.length; i++) {
		var nums = arrayList[i].split(",");
		temp += "\"" + nums[0]+"\""+":"+"\""+nums[1]+"\"";
		if(arrayList.length-1!=i){
			temp += ",";
		}
	}
	temp += "}";
	if(mapId!=null&&mapId!=""){
		$.ajax({
			type: "POST",
			url:getRootPath()+ "/web/mapList/updateMapList",
			data:{
				id:mapId,
				mapList:temp,
				reMarket:$("#remarks").val()
			},
			success: function(data) {
				if (data.code == 200) {
					window.location.href =getRootPath()+ "/web/mapList/list";
				}
				else{
					layer.msg('更新失败');
				}
			}
		});
	}else{
		$.ajax({
			type: "POST",
			url:getRootPath()+ "/web/mapList/addMapList",
			data:{
				mapList:temp,
				reMarket:$("#remarks").val()
			},
			success: function(data) {
				if (data.code == 200) {
					window.location.href =getRootPath()+ "/web/mapList/list";
				}
				else{
					layer.msg('添加失败');
				}
			}
		});
	}
}


//返回标注列表
function cityMarkerList(){
	window.location.href = getRootPath() + 
	"/web/cityMarker/cityMarkerList";
}

