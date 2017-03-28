// JavaScript Document

// JavaScript Document

$(function(){
	$(".button-search").bind("click",function(){
			document.searchForm.submit();						  
	});
	$(".btn-close-groups").bind("click",function(){
		var param = "";
		$.each($(".slct-tbl td :checked"),function(n,o){
			if(n == 0) {
			  param = "id=" + $(this).attr("id");
			} else {
			   param += "&id=" + $(this).attr("id");
			}
		});
		DCampus.Public.AjaxRequestFunction("/group/closeGroup.action",param,"POST",DCampus.GroupsData._requestSuccess);	  
		$(".container002").DCampusPaging("reflash");
	});
	$(".btn-open-groups").bind("click",function(){
		var param = "";
		$.each($(".slct-tbl td :checked"),function(n,o){
		    if(n == 0) {
			  param = "id=" + $(this).attr("id");
			} else {
			   param += "&id=" + $(this).attr("id");
			}
		});												
         DCampus.Public.AjaxRequestFunction("/group/restoreGroup.action",param,"POST",DCampus.GroupsData._requestSuccess);	  	
		 $(".container002").DCampusPaging("reflash");
	});		
	$("#redoIndex").bind("click",function(){
	   DCampus.Public.AjaxRequestFunction("/group/rebuildGroupIndex.action","","POST",DCampus.GroupsData._requestSuccess);
	});
	$(".container002").DCampusPaging({
	     "limit":DCampus.GroupsUI.limit             /** 显示条数默认20条    **/
	    ,"start":DCampus.GroupsUI.start              /** 开始位置 默认从0开始**/
	    ,"liststep":DCampus.GroupsUI.liststep          /** 分页显示长度 默认10 **/	
	    ,"pageNum":DCampus.GroupsUI.pageNum            /** 默认第一页开始      **/	
	    ,"pageCount":DCampus.GroupsUI.pageCount          /** 页数                **/
	    ,"totalCount":DCampus.GroupsUI.totalCount         /** 列表总数            **/
	    ,"listbegin":DCampus.GroupsUI.listbegin
	    ,"listend":DCampus.GroupsUI.listend							 
	    ,"RequestPath" : "/group/searchGroups.action"
		,"RequestData" : "query="+$("input[name='groupsName']").val()
		,"onBeforeStart":function(){
			$("#query-lst").hide();
			DCampus.Public.ShowLoading("container005","",0,100,0,DCampus.systemPath);//显示loading图标
			$(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});//关闭管理窗
	                      }
		 ,"onLoad" : function(jsonObj){
			               DCampus.Public.HideLoading("container005");
				            /**调用输出主题列表**/
							var _template = TrimPath.parseTemplate($("#groups_template").val()); 
						   $("#query-lst").html(_template.process(jsonObj));
						   $("#query-lst").show();
						   if($("#query-lst tbody tr").length > 0) {
							  $(".listInfoTableWrap").removeClass("displayNone");
						   } else {
						      $(".listInfoTableWrap").addClass("displayNone");
						   }	
						 //select管理插件  
						$(".slct-tbl").ListManage({hasTH:true,isListType:true,listBgColor:"#fff8bf",toolWrapID:"ManageToolWrap"});	   
					 }
	});
});
DCampus.GroupsData = {
   _querySuccess : function(jsonObj){
	   var _template = TrimPath.parseTemplate($("#groups_template").val());  
       $("#query-lst").html(_template.process(jsonObj));
   },
   _requestSuccess : function(jsonObj){
      alert(jsonObj.detail)
   }
};
DCampus.GroupsUI = {
	limit : 25,//列表条数
	start : 0,//开始值
	liststep : 10,	
	pageNum : 0,	
	pageCount : 0,
	totalCount : 0,
	listbegin : 0,
	listend : 0,
	isPaging : false
};