DCampus.LevelData = {
   _saveSucecess : function(jsonObj){
       alert(jsonObj.detail);
	   $(".container002").DCampusPaging("reflash");
   }	
};
$(function(){
	DCampus.LevelUI._init();
	$("#addLevelBtn").bind("click",DCampus.LevelUI._addLevelBtn_Function);
	$("#levelSubmit").bind("click",DCampus.LevelUI._levelSubmit_Function);
    $("#deleteBtn").bind("click",DCampus.LevelUI._deleteBtn_Function);
});
DCampus.LevelUI = {
	limit : 500,//列表条数
	start : 0,//开始值
	liststep : 10,	
	pageNum : 0,	
	pageCount : 0,
	totalCount : 0,
	listbegin : 0,
	listend : 0,
	isPaging : false,	
	_init : function(){
		$(".container002").DCampusPaging({
			 "limit":DCampus.LevelUI.limit             /** 显示条数默认20条    **/
			,"start":DCampus.LevelUI.start              /** 开始位置 默认从0开始**/
			,"liststep":DCampus.LevelUI.liststep          /** 分页显示长度 默认10 **/	
			,"pageNum":DCampus.LevelUI.pageNum            /** 默认第一页开始      **/	
			,"pageCount":DCampus.LevelUI.pageCount          /** 页数                **/
			,"totalCount":DCampus.LevelUI.totalCount         /** 列表总数            **/
			,"listbegin":DCampus.LevelUI.listbegin
			,"listend":DCampus.LevelUI.listend							 
			,"RequestPath" : System.site+"/group/getGroupTypes.action"
			,"RequestData" : ""			
			,"onBeforeStart":function(){
				$("#query-lst").hide();
				DCampus.Public.ShowLoading("container005","",0,100,0,DCampus.systemPath);//显示loading图标
				$(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});//关闭管理窗
			}
			,"onComplete" : function(){
				$(".editSingle").bind("click",function(){
					 $(this).prev().html("<input type='text' value='"+$(this).prev().text()+"'/>").find("input").focus().bind("click",function(e){
					    e.stopPropagation();
					 }).bind("keypress",function(e){
					    if(e.keyCode == 13) {
					       $(this).parent().next().next().trigger("click");
						} 
					 });
					 $(this).addClass("displayNone");
					 $(this).next().removeClass("displayNone");
				});
				$(".saveSingle").bind("click",function(){
						DCampus.Public.AjaxRequestFunction(System.site+"/group/modifyGroupType.action", "id="+$(this).attr("id")+"&singleFileSize="+$(this).parent().find("span input").val()*1024,"post", DCampus.LevelData._saveSucecess);		
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
					 $(this).next().removeClass("displayNone");
				});
				$(".saveSpace").bind("click",function(){
					DCampus.Public.AjaxRequestFunction(System.site+"/group/modifyGroupType.action", "id="+$(this).attr("id")+"&totalFileSize="+$(this).parent().find("span input").val()*1024,"post", DCampus.LevelData._saveSucecess);		
				});			
				$(".levelName").bind("click",function(e){
					e.stopPropagation();
				});
				$(".delete").bind("click",function(){
				   if(confirm("是否删除？")) {
				      DCampus.Public.AjaxRequestFunction(System.site+"/group/deleteGroupType.action","id="+$(this).attr("id"),"post", DCampus.LevelData._saveSucecess);	   }
				});
			 }			 				  
			 ,"onLoad" : function(jsonObj){
				   DCampus.Public.HideLoading("container005");
					/**调用输出主题列表**/
					var _template = TrimPath.parseTemplate($("#groups_template").val()); 
				   $("#query-lst").html(_template.process(jsonObj));
				   $("#query-lst").show();
				   if($("#query-lst tbody tr").length > 0) {
					  $(".header").removeClass("displayNone");
				   } else {
					  $(".header").addClass("displayNone");
				   }	
				 //select管理插件  
				$(".slct-tbl").ListManage({hasTH:true,isListType:true,listBgColor:"#fff8bf"});	   
			}
		});  	
	},
	_addLevelBtn_Function : function(){
	   var _appendHtml = "<tr><td></td><td><input type='text' name='nameadd' class='levelValue'/></td><td></td><td></td><td></td></tr>";
	   $(".table001 tbody").append(_appendHtml);
	   $(".table001 tbody").find("input:last").focus();
	},
	_levelSubmit_Function : function(){
	   DCampus.Public.AjaxRequestFunction(System.site+"/group/addOrModifyGroupType.action",$(".levelValue").serialize(),"post", DCampus.LevelData._saveSucecess);	
	},
	_deleteBtn_Function : function(){
		var checked = $(".slct-tbl").find("td :checked");
		var param = "";
		if(checked.length < 1) {
			alert("未选择列表");
		} else {
		  if(confirm("是否删除选中的 "+checked.length+" 条？")) {			
	        DCampus.Public.AjaxRequestFunction(System.site+"/group/deleteGroupType.action",$("td input:checked").serialize(),"post", DCampus.LevelData._saveSucecess);
		  }
		}
	}
};