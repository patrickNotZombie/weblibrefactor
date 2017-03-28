// JavaScript Document
var $j = jQuery.noConflict();
var DCampus = {}; //定义命名规范
DCampus._LogoutSuccess = function(){
    window.location.href = System.site+ "/pages/login.jsp";
};

/**公共方法**/
DCampus.Public = {
	/**异步请求返回json的方法**/
	AjaxRequestFunction : function(url,param,method,jsonFunction,jsonErrorFunction){
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
					   //var json = eval('('+$j.trim(message.responseText)+')');
					   var json = jQuery.parseJSON(message.responseText);
					   jsonErrorFunction(json);
					 } else {
						//var json = eval('('+message.responseText+')');
						var json = jQuery.parseJSON(message.responseText);
						$j("body").message({message:json.detail,warning:true});
					 }
				 }
			  })
	},

	/**监听回车事件**/
	EnterListener : function(Obj){
		$j("input").bind("keydown",function(event){
		   if(event.keyCode == 13) {
			  var _this = $j(this).attr("type");
			  if(_this == "button" || _this == "submit") {
				  return;
			  } else {
				  Obj.trigger("click");
			  }
		   }
		});
	},
	/**退出圈子**/
	LogoutOut : function(){
		DCampus.Public.AjaxRequestFunction(System.site+ "/login/logout.action","","POST",DCampus._LogoutSuccess);
	},
	/**对话框的方法**/
	Dialog : function(options){
		var settings = jQuery.extend({
			handler : ""
		   ,title : "新建窗口"
		   ,width : 400
		   ,height : 100
		   ,close : false
		   ,openFunction : function(){}
		   ,closeFunction : function(){}
		   ,onLoadFunction : function(){}
		}, options||{});	
		if (!settings.close) {
			DialogObj = $j("#"+settings.handler);
			var _height;
			var Left = ($j(window).width() - settings.width)/2 + "px";
			var Top = ($j(window).height()- settings.height - 90)/2 + document.documentElement.scrollTop + "px";
			if($j(window).height() > $j(window.document.body).height()) {
				_height = $j(window).height();
			} else {
				_height = $j(window.document.body).height();
			}
			DialogObj.before("<div class='transparentCover'></div>");
			$j(".transparentCover").css({"width":$j(window.document.body).width()+"px","height":_height+"px"});
			$j(window).resize(function(){
				if($j(window).height() > $j(window.document.body).height()) {
					_height = $j(window).height() + "px";
				} else {
					_height = $j(window.document.body).height() + "px";
				}
				$j(".transparentCover").width($j(window.document.body).width()).height(_height);
				DialogObj.css({"left":($j(window).width() - settings.width)/2 + "px","top":($j(window).height()- settings.height - 90)/2 + document.documentElement.scrollTop + "px"});
			});
			if(DialogObj.css("display") == "none") {
			  DialogObj.removeClass("displayNone");
			}
			if(typeof(settings.onLoadFunction) == "function") {
			   settings.onLoadFunction();
			}
			if(DialogObj.find(".ui-dialog-title").text() == "") {
				if(typeof(settings.openFunction) == "function") {
				  settings.openFunction();
				}
				//首次初始化对话框的时候设置对话框的属性
				DialogObj.css({"position":"absolute","left":Left,"z-index":1001});
				DialogObj.width(settings.width);
				DialogObj.find(".ui-dialog-content").height(settings.height);
				DialogObj.find(".ui-dialog-titlebar-close").hover(function(){$j(this).addClass("ui-state-hover")},function(){$j(this).removeClass("ui-state-hover")});
				DialogObj.find(".ui-icon-closethick").bind("click",function(){
					DialogObj.addClass("displayNone");
					$j(".transparentCover").remove();
					if(typeof(settings.closeFunction) == "function") {
					  settings.closeFunction();
					}
				});
				DialogObj.find(".dialog-btn-cancel").bind("click",function(){
					DialogObj.addClass("displayNone");
					$j(".transparentCover").remove();
					if(typeof(settings.closeFunction) == "function") {
					  settings.closeFunction();
					}
				});
				DialogObj.draggable({ handle:'.ui-dialog-titlebar',scroll:false,containment:'body'});
			}
			DialogObj.find(".ui-dialog-title").text(settings.title);
			DialogObj.css({"top":Top});
		} else {
			  DialogObj = $j("#"+settings.handler);
			  DialogObj.addClass("displayNone");
			  $j(".transparentCover").remove();
			  if(typeof(settings.closeFunction) == "function") {
				 settings.closeFunction();
			  }		
		}
	},
	/**ajax loading**/
	ShowLoading : function(obj,bgColor,Width,Height,isAbsolute,path){//参数说明：obj：class名称/bgColor:背景颜色/Width:宽度(默认100%)/Height:高度(默认100%)/isAbsolute(是否绝对定位0是绝对，其它是相对)
	    if(Width == 0)
		Width = $j("."+obj).width();
		if(Height == 0)
		Height = $j("."+obj).height();
		if(isAbsolute == 0) {
		   isAbsolute = "absolute";
		} else {
		   isAbsolute = "relative";
		}
		var Left = (Width - 28) / 2;
		var Top = (Height - 28) / 2;
	   $j("."+obj).addClass("position-relative");
	   $j("."+obj).append("<div class='loading' style='z-index:1000;top:0;left:0;position:"+isAbsolute+";background:"+bgColor+";width:"+Width+"px;height:"+Height+"px'><img src='"+path+"/themes/default/images/ajax-loader.gif' style='position:absolute;z-index:1001;top:"+Top+"px;left:"+Left+"px;'/></div>");
	},
	HideLoading : function(obj){
	   $j("."+obj).find(".loading").remove();
	},
	 /**【Tab的方法】
	 参数说明：
	   mouse_event:鼠标事件类型
	   handle:绑定的句柄
	   tabWrap:tab的内容的框框对象
	   method:执行tab事件的时候触发的函数，默认不执行
	   contentEnable:是否切换content的内容
    **/
	tabFunction : function(mouse_event,handle,tabWrap,method,contentEnable){
		  if(typeof(contentEnable) == "undefined") {
		      contentEnable = true;
		  }
		  $j(handle).find("a").bind(mouse_event,function(){
				var __index = $j(handle).find("a").index(this);
				if(contentEnable) {
					$j(tabWrap).children().hide();
					$j(tabWrap+__index).show();
				}
				$j(this).blur();
				if(typeof(method) == "function") {
					  method($j(this));
				}
		  });
	},
	/**
	   计算Iframe高度
	**/
	setIFrameHeight : function(iframeObj,childHeight){
	    $j(iframeObj).height(childHeight);
	},
	ListHover : function(options) {
	var settings = jQuery.extend({
        handler : ""
	   ,cssName : ""
	   ,oprtText : false
	   ,callback : ""
    }, options||{});
	   if(settings.handler != "") {
		   settings.handler.bind("mouseover",function(e){
				var target = $j(e.target);
				var tdObj = target.parent().find("td");
				if(target.is("a") || target.is("p") || target.is("span") && !target.is("div") ) {
					tdObj = target.parent().parent().find("td");
				}
				if(target.parent().is(".oprtText")) {
				   tdObj = target.parent().parent().parent().find("td");
				}
			   settings.handler.find("td").removeClass(settings.cssName);
			   tdObj.addClass(settings.cssName);
			   if(settings.oprtText) {
				   if(!target.parent().is(".oprtText")) {
					$j(".oprtText").empty();
					var downloadText = "";
					if(tdObj.find(".resourceName").attr("type") == 1) {
                        downloadText = "打包下载";
					} else {
					    downloadText = "下载";
					}
                     tdObj.find(".oprtText").append("[ <a href='javascript:void(0)' id='dlPack'>"+downloadText+"</a> | <a href='javascript:void(0)' class='btn-rename'>改名</a> | <a href='javascript:void(0)' class='btn-rename'>备注</a> ]");
					 if(typeof(settings.callback) == "function") {
					    settings.callback();
					 }
				   }
			   }
		   }).bind("mouseleave",function(){
			   settings.handler.find("td").removeClass(settings.cssName);
			   $j(".oprtText").empty();
		   });
	   }
	}
};

/**插件**/
(function($){
/**多选单选以及管理窗口的插件**/
$.fn.ListManage = function(options) {
    var __this = $(this);
	var __wrapObject = "";
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
		 __this.find(".num").text(__this.find("td :checkbox").length);
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
			   __wrapObject.show().css({"top":e.pageY,"left":e.pageX+50});
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
	   if(options.toolWrapID != "")
	   __wrapObject.find(".num").text(__this.find("td :checked").length);
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
			   __wrapObject.show().css({"top":e.pageY + 20,"left":e.pageX+50 - __wrapObject.width()});
		   } else {
			   __wrapObject.show().css({"top":e.pageY + 20,"left":e.pageX+50});
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
			  if(options.toolWrapID != "")
			  __wrapObject.find(".num").text(__this.find("td :checked").length);
			  __parent.find("td").css("background",options.listBgColor);
				 if(options.toolWrapID != "") {
				   if(e.pageX + __wrapObject.width() > __this.width()) {
					   __wrapObject.show().css({"top":e.pageY + 20,"left":e.pageX+50 - __wrapObject.width()});
				   } else {
				       __wrapObject.show().css({"top":e.pageY + 20,"left":e.pageX+50});
				   }
				 }
		   } else {
				 if(options.toolWrapID != "" && __this.find("td :checkbox:checked").length == 1) {
				   __wrapObject.hide();
				 }
			     __parent.find(":checkbox").attr("checked","");
			     __this.find("th :checkbox").attr("checked","");
			     __parent.find("td").css("background","");
				 if(options.toolWrapID != "")
				 __wrapObject.find(".num").text(__this.find("td :checked").length);
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
	  $j("body").message({message:"not function",warning:true});
	}
}
})(jQuery);

(function($){
   $.fn.message = function(options) {
		var settings = jQuery.extend({
		  message : "",
		  top : "",
		  warning : false
		}, options||{});
		if(settings.message == "") {
		  settings.message = "未知错误";
		}
		  if($j("#messageWrap").length != 0) {
		     $j("#messageTD").html(settings.message);
			 $j("#messageBox").fadeIn("fast");
				if(settings.warning) {
				   $j("#messageBox").addClass("error");
				} else {
				   $j("#messageBox").removeClass("error");
				}	 
		  } else {
 	 	    $j(this).append("<div id='messageWrap'><div id='messageBox' class='displayNone'><table><tr><td id='messageTD'>"+settings.message+"</td></tr></table></div></div>");
			$j("#messageBox").css({"left":$j(window).width()/2 - $j("#messageBox").width()+"px"});
			if(settings.top != "") {
			  //$j("#messageBox").css({top:document.scrollTop.body});
			}
			if(settings.warning) {
			   $j("#messageBox").addClass("error");
			} else {
			   $j("#messageBox").removeClass("error");
			}	
			$j("#messageBox").fadeIn("fast");
		  }
		  if($j.browser.version == "6.0") {		  
			$j("#messageWrap").pngFix();
		  }
		  setTimeout(function(){
		     $j("#messageBox").fadeOut("fast");
		  },2000)
   }  
})(jQuery);

if($j.browser.version == "6.0") {
eval(function(p,a,c,k,e,r){e=function(c){return(c<62?'':e(parseInt(c/62)))+((c=c%62)>35?String.fromCharCode(c+29):c.toString(36))};if('0'.replace(0,e)==0){while(c--)r[e(c)]=k[c];k=[function(e){return r[e]||e}];e=function(){return'([237-9n-zA-Z]|1\\w)'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('(s(m){3.fn.pngFix=s(c){c=3.extend({P:\'blank.gif\'},c);8 e=(o.Q=="t R S"&&T(o.u)==4&&o.u.A("U 5.5")!=-1);8 f=(o.Q=="t R S"&&T(o.u)==4&&o.u.A("U 6.0")!=-1);p(3.browser.msie&&(e||f)){3(2).B("img[n$=.C]").D(s(){3(2).7(\'q\',3(2).q());3(2).7(\'r\',3(2).r());8 a=\'\';8 b=\'\';8 g=(3(2).7(\'E\'))?\'E="\'+3(2).7(\'E\')+\'" \':\'\';8 h=(3(2).7(\'F\'))?\'F="\'+3(2).7(\'F\')+\'" \':\'\';8 i=(3(2).7(\'G\'))?\'G="\'+3(2).7(\'G\')+\'" \':\'\';8 j=(3(2).7(\'H\'))?\'H="\'+3(2).7(\'H\')+\'" \':\'\';8 k=(3(2).7(\'V\'))?\'float:\'+3(2).7(\'V\')+\';\':\'\';8 d=(3(2).parent().7(\'href\'))?\'cursor:hand;\':\'\';p(2.9.v){a+=\'v:\'+2.9.v+\';\';2.9.v=\'\'}p(2.9.w){a+=\'w:\'+2.9.w+\';\';2.9.w=\'\'}p(2.9.x){a+=\'x:\'+2.9.x+\';\';2.9.x=\'\'}8 l=(2.9.cssText);b+=\'<y \'+g+h+i+j;b+=\'9="W:X;white-space:pre-line;Y:Z-10;I:transparent;\'+k+d;b+=\'q:\'+3(2).q()+\'z;r:\'+3(2).r()+\'z;\';b+=\'J:K:L.t.M(n=\\\'\'+3(2).7(\'n\')+\'\\\', N=\\\'O\\\');\';b+=l+\'"></y>\';p(a!=\'\'){b=\'<y 9="W:X;Y:Z-10;\'+a+d+\'q:\'+3(2).q()+\'z;r:\'+3(2).r()+\'z;">\'+b+\'</y>\'}3(2).hide();3(2).after(b)});3(2).B("*").D(s(){8 a=3(2).11(\'I-12\');p(a.A(".C")!=-1){8 b=a.13(\'url("\')[1].13(\'")\')[0];3(2).11(\'I-12\',\'none\');3(2).14(0).15.J="K:L.t.M(n=\'"+b+"\',N=\'O\')"}});3(2).B("input[n$=.C]").D(s(){8 a=3(2).7(\'n\');3(2).14(0).15.J=\'K:L.t.M(n=\\\'\'+a+\'\\\', N=\\\'O\\\');\';3(2).7(\'n\',c.P)})}return 3}})(3);',[],68,'||this|jQuery||||attr|var|style||||||||||||||src|navigator|if|width|height|function|Microsoft|appVersion|border|padding|margin|span|px|indexOf|find|png|each|id|class|title|alt|background|filter|progid|DXImageTransform|AlphaImageLoader|sizingMethod|scale|blankgif|appName|Internet|Explorer|parseInt|MSIE|align|position|relative|display|inline|block|css|image|split|get|runtimeStyle'.split('|'),0,{}));
}