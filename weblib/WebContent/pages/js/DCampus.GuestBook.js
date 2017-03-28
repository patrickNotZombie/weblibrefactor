// Javdescript Document
DCampus.GuestBookData = {
	_CKEDITOR : CKEDITOR,
		//成功请求成员列表返回方法
	_requestMemberListSuccess : function(jsonObj){
		$j("#members-lst").html(DCampus.GuestBookData._memberTemplate.process(jsonObj)); 
	},
	//请求板块选项后执行的方法
	_requestOptionSuccess : function(jsonObj){
		for(i=0;i<jsonObj.forums.length;i++) {
		  $j("select[name='forumId']").append("<option value="+jsonObj.forums[i].id+">"+jsonObj.forums[i].name+"</option>");
		}
	},
	_requestThreadsListSuccess : function(jsonObj){
		/**调用输出主题列表**/
		$j("#threads-lst").html(DCampus.GuestBookData._threadsTemplate.process(jsonObj));   
	},
	_requestSourceListSuccess : function(jsonObj){
		/**调用输出主题列表**/
		//$j("#sourceWrap").html(DCampus.GuestBookData._sourceTemplate.process(jsonObj));   		
	},
	//发表主题后执行
	_createThreadSuccess : function(jsonObj) {
		$j("body").message({message:"发表成功"});
		if($j(".pageNumA a").length != 0) {
		  $j(".pageNumA a").eq(0).trigger("click");
		} else {
		  $j(".container007").DCampusPaging("reflash");	 /**请求主题列表**/
		}
		$j(".guestTextarea").val("");
		DCampus.Public.Dialog({
				handler:"createThreadDialog"
				,close:true
				,closeFunction : DCampus.GuestBookUI._closeCreateThreadDialog
		});			
	},
	_saveAnnounceSuccess : function(){
       DCampus.Public.AjaxRequestFunction(System.site+"/group/getGroupInfo.action?temp="+Math.random(),"groupId="+$j("input[name='groupId']").val(),"POST",DCampus.GuestBookData._getAnnounceInfo);	   
	},
	_getAnnounceInfo : function(jsonObj){
		$j("body").message({message:"保存成功"});
	    $j("#inlineEdit").show().html(jsonObj.inform).css("visibility","visible");
	},
	_getReplyListSuccess : function(jsonObj){
		
		var moreReplyTrigger = $j(".reNews"+DCampus.GuestBookUI.replyCount).parent().find(".moreReply");
		var __reNewsID = $j(".reNews"+DCampus.GuestBookUI.replyCount);
		if (DCampus.GuestBookUI.replyCount < DCampus.GuestBookUI.saveReplyID.length) {
		$j(__reNewsID).html(DCampus.GuestBookUI.replyTemplate.process(jsonObj)).parent().find(".moreReply").text(jsonObj.totalCount-1);
		if(moreReplyTrigger.text() > 5) {
		   	moreReplyTrigger.parent().removeClass("hidden");
		}
		DCampus.GuestBookUI.replyCount++;
		if(DCampus.GuestBookUI.replyCount != DCampus.GuestBookUI.saveReplyID.length)
		DCampus.GuestBookUI._getReplyList();
		}
	},
	_reflashReplyListSuccess : function(jsonObj){
		var __trigger = $j("."+DCampus.GuestBookUI.saveTemplateTrigger);
		__trigger.html(DCampus.GuestBookUI.replyTemplate.process(jsonObj));
		if(jsonObj.totalCount > 6) {
		   __trigger.parent().find(".more").removeClass("hidden");
		} else {
		   __trigger.parent().find(".more").addClass("hidden");
		}
		$j(".moreReply").text(jsonObj.totalCount-1);
	},	
	_createPostSuccess : function(jsonObj){
	   //alert("发表成功");
	   $j(".reContainer").addClass("hidden");
	   $j(".reList .reOut").show();		
	   DCampus.Public.AjaxRequestFunction(System.site+"/post/posts.action?temp="+Math.random(),"threadId="+DCampus.GuestBookUI.saveReID+"&start=0&limit=6&order=desc","POST",DCampus.GuestBookData._reflashReplyListSuccess);
	},
	_createPostSuccessAll : function(){
	   //alert("发表成功");
	   $j(".reContainer").addClass("hidden");
	   $j(".reList .reOut").show();		
	   DCampus.Public.AjaxRequestFunction(System.site+"/post/posts.action?temp="+Math.random(),"threadId="+DCampus.GuestBookUI.saveReID+"&start=0&limit=100&order=desc","POST",DCampus.GuestBookData._reflashReplyListSuccess);
	},
	_DeleteSuccess : function(jsonObj){
        DCampus.Public.AjaxRequestFunction(System.site+"/post/posts.action?temp="+Math.random(),"threadId="+DCampus.GuestBookUI.saveReID+"&start=0&limit=6&order=desc","POST",DCampus.GuestBookData._reflashReplyListSuccess);
	},
	_DeleteSuccessAll : function(){
        DCampus.Public.AjaxRequestFunction(System.site+"/post/posts.action?temp="+Math.random(),"threadId="+DCampus.GuestBookUI.saveReID+"&start=0&limit=100&order=desc","POST",DCampus.GuestBookData._reflashReplyListSuccess);
	},
	_deleteThrLstSuccess : function(){
	   $j(".container007").DCampusPaging("reflash");
	}
}
/**
   页面加载完毕执行事件
**/
$j(function(){
	 DCampus.GuestBookUI._init();//页面初始化函数		
	 $j(".createThread").bind("click",DCampus.GuestBookUI._createThread_Function);/**打开发表主题的窗口**/
	 $j(".uploadResources").bind("click",DCampus.GuestBookUI._uploadResources_Function);/**打开发资源上传窗口**/  
	 $j(".dialog-btn-publish").bind("click",DCampus.GuestBookUI._dialog_btn_publish_Function); //发表主题按钮事件
	 $j(".dialog-btn-confirm").bind("click",DCampus.GuestBookUI._dialog_btn_confirm);//上传资源确定事件
	  //$j("#groups-frontpage-inlineEdit").bind("click",DCampus.GuestBookUI._groups_frontpage_inlineEdit_Function);//inline edit
     $j("#editFrontpage").bind("click",DCampus.GuestBookUI._editFrontpage_Function);//关闭并保存首页描述编辑
	 $j("#addFavorite").bind("click",DCampus.GuestBookUI._addFavorite_Function);/**收藏本站**/
     $j(".btn-publish-message").bind("click",DCampus.GuestBookUI._btn_publish_message_Function);//发表留言
	 
	 /*$j("body").bind("keydown",function(){
		if($j.browser.msie){
		   if(e.ctrlKey && e.keyCode==13){
		       alert(213);
		   }
		}else{
		   if(isKeyTrigger(e,13,true)){
		      alert(213);
		   }
		}	
	 });*/
	 
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

DCampus.GuestBookUI = {
	
	_isIntitalEditor : true,
	
	_isInlineEditor : true,
	
	_editor : null,
	
	limit : 10,//列表条数
	start : 0,//开始值
	liststep : 10,	
	pageNum : 0,	
	pageCount : 0,
	totalCount : 0,
	listbegin : 0,
	listend : 0,	
	saveReID : 0,
	saveReplyID : [],
	replyCount : 0,
	saveTemplateTrigger : 0,
	_isIntitalEditor : true,
	_defaultForumId : $j("#defaultForumID").val(),
	firstload : true,
	isPaging : false,	
	
	_init : function(){
			DCampus.Public.ListHover({cssName:"resourceHover",handler:$j("#threads-lst")});//列表鼠标经过
			DCampus.Public.ListHover({cssName:"resourceHover",handler:$j("#sourceWrap"),oprtText:true});//列表鼠标经
			DCampus.GuestBookData._threadsTemplate = TrimPath.parseTemplate($j("#threads_template").val());//主题列表模板
			DCampus.GuestBookUI.replyTemplate = TrimPath.parseTemplate($j("#replyListTemplate").val());//回复列表模板
			$j("#inlineEdit").html(json.inform);
			if(typeof(myOwnMemberList) != "undefined")
		    $j(".guestICO").html("<img src='"+myOwnMemberList.memberIcon+"' width='50' height='50'/>");
		   //初始化页面内容，主要是获取页面上的json数据
		   if(json.type != "error") {
			/**
				请求列表
			**/
			if(window.location.href.lastIndexOf("/p/") != -1) {
			   var locationNum = window.location.href.substring(window.location.href.lastIndexOf("/p/")+3);
			   DCampus.GuestBookUI.pageNum = parseInt(locationNum);
			   DCampus.GuestBookUI.isPaging = true;
			} 					
					
			//请求文章列表
			 $j(".container007").DCampusPaging({
					 "limit":DCampus.GuestBookUI.limit             /** 显示条数默认20条    **/
					,"start":DCampus.GuestBookUI.start              /** 开始位置 默认从0开始**/
					,"liststep":DCampus.GuestBookUI.liststep          /** 分页显示长度 默认10 **/	
					,"pageNum":DCampus.GuestBookUI.pageNum            /** 默认第一页开始      **/	
					,"pageCount":DCampus.GuestBookUI.pageCount          /** 页数                **/
					,"totalCount":DCampus.GuestBookUI.totalCount         /** 列表总数            **/
					,"listbegin":DCampus.GuestBookUI.listbegin
					,"listend":DCampus.GuestBookUI.listend							 
					,"RequestPath" : System.site+"/thread/getThreads.action?temp="+Math.random()
					,"RequestData" : "forumId="+$j("#defaultForumID").val()
					,"PageJson":listJSON
					,"isPaging": DCampus.GuestBookUI.isPaging
					,"onBeforeStart":function(){
						if(DCampus.Permission.delete_thread) {
							$j(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});//关闭管理窗
						}
						$j(".mainPage").hide();
						DCampus.Public.ShowLoading("container007","",0,100,0,System.site);//显示loading图标
						DCampus.GuestBookUI.replyCount = 0;//计数清0
                        DCampus.GuestBookUI.saveReplyID = [];//数组清空
						}
					 ,"onLoad" : function(jsonObj){
					   DCampus.Public.HideLoading("container007");
						/**调用输出主题列表**/
					   var _template = TrimPath.parseTemplate($j("#threads_template").val());
					   $j(".mainPage").html(_template.process(jsonObj));
					   $j(".mainPage").show();
					   //select管理插件
					   if(DCampus.Permission.delete_thread) {
						 $j(".table001 th").removeClass("displayNone");
						 $j(".table001 td").removeClass("displayNone");
						 $j(".slct-tbl").ListManage({hasTH:true,isListType:true,listBgColor:"#fff8bf",toolWrapID:"ManageToolWrap"});
					  }
					},onComplete : function(){
	
					}});	
			//DCampus.GuestBookData._requestThreadsListSuccess(newThreadsJSON);
		}	   
	   if(DCampus.Permission.Group_Manager) { //是否管理员
		  DCampus.Public.AjaxRequestFunction(System.site+"/user/getRequestingMembers.action?temp="+Math.random(),"groupId="+json.groupId,"POST"
		 ,function(jsonObj){
			 if(jsonObj.totalCount > 0) {
			  $j("#joinMessage").removeClass("displayNone");
			  $j(".joinCount").text(jsonObj.totalCount);
			 }
		  });  
	   }
	   
	   $j(".container007").bind("click",function(e){
			var target = $j(e.target);
			if(target.is(".re")) {
			   $j(".reContainer").addClass("hidden");
			   $j(".reList .reOut").show();
			   target.parent().hide().parent().next().removeClass("hidden").find(".reOut")
			   .html("<textarea></textarea>").find("textarea")
			   .focus().blur(function(){
							      if($j(this).val() == "") {
									  $j(".reContainer").addClass("hidden");
									  $j(".reList .reOut").show();
								  }
							 });
			}
			if(target.is(".reCancel")) {
			  $j(".reContainer").addClass("hidden");
			  $j(".reList .reOut").show();
			}
			if(target.is(".reOk")) {
			   var _getParent = target.parent().parent().parent();
			   var _doneSuccessFuntion = DCampus.GuestBookData._createPostSuccess;
			   DCampus.GuestBookUI.saveReID	 = target.attr("id");
			   DCampus.GuestBookUI.saveTemplateTrigger = _getParent.find(".reNews").attr("class").split(" ")[0];
			   if(target.parents(".item").find(".less").css("display") == "inline") {
			      _doneSuccessFuntion = DCampus.GuestBookData._createPostSuccessAll;
			   }
			   DCampus.Public.AjaxRequestFunction(System.site+"/post/createPost.action","topic="+_getParent.find(".replyTitle").text()+"&body="+encodeURIComponent(_getParent.find("textarea").val())+"&threadId="+target.attr("id")+"&memberVisible=true","POST",_doneSuccessFuntion);
			}
			if(target.is(".more") || target.parent().is(".more")) {
			   if(target.attr("class") != "more") {
			      target = target.parent();
			   }
			   target.hide().parent().find(".less").show();
			   DCampus.GuestBookUI.saveTemplateTrigger = target.attr("rev");
			   DCampus.Public.AjaxRequestFunction(System.site+"/post/posts.action?temp="+Math.random(),"threadId="+target.attr("rel")+"&start=0&limit=100&order=desc","POST",DCampus.GuestBookData._reflashReplyListSuccess);
			}
			if(target.is(".hide") || target.parent().is(".hide")) {
			   if(target.attr("class") != "less hide") {
			      target = target.parent();
			   }	
			   target.hide().parent().find(".more").show();
			   DCampus.GuestBookUI.saveTemplateTrigger = target.attr("rev");
			   DCampus.Public.AjaxRequestFunction(System.site+"/post/posts.action?temp="+Math.random(),"threadId="+target.attr("rel")+"&start=0&limit=6&order=desc","POST",DCampus.GuestBookData._reflashReplyListSuccess);
			 }
			 if(target.is(".deletePost")) {
				//删除帖子	
				var deleteIdArr = "";
				 _doneSuccessFuntion = DCampus.GuestBookData._DeleteSuccess;
				DCampus.GuestBookUI.saveReID	 = target.parent().parent().parent().parent().find(".more").attr("rel");
				DCampus.GuestBookUI.saveTemplateTrigger = target.parent().parent().parent().attr("class").split(" ")[0];
				var Ochecked = $j(".threads-lst").find("input:checked");
			    if(target.parents(".item").find(".less").css("display") == "inline") {
			      _doneSuccessFuntion = DCampus.GuestBookData._DeleteSuccessAll;
			    }				
				if(confirm("是否删除该回复？")) {
				 deleteIdArr = "postIds="+target.attr("rev");
				 DCampus.Public.AjaxRequestFunction(System.site+"/post/deletePost.action",deleteIdArr,"POST",_doneSuccessFuntion);
				}
			 }
			 if(target.is(".deleteThread")) {
				  if(confirm("是否删除该留言？")) {			
					DCampus.Public.AjaxRequestFunction(System.site+"/thread/deleteThread.action?temp="+Math.random(),"threadId="+target.attr("rev"),"POST",DCampus.GuestBookData._deleteThrLstSuccess);
				}
			 }
	   }).bind("mouseover",function(e){
	        var target = $j(e.target);
			if(target.parents(".item").length != 0) {
			   target.parents(".item").find(".deleteThread").removeClass("displayNone").prev().hide();
			}
	   }).bind("mouseout",function(){	
			$j(".deleteThread").addClass("displayNone");
			$j(".guestTime").show();
	   });
	},
	
	_openCreateThreadDialog : function(){
		//打开窗口的时候创建CKEditor，这个方法只会调用一次
		if(DCampus.GuestBookUI._isIntitalEditor) {
			//调用编辑器
			var editor = DCampus.GuestBookData._CKEDITOR.replace( 'discussBody',{
					// Defines a simpler toolbar to be used in this sample.
					// Note that we have added out "MyButton" button here.
			toolbar : [
			['Bold','Italic','Underline','Strike'],['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],['Link','Unlink','Image','Table'],'/',['Format','Font','FontSize','TextColor','BGColor'],['Maximize','DCampus_OpenPhotoDialogButton']
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
			});
			DCampus.GuestBookUI._isIntitalEditor = false;
	   }
	   //请求板块选项
	   DCampus.Public.AjaxRequestFunction(System.site+"/forum/getForums.action?temp="+Math.random(),"groupId="+$j("input[name='groupId']").val(),"POST",DCampus.GuestBookData._requestOptionSuccess);
	},
	
	_closeCreateThreadDialog : function(){
		//关闭对话框执行的方法
	   //CKEDITOR.instances.discussBody.setData("");
	   //$j("input[name='topic']").val("");
	},
	
	_openUploadDialog : function(){
	   $j(".uploadIframe").html("<iframe src='"+System.site+"/js/fancyupload/showcase/photoqueue/uploadResource.jsp' scrolling='no' style='width:525px;height:300px;' id='build' name='build' rel="+json.groupId+" frameborder='0'></iframe>");
	   //window.frames["build"].document.location.reload();
	},
	
	_replaceDivEditor : function(element){
		//if (DCampus.GuestBookUI._editor)
		//DCampus.GuestBookUI._editor.destroy();
		//DCampus.GuestBookUI._editor = CKEDITOR.replace(element);	
	},
	_createThread_Function : function(){
		//这个方法是可以打开对话框，并初始化对话框的宽和高，对话框参数只初始化一次
		DCampus.Public.Dialog({
				handler:"createThreadDialog"
				,title:"发表主题"
				,width:650
				,height:372
				,openFunction : DCampus.GuestBookUI._openCreateThreadDialog
				,closeFunction : DCampus.GuestBookUI._closeCreateThreadDialog
		});			
	},
	_uploadResources_Function : function(){
		//这个方法是可以打开对话框，并初始化对话框的宽和高，对话框参数只初始化一次
		DCampus.Public.Dialog({
				handler:"uploadDialog"
				,title:"上传资源"
				,width:525
				,height:300
				,openFunction : DCampus.GuestBookUI._openUploadDialog
		});			
	},
	_dialog_btn_publish_Function : function(){
       if($j("input[name='topic']").val() == "") {
		   alert("请填写标题");
	   } else {
		 //发表新主题请求 
	     DCampus.Public.AjaxRequestFunction(System.site+"/thread/createThread.action?temp="+Math.random(),"topic="+encodeURIComponent($j("input[name='topic']").val())+"&body="+encodeURIComponent(CKEDITOR.instances.discussBody.getData())+"&forumId="+$j("select[name='forumId']").val()+"&memberVisible=true"/*+$j("input[name='memberVisible']").attr("checked")*/,"POST",DCampus.GuestBookData._createThreadSuccess);
	   }	
	},
	_dialog_btn_confirm : function(){
	   //请求资源列表
		DCampus.Public.AjaxRequestFunction(System.site+"/group/getResources.action?temp="+Math.random(),"groupId="+json.groupId+"&start=1&limit=11","POST",DCampus.GuestBookData._requestSourceListSuccess);        
		DCampus.Public.Dialog({
				handler:"uploadDialog"
				,close:true
				,closeFunction : DCampus.GuestBookUI._closeCreateThreadDialog
		});		   
	 },
	 _groups_frontpage_inlineEdit_Function : function(){
	   //DCampus.GuestBookUI._replaceDivEditor($j(this)[0]);
	},
	_editFrontpage_Function : function(){ 
		//打开窗口的时候创建CKEditor，这个方法只会调用一次
		if(DCampus.GuestBookUI._isInlineEditor) {
			//调用编辑器
			var editor = DCampus.GuestBookData._CKEDITOR.replace( 'inlineEdit',{

			toolbar : [
			['Bold','Italic','Underline','Strike'],['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],['Link','Unlink','Image','Table'],'/',['Format','Font','FontSize','TextColor','BGColor'],['Maximize']
			]
				});

			DCampus.GuestBookUI._isInlineEditor = false;
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
			   DCampus.Public.AjaxRequestFunction(System.site+"/group/modifyGroupInform.action?temp="+Math.random(),"groupId="+json.groupId+"&inform="+encodeURIComponent(CKEDITOR.instances.inlineEdit.getData()),"POST",DCampus.GuestBookData._saveAnnounceSuccess); 
			}			
	},
	
	_addFavorite_Function : function(){
	   if($j.browser.safari) {
		 alert("本功能不能再该浏览器使用！");  
	   } else {
			if($j.browser.msie ) {
					 window.external.addFavorite(location.href,'DCampus BBS2008');
				   } else {
					 window.sidebar.addPanel('DCampus BBS2008', location.href, "");
				   }
	   } 
	},
	_getReplyList : function(){
		  DCampus.Public.AjaxRequestFunction(System.site+"/post/posts.action?temp="+Math.random(),"threadId="+DCampus.GuestBookUI.saveReplyID[DCampus.GuestBookUI.replyCount]+"&start=0&limit=6&order=desc","POST",DCampus.GuestBookData._getReplyListSuccess);
	   	
	},
	_btn_publish_message_Function : function(){
      DCampus.Public.AjaxRequestFunction(System.site+"/thread/createThread.action?temp="+Math.random(),"topic="+encodeURIComponent($j(".guestTextarea").val())+"&body="+encodeURIComponent($j(".guestTextarea").val())+"&forumId="+$j("#defaultForumID").val()+"&memberVisible=true"/*+$j("input[name='memberVisible']").attr("checked")*/,"POST",DCampus.GuestBookData._createThreadSuccess);
	}
}