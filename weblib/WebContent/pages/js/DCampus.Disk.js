/**
    资源列表数据处理函数
**/
DCampus.DiskData = {
	_deleteRlstSuccess : function(){
	   $j(".container002").DCampusPaging("Res-reflash");
	   $j("#checkAll").attr("checked","");
	},
	_requestCreateFolderSuccess : function(jsonObj){
		$j("input[name='folderName']").val("");
		$j(".container002").DCampusPaging("Res-reflash");
		DCampus.Public.Dialog({
				handler:"createFolder"
				,close:true
		});			
		$j("#folderTree").unbind().treeview({url: System.site+"/group/getResources.action"});//生成文件夹树 		
	},
	_getResourceSizeSuccess : function(jsonObj){
	   var total = jsonObj.totalSize;
	   var used = jsonObj.resourcesSize; 
	   if(total >= 1024 && total <= 1024*1024) {
	      total = DCampus.DiskUI._formatFloat(total / 1024 , 2) + "MB";
	   } else if(total >= 1024*1024) {
		      total = DCampus.DiskUI._formatFloat(total / 1024 / 1024 , 2) + "G";
		 } else {
	         total = total + "KB";
	      }
	   if(used >= 1024 && used <= 1024*1024) {
	      used = DCampus.DiskUI._formatFloat(used / 1024 , 2) + "MB";
	   } else if(used >= 1024*1024){
		    used = DCampus.DiskUI._formatFloat(used / 1024 / 1024 , 2) + "G";
		 }else {
	       used = used + "KB";
	     }	
	   $j(".totalSpace").text(total);
	   $j(".usedspace").text(used);
	   $j(".percent").text(DCampus.DiskUI._formatFloat(jsonObj.resourcesSize/jsonObj.totalSize*100,2)+"%");
	},
	_saveSuccess : function(){
		DCampus.Public.Dialog({
				handler:"renameDialog"
				,close:true
		});				
		$j(".container002").DCampusPaging("Res-reflash");	   
	},
	_moveSuccess : function(){
		DCampus.Public.Dialog({
				handler:"moveDialog"
				,close:true
		});		   
	   $j(".container002").DCampusPaging("Res-reflash");	
	   $j("#folderTree").unbind().treeview({url: System.site+"/group/getResources.action"});//生成文件夹树
	},
	_sendEmailSuccess : function(jsonObj){
		var pickAttachment = "";
	   for(i=0;i<jsonObj.resources.length;i++){
	      pickAttachment += "<table cellspacing='0' cellpadding='0' border='0'><tbody><tr><td><a target='_blank' title='下载' class='pickfilename' href='"+System.site+"/filedownload.jsp?filesize="+jsonObj.resources[i].filesize+"&name="+encodeURIComponent(jsonObj.resources[i].name)+"&id="+jsonObj.resources[i].id+"&code="+jsonObj.resources[i].code+"'>"+jsonObj.resources[i].name+"("+jsonObj.resources[i].filesize+"KB)</a></td><td><a title='删除' class='delete' href='javascript:void(0)' onclick='Compose.DeletePickAttachment(this)'>&nbsp;&nbsp;</a></td></tr></tbody></table>";
	   }
	   $j("#pickWrap").html(pickAttachment);
	   if($j(parent.window.document).find("#iframe02").attr("src").indexOf("compose.jsp") >= 0) {
	      $j(parent.window.document).find("#iframe02").contents().find("#vdiskListSpan").html(pickAttachment);
	   }
	   pickAttachment = null;
       parent.DCampus.FunctionTab.eq(2).trigger("click");
	},
	_getSingleSuccess : function(jsonObj){
	   var signleSize = jsonObj.singleSize;
	   DCampus.DiskUI.filesize = signleSize;
	   if(signleSize >= 1024 && signleSize <= 1024*1024) {
	      signleSize = DCampus.DiskUI._formatFloat(signleSize / 1024 , 2) + "MB";
	   } else if(signleSize >= 1024*1024){
		    signleSize = DCampus.DiskUI._formatFloat(signleSize / 1024 / 1024 , 2) + "G";
		 }else {
	       signleSize = signleSize + "KB";
	     }	   
	   $j("#sizelimit").text(signleSize);
	}
};
/**
   资源列表页面事件处理函数
**/
$j(function(){
	DCampus.DiskUI.PathTemplate = TrimPath.parseTemplate($j("#pathTemplate").val());
	DCampus.DiskUI.myGroupsTemplate = TrimPath.parseTemplate($j("#myGrupsTemp").val());	
	DCampus.DiskUI.shareTemplate = TrimPath.parseTemplate($j("#shareCategoryTemp").val());	
	
    DCampus.DiskUI.init();//页面初始化时执行的functon
	$j(".dialog-btn-save").bind("click",DCampus.DiskUI._dialog_btn_save_Function);//保存资源信息
	$j(".uploadResources").bind("click",DCampus.DiskUI._uploadResources_Function);//上传资源事件
	$j(".createFolder").bind("click",DCampus.DiskUI._createFolder_Function);//打开创建窗口	
	$j(".dialog-btn-confirm").bind("click",DCampus.DiskUI._dialog_btn_confirm_Function);//上传资源确定事件  	
	$j(".btn-del-rLst").bind("click",DCampus.DiskUI._btn_del_rLst_Function);//删除资源
	$j(".dialog-btn-createFolder").bind("click",DCampus.DiskUI._dialog_btn_createFolder_Function); //创建文件夹按钮事件
	$j(".btn-download").bind("click",DCampus.DiskUI._btn_download_Function);//打包下载事件
	$j(".moverResource").bind("click",DCampus.DiskUI._moverResource_Function);//移动资源
	$j(".dialog-btn-move").bind("click",DCampus.DiskUI._dialog_btn_move_Function);//确认移动
	$j(".btn_send_email").bind("click",DCampus.DiskUI._Btn_Send_Email);//资源发邮件
	$j(".shareResource").bind("click",DCampus.DiskUI._openFilePicker);//共享资源
    $j(".dialog-btn-share").bind("click",DCampus.DiskUI._Btn_ShareResource);//执行共享
    
	
				

});
/**
    资源列表UI部分函数
**/
DCampus.DiskUI = {
	limit : 20,//列表条数
	start : 0,//开始值
	liststep : 10,	
	pageNum : 0,	
	pageCount : 0,
	totalCount : 0,
	listbegin : 0,
	listend : 0,
	_sourceTemplate : null,
	isPaging : false,
	filesize : "",
	getCurrentID : "",
	init : function(){
		
		$j("#folderTree").bind("click",function(e){
		   var target = $j(e.target);
		   if(target.is("a")) {
			   $j("#folderTree").find("a").removeClass("chooseRed");
			   target.addClass("chooseRed");
		   }
		});		
		
		//显示下拉资源库列表
		$j("#chooseResource").html(DCampus.DiskUI.myGroupsTemplate.process(getMyGroups));
		
		//选中当前资源库
		$j.each($j("#chooseResource option"),function(){
			  if($j(this).val() == $j("#groupsInputId").val()) {
				   $j(this).attr("selected","selected");  
			  }								  
		});
		//下拉选择资源库
		$j("#chooseResource").bind("change",function(){
			if($j("this").val() != 0) {
			   window.location.href = "disk.jsp?diskId=" + $j(this).val();	
			} else {
				window.location.href = "disk.jsp";
			}
		});		
		setInterval(function(){DCampus.Public.AjaxRequestFunction(System.site+"/user/alive.action","","POST",function(){},function(){alert("请重新登录");});},60000);
		$j(".treeRoot").bind("click",function(){
			 $j(this).addClass("chooseRed");
			 $j("#folderTree").find("a").removeClass("chooseRed");
		});
		$j("#folderTree").bind("click",function(e){
			 var target = $j(e.target);
			 if(target.is("a")) {
			    $j(".treeRoot").removeClass("chooseRed");	 
			 }
		});		
		DCampus.Public.ListHover({cssName:"resourceHover",handler:$j("#sourceWrap"),oprtText:true,callback:function(){
			//下载资源
			$j("#dlPack").bind("click",function(e){
				var parentObj = $j(this).parent().parent();								
				$j(this).attr("href",parentObj.find(".resourceName").attr("link"));
				e.stopPropagation();
				//return false;
			 });
			 //改名
			 $j(".btn-rename").bind("click",function(e){
				 var dialogText = "";
				 var parentObj = $j(this).parent().parent();	
				 var resourceName = parentObj.find(".resourceName").text();
				 var resourceDesc = parentObj.find(".resourceDesc").attr("title");
				 $j(".extName").empty();
				 if(parentObj.find(".resourceName").attr("type") == 1) {
					 dialogText = "文件夹详情";
				 } else {
					 dialogText = "文件详情";
				 }
					DCampus.Public.Dialog({
							handler:"renameDialog"
							,title:dialogText
							,width:450
							,height:150
							,onLoadFunction : function(){
								  $j("#resourceID").val(parentObj.find(".resourceName").attr("id"));
								  if(resourceName.lastIndexOf(".") > 0) {
									 $j(".extName").text(resourceName.substring(resourceName.lastIndexOf(".")));
								  }
							}
				 });					 
				 if(resourceName.lastIndexOf(".") > 0) {
					resourceName = resourceName.substring(0,resourceName.lastIndexOf("."));
				 }
				 $j(".renameInput").empty().val(resourceName);
				 if(typeof(resourceDesc) != "undefined") {
				    $j(".renameTextarea").val(resourceDesc);
				 } else {
					$j(".renameTextarea").val("");
				 }
				 if($j(this).text() == "改名") {
					$j(".renameInput").focus();
				 } else {
				   $j(".renameTextarea").focus();
				 }
				 e.stopPropagation();
			 });
		}});//列表鼠标经
		DCampus.DiskUI._sourceTemplate = TrimPath.parseTemplate($j("#sourceTemplate").val());	
		//获取空间容量
		DCampus.Public.AjaxRequestFunction(System.site+"/group/getResourceSize.action","groupId="+Math.abs($j("#groupsInputId").val()),"POST",DCampus.DiskData._getResourceSizeSuccess);
		DCampus.Public.AjaxRequestFunction(System.site+"/group/getResourceSizeLimit.action","groupId="+Math.abs($j("#groupsInputId").val()),"POST",DCampus.DiskData._getSingleSuccess);		
		/**保存当前页数，刷新保留当前页**/		
		if(window.location.href.lastIndexOf("/p/") != -1) {
		   var locationNum = window.location.href.substring(window.location.href.lastIndexOf("/p/")+3);
		   DCampus.DiskUI.pageNum = parseInt(locationNum);
		   DCampus.DiskUI.isPaging = true;
		} 			
		$j(".container002").DCampusPaging({
			 "limit":DCampus.DiskUI.limit             /** 显示条数默认20条    **/
			,"start":DCampus.DiskUI.start              /** 开始位置 默认从0开始**/
			,"liststep":DCampus.DiskUI.liststep          /** 分页显示长度 默认10 **/	
			,"pageNum":DCampus.DiskUI.pageNum            /** 默认第一页开始      **/	
			,"pageCount":DCampus.DiskUI.pageCount          /** 页数                **/
			,"totalCount":DCampus.DiskUI.totalCount         /** 列表总数            **/
			,"listbegin":DCampus.DiskUI.listbegin
			,"listend":DCampus.DiskUI.listend							 
			,"RequestPath" : System.site+"/group/getResources.action"
			,"RequestData" : "parentId="+resourceJSON.parentId
			,"PageJson":resourceJSON
			,"isPaging":DCampus.DiskUI.isPaging
			,"onComplete" : function(jsonObj){
				$j("input[name='parentId']").val(jsonObj.parentId);
				$j(".dirAmout").text(jsonObj.dirAmout);
				$j(".fileAmout").text(jsonObj.fileAmout);
				$j(".sourseTable th :checked").attr("checked","");
				if(jsonObj.path.length > 1) {
				   	 $j("#path").html(DCampus.DiskUI.PathTemplate.process(jsonObj));
					 $j(".diskTitle").hide();
				} else {
				     $j(".diskTitle").show();
					 $j("#path").empty();
				}
				$j("#path a").bind("click",DCampus.DiskUI._path_Function);
               DCampus.Public.AjaxRequestFunction(System.site+"/group/getResourceSize.action","groupId="+Math.abs($j("#groupsInputId").val()),"POST",DCampus.DiskData._getResourceSizeSuccess);				
			}
			,"onBeforeStart":function(){
				$j(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});//关闭管理窗
				$j(".sourseTable tbody").addClass("displayNone");
				DCampus.Public.ShowLoading("container002","",0,100,0,System.site);//显示loading图标
			    }
			 ,"onLoad" : function(jsonObj){
				   DCampus.Public.HideLoading("container002");
					/**调用输出主题列表**/
				   $j(".sourseTable tbody").html(DCampus.DiskUI._sourceTemplate.process(jsonObj));
				   $j(".sourseTable tbody").removeClass("displayNone");
				   $j(".slct-tbl").ListManage({hasTH:true,isListType:true,listBgColor:"#F2F8E6",toolWrapID:""});//select管理插件		
				   $j(".signDelete").bind("click",function(){
					  if(confirm("是否删除当前资源？"))  {
					   DCampus.Public.AjaxRequestFunction(System.site+"/group/deleteResource.action",
														  "id="+$j(this).attr("id"),"POST",DCampus.DiskData._deleteRlstSuccess);
					  }
				   });	
				   //点击显示下一级列表
				   $j(".resourceName").bind("click",function(e){
						 if($j(this).attr("type") == 1) {
						   $j("input[name='parentId']").val($j(this).attr("id"));
						   DCampus.DiskUI._getNextLevelList();
						   return false;
						 }
				   });
				   /**返回上一级**/
				   $j("#goBack").bind("click",function(){
					  $j("input[name='parentId']").val($j(this).attr("rel"));
					  DCampus.DiskUI._goBackList();
					  return false;
				   });						   
						 }
		});	
		
		$j("#groupsTitle").height($j(window).height()-50);//resize整个frame内的高度
		$j(window).resize(function(){
		    $j("#groupsTitle").height($j(window).height()-50);//resize整个frame内的高度
		});
		//为资源目录树添加对象监听事件
		$j("#shareTreeWrap").bind("click",function(e){
		     var target = $j(e.target);
			 if(target.is(".shareA")) {
				$j(this).find("a").removeClass("chooseRed"); 
				target.addClass("chooseRed");
				DCampus.DiskUI.getCurrentID = target.attr("rev");//设置id
				if(target.parent().next().find("li").length > 0) {
					if(target.parent().next().css("display") == "block") {
					    target.parent().next().hide();
					}else{
					   target.parent().next().show();	
					}
			    } else {
					resourceJSON.parentId = - target.attr("rev");
					target.parent().next().show().empty().treeview({url: System.site+"/group/getResources.action"});//生成文件夹树
				}
			 }
			 if(target.is(".treeUL a")) {
				$j(".shareA").removeClass("chooseRed"); 
				$j(".treeUL").find("a").removeClass("chooseRed");
				target.addClass("chooseRed");				 
			 }
		});

	},	
	_openUploadDialog : function(){
	   $j(".uploadIframe").html("<iframe src='js/fancyupload/showcase/photoqueue/uploadResource.jsp?filesize="+DCampus.DiskUI.filesize+"' scrolling='no' style='width:525px;height:300px;' id='build' name='build' rel="+Math.abs($j("#groupsInputId").val())+" frameborder='0'></iframe>");
	},
	_openFolderDialog : function(){
		$j("[name='folderName']").focus();
	},	
	_requestSourceListSuccess : function(jsonObj){
	   //刷新分页
	   $j(".container002").DCampusPaging("Res-reflash");
	},
	_getNextLevelList : function() {
		$j(".container002").DCampusPaging("resource."+$j("input[name='parentId']").val());//显示下一级目录	   
	},
	_goBackList : function() {
		$j(".container002").DCampusPaging("resource_back."+$j("input[name='parentId']").val());//显示下一级目录	   
	},
	_onLoadFolderDialog : function() {
	   if($j("#build").length != 0)
	    $j("#build").contents().find("#parentId").val($j("input[name='parentId']").val());
		//$j("#build").contents().find("#demo-list .file").remove();
		$j("#build").contents().find("#demo-list .uploadText").show();
		$j("#build").contents().find(".current-text").empty();		   
	   
	},
	_btn_download_Function : function(){
	   var params = "";
        var checked = $j(".slct-tbl").find("td :checked");
		if(checked.length < 1) {
		    alert("未选择列表");
		} else {	   
		   $j.each($j("#sourceWrap").find("input:checked"),function(n,i){
			  if(n==0) {
				params += "?id="+$j(this).val();
			  } else {
				params += "&id="+$j(this).val();
			  }
		   });
		   window.location.href = System.site+"/group/downloadResource.action"+params; 
		}
	   //$j(this).attr("href",System.site+"/group/downloadResource.action"+params);	   
	},
	_dialog_btn_createFolder_Function : function() {
		if($j.trim($j("input[name='folderName']").val()) != "") {
		var parentID = $j("input[name='parentId']").val();
		if(parentID < 0) {
		   parentID = 0;
		}
		DCampus.Public.AjaxRequestFunction(System.site+"/group/createDir.action","parentId="+parentID+"&groupId="+Math.abs($j("#groupsInputId").val())+"&name="+$j("input[name='folderName']").val(),"POST",DCampus.DiskData._requestCreateFolderSuccess);      
		} else {
		   alert("不能为空");
		   $j("input[name='folderName']").focus();
		}  
	},
	_btn_del_rLst_Function : function(){
        var checked = $j(".slct-tbl").find("td :checked");
		var param = "";
		if(checked.length < 1) {
		    alert("未选择列表");
		} else {
		  if(confirm("是否删除选中的 "+checked.length+" 个资源？")) {			
			for(i=0;i<checked.length;i++){
			   var sign = "&id";
			   if(i==0) {
				  sign = "id";
			   }
			   param += (sign + "=" + checked.eq(i).val());
			}
		DCampus.Public.AjaxRequestFunction(System.site+"/group/deleteResource.action",param,"POST",DCampus.DiskData._deleteRlstSuccess);
		}
		}
	},
	_dialog_btn_confirm_Function : function(){
		if($j("#build").contents().find(".uploadText").css("display") != "inline") {										   
	   //请求资源列表
	    frames["build"].up.remove();//清空所有上传列表
	    $j(".container002").DCampusPaging("Res-reflash");      
			DCampus.Public.Dialog({
					handler:"uploadDialog"
					,close:true
			});			
		} else {
			DCampus.Public.Dialog({
					handler:"uploadDialog"
					,close:true
			});				 
		}
	},
	_createFolder_Function : function(){
		
		DCampus.Public.Dialog({
				handler:"createFolder"
				,title:"新建文件夹"
				,width:400
				,height:80
				,openFunction : DCampus.DiskUI._openFolderDialog
				,onLoadFunction : DCampus.DiskUI._openFolderDialog
		});					
	},
	_uploadResources_Function : function(){
		var parentID = $j("#goBack").attr("rel");
		//这个方法是可以打开对话框，并初始化对话框的宽和高，对话框参数只初始化一次
		DCampus.Public.Dialog({
				handler:"uploadDialog"
				,title:"上传文件"
				,width:525
				,height:300
				,openFunction : DCampus.DiskUI._openUploadDialog
				,closeFunction : DCampus.DiskUI._closeUploadDialog
				,onLoadFunction : DCampus.DiskUI._onLoadFolderDialog
		});			
	},
	_dialog_btn_save_Function : function(){
		if($j(".renameInput").val() == "") {
		  alert("名称不能为空");
		  $j(".renameInput").focus();
		} else {
	    var renameInput = $j(".renameInput").val();
	    DCampus.Public.AjaxRequestFunction(System.site+"/group/modifyResource.action","id="+$j("#resourceID").val()+"&name="+renameInput+"&desc="+$j(".renameTextarea").val(),"POST",DCampus.DiskData._saveSuccess);
		}
	},

	_formatFloat :function(src, pos){
	  if(src > 0 && src<0.01) {
	     src = 0.01;
	  }
      return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
    },
	_moverResource_Function : function(){
		var checked = $j(".slct-tbl").find("td :checked");
		if(checked.length < 1) {
		    alert("未选择列表");
		} else {		
		DCampus.Public.Dialog({
				handler:"moveDialog"
				,title:"移动"
				,width:400
				,height:200
				,onLoadFunction : function(){
					resourceJSON.parentId = -$j("#groupsInputId").val();
				   	$j("#folderTree").empty().unbind().treeview({url: System.site+"/group/getResources.action"});//生成文件夹树 
				}
		});				
		$j(".folderNum").text($j("#sourceWrap").find("input:checked").length);
		}
	},
	_dialog_btn_move_Function : function(){
       var checked = $j(".slct-tbl").find("td :checked");
		var param = "";
		  if(confirm("是否移动选中的 "+checked.length+" 个资源？")) {			
			for(i=0;i<checked.length;i++){
			   var sign = "&id";
			   if(i==0) {
				  sign = "id";
			   }
			   param += (sign + "=" + checked.eq(i).val());
			}     
		 DCampus.Public.AjaxRequestFunction(System.site+"/group/moveResource.action",
											param+"&parentId="+$j(".chooseRed").attr("id"),"POST",DCampus.DiskData._moveSuccess);	
		    param = null;
		  }
	},
	_Btn_Send_Email : function(){
	   var params = "";
        var checked = $j(".slct-tbl").find("td :checked");
		if(checked.length < 1) {
		    alert("未选择列表");
		} else {	   
		   $j.each($j("#sourceWrap").find("input:checked"),function(n,i){
			  if(n==0) {
				params += "id="+$j(this).val();
			  } else {
				params += "&id="+$j(this).val();
			  }
		   });	
	      DCampus.Public.AjaxRequestFunction(System.site+"/webmail/regist.action",params,"POST",DCampus.DiskData._sendEmailSuccess);
	      param = null;
		}
	},
	_closeUploadDialog : function(){
	   	frames["build"].up.remove();//清空所有上传列表	
	},
	_path_Function : function(){
	  $j(".container002").DCampusPaging("resource."+$j(this).attr("id"));
	},
	_Btn_OpenShareDialog : function(){
        var checked = $j(".slct-tbl").find("td :checked");
		if(checked.length < 1) {
		    alert("未选择列表");
		} else {		
			DCampus.Public.Dialog({
					handler:"shareDialog"
					,title:"共享资源"
					,width:525
					,height:300
					,openFunction : function(){
					                   $j("#shareTreeWrap").html(DCampus.DiskUI.shareTemplate.process(getMyGroups));
									} 
					//,closeFunction : 
					//,onLoadFunction : 
			});
		}
	},
	_Btn_ShareResource : function(){
	   var params = "";
	   
	   $j.each($j("#sourceWrap").find("input:checked"),function(n,i){
		  if(n==0) {
			params += "id="+$j(this).val();
		  } else {
			params += "&id="+$j(this).val();
		  }
	   });	

	   params = params + "&parentId="+ $j(".chooseRed").attr("id")+"&groupId="+DCampus.DiskUI.getCurrentID;
			   DCampus.Public.AjaxRequestFunction(System.site+"/group/shareResource.action",params,"POST",function(){
				DCampus.Public.Dialog({
						handler:"shareDialog"
						,close:true
				});																									   
	   });
	},
	_openFilePicker : function(){
		DCampus.Public.Dialog({
			handler:"filePicker"
			,title:"选择文件"
			,width:560
			,height:350
			,onLoadFunction : function(){
			}
	});
}