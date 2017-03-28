// JavaScript Document
DCampus.MemberListData = {
	_deleteThrLstSuccess : function(jsonObj){
	   $j("body").message({message:"删除成功"});
	   DCampus.MemberListUI._getMemberList();	 /**请求主题列表**/	
	   $j(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});
	},
	_deleteThrLstError : function(jsonObj){
	   alert(jsonObj.detail);
	},
	_DeleteFriendsSuccess : function(){
	   $j("body").message({message:"删除成功"});
	   $j(".container002").DCampusPaging("reflash");
	},
   _requestMembersListFail : function(){
	  window.location.href="index.jsp";
   }		
};
$j(function(){
    //DCampus.MemberListUI._getMemberList();
   /*模拟下拉框*/
   $j(".chooseType").bind("click",function(){
       if($j(".selectInput").find("ul").css("display") == "none") {
	      $j(".selectInput").find("ul").slideDown("fast");
	   } else {
	      $j(".selectInput").find("ul").slideUp("fast");
	   }
   })
   $j(".selectInput").find("ul").bind("mouseleave",function(){
	  $j(".selectInput").find("ul").slideUp("fast");													
   }).find("a").bind("click",function(){
	   $j(".selectInput span").text($j(this).text());   
	   $j(".selectInput").find("ul").slideUp("fast");
   });

	/**保存当前页数，刷新保留当前页**/		
	if(window.location.href.lastIndexOf("/p/") != -1) {
	   var locationNum = window.location.href.substring(window.location.href.lastIndexOf("/p/")+3);
	   DCampus.MemberListUI.pageNum = parseInt(locationNum);
	   DCampus.MemberListUI.isPaging = true;
	} 			
	$j(".container002").DCampusPaging({
	     "limit":DCampus.MemberListUI.limit             /** 显示条数默认20条    **/
	    ,"start":DCampus.MemberListUI.start              /** 开始位置 默认从0开始**/
	    ,"liststep":DCampus.MemberListUI.liststep          /** 分页显示长度 默认10 **/	
	    ,"pageNum":DCampus.MemberListUI.pageNum            /** 默认第一页开始      **/	
	    ,"pageCount":DCampus.MemberListUI.pageCount          /** 页数                **/
	    ,"totalCount":DCampus.MemberListUI.totalCount         /** 列表总数            **/
	    ,"listbegin":DCampus.MemberListUI.listbegin
	    ,"listend":DCampus.MemberListUI.listend							 
	    ,"RequestPath" : System.site+"/user/getMembersInGroup.action?temp="+Math.random()
		,"RequestData" : "groupId="+json.groupId
		,"PageJson":memberJSON
		,"isPaging":DCampus.MemberListUI.isPaging
		,"onBeforeStart":function(){
			$j(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});//关闭管理窗
			$j("#memberLst").hide();
			DCampus.Public.ShowLoading("container002","",0,100,0,System.site);//显示loading图标
	                      }
		 ,"onLoad" : function(jsonObj){
			               DCampus.Public.HideLoading("container002");
				            /**调用输出主题列表**/
		                   var _template = TrimPath.parseTemplate($j("#memberList_template").val());
		                   $j("#memberLst").html(_template.process(jsonObj));
						   $j("#memberLst").show();
						   $j(".slct-tbl").ListManage({hasTH:true,isListType:true,listBgColor:"#fff8bf",toolWrapID:"ManageToolWrap"});//select管理插件	
						   /**删除好友**/
						   $j(".deleteFriends").bind("click",function(){
							  if(confirm("是否删除该会员？")) {
								  DCampus.Public.AjaxRequestFunction(System.site+"/user/deleteMemberFromGroup.action","memberId="+$j(this).attr("id")+"&groupId="+json.groupId,"POST",DCampus.MemberListData._DeleteFriendsSuccess);
							  }
						   });							   
					 }
	});
});

DCampus.MemberListUI = {
	_isIntitalEditor : true,
	_defaultForumId : 0,
	limit : 20,//列表条数
	start : 0,//开始值
	liststep : 10,	
	pageNum : 0,	
	pageCount : 0,
	totalCount : 0,
	listbegin : 0,
	listend : 0,
	firstload : true,
	isPaging : false
};