// JavaScript Document
DCampus.PersonalData = (function(){
   return {
	  lstid : 0,//定义一个增量这个增量用来按顺序读取动态列表用
	  idArr : [],//定义一个保存动态圈子ID的数组
	  random_lstid : 0,//定义一个增量这个增量用来按顺序读取动态列表用
	  random_idArr : [],//定义一个保存动态圈子ID的数组
      _getGroupNewsSuccess : function(data){
		var _template = TrimPath.parseTemplate($j("#News_template").val());//调用模板
		$j("#News-Wrap").html(_template.process(data));//输出圈子动态名称列表
	   DCampus.Public.ShowLoading("NewsLst"+DCampus.PersonalData.lstid,"",0,60,0,System.site);//显示loading图标
	   if(DCampus.PersonalData.idArr.length != 0) {
	   DCampus.Public.AjaxRequestFunction(System.site+"/group/getGroupRecords.action","groupId="+DCampus.PersonalData.idArr[DCampus.PersonalData.lstid]+"&start=0&limit=5","get",DCampus.PersonalData._getGroupNewsLstSuccess);//然后异步请求输出圈子的动态列表
	   }
	  },
	  _getGroupNewsLstSuccess : function(data){//输出圈子动态列表请求成功调用的方法
		var _template = TrimPath.parseTemplate($j("#News-lst_template").val());//调用模板
		$j("#NewsLst"+DCampus.PersonalData.lstid).html(_template.process(data));	//输出动态列表
		DCampus.PersonalData.lstid++;//递增
		if(DCampus.PersonalData.lstid < DCampus.PersonalData.idArr.length) {//跳出递归
		DCampus.Public.ShowLoading("NewsLst"+DCampus.PersonalData.lstid,"",0,60,0,System.site);//显示loading图标
		DCampus.Public.AjaxRequestFunction(System.site+"/group/getGroupRecords.action","groupId="+DCampus.PersonalData.idArr[DCampus.PersonalData.lstid]+"&start=0&limit=5","get",DCampus.PersonalData._getGroupNewsLstSuccess);//异步请求动态列表
		}
	  },
	  _getMoreGroupsListSuccess : function(data){//显示更多我的圈子
		for(i=0;i<data.groups.length;i++) {
			//for(j=0;j<$j(".personal_coR_table .title a").length;j++) {
			   //if(data.groups[i].name == $j(".personal_coR_table .title a").text())
			   //return;
			//}
	       $j(".moreMyGroups").append("<li><span class='ico ico01'>&nbsp;</span><a href='"+System.site+'/'+data.groups[i].addr+"/'>"+data.groups[i].name+"</a></li>");       
		}
		$j("#totalGroups").text(data.totalCount);
		$j("#totalMyGroups").text(data.myGroupCount);
	  },
	  
      _getRandomNews : function(data){
		var _template = TrimPath.parseTemplate($j("#Random_template").val());//调用模板
		$j("#Random-Wrap").html(_template.process(data));//输出圈子动态名称列表
	   DCampus.Public.ShowLoading("RandomLst"+DCampus.PersonalData.random_lstid,"",0,60,0,System.site);//显示loading图标
	   if(DCampus.PersonalData.random_idArr.length != 0) {
	      DCampus.Public.AjaxRequestFunction(System.site+"/group/getGroupRecords.action","groupId="+DCampus.PersonalData.random_idArr[DCampus.PersonalData.random_lstid]+"&start=0&limit=5","get",DCampus.PersonalData._getRandomLstSuccess);//然后异步请求输出圈子的动态列表
	   }
	  },
	  _getRandomLstSuccess : function(data){//输出圈子动态列表请求成功调用的方法
		var _template = TrimPath.parseTemplate($j("#Random-lst_template").val());//调用模板
		$j("#RandomLst"+DCampus.PersonalData.random_lstid).html(_template.process(data));	//输出动态列表
		DCampus.PersonalData.random_lstid++;//递增
		if(DCampus.PersonalData.random_lstid < DCampus.PersonalData.random_idArr.length) {//跳出递归
		DCampus.Public.ShowLoading("RandomLst"+DCampus.PersonalData.random_lstid,"",0,60,0,System.site);//显示loading图标
		DCampus.Public.AjaxRequestFunction(System.site+"/group/getGroupRecords.action","groupId="+DCampus.PersonalData.random_idArr[DCampus.PersonalData.random_lstid]+"&start=0&limit=5","get",DCampus.PersonalData._getRandomLstSuccess);//异步请求动态列表
		}
	  },
	  _getInvitationsSuccess : function(jsonObj){
	      if(jsonObj.invitations > 0) {
			  $j(".personal-infoWrap").show().find(".num").text(jsonObj.invitations);  
		  }
	  },
	  _readInvationsSuccess : function(){
		 window.location.href = "ucenter/inbox.jsp";  
	  }
   }
})();
/**页面事件**/
$j(function(){
	//DCampus.Public.AjaxRequestFunction(System.site+"/group/getMyGroupsByLastRecords.action","","POST",DCampus.PersonalData._getGroupNewsSuccess);//获取动态圈子名列表
	/**
	   获取圈子动态列表
	**/
	DCampus.PersonalUI.init();
	DCampus.PersonalData._getGroupNewsSuccess(groupNewsJSON);
	
	DCampus.PersonalData._getRandomNews(randGroupsJson);
	
	/**
	   获取更多我的圈子
	**/
	DCampus.PersonalData._getMoreGroupsListSuccess(myGroupsJson);
	/**
	    点击搜索
	**/
	$j("#doSearch").bind("click",function(){
		 document.searchForm.submit();
	});	
	
	DCampus.Public.tabFunction("click",".tab",".tabContent",DCampus.PersonalUI.tabFunction); 
	$j(".tabHanddle").find("a").eq(0).trigger("click");
	$j(".personal-infoWrap").find("a").bind("click",DCampus.PersonalUI._readInvations);
});

/**UI**/
DCampus.PersonalUI = {
	init : function(){	
		 DCampus.Public.AjaxRequestFunction(System.site+"/user/getMyInvitations.action","","GET",DCampus.PersonalData._getInvitationsSuccess);	
	},
	tabFunction : function(thisObj){//滑动tab效果
		$j(".tabCover").width(thisObj.width());
		$j(".tabCover").text(thisObj.text())
		    switch($j(".tabHanddle a").index(thisObj)) {
			    case 0 :  
				$j(".tabCover").animate({left:"5px"},"fast");
				$j("#News-Wrap").show();$j("#Random-Wrap").hide();break;
				case 1 :  
				$j(".tabCover").animate({left:"76px"},"fast");
				$j("#News-Wrap").hide();$j("#Random-Wrap").show();break;
			}
	},
	_readInvations : function(){
	   DCampus.Public.AjaxRequestFunction(System.site+"/user/readInvitations.action","","GET",DCampus.PersonalData._readInvationsSuccess);	
	}
};