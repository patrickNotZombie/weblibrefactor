// JavaScript Document
var DCampus = {};
DCampus.Public = {
 	/**异步请求返回json的方法**/
	AjaxRequestFunction : function(url,param,method,jsonFunction,jsonErrorFunction){
		$.ajax({
			 type: method,
			 url: url,
			 data: param,
			 dataType:"json",
			 success: function(json){
				jsonFunction(json);       
			 },
			 error : function(message) {
				 if(eval(jsonErrorFunction) != undefined) {
				   var json = eval('('+$.trim(message.responseText)+')');
				   jsonErrorFunction(json);
				 } else {
					var json = eval('('+message.responseText+')');
					alert(json.detail);
				 }
			 }
		  })  
	},
	ResizeIframeHeight : function(_iframe,_height){
	    _iframe.height(_height);
	},
    Dialog : function(DialogObj,Title,Width,Height,openFunction,closeFunction,onLoadFunction){
		DialogObj = $("#"+DialogObj);
		var _height;
		var Left = ($(window).width() - Width)/2 + "px";
		var Top = ($(window).height()- Height - 90)/2 + document.documentElement.scrollTop + "px";
		if($(window).height() > $(window.document.body).height()) {
		  	_height = $(window).height();
		} else {
			_height = $(window.document.body).height();
		}
		DialogObj.before("<div class='transparentCover'></div>");
		$(".transparentCover").css({"width":$(window.document.body).width()+"px","height":_height+"px"});
		$(window).resize(function(){
			if($(window).height() > $(window.document.body).height()) {
				_height = $(window).height() + "px";
			} else {
				_height = $(window.document.body).height() + "px";
			}								  
			$(".transparentCover").width($(window.document.body).width()).height(_height);
			DialogObj.css({"left":($(window).width() - Width)/2 + "px","top":($(window).height()- Height - 90)/2 + document.documentElement.scrollTop + "px"});					  
		});
		if(DialogObj.css("display") == "none") {
		  DialogObj.removeClass("displayNone");
		}
		if(typeof(onLoadFunction) == "function") {
		   onLoadFunction();
		}
		if(DialogObj.find(".ui-dialog-title").text() == "") {
			if(typeof(openFunction) == "function") {
			  openFunction();
			}
			//首次初始化对话框的时候设置对话框的属性
			DialogObj.css({"position":"absolute","left":Left,"z-index":1001});
			DialogObj.width(Width);
			DialogObj.find(".ui-dialog-content").height(Height);
			DialogObj.find(".ui-dialog-titlebar-close").hover(function(){$(this).addClass("ui-state-hover")},function(){$(this).removeClass("ui-state-hover")})
			DialogObj.find(".ui-icon-closethick").bind("click",function(){
				DialogObj.addClass("displayNone");
				$(".transparentCover").remove();
				if(typeof(closeFunction) == "function") {
				  closeFunction();
				}
			});
			DialogObj.find(".dialog-btn-cancel").bind("click",function(){
				DialogObj.addClass("displayNone");
				$(".transparentCover").remove();
				if(typeof(closeFunction) == "function") {
				  closeFunction();
				}				
			});
			DialogObj.draggable({ handle:'.ui-dialog-titlebar',scroll:false,containment:'body'});
		}
		DialogObj.find(".ui-dialog-title").text(Title);
		DialogObj.css({"top":Top});
	},
	CloseDialog : function(DialogObj,closeFunction){
	  DialogObj = $("#"+DialogObj);
	  DialogObj.addClass("displayNone");
	  $(".transparentCover").remove();
	  if(typeof(closeFunction) == "function") {
		 closeFunction();
	  }	  
	},
	
	/**ajax loading**/
	ShowLoading : function(obj,bgColor,Width,Height,isAbsolute,path){//参数说明：obj：class名称/bgColor:背景颜色/Width:宽度(默认100%)/Height:高度(默认100%)/isAbsolute(是否绝对定位0是绝对，其它是相对)
		if(Width == 0)
		Width = $("."+obj).width();
		if(Height == 0)
		Height = $("."+obj).height();
		if(isAbsolute == 0) {
		   isAbsolute = "absolute"; 
		} else {
		   isAbsolute = "relative";	
		}
		var Left = (Width - 28) / 2;
		var Top = (Height - 28) / 2;
	   $("."+obj).addClass("position-relative");
	   $("."+obj).append("<div class='loading' style='z-index:1000;top:0;left:0;position:"+isAbsolute+";background:"+bgColor+";width:"+Width+"px;height:"+Height+"px'><img src='"+path+"/themes/default/images/ajax-loader.gif' style='position:absolute;z-index:1001;top:"+Top+"px;left:"+Left+"px;'/></div>");
	},
	HideLoading : function(obj){
	   $("."+obj).find(".loading").remove();
	}	
	
}



/**插件**/
;(function($){
/**多选单选以及管理窗口的插件**/
$.fn.ListManage = function(options) {
    var __this = $(this);
	var __wrapObject = null;
	var options = jQuery.extend({
      hasTH:false,//是否有th
	  isListType : false,//是否列表形式
	  listBgColor:"",//选中列表颜色
	  toolWrapID:"",//同时出现的manage管理工具栏
      close : false,
	  toggle : null,
	  callback:function(){}//回调方法
    }, options||{});
	__this.find("a").bind("click",function(e){
	      e.stopPropagation();
	});
	if(options.toolWrapID != "") {
	   __wrapObject = $("."+options.toolWrapID);
	}
	if(options.close) {
	   __wrapObject.hide();
	   return;
	}
	if(options.hasTH) {
	  __this.find("th :checkbox").bind("click",function(e){//全选
		 if(options.toolWrapID != "") {
		    __wrapObject.find(".num").text(__this.find("td :checkbox").length);	
		 }
		 if($(this).attr("checked") != true) {
			__this.find("td :checkbox").attr("checked","");
			if(options.isListType && options.listBgColor != "") {
                 __this.find("td").css("background","");  
			}
			 if(options.toolWrapID != "") {
			   __wrapObject.hide();
			 }				
		 } else {
		    __this.find("td :checkbox").attr("checked","true");
			if(options.isListType && options.listBgColor != "") {
                __this.find("td").css("background",options.listBgColor); 
			}
			 if(options.toolWrapID != "") {
			   __wrapObject.show().css({"top":e.pageY,"left":e.pageX+10});
			 }				
		 }
	  })
	};
	__this.find("td :checkbox").bind("click",function(e){//checkbox选择
		if(options.toolWrapID != "") {											  
		   __wrapObject.find(".num").text(__this.find("td :checked").length);		
		}
	   if(__this.find("td :checked").length == __this.find("td :checkbox").length) {
	     __this.find("th :checkbox").attr("checked","true");
	   }
       if($(this).attr("checked") == false) {
	      __this.find("th :checkbox").attr("checked","");
		  $(this).parent().parent().find("td").css("background","");
		 if(options.toolWrapID != "" && __this.find("td :checkbox:checked").length < 1) {
		   __wrapObject.hide();
		 }		  
	   } else {
		  $(this).parent().parent().find("td").css("background",options.listBgColor);
		 /**如果有工具框架**/
		 if(options.toolWrapID != "") {
		   if(e.pageX + __wrapObject.width() > __this.width()) {
			   __wrapObject.show().css({"top":e.pageY + 20,"left":e.pageX+10 - __wrapObject.width()});
		   } else {
			   __wrapObject.show().css({"top":e.pageY + 20,"left":e.pageX+10});
		   }	
		 }		  
	   }
	   e.stopPropagation();//防止event冒泡
	});
	if(options.isListType) {//TD也可选择
	   var toggleObject = null;
       if(options.toggle != null) {
		   toggleObject = $("."+options.toggle);
	   } else {
		   toggleObject = __this.find("td");
	   }
	   toggleObject.bind("click",function(e){
	       var __parent = $(this).parent();
		   if(__parent.find(":checkbox").attr("checked") == false) {
			  __parent.find(":checkbox").attr("checked","true");
			  if(options.toolWrapID != "") {
			  __wrapObject.find(".num").text(__this.find("td :checked").length);
			  }
			  __parent.find("td").css("background",options.listBgColor);
				 if(options.toolWrapID != "") {
				   if(e.pageX + __wrapObject.width() > __this.width()) {
					   __wrapObject.show().css({"top":e.pageY + 20,"left":e.pageX+10 - __wrapObject.width()});
				   } else {
				       __wrapObject.show().css({"top":e.pageY + 20,"left":e.pageX+10});
				   }			   
				 }						  
		   } else {
				 if(options.toolWrapID != "" && __this.find("td :checkbox:checked").length == 1) {
				   __wrapObject.hide();
				 }	
			     __parent.find(":checkbox").attr("checked","");
			     __this.find("th :checkbox").attr("checked","");
			     __parent.find("td").css("background","");
				 if(options.toolWrapID != "") {
				 __wrapObject.find(".num").text(__this.find("td :checked").length);
				 }
		   }	
		   if(__this.find("td :checked").length == __this.find("td :checkbox").length) {
			 __this.find("th :checkbox").attr("checked","true");
		   }		   
	   });
	}
	/**如果有回调方法**/
	if(typeof(options.callback)=="function"){
	  options.callback();
	}else {
	  alert("not function!");
	}
}
})(jQuery);