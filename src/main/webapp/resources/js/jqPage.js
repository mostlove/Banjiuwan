function addpage(){
	var pageStr='<div class="row"><div class="col-lg-12 col-sm-12 col-xs-12" id="pageCon">'+
		'<div class="row">'+
	'<div class="col-lg-6 col-sm-4 col-xs-12">'+
		'<p id="showing" style="float: left;"></p>'+
	'</div>'+
	'<div class="col-lg-6 col-sm-8 col-xs-12">'+
		'<div class="goPage" style="float:right">'+
			'<input type="text" id="num" value="1" onpaste="return false;"  onkeypress="keyPress()">'+
			'<a href="javascript:void(0)" class="btn"  id="go">go</a>'+
		'</div>'+
		'<ul class="pagination" id="pagination" style="float: right;">'+
			
		'</ul>'+
	'</div>'+
'</div>'+
'</div></div>';
	
	
	$('#listTable').after(pageStr);
	$('#pageCon').hide();
	$('#go').click(function(){
		var num=$('#num').val();
		if(num<=totalpage && num>0){
			$('#pagination').currentPage = num;
			$('#pagination').jqPaginator('refresh',{pageIndex:parseInt(num)});
		}
	})
}

function keyPress() {    
    var keyCode = event.keyCode;    
    if ((keyCode >= 48 && keyCode <= 57))    
   {    
        event.returnValue = true;    
    } else {    
          event.returnValue = false;    
   }    
}    