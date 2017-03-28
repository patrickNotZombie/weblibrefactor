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
	var _subCategories = TrimPath.parseTemplate($j("#subCategories_template").val());
	var _breadTemplate = TrimPath.parseTemplate($j("#breadTemplate").val());
	$j("#categoryWrap").bind("click",DCampus.SearchUI._categoryWrap_Function);
	$j("#showSubCategories").bind("click",DCampus.SearchUI._categoryWrap_Function);
    $j("#showBreadCrumb").bind("click",DCampus.SearchUI._categoryWrap_Function);
	/**保存当前页数，刷新保留当前页**/		
	if(window.location.href.lastIndexOf("/p/") != -1) {
	   var locationNum = window.location.href.substring(window.location.href.lastIndexOf("/p/")+3);
	   DCampus.SearchUI.pageNum = parseInt(locationNum);
	} 	
	/**
	  分页插件初始化
	**/
	var queryURL = System.site+"/group/getGroups.action";
	$j(".container005").DCampusPaging({
	     "limit":DCampus.SearchUI.limit             /** 显示条数默认20条    **/
	    ,"start":DCampus.SearchUI.start              /** 开始位置 默认从0开始**/
	    ,"liststep":DCampus.SearchUI.liststep          /** 分页显示长度 默认10 **/	
	    ,"pageNum":DCampus.SearchUI.pageNum            /** 默认第一页开始      **/	
	    ,"pageCount":DCampus.SearchUI.pageCount          /** 页数                **/
	    ,"totalCount":DCampus.SearchUI.totalCount         /** 列表总数            **/
	    ,"listbegin":DCampus.SearchUI.listbegin
	    ,"listend":DCampus.SearchUI.listend							 
	    ,"RequestPath" : queryURL
		,"RequestData" : "categoryId="+$j("input[name='categoryId']").val()
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
						   
						   if(jsonObj.subCategories.length > 0) {
							   $j("#showSubCategories").html(_subCategories.process(jsonObj)).show();
						   }
	                       $j("#showBreadCrumb").html(_breadTemplate.process(jsonObj));
							   
					 }
	});
    $j("#doSearch").bind("click",function(){
       document.searchForm.submit();
    });	
	/**
	    请求所有分类
	**/
	if(allCategories.categories.length > 0) {
		 $j("#categoryWrap").html(_categoryTemplate.process(allCategories));
	}
});
DCampus.SearchUI = {
	limit : 10,//列表条数
	start : 0,//开始值
	liststep : 10,	
	pageNum : 0,	
	pageCount : 0,
	totalCount : 0,
	listbegin : 0,
	listend : 0,
	jumpURL : "#",
	_categoryWrap_Function : function(e){
	    var target = $j(e.target);
		if(target.is("a")) {
		   $j("[name='categoryId']").val(target.attr("rev"));
		   $j("#gform").submit();
		}
	}		
}