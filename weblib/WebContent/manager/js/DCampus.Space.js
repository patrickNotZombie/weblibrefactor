// JavaScript Document

// JavaScript Document

$(function(){
	$(".button-search").bind("click",function(){
			document.searchForm.submit();						  
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
		,"onComplete" : function(){
			                $(".editSingle").bind("click",function(){
						         $(this).prev().html("<input type='text' value='"+$(this).prev().text()+"'/>").find("input").focus();
								 $(this).addClass("displayNone");
								 $(".saveSingle").removeClass("displayNone");
							});
			                $(".saveSingle").bind("click",function(){
								DCampus.Public.AjaxRequestFunction("/group/modifySingleFileSize.action", "id="+$(this).attr("id")+"&filesize="+$(this).parent().find("span input").val(),"post", DCampus.GroupsData._saveSucecess);								   
						         /*$(this).parent().find("span").text($(this).parent().find("span input").val());
								 $(this).addClass("displayNone");
								 $(".editSingle").removeClass("displayNone");*/
							});		
			                $(".editSpace").bind("click",function(){
						         $(this).prev().html("<input type='text' value='"+$(this).prev().text()+"'/>").find("input").focus();
								 $(this).addClass("displayNone");
								 $(".saveSpace").removeClass("displayNone");
							});
			                $(".saveSpace").bind("click",function(){
								DCampus.Public.AjaxRequestFunction("/group/modifyTotalFileSize.action", "id="+$(this).attr("id")+"&filesize="+$(this).parent().find("span input").val(),"post", DCampus.GroupsData._saveSucecess);								  
						         /*$(this).parent().find("span").text($(this).parent().find("span input").val());
								 $(this).addClass("displayNone");
								 $(".editSpace").removeClass("displayNone");*/
								 
							});									
						}
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
   },
   _saveSucecess : function(jsonObj){
       alert(jsonObj.detail);
	   $(".container002").DCampusPaging("reflash");
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