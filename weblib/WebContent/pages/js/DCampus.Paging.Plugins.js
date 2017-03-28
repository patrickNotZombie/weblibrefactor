// JavaScript Document
(function($){
  var settings,AjaxRequestFunction,pageScrollFunction,requestThreadsListSuccess;		  
  $.fn.DCampusPaging = function(options) {
	    if(typeof(options) != "string") {
			settings = jQuery.extend({
			   limit:20             /** 显示条数默认20条**/
			  ,start:0              /** 开始位置 默认从0开始**/
			  ,liststep:10          /** 分页显示长度 默认10**/	
			  ,pageNum:0            /** 默认第一页开始**/	
			  ,pageCount:0          /** 页数**/
			  ,totalCount:0         /** 列表总数**/
			  ,listbegin:0
			  ,listend:0
			  ,PageJson : null
			  ,RequestPath : null
			  ,RequestData : null
			  ,RequestMethod : "POST"
			  ,isPaging : false
			  ,onBeforeStart:null /**执行分页查询前执行**/
			  ,onLoad : null /**执行分页的时候执行**/
			  ,onComplete : null /**完成分页时候执行**/
			  ,reflash : null
			}, options||{});      
		
			AjaxRequestFunction = function(url,param,method,jsonFunction,jsonErrorFunction){
				$j.ajax({
					 type: method,
					 url: url,
					 data: param,
					 dataType:"json",
					 success: function(json){
						jsonFunction(json);       
					 },
					 error : function(message) {
						 if(eval(jsonErrorFunction) != undefined) {
						   var json = eval('('+$j.trim(message.responseText)+')');
						   jsonErrorFunction(json);
						 } else {
							var json = eval('('+message.responseText+')');
							   alert(json.detail);
						 }
					 }
				  })  
			};
			pageScrollFunction = function(pageNum,parentID,reflash){
				settings.reflash = reflash;
				if(settings.onBeforeStart != null && typeof(settings.onBeforeStart) == "function") {
				  settings.onBeforeStart();
				}
				settings.pageNum = pageNum;
				settings.start = (settings.pageNum - 1) * settings.limit;
				if(settings.start < 0)
				settings.start = 0;
				if(settings.PageJson != null && !settings.isPaging) {
					 requestThreadsListSuccess(settings.PageJson);
					 settings.PageJson = null;
				} else {				
					if(settings.RequestPath != null && settings.RequestData != null) {
					  //上传附件专用参数
				      switch(reflash) {
					     case "next" : settings.RequestData = "parentId=" + parentID;settings.start=0;break;
						 case "back" : settings.RequestData = "parentId=" + parentID + "&back=true";settings.start=0;break;
						 case "Res-reflash" : settings.RequestData = "parentId=" + $j("#parentID").val();break;
					  }
					  AjaxRequestFunction(settings.RequestPath,settings.RequestData+"&start="+settings.start+"&limit="+settings.limit,settings.RequestMethod,requestThreadsListSuccess);					    
					} else {
					   alert("请输入请求地址或参数!");
					}	
				}
			};
			requestThreadsListSuccess = function(jsonObj){
					if(settings.onComplete != null && typeof(settings.onComplete) == "function") {
					   settings.onComplete(jsonObj);
					}				
			     	//资源分页
					if(typeof(options) == "string") {
						if(options.indexOf("resource_") == 0) {
							$("#goBack").attr("rel",jsonObj.parentId)
						}
					}
					if(settings.onLoad != null && typeof(settings.onLoad) == "function") {
					  settings.onLoad(jsonObj);
					}				
					
					
					
					$j(".totalCount").text(jsonObj.totalCount);
					settings.totalCount = jsonObj.totalCount;
					settings.pageCount = settings.totalCount / settings.limit;
					if (settings.pageCount * settings.limit < settings.totalCount) {
						settings.pageCount++;
					}
										

					if(settings.pageNum != 0) {
					 window.location.hash = "/p/"+settings.pageNum;
					}
					if(settings.pageNum > Math.ceil(settings.pageCount)) {
					   //return;
					}			
					if(settings.pageNum > 1) {
					  $j(".prePage").show();
					} else {
					  $j(".prePage").hide();
					}
					if(Math.ceil(settings.pageCount) > 1) {
					  $j(".nextPage").show();
					} else {
					  $j(".nextPage").hide();
					}	
					if(settings.pageNum ==  Math.ceil(settings.pageCount)) {//如果当前页等于最大页数，隐藏下一页
					   $j(".nextPage").hide();
					}
					if (settings.pageNum <= 0) {
						settings.pageNum = 1;
					}
					if (settings.pageNum > settings.pageCount && settings.pageCount > 0) {
						settings.pageNum = Math.ceil(settings.pageCount);
					}
					settings.start = (settings.pageNum - 1) * settings.limit;
					if (settings.start < 0) {
						settings.start = 0;
					}
					settings.listbegin = settings.pageNum - Math.ceil(settings.liststep / 2);//从第几页开始显示分页信息
					if (settings.listbegin < 1) {
						settings.listbegin = 1;
					}
					settings.listend = parseInt(settings.pageNum) + parseInt(settings.liststep / 2);
					if (settings.listend > settings.pageCount) {
						settings.listend = settings.pageCount + 1;
					}
					$j(".pageNumA").empty();
					for (var i = settings.listbegin; i < settings.listend; i++) {
					   var current = (i == settings.pageNum ? "class='currentPage'" : "");
					   $j(".pageNumA").append("<a "+current+" href='javascript:void(0)'>"+i+"</a> ")
					}		
					$j(".pageNumA a").bind("click",function(){
					   pageScrollFunction($j(this).text());
					});
					$j(".myThreadPagenum").text(settings.pageNum);
					$j(".myThreadpageCount").text(Math.ceil(settings.pageCount));	
					//webmail下拉分页
					 var __html = ""
                     var countPage = settings.pageCount;
					 if(countPage < 1) {
					   countPage = 1;
					 }
					 for(i=0;i<Math.ceil(countPage);i++) {
						__html += "<option value='"+(i+1)+"'>第 "+(i+1)+" 页</option>";
						$j(".pageSelect").html(__html);
					 }
					 
					 //if(settings.reflash != "next" || settings.reflash != "back") {
					if(typeof(settings.reflash) != "string") {
						setTimeout(function(){$j(".pageSelect option").attr("selected","");},1)					
						$.each($j(".pageSelect"),function(n,i){
							setTimeout(function(){$j(".pageSelect").eq(n).find("option").eq(settings.pageNum - 1).attr("selected","selected");},1)							
						});
					}
			}
			
    /**
		    分页事件
		**/
		$j(".nextPage").unbind().bind("click",function(){
			if (settings.pageNum < settings.pageCount) {
			   settings.pageNum = parseInt(settings.pageNum) + 1;
			   pageScrollFunction(settings.pageNum);
			}		
		});
		 $j(".prePage").unbind().bind("click",function(){
			  settings.pageNum = parseInt(settings.pageNum) - 1;
			  pageScrollFunction(settings.pageNum);
		 });	
		 $j(".go_botton").unbind().bind("click",function(){
			pageScrollFunction($j(this).parent().parent().parent().find(".pageInput").val());
			$j(".pageInput").val("");
		 });	
		 $j(".pageInput").unbind().bind("keypress",function(event){
			  if(event.keyCode == 13) {
				   $j(this).parent().parent().parent().find(".go_botton").trigger("click");
				   return false;
			  }
		 });	
          //webmail下拉分页
		  $j(".pageSelect").unbind().bind("change",function(){
			   pageScrollFunction($(this).val());
		  });
		  $(".firstPage").unbind().bind("click",function(){
			  	pageScrollFunction(1);								
		  });
		  $(".lastPage").unbind().bind("click",function(){
			  	pageScrollFunction(Math.ceil(settings.pageCount));								
		  });				
			
		};
		
		
		  
		 
		 /**
			 执行分页
		**/
		/**当options包含resource关键字时促发**/
	    if(typeof(options) == "string") {
			if(options.indexOf("resource") == 0) {
				var parentID = options.substring(options.indexOf(".")+1);
			   if(options.indexOf("resource_") == 0) {
			       pageScrollFunction(settings.pageNum,parentID,"back");
						   
			   } else {
				   pageScrollFunction(settings.pageNum,parentID,"next");
				   
			   }
			   return;
			}
		}
		
		if(typeof(options) != "string" || options == "reflash") {
		   pageScrollFunction(settings.pageNum);
		} else if (options == "Res-reflash") {
	       pageScrollFunction(settings.pageNum,"",options);
		}
		

   }
})(jQuery);





	
