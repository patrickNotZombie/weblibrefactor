// JavaScript Document
/**页面数据处理的方法集**/
DCampus.Login = (function(){
   return {
	     //登录成功
		_LoginSuccess : function(data){
		   $j(".loginWrap").hide();
		   $j(".chooseMaJiaWrap").fadeIn("slow");
		   /**调用输出马甲模板**/
		   var _template = TrimPath.parseTemplate($j("#majiaList_template").val());
		   $j("#showMaJiaList").html(_template.process(data));
		   DCampus.LoginUI._chooseMaJia();
		   /**回车登录**/
		   DCampus.Public.EnterListener($j(".putOnMaJia"));
		   DCampus.Public.HideLoading("loginWrap");
		},
		/**登录失败**/
		_LoginError : function(data){
		   $j("body").message({message:data.detail,warning:true});
		   DCampus.Public.HideLoading("loginWrap");
		   $j(".DCampus.Login-content").show();
		},
		/**披马甲成功调用**/
		_PutOnMaJiaSuccess : function(data){
			var jumpLink;
			var locationHref = window.location.href;
			if(locationHref.indexOf("#") != -1) {
				if(locationHref.split("#")[1] == "/create/") {
				   	jumpLink = System.site + "/pages/step01.jsp";
				} else {
		            jumpLink = 	System.site+ "/"+locationHref.substring(locationHref.indexOf("#")+1)+"/";
				}
				if(jumpLink == "") {
			       jumpLink = "personal.jsp";
				}
			} else {
		        jumpLink = "personal.jsp";
			}
			window.location.href= jumpLink;
		}
   }
})();

$j(function(){
	/**页面载入完毕执行的方法**/
	DCampus.LoginUI._pageLoaded();
	/**回车登录**/
	DCampus.Public.EnterListener($j(".submit"));
   /*选择马甲的事件*/
   $j(".chooseMaJiaWrap a").bind("click",function(){
	  $j(this).parent().parent().find("input:radio").attr("checked","true");
	  $j(".chooseMaJiaWrap a").removeClass("hoverMaJia");
	  $j(this).addClass("hoverMaJia");
   });
   $j("input:radio").bind("click",function(){
      $j(".chooseMaJiaWrap a").removeClass("hoverMaJia");
      $j(this).parent().parent().find("a").addClass("hoverMaJia");
   });
   /**登录事件**/
   $j(".submit").bind("click",function(){
	   //显示loading图标
	   DCampus.Public.ShowLoading("loginWrap","",299,0,0,System.site);
	   $j(".DCampus.Login-content").hide();
	   var username = encodeURIComponent($j("input[name='account']").val());
	   var password = encodeURIComponent($j("input[name='password']").val());
	   DCampus.Public.AjaxRequestFunction(System.site+"/login/authenticate.action","account="+username+"&password="+password,"POST",DCampus.Login._LoginSuccess,DCampus.Login._LoginError);
	});
   /**披马甲的事件**/
   $j(".putOnMaJia").bind("click",function(){
	   DCampus.Public.AjaxRequestFunction(System.site+"/login/selectMember.action","memberId="+$j(".maJiaListTable input:checked").val(),"POST",DCampus.Login._PutOnMaJiaSuccess);
   });
   $j(".cancel").bind("click",function(){
	  DCampus.Public.LogoutOut();
   })
});
/**页面UI处理方法结**/
DCampus.LoginUI = {
	/**页面载入完毕执行的方法**/
	_pageLoaded : function(){
	  $j("input[name='account']").focus();
	},
	_chooseMaJia : function(){
	   $j("input:radio").eq(0).attr("checked","true");
	   $j("input:radio").eq(0).focus();
	   $j(".maJiaListTable").find("a").eq(0).addClass("hoverMaJia").addClass("curentMaJia");
	   /*选择马甲的事件*/
	   $j(".maJiaListTable a").bind("click",function(){
		  $j(this).parent().parent().find("input:radio").focus();
		  $j(this).parent().parent().find("input:radio").attr("checked","true");
		  $j(".maJiaListTable a").removeClass("hoverMaJia").removeClass("curentMaJia");
		  $j(this).addClass("hoverMaJia").addClass("curentMaJia");
	   });
	   $j("input:radio").bind("click",function(){
		  $j(".maJiaListTable a").removeClass("hoverMaJia").removeClass("curentMaJia");
		  $j(this).parent().parent().find("a").addClass("hoverMaJia").addClass("curentMaJia");
	   });
	}
}