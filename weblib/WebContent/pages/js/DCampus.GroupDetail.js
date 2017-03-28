// JavaScript Document
DCampus.GroupDetailData = {
	  _CKEDITOR : CKEDITOR,
	  _detailTemplate : null,
	   //成功请求成员列表返回方法
      _requestMemberListSuccess : function(jsonObj){
		  //alert(jsonObj);
	  },
	  //发表主题后执行
	  _createThreadSuccess : function(jsonObj) {
		   $j("body").message({message:"发表成功"});
    	   window.location.href= $j(".list005").find("a").eq(1).attr("href");
	   },
	  //发表帖子后执行
	  _createPostSuccess : function(jsonObj) {
		   $j("body").message({message:"发表成功"});
		   $j.cookie("position",parseInt($j(".totalCount").eq(0).text()));
		   if(parseInt($j(".totalCount").eq(0).text()) % DCampus.GroupDetailUI.limit == 0) {
               var jumpNum = parseInt($j(".myThreadpageCount").eq(0).text()) + 1;
	           DCampus.GroupDetailUI._pageScrollFunction(jumpNum);//翻页
				DCampus.Public.Dialog({
						handler:"createThreadDialog"
						,close:true
						,closeFunction : DCampus.GroupDetailUI._closePostDialog
				});				   
           } else if($j(".currentPage").eq(0).text() != $j(".myThreadpageCount").eq(0).text()) {
                DCampus.GroupDetailUI._pageScrollFunction(parseInt($j(".myThreadpageCount").eq(0).text()));//翻页
				DCampus.Public.Dialog({
						handler:"createThreadDialog"
						,close:true
						,closeFunction : DCampus.GroupDetailUI._closePostDialog
				});					
		   }else {
			 window.location.reload();
		   }
	   },
	   _editPostSuccess : function(){
	      $j("body").message({message:"修改成功"});
		  window.location.reload();
	   },
	   //请求板块选项后执行的方法
	   _requestOptionSuccess : function(jsonObj){
		  for(i=0;i<jsonObj.forums.length;i++) {
			  $j("select[name='forumId']").append("<option value="+jsonObj.forums[i].id+">"+jsonObj.forums[i].name+"</option>");
		  }
	   },
		//显示detail
		_getDetailSuccess : function(jsonObj){
	        $j(".totalCount").text(jsonObj.totalCount);
			DCampus.GroupDetailUI.totalCount = jsonObj.totalCount;
			DCampus.GroupDetailUI.pageCount = DCampus.GroupDetailUI.totalCount / DCampus.GroupDetailUI.limit;
            if (DCampus.GroupDetailUI.pageCount * DCampus.GroupDetailUI.limit < DCampus.GroupDetailUI.totalCount) {
				DCampus.GroupDetailUI.pageCount++;
			}
			if(DCampus.GroupDetailUI.pageNum != 0) {
			 window.location.hash = "tid"+DCampus.GroupDetailUI.threadID+"/p/"+DCampus.GroupDetailUI.pageNum;
			}
			if(DCampus.GroupDetailUI.pageNum > Math.ceil(DCampus.GroupDetailUI.pageCount)) {
				DCampus.Public.HideLoading("container002");
			    $j(".threads-lst").show();
			    return;
			}
			if(DCampus.GroupDetailUI.pageNum > 1) {
			  $j(".prePage").show();
			} else {
			  $j(".prePage").hide();
			}
			if(Math.ceil(DCampus.GroupDetailUI.pageCount) > 1) {
			  $j(".nextPage").show();
			} else {
			  $j(".nextPage").hide();
			}
			if(DCampus.GroupDetailUI.pageNum ==  Math.ceil(DCampus.GroupDetailUI.pageCount)) {//如果当前页等于最大页数，隐藏下一页
			   $j(".nextPage").hide();
			}
			if (DCampus.GroupDetailUI.pageNum <= 0) {
				DCampus.GroupDetailUI.pageNum = 1;
			}
			if (DCampus.GroupDetailUI.pageNum > DCampus.GroupDetailUI.pageCount && DCampus.GroupDetailUI.pageCount > 0) {
				DCampus.GroupDetailUI.pageNum = Math.ceil(DCampus.GroupDetailUI.pageCount);
			}
			DCampus.GroupDetailUI.start = (DCampus.GroupDetailUI.pageNum - 1) * DCampus.GroupDetailUI.limit;
			if (DCampus.GroupDetailUI.start < 0) {
				DCampus.GroupDetailUI.start = 0;
			}
			DCampus.GroupDetailUI.listbegin = DCampus.GroupDetailUI.pageNum - Math.ceil(DCampus.GroupDetailUI.liststep / 2);//从第几页开始显示分页信息
			if (DCampus.GroupDetailUI.listbegin < 1) {
				DCampus.GroupDetailUI.listbegin = 1;
			}
			DCampus.GroupDetailUI.listend = DCampus.GroupDetailUI.pageNum + DCampus.GroupDetailUI.liststep / 2;
			if (DCampus.GroupDetailUI.listend > DCampus.GroupDetailUI.pageCount) {
				DCampus.GroupDetailUI.listend = DCampus.GroupDetailUI.pageCount + 1;
			}
			$j(".pageNumA").empty();
			for (var i = DCampus.GroupDetailUI.listbegin; i < DCampus.GroupDetailUI.listend; i++) {
			   var current = (i == DCampus.GroupDetailUI.pageNum ? "class='currentPage'" : "");
			   $j(".pageNumA").append("<a "+current+" href='javascript:DCampus.GroupDetailUI._pageScrollFunction("+i+");void(0);'>"+i+"</a> ")
			}
			$j(".myThreadPagenum").text(DCampus.GroupDetailUI.pageNum);
			$j(".myThreadpageCount").text(Math.ceil(DCampus.GroupDetailUI.pageCount));

			_detailTemplate = TrimPath.parseTemplate($j("#posts_template").val());
		    $j(".threads-lst").html(_detailTemplate.process(jsonObj));
			DCampus.Public.HideLoading("container002");
			$j(".detail-topic").text(jsonObj.topic);
			$j(".threads-lst").show();
			//回复帖子按钮事件
			$j(".btn-detail-reply").bind("click",function(){
				var __getStepInfo = "RE:"+$j(this).parent().parent().find(".step-num").text();
				$j("input[name='topic']").val(__getStepInfo);
				DCampus.Public.Dialog({
						handler:"createThreadDialog"
						,title:"回复帖子"
						,width:650
						,height:350
						,openFunction : DCampus.GroupDetailUI._openCreatePostDialog
						,closeFunction : DCampus.GroupDetailUI._closePostDialog
				});						
				CKEDITOR.instances.discussBody.setData("<div class='italic'><i>"+__getStepInfo+"</i></div><br/>");
			});
		   /**打开引用窗口**/
		   $j(".btn-repquote").bind("click",function(){
			   var __get_step_num = $j(this).parent().parent().find(".step-num").text();
			   var __get_current_body = "";
			   var __getStepInfo = "RE:"+__get_step_num;
			   $j("input[name='topic']").val(__getStepInfo);
				DCampus.Public.Dialog({
						handler:"createThreadDialog"
						,title:"引用回复"
						,width:650
						,height:350
						,openFunction : DCampus.GroupDetailUI._openCreatePostDialog
						,closeFunction : DCampus.GroupDetailUI._closePostDialog
				});				   
			   if($j(this).parent().parent().find(".detail-body").find(".blockquote").length != 0){
			      __get_current_body = $j(this).parent().parent().find(".detail-body").find(".blockquote").next().html();
			   } else {
			      __get_current_body = $j(this).parent().parent().find(".detail-body").html();
			   }
			   DCampus.GroupDetailUI._saveQuoteBody = __get_current_body;
			   CKEDITOR.instances.discussBody.setData("");
		   });
		   if($j.cookie("position") != null) {
			  $j("html,body").animate({scrollTop:$j("#step"+($j.cookie("position")-1).toString()).offset().top},100);
			  //发文成功后跳到用户当前帖子位置
			  $j.cookie("position",null);
		   }
		     //if(DCampus.Permission.DELETE_POST)//是圈主或者管理员
		 $j(".threads-lst").ListManage({toolWrapID:"ManageToolWrap",isListType:true,toggle:"manage-threads"});//select管理插件
		 $j(".btn-delete-one").bind("click",function(){//删除一条帖子
			 if(confirm("是否删除该帖子？")) {
				if($j(this).attr("rev") == "fThreads") {
				   DCampus.GroupDetailUI.fThreads = true;
				}
				DCampus.Public.AjaxRequestFunction(System.site+"/post/deletePost.action","postIds="+$j(this).attr("rel"),"POST",DCampus.GroupDetailData._DeleteSuccess);		    
			 }
		 });		
		 $j(".btn-detail-edit").bind("click",function(){
				DCampus.GroupDetailUI.savePostId = $j(this).attr("rel");									  
				var __getHtml = $j(this).parent().parent().find(".detail-body").html();
				var __getTitle =  "RE:" + $j(this).parent().parent().find(".step-num").text();
				$j("input[name='topic']").val(__getTitle);
				DCampus.Public.Dialog({
						handler:"createThreadDialog"
						,title:"编辑帖子"
						,width:650
						,height:350
						,openFunction : DCampus.GroupDetailUI._openCreatePostDialog
						,closeFunction : DCampus.GroupDetailUI._closePostDialog
				});					
				CKEDITOR.instances.discussBody.setData(__getHtml);		    
		 });
		     $j(".detail-body").width($j(window).width()-379);//宽度自适应
		},
		//请求正文失败
		_getDetailError : function(jsonObj) {
		   if(jsonObj.code == "300") {
		      window.location.href = System.site+"/pages/error.jsp";
		   } else {
		      $j("body").message({message:jsonObj.detail,warning:true});
		   }
		},
		_DeleteSuccess : function(jsonObj){
		   if(DCampus.GroupDetailUI.fThreads) {
			   window.location.href = "list.jsp";
		   } else {
			   $j("body").message({message:"删除成功"});
			   $j(".threads-lst").ListManage({close:true,toolWrapID:"ManageToolWrap"}); //关闭管理窗口
			   DCampus.GroupDetailUI._getThreadList();//重新获取列表
		   }
		},
		_requestForumSuccess : function(jsonObj){
			for(i=0;i<jsonObj.forums.length;i++) {
			   if(jsonObj.forums[0].name == "default") {
				 DCampus.GroupDetailUI._defaultForumId = jsonObj.forums[i].id;
				 break;
			   }
			}
		}
}
$j(function(){
	/******************************************************/
   /*        初始化页面内容，主要是获取页面上的json数据        */
   /******************************************************/
    $j(window).resize(function(){$j(".detail-body").width($j(window).width()-379);});//宽度自适应
    if(json.type != "error") {
     /**获取forum**/
	   if(DCampus.Permission.view_group) {
         DCampus.Public.AjaxRequestFunction(System.site+"/forum/getForums.action?temp="+Math.random(),"groupId="+$j("input[name='groupId']").val(),"get",DCampus.GroupDetailData._requestForumSuccess);
	   }
	}
	//获取detail列表
    DCampus.GroupDetailUI._getThreadList();//重新获取列表
   /*模拟下拉框*/
   $j(".chooseType").bind("click",function(){
       if($j(".selectInput").find("ul").css("display") == "none") {
	      $j(".selectInput").find("ul").slideDown("fast");
	   } else {
	      $j(".selectInput").find("ul").slideUp("fast");
	   }
   });
   $j(".selectInput").find("ul").bind("mouseleave",function(){
	  $j(".selectInput").find("ul").slideUp("fast");
   }).find("a").bind("click",function(){
	   $j(".selectInput span").text($j(this).text());
	   $j(".selectInput").find("ul").slideUp("fast");
   });
   /**打开发表主题的窗口**/
   $j(".btn-newTopic").bind("click",function(){
		//这个方法是可以打开对话框，并初始化对话框的宽和高，对话框参数只初始化一次
		DCampus.Public.Dialog({
				handler:"createThreadDialog"
				,title:"发表帖子"
				,width:650
				,height:350
				,openFunction : DCampus.GroupDetailUI._openCreateThreadDialog
				,closeFunction : DCampus.GroupDetailUI._closeCreateThreadDialog
		});			
	});
   /**打开回复主题窗口**/
   $j(".btn-reply").bind("click",function(){
		$j("input[name='topic']").val("RE:"+$j(".detail-topic").text());
		DCampus.Public.Dialog({
				handler:"createThreadDialog"
				,title:"回复主题"
				,width:650
				,height:350
				,openFunction : DCampus.GroupDetailUI._openCreatePostDialog
				,closeFunction : DCampus.GroupDetailUI._closePostDialog
		});		
   });
   $j(".dialog-btn-publish").bind("click",function(){
       if($j("input[name='topic']").val() == "") {
		   $j("body").message({message:"请填写标题",warning:true});
	   } else {
		   switch($j(".ui-dialog-title").text()) {
			   case "发表帖子":DCampus.Public.AjaxRequestFunction(System.site+"/thread/createThread.action","topic="+encodeURIComponent($j("input[name='topic']").val())+"&body="+encodeURIComponent(CKEDITOR.instances.discussBody.getData())+"&forumId="+DCampus.GroupDetailUI._defaultForumId+"&memberVisible=true"/*+$j("input[name='memberVisible']").attr("checked")*/,"POST",DCampus.GroupDetailData._createThreadSuccess);break;
			   case "回复主题":
			   case "回复帖子":
			   DCampus.Public.AjaxRequestFunction(System.site+"/post/createPost.action","topic="+encodeURIComponent($j("input[name='topic']").val())+"&body="+encodeURIComponent(CKEDITOR.instances.discussBody.getData())+"&threadId="+$j(".tdL").eq(0).attr("threadId")+"&memberVisible=true"/*+$j("input[name='memberVisible']").attr("checked")*/,"POST",DCampus.GroupDetailData._createPostSuccess);break;
			   case "引用回复":
			   var postBody = CKEDITOR.instances.discussBody.getData();
				     result = DCampus.GroupDetailUI._saveQuoteBody;
			       postBody = "<div class='blockquote'><blockquote style='margin:0;'>"+result+"</blockquote></div>" + postBody;//重新组织内容
			 DCampus.Public.AjaxRequestFunction(System.site+"/post/createPost.action","topic="+encodeURIComponent($j("input[name='topic']").val())+"&body="+encodeURIComponent(postBody)+"&threadId="+$j(".tdL").eq(0).attr("threadId")+"&memberVisible=true"/*+$j("input[name='memberVisible']").attr("checked")*/,"POST",DCampus.GroupDetailData._createPostSuccess);DCampus.GroupDetailUI._saveQuoteBody = "";break;
			 case "编辑帖子" : DCampus.Public.AjaxRequestFunction(System.site+"/post/modifyPost.action","topic="+encodeURIComponent($j("input[name='topic']").val())+"&body="+encodeURIComponent(CKEDITOR.instances.discussBody.getData())+"&postId="+DCampus.GroupDetailUI.savePostId,"POST",DCampus.GroupDetailData._editPostSuccess);break; 
		   }
	   }
   });
   //分页事件
   	$j(".nextPage").bind("click",function(){
        if (DCampus.GroupDetailUI.pageNum < DCampus.GroupDetailUI.pageCount) {
		   DCampus.GroupDetailUI.pageNum = DCampus.GroupDetailUI.pageNum + 1;
		   DCampus.GroupDetailUI._pageScrollFunction(DCampus.GroupDetailUI.pageNum);
		}
	});
	 $j(".prePage").bind("click",function(){
		  DCampus.GroupDetailUI.pageNum = DCampus.GroupDetailUI.pageNum - 1;
		  DCampus.GroupDetailUI._pageScrollFunction(DCampus.GroupDetailUI.pageNum);
	 });
	 $j(".go_botton").bind("click",function(){
	    DCampus.GroupDetailUI._pageScrollFunction($j(this).parent().parent().parent().find(".pageInput").val());
		$j(".pageInput").val("");
	 });
	 $j(".pageInput").bind("keypress",function(event){
		  if(event.keyCode == 13) {
			   $j(this).parent().parent().parent().find(".go_botton").trigger("click");
			   return false;
		  }
	 });
	 //删除帖子
	 $j(".delete").bind("click",function(){
		  var deleteIdArr = "";
		  var Ochecked = $j(".threads-lst").find("input:checked");
		  if(confirm("是否删除选中的 "+Ochecked.length+" 篇帖子？")) {
				for(i=0;i<Ochecked.length;i++){
				   if(Ochecked.eq(i).attr("rev") == "fThreads") {
					   DCampus.GroupDetailUI.fThreads = true;
				   }
				   if(i==0) {
					  deleteIdArr += "postIds="+Ochecked.eq(i).val();
				   } else {
					  deleteIdArr += "&postIds="+Ochecked.eq(i).val();
				   }
				}
			 if(deleteIdArr == "") {
			   $j("body").message({message:"请选择要删除的帖子",warning:true});
			 } else {
				DCampus.Public.AjaxRequestFunction(System.site+"/post/deletePost.action",deleteIdArr,"POST",DCampus.GroupDetailData._DeleteSuccess);
			 }
		  }
	 });//删除帖子

});

DCampus.GroupDetailUI = {
	_isIntitalEditor : true,
	_defaultForumId : 0,
	limit : 10,
	start : 0,
	liststep : 10,
	pageNum : 1,
	pageCount : 0,
	totalCount : 0,
	listbegin : 0,
	listend : 0,
	firstload : true,
	threadID : 0,
	savePostId : 0,
	_saveQuoteBody : "", //保存引用的原文
	fThreads : false,//是否首贴
	_pageScrollFunction : function(pageNum){
		$j(".threads-lst").hide();
		DCampus.Public.ShowLoading("container002","",0,100,0,System.site);//显示loading图标
		DCampus.GroupDetailUI.pageNum = pageNum;
		DCampus.GroupDetailUI.start = (DCampus.GroupDetailUI.pageNum - 1) * DCampus.GroupDetailUI.limit;
		if(DCampus.Permission.MODIFY_GROUP)//是圈主或者管理员
		$j(".threads-lst").ListManage({close:true,toolWrapID:"ManageToolWrap"}); //关闭管理窗口
		if(window.location.href.indexOf("/p/") != -1) {
		  DCampus.GroupDetailUI.threadID = window.location.href.substring(window.location.href.lastIndexOf("#tid")+4,window.location.href.indexOf("/p/"));//获取threadID
		} else {
		  DCampus.GroupDetailUI.threadID = window.location.href.substring(window.location.href.lastIndexOf("#tid")+4);//获取threadID
		}
		DCampus.Public.AjaxRequestFunction(System.site+"/post/posts.action?temp="+Math.random(),"threadId="+DCampus.GroupDetailUI.threadID+"&start="+DCampus.GroupDetailUI.start+"&limit="+DCampus.GroupDetailUI.limit,"get",DCampus.GroupDetailData._getDetailSuccess,DCampus.GroupDetailData._getDetailError);
	},
	_openCreateThreadDialog : function(){
       DCampus.GroupDetailUI._inistialCkeditor();
	   //请求板块选项
	   DCampus.Public.AjaxRequestFunction(System.site+"/forum/getForums.action","groupId="+$j("input[name='groupId']").val(),"get",DCampus.GroupDetailData._requestOptionSuccess);
	},
	_closeCreateThreadDialog : function(){
		//关闭对话框执行的方法
	   CKEDITOR.instances.discussBody.setData("");
	   $j("input[name='topic']").val("");
	},
	_openCreatePostDialog : function(){//打开回复窗口
		DCampus.GroupDetailUI._inistialCkeditor();
	},
	_closePostDialog : function(){
		$j("input[name='topic']").val("");
	},
	_inistialCkeditor : function(){
		//打开窗口的时候创建CKEditor，这个方法只会调用一次
		if(DCampus.GroupDetailUI._isIntitalEditor) {
			//调用编辑器
			var editor = DCampus.GroupDetailData._CKEDITOR.replace( 'discussBody',{
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
			DCampus.GroupDetailUI._isIntitalEditor = false;
	   }
	},
	_getThreadList : function(){
	  	//获取Detail
	    var p_index = window.location.href.indexOf("/p/");
		if (p_index != -1) {
		  DCampus.GroupDetailUI._pageScrollFunction(parseInt(window.location.href.substring(p_index+3)));
		} else {
		  DCampus.GroupDetailUI._pageScrollFunction(0);
		}
	}
};