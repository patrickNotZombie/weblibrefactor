// JavaScript Document
var outerLayout, middleLayout, innerLayout; 
$(function(){
        outerLayout = $('body').layout({ 
			center__paneSelector:	".outer-center" 
		,	west__paneSelector:		".outer-west" 
		,	west__size:				146 
		,   north__size:             59
		,	spacing_open:			0 // ALL panes
		,	spacing_closed:			0 // ALL panes
		,	center__onresize:		"middleLayout.resizeAll" 
		}); 

		middleLayout = $('div.outer-center').layout({ 
			center__paneSelector:	".middle-center"
		,	center__onresize:		"innerLayout.resizeAll" 
		}); 

		innerLayout = $('div.middle-center').layout({ 
			center__paneSelector:	".inner-center" 
		,   resizable : true
		,	spacing_open:			0  // ALL panes
		,	spacing_closed:			0  // ALL panes
		}); 
		   

	   $(".siteMap").click(function(){
                if($("#siteMap").css("display")=="none"){
					$("#siteMap").fadeIn("slow");
				}else {
					$("#siteMap").fadeOut("slow");
				 }  
	   });
	   
	  $(".contentMapWrap").find("td").hover(function(){$(this).addClass("tdHover")},function(){$(this).removeClass("tdHover")});
      $(".subMenu").find("li").bind("click",function(){
	    var _this =$(this);
		_this.siblings().find("a").removeClass("subOn");
		_this.find("a").addClass("subOn");
	  });
	  
	var myLayout = $('body').layout({ 	 
		applyDefaultStyles: true ,
		closable:false,
		spacing_open:0,
		north__size:59,
		north__paneClass:"north",
		west__size:146,
		center__maskIframesOnResize: "#dcampusFrame",
		west__paneClass:"west",
		center__paneClass:"center"
	});   
	setTimeout(function(){
	  mainUI._layoutResize();  
	},100);
	
	$(window).resize(function(){
	  mainUI._layoutResize();
	})
	mainUI._isCompleteLoadingFrame("dcampusFrame");
	//$("iframe").attr({src:"teacherInfo/personalInfo.html"});
	$(window.document).keydown(function(event){	
	  switch(event.keyCode) {
		 case 27 :if($("#siteMap").css("display")=="none"){
					   $("#siteMap").fadeIn("slow");
				   }else {
						       $("#siteMap").fadeOut("slow");
					 };break;
	  }
	}); 
	$(".menu li").bind("click",function(){
	   $(this).siblings().find("a").removeClass("tab_on");
	   $(this).find("a").addClass("tab_on");	
	   _thisRel = $(this).attr("rel");
	  // _index = $(".menu li").index(this);
	   $(".west").find("ul").addClass("displayNone");
	    $(".subMenu[rel='"+_thisRel+"']").removeClass("displayNone").find("a").eq(0).click();
	});
	$("#logotOut").bind("click",function(){
	   if(confirm("是否退出？")) {
	      mainUI._AjaxRequestFunction(System.site+"/login/logout.action","","POST",mainUI._LogoutSuccess);
	   }									 
	})
	setInterval(function(){mainUI._AjaxRequestFunction(System.site+"/user/alive.action","","POST",function(){},function(){});},60000);
});


var mainUI = {
   _layoutResize : function() {
	 setTimeout(function(){$("iframe").width($(".center").width()-20);},100);
	 $("#coverDiv").width($(window).width()+20).height($(window).height());
	 $("#siteMap").css({top:$(window).width()/10,left:$(window).height()/2});
   },
   
  
	_isCompleteLoadingFrame : function (_frame) {
 		var _getheightAndWidth = function(){
		  	var _height = $("#"+_frame.id).contents().find("body").height()+80;
			$("#"+_frame.id).height(_height);
			$("iframe").width($(".center").width()-20);
		}
	
		if($.browser.msie) {
			 if (_frame.readyState=="complete")
			 { 
			  _getheightAndWidth();
			 }   
		}else{
              _getheightAndWidth();
			  
		 }
		 
	},
	_AjaxRequestFunction : function(url,param,method,jsonFunction,jsonErrorFunction){
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
	_LogoutSuccess : function(){
	    location.href = System.site+"/manager/login.jsp";
	}

}