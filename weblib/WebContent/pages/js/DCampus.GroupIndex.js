// JavaScript Document
DCampus.GroupIndexData = {
	_CKEDITOR : CKEDITOR,
		//成功请求成员列表返回方法
		_requestMemberListSuccess : function(jsonObj){
		$j("#members-lst").html(DCampus.GroupIndexData._memberTemplate.process(jsonObj)); 
	},
	//请求板块选项后执行的方法
	_requestOptionSuccess : function(jsonObj){
		for(i=0;i<jsonObj.forums.length;i++) {
		  $j("select[name='forumId']").append("<option value="+jsonObj.forums[i].id+">"+jsonObj.forums[i].name+"</option>");
		}
	},
	_requestThreadsListSuccess : function(jsonObj){
		/**调用输出主题列表**/
		$j("#threads-lst").html(DCampus.GroupIndexData._threadsTemplate.process(jsonObj));   
	},
	_requestSourceListSuccess : function(jsonObj){
		/**调用输出主题列表**/
		//$j("#sourceWrap").html(DCampus.GroupIndexData._sourceTemplate.process(jsonObj));   		
	},
	//发表主题后执行
	_createThreadSuccess : function(jsonObj) {
		$j("body").message({message:"发表成功"});
		DCampus.Public.AjaxRequestFunction(System.site+"/thread/getNewThreadsInGroup.action?temp="+Math.random(),"groupId="+$j("input[name='groupId']").val(),"get",DCampus.GroupIndexData._requestThreadsListSuccess);
		DCampus.Public.Dialog({
				handler:"createThreadDialog"
				,close:true
				,closeFunction : DCampus.GroupIndexUI._closeCreateThreadDialog
		});			
	},
	_saveAnnounceSuccess : function(){
       DCampus.Public.AjaxRequestFunction(System.site+"/group/getGroupInfo.action?temp="+Math.random(),"groupId="+$j("input[name='groupId']").val(),"POST",DCampus.GroupIndexData._getAnnounceInfo);	   
	},
	_getAnnounceInfo : function(jsonObj){
		$j("body").message({message:"保存成功"});
	    $j("#inlineEdit").show().html(jsonObj.inform).css("visibility","visible");
	}
}
/**
   页面加载完毕执行事件
**/
$j(function(){
	 DCampus.GroupIndexUI._init();//页面初始化函数		
	 $j(".createThread").bind("click",DCampus.GroupIndexUI._createThread_Function);/**打开发表主题的窗口**/
	 $j(".uploadResources").bind("click",DCampus.GroupIndexUI._uploadResources_Function);/**打开发资源上传窗口**/  
	 $j(".dialog-btn-publish").bind("click",DCampus.GroupIndexUI._dialog_btn_publish_Function); //发表主题按钮事件
	 $j(".dialog-btn-confirm").bind("click",DCampus.GroupIndexUI._dialog_btn_confirm);//上传资源确定事件
	  //$j("#groups-frontpage-inlineEdit").bind("click",DCampus.GroupIndexUI._groups_frontpage_inlineEdit_Function);//inline edit
     $j("#editFrontpage").bind("click",DCampus.GroupIndexUI._editFrontpage_Function);//关闭并保存首页描述编辑

/*模拟下拉框*/
   /*$j(".chooseType").bind("click",function(){
       if($j(".selectInput").find("ul").css("display") == "none") {
	      $j(".selectInput").find("ul").slideDown("fast");
	   } else {
	      $j(".selectInput").find("ul").slideUp("fast");
	   }
   });*/   
   /*$j(".selectInput").find("ul").bind("mouseleave",function(){
	  $j(".selectInput").find("ul").slideUp("fast");													
   }).find("a").bind("click",function(){
	   $j(".selectInput span").text($j(this).text());   
	   $j(".selectInput").find("ul").slideUp("fast");
   });*/   
});

DCampus.GroupIndexUI = {
	
	_isIntitalEditor : true,
	
	_isInlineEditor : true,
	
	_editor : null,
	
	_init : function(){
		DCampus.Public.ListHover({cssName:"resourceHover",handler:$j("#threads-lst")});//列表鼠标经过
		DCampus.Public.ListHover({cssName:"resourceHover",handler:$j("#sourceWrap"),oprtText:true});//列表鼠标经
		DCampus.GroupIndexData._memberTemplate = TrimPath.parseTemplate($j("#members_template").val());//会员列表
		DCampus.GroupIndexData._threadsTemplate = TrimPath.parseTemplate($j("#threads_template").val());//主题列表
		$j("#inlineEdit").html(json.inform);
		//DCampus.GroupIndexData._sourceTemplate = TrimPath.parseTemplate($j("#sourceTemplate").val());//资源列表		
		
	   //初始化页面内容，主要是获取页面上的json数据
	   if(json.type != "error") {
			if(DCampus.Permission.view_group) {
				//请求文章列表
				DCampus.GroupIndexData._requestThreadsListSuccess(newThreadsJSON);
			}
			if(DCampus.Permission.view_member) {
				/**
				  显示成员列表
				**/
				DCampus.GroupIndexData._requestMemberListSuccess(membersJSON);	    
			}	
			/**
				请求资源列表
			**/
			if(DCampus.Permission.view_resource) {
				DCampus.GroupIndexData._requestSourceListSuccess (resourcesJSON);
			}		 
	   }	   
	   
	   if(DCampus.Permission.Group_Manager) { //是否管理员
	      DCampus.Public.AjaxRequestFunction(System.site+"/user/getRequestingMembers.action?temp="+Math.random(),"groupId="+json.groupId,"get"
		 ,function(jsonObj){
			 if(jsonObj.totalCount > 0) {
		      $j("#joinMessage").removeClass("displayNone");
			  $j(".joinCount").text(jsonObj.totalCount);
			 }
		  });  
	   }
	},
	
	_openCreateThreadDialog : function(){
		//打开窗口的时候创建CKEditor，这个方法只会调用一次
		if(DCampus.GroupIndexUI._isIntitalEditor) {
			//调用编辑器
			var editor = DCampus.GroupIndexData._CKEDITOR.replace( 'discussBody',{
					// Defines a simpler toolbar to be used in this sample.
					// Note that we have added out "MyButton" button here.
			toolbar : [
			['Bold','Italic','Underline','Strike'],['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],['Link','Unlink','Image','Table'],['DCampus_OpenPhotoDialogButton'],'/',['Format','Font','FontSize','TextColor','BGColor'],['Maximize']
			]
				});
			// Listen for the "pluginsLoaded" event, so we are sure that the
			// "dialog" plugin has been loaded and we are able to do our
			// customizations.
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
									   //fancyupload IE 的bug
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
					});
			});
			DCampus.GroupIndexUI._isIntitalEditor = false;
	   }
	   //请求板块选项

	   DCampus.Public.AjaxRequestFunction(System.site+"/forum/getForums.action?temp="+Math.random(),"groupId="+$j("input[name='groupId']").val(),"get",DCampus.GroupIndexData._requestOptionSuccess);
	},
	
	_closeCreateThreadDialog : function(){
		//关闭对话框执行的方法
	   CKEDITOR.instances.discussBody.setData("");
	   $j("input[name='topic']").val("");
	},
	
	_openUploadDialog : function(){
	   $j(".uploadIframe").html("<iframe src='"+System.site+"/js/fancyupload/showcase/photoqueue/uploadResource.jsp' scrolling='no' style='width:525px;height:300px;' id='build' name='build' rel="+json.groupId+" frameborder='0'></iframe>");
	   //window.frames["build"].document.location.reload();
	},
	
	_replaceDivEditor : function(element){
		//if (DCampus.GroupIndexUI._editor)
		//DCampus.GroupIndexUI._editor.destroy();
		//DCampus.GroupIndexUI._editor = CKEDITOR.replace(element);	
	},
	_createThread_Function : function(){
		//这个方法是可以打开对话框，并初始化对话框的宽和高，对话框参数只初始化一次
		DCampus.Public.Dialog({
				handler:"createThreadDialog"
				,title:"发表主题"
				,width:650
				,height:372
				,openFunction : DCampus.GroupIndexUI._openCreateThreadDialog
				,closeFunction : DCampus.GroupIndexUI._closeCreateThreadDialog
		});
	},
	_uploadResources_Function : function(){
		//这个方法是可以打开对话框，并初始化对话框的宽和高，对话框参数只初始化一次
		DCampus.Public.Dialog({
				 handler:"uploadDialog"
				 ,title:"上传资源"
				 ,width:525
				 ,height:300
				 ,openFunction : DCampus.GroupIndexUI._openUploadDialog
		});	 
	},
	_dialog_btn_publish_Function : function(){
       if($j("input[name='topic']").val() == "") {
		   $j("body").message({message:"请填写标题",warning:true});
	   } else {
		 //发表新主题请求 
	     DCampus.Public.AjaxRequestFunction(System.site+"/thread/createThread.action?temp="+Math.random(),"topic="+encodeURIComponent($j("input[name='topic']").val())+"&body="+encodeURIComponent(CKEDITOR.instances.discussBody.getData())+"&forumId="+$j("select[name='forumId']").val()+"&memberVisible=true"/*+$j("input[name='memberVisible']").attr("checked")*/,"POST",DCampus.GroupIndexData._createThreadSuccess);
	   }	
	},
	_dialog_btn_confirm : function(){
	   //请求资源列表
	   DCampus.Public.AjaxRequestFunction(System.site+"/group/getResources.action?temp="+Math.random(),"groupId="+json.groupId+"&start=0&limit=10","get",DCampus.GroupIndexData._requestSourceListSuccess);        
		DCampus.Public.Dialog({
				handler:"uploadDialog"
				,close:true
				,closeFunction : DCampus.GroupIndexUI._closeCreateThreadDialog
		});			   
	 },
	 _groups_frontpage_inlineEdit_Function : function(){
	   //DCampus.GroupIndexUI._replaceDivEditor($j(this)[0]);
	},
	_editFrontpage_Function : function(){ 
		//打开窗口的时候创建CKEditor，这个方法只会调用一次
		if(DCampus.GroupIndexUI._isInlineEditor) {
			//调用编辑器
			var editor = DCampus.GroupIndexData._CKEDITOR.replace( 'inlineEdit',{

			toolbar : [
			['Bold','Italic','Underline','Strike'],['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],['Link','Unlink','Image','Table'],'/',['Format','Font','FontSize','TextColor','BGColor'],['Maximize']
			]
				});

			DCampus.GroupIndexUI._isInlineEditor = false;
			} else {
				if($j("#cke_inlineEdit").css("display") != "none") {
				   $j("#cke_inlineEdit").hide();
				   $j("#showAnnounceArea").hide();
				} else {
				   $j("#cke_inlineEdit").show();
				   $j("#showAnnounceArea").show();
				}
	        }
	        if($j(this).text() == "编辑") {
			   $j(this).text("保存");
			   $j("#inlineEdit").hide();
			} else {
		       $j(this).text("编辑");
			   DCampus.Public.AjaxRequestFunction(System.site+"/group/modifyGroupInform.action?temp="+Math.random(),"groupId="+json.groupId+"&inform="+encodeURIComponent(CKEDITOR.instances.inlineEdit.getData()),"POST",DCampus.GroupIndexData._saveAnnounceSuccess); 
			}			
	}
}