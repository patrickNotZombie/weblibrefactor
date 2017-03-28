// JavaScript Document
DCampus.AuditMemberData = {
   _requestPassSuccess : function(){
       $j("body").message({message:"操作成功"});
	   $j(".container002").DCampusPaging("reflash");
   }	
}
$j(function(){
	/**
		请求列表
	**/
	if(window.location.href.lastIndexOf("/p/") != -1) {
	   var locationNum = window.location.href.substring(window.location.href.lastIndexOf("/p/")+3);
	   DCampus.AuditMemberUI.pageNum = parseInt(locationNum);
	   DCampus.AuditMemberUI.isPaging = true;
	} 			
	$j(".container002").DCampusPaging({
		 "limit":DCampus.AuditMemberUI.limit             /** 显示条数默认20条    **/
		,"start":DCampus.AuditMemberUI.start              /** 开始位置 默认从0开始**/
		,"liststep":DCampus.AuditMemberUI.liststep          /** 分页显示长度 默认10 **/	
		,"pageNum":DCampus.AuditMemberUI.pageNum            /** 默认第一页开始      **/	
		,"pageCount":DCampus.AuditMemberUI.pageCount          /** 页数                **/
		,"totalCount":DCampus.AuditMemberUI.totalCount         /** 列表总数            **/
		,"listbegin":DCampus.AuditMemberUI.listbegin
		,"listend":DCampus.AuditMemberUI.listend			
		,"PageJson":memberJson
		,"RequestPath" : System.site+"/user/getRequestingMembers.action?temp="+Math.random()
		,"RequestData" : "groupId="+DCampus.AuditMemberUI.mygroupId
		,"isPaging"  : DCampus.AuditMemberUI.isPaging
		,"onBeforeStart":function(){
			/*if(DCampus.AuditMemberUI.MANAGE_MEMBER_REQUEST) {
				$j(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});//关闭管理窗
			}*/
			$j("#members-lst").hide();
			DCampus.Public.ShowLoading("container002","",0,100,0,System.site);//显示loading图标
						  }
		 ,"onLoad" : function(jsonObj){
						   DCampus.Public.HideLoading("container002");
							/**调用输出主题列表**/
						   var _template = TrimPath.parseTemplate($j("#members_template").val());
						   $j("#members-lst").html(_template.process(jsonObj));
						   $j("#members-lst").show();
						   if($j.trim($j("#members-lst tbody").html()) == "") {
						      $j("#members-lst").html("暂没会员审核信息");
							  $j(".listInfoTableWrap").hide();
						   }
						   //select管理插件
						  /* if(DCampus.AuditMemberUI.MANAGE_MEMBER_REQUEST) {
							 $j(".table001 th").removeClass("displayNone");
							 $j(".table001 td").removeClass("displayNone");
							 $j(".slct-tbl").ListManage({hasTH:true,isListType:true,listBgColor:"#fff8bf",toolWrapID:"ManageToolWrap",isPop:false});
						   }*/
						   $j(".btn-pass").bind("click",function(){
								if(confirm("是否确认通过？")) {
		                        DCampus.Public.AjaxRequestFunction(System.site+"/user/passMemberRequest.action","groupId="+DCampus.AuditMemberUI.mygroupId+"&memberId="+$j(this).attr("id"),"POST",DCampus.AuditMemberData._requestPassSuccess);
								}
						   });
						   $j(".btn-not-pass").bind("click",function(){
						       if(confirm("是否确认不通过？")) {
							   DCampus.Public.AjaxRequestFunction(System.site+"/user/deleteMemberFromGroup.action","groupId="+DCampus.AuditMemberUI.mygroupId+"&memberId="+$j(this).attr("id"),"POST",DCampus.AuditMemberData._requestPassSuccess)
							   }
						   });
					 }
	});  			
})
DCampus.AuditMemberUI = {
	limit : 20,//列表条数
	start : 0,//开始值
	liststep : 10,	
	pageNum : 0,	
	pageCount : 0,
	totalCount : 0,
	listbegin : 0,
	listend : 0,
	mygroupId : 0,
	isPaging : false
}