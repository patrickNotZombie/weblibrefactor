DCampus.categoryData = {
	_getCategoryList : function(allCategoryJson) {
		$(".categoryWrap").html(DCampus.categoryUI._template.process(allCategoryJson));
		$(".btn-closeOne").bind("click",function() {
			DCampus.Public.AjaxRequestFunction(System.site+"/category/closeCategory.action", "id="+$(this).attr("rel"), "post",DCampus.categoryData._closeOrOpenSuccess,"");
		});		
	
		$(".btn-open").bind("click",function(){
		   DCampus.Public.AjaxRequestFunction(System.site+"/category/restoreCategory.action", "id="+$(this).attr("rel"), "post",DCampus.categoryData._closeOrOpenSuccess,""); 
		});
		$(".btn-close").bind("click",function(){
		   DCampus.Public.AjaxRequestFunction(System.site+"/category/closeCategory.action", "id="+$(this).attr("rel"), "post",DCampus.categoryData._closeOrOpenSuccess,"");
		});	
	},
    _closeOrOpenSuccess : function(){
		window.location.reload();
	},
	_rebuildCategoryIndex : function(jsonObj) {
		alert("重建索引成功");
	},
	_createSuccess : function(){
		window.location.reload();
	}
};

$(function() {
		   
	DCampus.categoryUI._template = TrimPath.parseTemplate($(
			"#category_template").val());
	// 获取分类列表
	DCampus.categoryData._getCategoryList(allCategoryJson);
	
	$("#rebuildCategoryIndex").bind(
			"click",
			function() {
				DCampus.Public.AjaxRequestFunction(
						System.site+"/category/rebuildCategoryIndex.action", "", "post",
						DCampus.categoryData._rebuildCategoryIndex);
			});
	$(".addtr").bind("click",DCampus.categoryUI._addtr_Function);
	$(".addOnetr").bind("click",DCampus.categoryUI._addOnetr_Function);
	$("#submit_editsubmit").bind("click",DCampus.categoryUI._submit_editsubmit_Function);
	$(".categoryWrap tbody").bind("mouseover",function(e){
	    var target = $(e.target);
		var tp = target.parent();
		var tpp = target.parent().parent();
		var tppp = target.parent().parent().parent();
		$(this).find("tr").css("background","#fff");
		if(target.is("td")) {
			if(tp.is(".hover"))
			   tp.css("background","#f2f9fd");
			}
		if(target.is("div") || target.is("a")) {
			 if(tpp.is(".hover"))
			   tpp.css("background","#f2f9fd");
			}
		if(target.is("input")) {
			if(tppp.is(".hover"))
			  tppp.css("background","#f2f9fd");
			}
	}).bind("mouseout",function(){
	    $(this).find("tr").css("background","#fff");
	});
});

DCampus.categoryUI = {
	_reseizeIframeHeight : function() {
		// resize iframe高度
	parent.DCampus.Public.ResizeIframeHeight($(parent.window.document).find(
			"#categoryIframe"), $("body").height());
	},
	_openCategoryDialog : function() {
	},
	_addtr_Function : function(){
	   $(this).parent().parent().parent().before("<tr><td class='td25'></td><td colspan='4'><div class='board'><input type='hidden' name='cpid' value='"+$(this).attr("id")+"' class='categorySubmit'/><input type='text' class='txt categorySubmit' size='20' value='新子分类' name='cnameadd'></div></td></tr>");
	},
	_addOnetr_Function : function(){
	   $(this).parent().parent().parent().before("<tr><td  class='td25'></td><td colspan='4'><input type='hidden' name='cpid' value='0' class='categorySubmit'/><input type='text' class='txt categorySubmit' size='20' value='一级分类' name='cnameadd'></td></tr>");
	},
	_submit_editsubmit_Function : function(){
	  var param = $(".categorySubmit").serialize();
	  DCampus.Public.AjaxRequestFunction(System.site+"/category/addOrModifyCategories.action", param,"post", DCampus.categoryData._createSuccess);
	}
};