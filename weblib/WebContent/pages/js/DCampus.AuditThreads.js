// JavaScript Document
DCampus.AuditThreadsData = {
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
	   DCampus.AuditThreadsUI.pageNum = parseInt(locationNum);
	   DCampus.AuditThreadsUI.isPaging = true;
	} 			
	$j(".container002").DCampusPaging({
		 "limit":DCampus.AuditThreadsUI.limit             /** 显示条数默认20条    **/
		,"start":DCampus.AuditThreadsUI.start              /** 开始位置 默认从0开始**/
		,"liststep":DCampus.AuditThreadsUI.liststep          /** 分页显示长度 默认10 **/	
		,"pageNum":DCampus.AuditThreadsUI.pageNum            /** 默认第一页开始      **/	
		,"pageCount":DCampus.AuditThreadsUI.pageCount          /** 页数                **/
		,"totalCount":DCampus.AuditThreadsUI.totalCount         /** 列表总数            **/
		,"listbegin":DCampus.AuditThreadsUI.listbegin
		,"listend":DCampus.AuditThreadsUI.listend			
		,"RequestPath" : System.site+"/thread/getAuditThreads.action?temp="+Math.random()
		,"RequestData" : "groupId="+DCampus.AuditThreadsUI.mygroupId
		,"PageJson":auditThreadsJSON
		,"isPaging"  : DCampus.AuditThreadsUI.isPaging
		,"onBeforeStart":function(){
				$j(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});//关闭管理窗
			$j("#auditThreads-lst").hide();
			DCampus.Public.ShowLoading("container002","",0,100,0,System.site);//显示loading图标
						  }
		 ,"onLoad" : function(jsonObj){
						   DCampus.Public.HideLoading("container002");
							/**调用输出主题列表**/
						   var _template = TrimPath.parseTemplate($j("#auditThreads_template").val());
						   $j("#auditThreads-lst").html(_template.process(jsonObj));
						   $j("#auditThreads-lst").show();
						   if($j.trim($j("#auditThreads-lst tbody").html()) == "") {
						      $j("#auditThreads-lst").html("暂没审核信息");
							  $j(".listInfoTableWrap").hide();
						   }
						   $j(".table001 th").removeClass("displayNone");
						   $j(".table001 td").removeClass("displayNone");
						   $j(".slct-tbl").ListManage({hasTH:true,isListType:true,listBgColor:"#fff8bf",toolWrapID:"ManageToolWrap",isPop:false});
						   $j("#auditThreads-lst").find("a").bind("click",function(){
							    var openTRObj = $j(this).parent().parent().next();
								if(openTRObj.css("display") != "none") {
								    $j(".dropTR").addClass("displayNone");
								} else {
								   $j(".dropTR").addClass("displayNone");
								   openTRObj.removeClass("displayNone");
								}
						   });
					 }
	    });  			
	   $j(".btn-pass").bind("click",function(){
			var checkedObj = $j("#auditThreads-lst").find("td input:checked");
			var checkedQuery = "";
			for(i=0;i<checkedObj.length;i++) {
			   if(i==0) {
				   checkedQuery = "postId=" + checkedObj.eq(0).val();
			   } else {
				   checkedQuery += "&postId=" + checkedObj.eq(i).val();
			   }
			}
			if(confirm("是否确认通过？")) {
			DCampus.Public.AjaxRequestFunction(System.site+"/post/passAuditPost.action",checkedQuery,"POST",DCampus.AuditThreadsData._requestPassSuccess);
			}
	   });
	   $j(".btn-not-pass").bind("click",function(){
			var checkedObj = $j("#auditThreads-lst").find("td input:checked");
			var checkedQuery = "";
			for(i=0;i<checkedObj.length;i++) {
			   if(i==0) {
				   checkedQuery = "postId=" + checkedObj.eq(0).val();
			   } else {
				   checkedQuery += "&postId=" + checkedObj.eq(i).val();
			   }
			}												 
		   if(confirm("是否确认不通过？")) {
		   DCampus.Public.AjaxRequestFunction(System.site+"/post/unpassAuditPost.action",checkedQuery,"POST",DCampus.AuditThreadsData._requestPassSuccess)
		   }
	   });	
	   
	  
})
DCampus.AuditThreadsUI = {
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