// JavaScript Document
DCampus.GroupListData = {
  _CKEDITOR : CKEDITOR,
   //成功请求成员列表返回方法
  _requestMemberListSuccess : function(jsonObj){
	  //alert(jsonObj);
  },
  //发表主题后执行
  _createThreadSuccess : function(jsonObj) {
		$j("body").message({message:"发表成功"});
		$j(".container002").DCampusPaging("reflash");	 /**请求主题列表**/	
		DCampus.Public.Dialog({
				handler:"createThreadDialog"
				,close:true
				,closeFunction : DCampus.GroupListUI._closeCreateThreadDialog
		});		  
   },
   //请求板块选项后执行的方法
   _requestOptionSuccess : function(jsonObj){
	  for(i=0;i<jsonObj.forums.length;i++) {
		  $j("select[name='forumId']").append("<option value="+jsonObj.forums[i].id+">"+jsonObj.forums[i].name+"</option>");
	  }
   },
	_requestForumSuccess : function(jsonObj){
		for(i=0;i<jsonObj.forums.length;i++) {
		   if(jsonObj.forums[0].name == "default") {
			 DCampus.GroupListUI._defaultForumId = jsonObj.forums[i].id;  
			 break;
		   }
		}
		/**
			请求列表
		**/
		if(window.location.href.lastIndexOf("/p/") != -1) {
		   var locationNum = window.location.href.substring(window.location.href.lastIndexOf("/p/")+3);
		   DCampus.GroupListUI.pageNum = parseInt(locationNum);
		   DCampus.GroupListUI.isPaging = true;
		} 		
		$j(".container002").DCampusPaging({
			 "limit":DCampus.GroupListUI.limit             /** 显示条数默认20条    **/
			,"RequestPath" : System.site+"/thread/getThreads.action?temp="+Math.random()
			,"RequestData" : "forumId="+DCampus.GroupListUI._defaultForumId
			,"PageJson":listJSON
			,"isPaging": DCampus.GroupListUI.isPaging
			,"onBeforeStart":function(){
				if(DCampus.Permission.delete_thread) {
					$j(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});//关闭管理窗
				}
				$j("#threads-lst").hide();
				DCampus.Public.ShowLoading("container002","",0,100,0,System.site);//显示loading图标
							  }
			 ,"onLoad" : function(jsonObj){
						   DCampus.Public.HideLoading("container002");
							/**调用输出主题列表**/
						   var _template = TrimPath.parseTemplate($j("#threads_template").val());
						   $j("#threads-lst").html(_template.process(jsonObj));
						   $j("#threads-lst").show();
						   //select管理插件
						   if(DCampus.Permission.delete_thread) {
							 $j(".table001 th").removeClass("displayNone");
							 $j(".table001 td").removeClass("displayNone");
							 $j(".slct-tbl").ListManage({hasTH:true,isListType:true,listBgColor:"#fff8bf",toolWrapID:"ManageToolWrap"});
						   }
						 }
		});			
	},
	_deleteThrLstSuccess : function(jsonObj){
	   $j("body").message({message:"删除成功"});
	   $j(".container002").DCampusPaging("reflash");	 /**请求主题列表**/	
	   $j(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});
	},
	_deleteThrLstError : function(jsonObj){
	   $j("body").message({message:jsonObj.detail,warning:true});
	},
	_doManageSuccess : function(jsonObj){
	   $j("body").message({message:"操作成功"});
	   $j(".container002").DCampusPaging("reflash");	 /**请求主题列表**/	
	   $j(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});
	}
}

$j(function(){
   if(json.type != "error") {
     /**获取forum**/
	   if(DCampus.Permission.view_group) {
         DCampus.Public.AjaxRequestFunction(System.site+"/forum/getForums.action?temp="+Math.random(),"groupId="+$j("input[name='groupId']").val(),"get",DCampus.GroupListData._requestForumSuccess);
	   }
	}
   /*模拟下拉框*/
   $j(".chooseType").bind("click",function(){
       if($j(".selectInput").find("ul").css("display") == "none") {
	      $j(".selectInput").find("ul").slideDown("fast");
	   } else {
	      $j(".selectInput").find("ul").slideUp("fast");
	   }
   })
   $j(".selectInput").find("ul").bind("mouseleave",function(){
	  $j(".selectInput").find("ul").slideUp("fast");													
   }).find("a").bind("click",function(){
	   $j(".selectInput span").text($j(this).text());   
	   $j(".selectInput").find("ul").slideUp("fast");
   });
   /**打开发表主题的窗口**/
   $j(".createThread").bind("click",function(){
		//这个方法是可以打开对话框，并初始化对话框的宽和高，对话框参数只初始化一次
		DCampus.Public.Dialog({
				handler:"createThreadDialog"
				,title:"发表主题"
				,width:650
				,height:370
				,openFunction : DCampus.GroupListUI._openCreateThreadDialog
				,closeFunction : DCampus.GroupListUI._closeCreateThreadDialog
		});		
	});
   $j(".dialog-btn-publish").bind("click",function(){
       if($j("input[name='topic']").val() == "") {
		   $j("body").message({message:"请填写标题",warning:true});
	   } else {
		 //发表新主题请求 
	     DCampus.Public.AjaxRequestFunction(System.site+"/thread/createThread.action?temp="+Math.random(),"topic="+encodeURIComponent($j("input[name='topic']").val())+"&body="+encodeURIComponent(CKEDITOR.instances.discussBody.getData())+"&forumId="+DCampus.GroupListUI._defaultForumId+"&memberVisible=true"/*+$j("input[name='memberVisible']").attr("checked")*/,"POST",DCampus.GroupListData._createThreadSuccess);
	   }
   });
 	 //删除主题
    $j(".btn-del-thrL").bind("click",function(){
        var checked = $j(".slct-tbl").find("td :checked");
		var param = "";
		if(checked.length < 1) {
		    $j("body").message({message:"未选择列表",warning:true});
		} else {
          if(confirm("是否删除选中的 "+checked.length+" 篇主题？")) {			
		    for(i=0;i<checked.length;i++){
			   var sign = "&threadId";
			   if(i==0) {
			      sign = "threadId";
			   }
			   param += (sign + "=" + checked.eq(i).val());
			}
			DCampus.Public.AjaxRequestFunction(System.site+"/thread/deleteThread.action?temp="+Math.random(),param,"POST",DCampus.GroupListData._deleteThrLstSuccess,DCampus.GroupListData._deleteThrLstError);
		}
		}
	});
	
	//置顶主题
	$j(".btn-top-thrL").bind("click",function(){
        var checked = $j(".slct-tbl").find("td :checked");
		var param = "";
		if(checked.length < 1) {
		    $j("body").message({message:"未选择列表",warning:true});
		} else {
			  if(confirm("是否置顶选中的 "+checked.length+" 篇主题？")) {			
				for(i=0;i<checked.length;i++){
				   var sign = "&threadId";
				   if(i==0) {
					  sign = "threadId";
				   }
				   param += (sign + "=" + checked.eq(i).val());
				}
				DCampus.Public.AjaxRequestFunction(System.site+"/thread/focusThread.action?temp="+Math.random(),param,"POST",DCampus.GroupListData._doManageSuccess);
			 }
		}											  
    });
	
	//解除置顶
	$j(".btn-untop-thrL").bind("click",function(){
        var checked = $j(".slct-tbl").find("td :checked");
		var param = "";
		if(checked.length < 1) {
		    $j("body").message({message:"未选择列表",warning:true});
		} else {
				for(i=0;i<checked.length;i++){
				   var sign = "&threadId";
				   if(i==0) {
					  sign = "threadId";
				   }
				   param += (sign + "=" + checked.eq(i).val());
				}
				DCampus.Public.AjaxRequestFunction(System.site+"/thread/unfocusThread.action?temp="+Math.random(),param,"POST",DCampus.GroupListData._doManageSuccess);
			 }
    });	
	
	//关闭主题
	$j(".btn-close-thrL").bind("click",function(){
        var checked = $j(".slct-tbl").find("td :checked");
		var param = "";
		if(checked.length < 1) {
		    $j("body").message({message:"未选择列表",warning:true});
		} else {
			  if(confirm("是否关闭选中的 "+checked.length+" 篇主题？")) {			
				for(i=0;i<checked.length;i++){
				   var sign = "&threadId";
				   if(i==0) {
					  sign = "threadId";
				   }
				   param += (sign + "=" + checked.eq(i).val());
				}
				DCampus.Public.AjaxRequestFunction(System.site+"/thread/closeThread.action?temp="+Math.random(),param,"POST",DCampus.GroupListData._doManageSuccess);
			 }
		}											  
    });	
	
	//解除关闭
	$j(".btn-open-thrL").bind("click",function(){
        var checked = $j(".slct-tbl").find("td :checked");
		var param = "";
		if(checked.length < 1) {
		    $j("body").message({message:"未选择列表",warning:true});
		} else {
				for(i=0;i<checked.length;i++){
				   var sign = "&threadId";
				   if(i==0) {
					  sign = "threadId";
				   }
				   param += (sign + "=" + checked.eq(i).val());
				}
				DCampus.Public.AjaxRequestFunction(System.site+"/thread/openThread.action?temp="+Math.random(),param,"POST",DCampus.GroupListData._doManageSuccess);
			 }
    });		
	
	//屏蔽主题
	$j(".btn-disabled-thrL").bind("click",function(){
        var checked = $j(".slct-tbl").find("td :checked");
		var param = "";
		if(checked.length < 1) {
		    $j("body").message({message:"未选择列表",warning:true});
		} else {
			  if(confirm("是否屏蔽选中的 "+checked.length+" 篇主题？")) {			
				for(i=0;i<checked.length;i++){
				   var sign = "&threadId";
				   if(i==0) {
					  sign = "threadId";
				   }
				   param += (sign + "=" + checked.eq(i).val());
				}
				DCampus.Public.AjaxRequestFunction(System.site+"/thread/disableThread.action?temp="+Math.random(),param,"POST",DCampus.GroupListData._doManageSuccess);
			 }
		}											  
    });		
	
	//解除屏蔽
	$j(".btn-enabled-thrL").bind("click",function(){
        var checked = $j(".slct-tbl").find("td :checked");
		var param = "";
		if(checked.length < 1) {
		    $j("body").message({message:"未选择列表",warning:true});
		} else {
				for(i=0;i<checked.length;i++){
				   var sign = "&threadId";
				   if(i==0) {
					  sign = "threadId";
				   }
				   param += (sign + "=" + checked.eq(i).val());
				}
				DCampus.Public.AjaxRequestFunction(System.site+"/thread/enableThread.action?temp="+Math.random(),param,"POST",DCampus.GroupListData._doManageSuccess);
			 }
    });		
	
});
DCampus.GroupListUI = {
	limit : 20,//列表条数
	_isIntitalEditor : true,
	_defaultForumId : 0,
	firstload : true,
	isPaging : false,
	_openCreateThreadDialog : function(){
		//打开窗口的时候创建CKEditor，这个方法只会调用一次
		if(DCampus.GroupListUI._isIntitalEditor) {
			//调用编辑器
			var editor = DCampus.GroupListData._CKEDITOR.replace( 'discussBody',{
					// Defines a simpler toolbar to be used in this sample.
					// Note that we have added out "MyButton" button here.
			toolbar : [
			['Bold','Italic','Underline','Strike'],['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],['Link','Unlink','Image','Table'],'/',['Format','Font','FontSize','TextColor','BGColor'],['Maximize','DCampus_OpenPhotoDialogButton']
			]
				});
            //添加编辑器插件
			editor.on( 'pluginsLoaded', function( ev )
				{
					// If our custom dialog has not been registered, do that now.
					if (!CKEDITOR.dialog.exists( 'DCampus_PhotoDialog'))
					{
						CKEDITOR.dialog.add('DCampus_PhotoDialog', function( editor )
						{
							return {
								onOk : function() {
								  var value = "";
								  if($j("#build").contents()[0].window.uploadFunction.photoArrId.length > 0) {
                                  for (i=0;i<$j("#build").contents()[0].window.uploadFunction.photoArrId.length;i++) {
								     value += "<img class='preview' src='"+System.site+"/user/downloadImage.action?id="+$j("#build").contents()[0].window.uploadFunction.photoArrId[i]+"'/><br/>";
								  }
								  CKEDITOR.instances.discussBody.insertHtml(""+value+"");
								  }
								},
					            onShow : function(){
									window.frames["build"].document.location.reload();
								},
								onHide : function(){
								   if($j.browser.msie) {
									   window.frames["build"].window["__flash__removeCallback"] = function(instance,name) {
										   return;   
									   }
								   }
								},								
								title : '上传图片',
								minWidth : 500,
								minHeight : 310,
								contents : [
									{
										id : 'tab1',
										label : 'First Tab',
										title : 'First Tab',
										elements :
										[
											{
												id : 'input1',
												type : 'html',
												html : "<div style='height:300px;overflow:hidden;'><iframe src='"+System.site+"/js/fancyupload/showcase/photoqueue/uploadPic.jsp' scrolling='no' style='width:500px;height:300px;' id='build' name='build' frameborder='0'></iframe></div>"
											}
										]
									}
								]
							};
						} );
					}
					// Register the command used to open the dialog.
					editor.addCommand( 'myDialogCmd', new CKEDITOR.dialogCommand('DCampus_PhotoDialog'));
					// Add the a custom toolbar buttons, which fires the above
					// command..
					editor.ui.addButton( 'DCampus_OpenPhotoDialogButton',
					{
						label : '插入图片',
						command : 'myDialogCmd'
					} );
			});//添加编辑器插件结束
			DCampus.GroupListUI._isIntitalEditor = false;
	   }
	   //请求板块选项
	   DCampus.Public.AjaxRequestFunction(System.site+"/forum/getForums.action?temp="+Math.random(),"groupId="+$j("input[name='groupId']").val(),"get",DCampus.GroupListData._requestOptionSuccess);
	},
	_closeCreateThreadDialog : function(){
		//关闭对话框执行的方法
	   CKEDITOR.instances.discussBody.setData("");
	   $j("input[name='topic']").val("");
	}
};