// JavaScript Document
function DCampusPaging(options) {
	            var me = this;
				me.settings = jQuery.extend({
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
				  ,pagingHandler : "pagebarTableWrap"
				  ,onBeforeStart:null /**执行分页查询前执行**/
				  ,onLoad : null /**执行分页的时候执行**/
				  ,onComplete : null /**完成分页时候执行**/
				  ,jsonErrorFunction : ""
				  ,reflash : null
				}, options||{});    
		
				
    
	me.AjaxRequestFunction = function(url,param,method,jsonFunction,jsonErrorFunction){
			jQuery.ajax({
				 type: method,
				 url: url,
				 data: param,
				 dataType:"json",
				 success: function(json){
					jsonFunction(json);       
				 },
				 error : function(message) {
					 if(typeof(jsonErrorFunction) == "function") {
					   var json = eval('('+jQuery.trim(message.responseText)+')');
					   jsonErrorFunction(json);
					 } else {
						var json = eval('('+message.responseText+')');
						   alert(json.detail);
					 }
				 }
			  })  
		};
		me.pageScrollFunction = function(pageNum,param){
			if(me.settings.onBeforeStart != null && typeof(me.settings.onBeforeStart) == "function") {
			  me.settings.onBeforeStart();
			}
			me.settings.pageNum = pageNum;
			me.settings.start = (me.settings.pageNum - 1) * me.settings.limit;
			if(me.settings.start < 0)
			me.settings.start = 0;
			if(me.settings.PageJson != null && me.settings.isPaging) {
				 me.requestThreadsListSuccess(me.settings.PageJson);
				 me.settings.PageJson = null;
			} else {				
                  if(param != null) {
				    me.settings.RequestData = param+"&";
				  } else {
					  me.settings.RequestData = me.settings.RequestData + "&";
				  }
				  me.AjaxRequestFunction(me.settings.RequestPath,me.settings.RequestData+"start="+me.settings.start+"&limit="+me.settings.limit+"&site="+System.site,me.settings.RequestMethod,me.requestThreadsListSuccess);					    
		
			}
		}
		me.requestThreadsListSuccess = function(jsonObj){
				if(me.settings.onComplete!=null&&typeof(me.settings.onComplete)=="function")
				{
					me.settings.onComplete(jsonObj)
				};
				if(me.settings.onLoad!=null&&typeof(me.settings.onLoad)=="function"){
					me.settings.onLoad(jsonObj)
				};
				jQuery(".totalCount").text(jsonObj.totalCount);
				me.settings.totalCount=jsonObj.totalCount;
				me.settings.pageCount=me.settings.totalCount/me.settings.limit;
				if(me.settings.pageCount*me.settings.limit<me.settings.totalCount){
					me.settings.pageCount++
				};
				if(me.settings.pageNum!=0){
					window.location.hash="/p/"+me.settings.pageNum
				};
				
				if(me.settings.pageNum > 1) {
				  jQuery("." + me.settings.pagingHandler + " .prePage").show();
				} else {
				  jQuery("." + me.settings.pagingHandler + " .prePage").hide();
				}
				if(Math.ceil(me.settings.pageCount) > 1) {
				  jQuery("." + me.settings.pagingHandler + " .nextPage").show();
				} else {
				  jQuery("." + me.settings.pagingHandler + " .nextPage").hide();
				}	
				if(me.settings.pageNum ==  Math.ceil(me.settings.pageCount)) {//如果当前页等于最大页数，隐藏下一页
				   jQuery("." + me.settings.pagingHandler + " .nextPage").hide();
				}
				if(me.settings.pageNum<=0){
					me.settings.pageNum=1
				};
				if(me.settings.pageNum>me.settings.pageCount&&me.settings.pageCount>0){
					me.settings.pageNum=Math.ceil(me.settings.pageCount)
				};
				me.settings.start=(me.settings.pageNum-1)*me.settings.limit;
				if(me.settings.start<0){
					me.settings.start=0
				};
				me.settings.listbegin=me.settings.pageNum-Math.ceil(me.settings.liststep/2);
				if(me.settings.listbegin<1){
					me.settings.listbegin=1
				};
				me.settings.listend=parseInt(me.settings.pageNum)+parseInt(me.settings.liststep/2);
				
				if(me.settings.listend>me.settings.pageCount){
					me.settings.listend=me.settings.pageCount+1
				};
				jQuery("." + me.settings.pagingHandler + " .pageNumA").empty();
				for(var i=me.settings.listbegin;i<me.settings.listend;i++){
					var current=(i==me.settings.pageNum?"class='currentPage'":"");
					jQuery("." + me.settings.pagingHandler + " .pageNumA").append("<a "+current+" href='javascript:void(0)'>"+i+"</a> ")
				};
				jQuery("." + me.settings.pagingHandler + " .pageNumA a").unbind("click").bind("click",function(){
					me.pageScrollFunction(jQuery(this).text(),me.settings.RequestData)
				});
				jQuery("." + me.settings.pagingHandler + " .myThreadPagenum").text(me.settings.pageNum);
				jQuery("." + me.settings.pagingHandler + " .myThreadpageCount").text(Math.ceil(me.settings.pageCount));
				jQuery("."+me.settings.pagingHandler).unbind("click").bind("click",function(e){
					  var target = jQuery(e.target);
					  if(target.is(".nextPage")) {
						if (me.settings.pageNum < me.settings.pageCount) {
						   me.settings.pageNum = me.settings.pageNum + 1;
						   me.pageScrollFunction(me.settings.pageNum,me.settings.RequestData);
						}	
					  }
					  if(target.is(".prePage")) {
						  me.settings.pageNum = me.settings.pageNum - 1;
						  me.pageScrollFunction(me.settings.pageNum,me.settings.RequestData);
					  }
				});
				 jQuery(".go_botton").unbind("click").bind("click",function(){
					me.pageScrollFunction(jQuery(this).parent().parent().parent().find(".pageInput").val(),me.settings.RequestData);
					jQuery(".pageInput").val("");
				 });	
				 jQuery(".pageInput").unbind("keypress").bind("keypress",function(event){
					  if(event.keyCode == 13) {
						   jQuery(this).parent().parent().parent().find(".go_botton").trigger("click");
						   return false;
					  }
				 });	
			
				  $(".firstPage").unbind("click").bind("click",function(){
						me.pageScrollFunction(1,me.settings.RequestData);								
				  });
				  $(".lastPage").unbind("click").bind("click",function(){
						me.pageScrollFunction(Math.ceil(me.settings.pageCount),me.settings.RequestData);								
				  });					
	}
	  
	  
	 /**
		 执行分页
	**/
	/**当options包含resource关键字时促发**/
	me.doFlash = function(param,num){
		 if(typeof(num) != "undefined") {
             me.settings.pageNum = num;
		 } else {
		    me.settings.pageNum = me.settings.pageNum;
	     }
		    me.pageScrollFunction(me.settings.pageNum,param);	
	     
	}	
    me.doFlash("",1);
	
}	

  
	  




	
