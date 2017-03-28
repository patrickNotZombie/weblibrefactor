// JavaScript Document
DCampus.ManageData = {
   _saveSucecess : function(jsonObj){
       alert(jsonObj.detail);
	   $(".container002").DCampusPaging("reflash");
   }
}

$(function(){
	DCampus.ManageUI._init();
	$(".button-search").bind("click",DCampus.ManageUI._button_search_Function);
	$(".btn-close-groups").bind("click",DCampus.ManageUI._btn_close_groups_Function);
	$(".btn-open-groups").bind("click",DCampus.ManageUI._btn_open_groups_Function);		
	
})


DCampus.ManageUI = {
	limit : 25,//列表条数
	start : 0,//开始值
	liststep : 10,	
	pageNum : 0,	
	pageCount : 0,
	totalCount : 0,
	listbegin : 0,
	listend : 0,
	isPaging : false,
    searchParam : "",
    _init : function(){
		var optionHtml = "";
		if($("#advanceSearch").val() == "false") {
		       DCampus.ManageUI.searchParam = "query="+$("input[name='groupsName']").val();
		} else {
		       DCampus.ManageUI.searchParam = $(".searchValue").serialize();
			   $(".clearValue").val("");
		}
		$("[name='groupsName']").focus();
		DCampus.ManageUI._openOrCloseSearchContent();
		for(i=0;i<levelJson.totalCount;i++) {
			  optionHtml += "<option value='"+levelJson.groupTypes[i].id+"'>" + levelJson.groupTypes[i].name + "</option>";
		}		
		$(".searchOption").append(optionHtml);
		$(".container002").DCampusPaging({
			 "limit":DCampus.ManageUI.limit             /** 显示条数默认20条    **/
			,"start":DCampus.ManageUI.start              /** 开始位置 默认从0开始**/
			,"liststep":DCampus.ManageUI.liststep          /** 分页显示长度 默认10 **/	
			,"pageNum":DCampus.ManageUI.pageNum            /** 默认第一页开始      **/	
			,"pageCount":DCampus.ManageUI.pageCount          /** 页数                **/
			,"totalCount":DCampus.ManageUI.totalCount         /** 列表总数            **/
			,"listbegin":DCampus.ManageUI.listbegin
			,"listend":DCampus.ManageUI.listend							 
			,"RequestPath" : System.site+"/group/searchGroups.action"
			,"RequestData" : DCampus.ManageUI.searchParam
			,"onBeforeStart":function(){
				$("#query-lst").hide();
				DCampus.Public.ShowLoading("container005","",0,100,0,DCampus.systemPath);//显示loading图标
				$(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});//关闭管理窗
			}
			,"onComplete" : function(){
				$(".chooseLevel").bind("click",function(e){e.stopPropagation();});
	            $(".saveLevelBtn").bind("click",DCampus.ManageUI._saveLevelBtn_Function);	
				$(".editSingle").bind("click",function(){
					 $(this).prev().html("<input type='text' value='"+$(this).prev().text()+"'/>").find("input").focus().bind("click",function(e){
					    e.stopPropagation();
					 }).bind("keypress",function(e){
					    if(e.keyCode == 13) {
					       $(this).parent().next().next().trigger("click");
						} 
					 });
					 $(this).addClass("displayNone");
					 $(".saveSingle").removeClass("displayNone");
				});
				$(".saveSingle").bind("click",function(){
					DCampus.Public.AjaxRequestFunction(System.site+"/group/modifySingleFileSize.action", "id="+$(this).attr("id")+"&filesize="+$(this).parent().find("span input").val()*1024,"post", DCampus.ManageData._saveSucecess);		
				});		
				$(".editSpace").bind("click",function(){
					 $(this).prev().html("<input type='text' value='"+$(this).prev().text()+"'/>").find("input").focus().bind("click",function(e){
					    e.stopPropagation();
					 }).bind("keypress",function(e){
					    if(e.keyCode == 13) {
					       $(this).parent().next().next().trigger("click");
						} 
					 });
					 $(this).addClass("displayNone");
					 $(".saveSpace").removeClass("displayNone");
				});
				$(".saveSpace").bind("click",function(){
					DCampus.Public.AjaxRequestFunction(System.site+"/group/modifyTotalFileSize.action", "id="+$(this).attr("id")+"&filesize="+$(this).parent().find("span input").val()*1024,"post", DCampus.ManageData._saveSucecess);		
				});									
			 }			 				  
			 ,"onLoad" : function(jsonObj){
				   DCampus.Public.HideLoading("container005");
					/**调用输出主题列表**/
					var _template = TrimPath.parseTemplate($("#groups_template").val()); 
				   $("#query-lst").html(_template.process(jsonObj));
				   $("#query-lst").show();
				   if($("#query-lst tbody tr").length > 0) {
					  $(".listInfoTableWrap").removeClass("displayNone");
					  $(".header").removeClass("displayNone");
				   } else {
					  $(".listInfoTableWrap").addClass("displayNone");
					  $(".header").addClass("displayNone");
				   }	
				 //select管理插件  
				$(".slct-tbl").ListManage({hasTH:true,isListType:true,listBgColor:"#fff8bf",toolWrapID:"ManageToolWrap"});	   
			}
		});   
    },
	_button_search_Function : function(){
       document.searchForm.submit();	
	},
	_btn_close_groups_Function : function(){
		var param = "";
		$.each($(".slct-tbl td :checked"),function(n,o){
			if(n == 0) {
			  param = "id=" + $(this).attr("id");
			} else {
			   param += "&id=" + $(this).attr("id");
			}
		});
		DCampus.Public.AjaxRequestFunction(System.site+"/group/closeGroup.action",param,"POST",DCampus.ManageData._saveSucecess);	  
		$(".container002").DCampusPaging("reflash");
	},
	_btn_open_groups_Function: function(){
		var param = "";
		$.each($(".slct-tbl td :checked"),function(n,o){
		    if(n == 0) {
			  param = "id=" + $(this).attr("id");
			} else {
			   param += "&id=" + $(this).attr("id");
			}
		});												
         DCampus.Public.AjaxRequestFunction(System.site+"/group/restoreGroup.action",param,"POST",DCampus.ManageData._saveSucecess);	  	
		 $(".container002").DCampusPaging("reflash");	
	},
	_saveLevelBtn_Function : function(){
	    DCampus.Public.AjaxRequestFunction(System.site+"/group/modifyType.action","groupId="+$(this).attr("rel")+"&groupType="+$(this).prev().val(),"POST",DCampus.ManageData._saveSucecess);	
	},
	_openOrCloseSearchContent : function(){
	  var _extend_content = $(".extend_content");
	  var _help_choose = $(".help_choose a");
	  _help_choose.toggle(function(){
	    _extend_content.slideDown('fast');
		_help_choose.text("收起高级搜索")
	  },function(){
	    _extend_content.slideUp('fast');
		_help_choose.text("展开高级搜索");
	  });
	}

}