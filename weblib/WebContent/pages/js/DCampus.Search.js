DCampus.SearchData = {
   _requestSearchSuccess : function(jsonObj){
        var _template = TrimPath.parseTemplate($j("#searchLst_template").val());
		$j("#search-lst").html(_template.process(jsonObj));
   },
   _joinSuccess : function(){
      $j("body").message({message:"成功加入"});
	  window.location.href = DCampus.SearchUI.jumpURL;
   },
   _joinError : function(jsonObj){
	  $j("body").message({message:jsonObj.detail,warning:true});
   }   
};
$j(function(){ 	
	var _template = TrimPath.parseTemplate($j("#searchLst_template").val());
	var _categoryTemplate = TrimPath.parseTemplate($j("#allCategories_template").val());
	/**保存当前页数，刷新保留当前页**/		
	if(window.location.href.lastIndexOf("/p/") != -1) {
	   var locationNum = window.location.href.substring(window.location.href.lastIndexOf("/p/")+3);
	   DCampus.SearchUI.pageNum = parseInt(locationNum);
	} 	
	/**
	  分页插件初始化
	**/
	var queryURL = System.site+"/group/searchGroups.action";
	var locationHref = location.href;
	var target = locationHref.substring(locationHref.indexOf("?")+1,locationHref.indexOf("="));
	if(target == "categoryName") {
	   queryURL = System.site+"/category/searchCategories.action";
	}
	$j(".container005").DCampusPaging({
	     "limit":DCampus.SearchUI.limit             /** 显示条数默认20条    **/
	    ,"RequestPath" : queryURL
		,"RequestData" : "query="+$j("input[name='groupsName']").val()+"&site="+System.site
		,"onBeforeStart":function(){
			$j("#search-lst").hide();
			DCampus.Public.ShowLoading("container005","",0,100,0,System.site);//显示loading图标
	                      }
		 ,"onLoad" : function(jsonObj){
			               DCampus.Public.HideLoading("container005");
				            /**调用输出主题列表**/
						   $j("#search-lst").html(_template.process(jsonObj));
						   if($j("#search-lst li").length > 0) {
							  $j(".listInfoTableWrap").removeClass("displayNone");
						   } else {
						      $j(".listInfoTableWrap").addClass("displayNone");
						   }
						   $j("#search-lst").show();
							 /**
								加入圈子
							 **/
							 /*$j(".joinUS a").bind("click",function(){
								 DCampus.Public.AjaxRequestFunction(System.site+"/user/joinGroup.action","groupId="+$j(this).attr("id"),"POST",DCampus.SearchData._joinSuccess,DCampus.SearchData._joinError);
								 DCampus.SearchUI.jumpURL = $j(this).attr("rel");
							 });  	*/					   
					 }
	});
    $j("#doSearch").bind("click",function(){
       document.searchForm.submit();
    });	
	
	$j("#categoryWrap").bind("click",DCampus.SearchUI._categoryWrap_Function);
	/**
	    请求所有分类
	**/
	if(allCategories.categories.length > 0) {
		 $j("#categoryWrap").html(_categoryTemplate.process(allCategories));
	}
});
DCampus.SearchUI = {
	limit : 10,//列表条数
	jumpURL : "#",
	_categoryWrap_Function : function(e){
	    var target = $j(e.target);
		if(target.is("a")) {
		   $j("[name='categoryId']").val(target.attr("id"));
		   $j("#gform").submit();
		}
	}	
}