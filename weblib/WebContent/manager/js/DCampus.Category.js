// JavaScript Document

// JavaScript Document

$(function() {
	DCampus.categoryUI._template = TrimPath.parseTemplate($(
			"#category_template").val());
	// 获取分类列表
	DCampus.categoryData._getCategoryList(categoryJson);
	$("#createCategory").bind(
			"click",
			function() {
				// 这个方法是可以打开对话框，并初始化对话框的宽和高，对话框参数只初始化一次
				DCampus.Public.Dialog("createCategoryDialog", "创建分类", 400, 90,
						DCampus.categoryUI._openCategoryDialog);
			});
	$(".dialog-btn-createCategory").bind(
			"click",
			function() {
				DCampus.Public.AjaxRequestFunction(
						"/category/createCategory.action", "name="
								+ $("input[name='name']").val() + "&desc="
								+ $("textarea[name='desc']").val(), "post",
						DCampus.categoryData._categoryResult,
						DCampus.categoryData._categoryResult);
			});

	$(".btn-close").bind(
			"click",
			function() {
				var param = "";
				$.each($(".slct-tbl td input:checked"), function() {
					param += "id=" + $(this).attr("id") + "&";
				});
				param = param.substring(0, param.length - 1);
				DCampus.Public.AjaxRequestFunction(
						"/category/closeCategory.action", param, "post",
						DCampus.categoryData._categoryResult,
						DCampus.categoryData._categoryResult);
			});
	$(".btn-restore").bind(
			"click",
			function() {
				var param = "";
				$.each($(".slct-tbl td input:checked"), function() {
					param += "id=" + $(this).attr("id") + "&";
				});
				param = param.substring(0, param.length - 1);
				DCampus.Public.AjaxRequestFunction(
						"/category/restoreCategory.action", param, "post",
						DCampus.categoryData._categoryResult,
						DCampus.categoryData._categoryResult);
			});
	$(".button-search").bind(
			"click",
			function() {
				var query = $(".searchWrap input[name='categoryName']").val();
				if (query == null || $.trim(query) == "") {
					DCampus.Public.AjaxRequestFunction(
							"/category/getCategories.action", "query=" + query,
							"post", DCampus.categoryData._getCategorySuccess);
				} else {
					DCampus.Public.AjaxRequestFunction(
							"/category/searchCategories.action", "query="
									+ query, "post",
							DCampus.categoryData._getCategorySuccess);
				}
			});
	$("#rebuildCategoryIndex").bind(
			"click",
			function() {
				DCampus.Public.AjaxRequestFunction(
						"/category/rebuildCategoryIndex.action", "", "post",
						DCampus.categoryData._rebuildCategoryIndex);
			});
});
DCampus.categoryData = {
	_getCategoryList : function(categoryJson) {
		$("#category-lst").html(
				DCampus.categoryUI._template.process(categoryJson));
		//DCampus.categoryUI._reseizeIframeHeight();
		$(".slct-tbl").ListManage( {
			hasTH : true,
			isListType : true,
			listBgColor : "#fff8bf",
			toolWrapID : "ManageToolWrap"
		});// select管理插件
	},
	_getCategorySuccess : function(jsonObj) {
		$("#category-lst").html(DCampus.categoryUI._template.process(jsonObj));
		$(".slct-tbl").ListManage( {
			hasTH : true,
			isListType : true,
			listBgColor : "#fff8bf",
			toolWrapID : "ManageToolWrap"
		});// select管理插件
	},
	_categoryResult : function(jsonObj) {
		alert(jsonObj.detail);
		$(".slct-tbl").ListManage( {
			close : true,
			toolWrapID : "ManageToolWrap"
		});// 关闭管理窗
		DCampus.Public.AjaxRequestFunction("/category/getCategories.action", "",
				"post", DCampus.categoryData._getCategorySuccess);
	},
	_rebuildCategoryIndex : function(jsonObj) {
		alert("重建索引成功");
	}
}
DCampus.categoryUI = {
	_reseizeIframeHeight : function() {
		// resize iframe高度
	parent.DCampus.Public.ResizeIframeHeight($(parent.window.document).find(
			"#categoryIframe"), $("body").height());
	},
	_openCategoryDialog : function() {
	}
}