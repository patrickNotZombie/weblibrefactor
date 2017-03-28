/**
    资源列表数据处理函数
**/
DCampus.ResourceListData = {
	_deleteRlstSuccess : function(){
	   $j("body").message({message:"删除成功"});
	   $j(".container002").DCampusPaging("Res-reflash");
	   $j("#checkAll").attr("checked","");
	},
	_requestCreateFolderSuccess : function(jsonObj){
	    $j("body").message({message:"创建成功"});
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
	      total = Math.ceil(total / 1024) + "MB";
	   } else if(total >= 1024*1024) {
		      total = Math.ceil(total / 1024 / 1024) + "G";
		 } else {
	         total = total + "KB";
	      }
	   if(used >= 1024 && used <= 1024*1024) {
	      used = Math.ceil(used / 1024) + "MB";
	   } else if(used >= 1024*1024){
		    used = Math.ceil(used / 1024 / 1024) + "G";
		 }else {
	       used = used + "KB";
	     }	
	   $j(".totalSpace").text(total);
	   $j(".usedspace").text(used);
	   $j(".percent").text(DCampus.ResourceListUI._formatFloat(jsonObj.resourcesSize/jsonObj.totalSize*100,2)+"%");
	},
	_saveSuccess : function(){
	    $j("body").message({message:"保存成功"});
		DCampus.Public.Dialog({
				handler:"renameDialog"
				,close:true
		});				
		$j(".container002").DCampusPaging("Res-reflash");	   
	},
	_moveSuccess : function(){
		$j("body").message({message:"移动资源成功"});
		DCampus.Public.Dialog({
				handler:"moveDialog"
				,close:true
		});			   
		$j(".container002").DCampusPaging("Res-reflash");	
		$j("#folderTree").unbind().treeview({url: System.site+"/group/getResources.action?temp="+Math.random()});//生成文件夹树
	},
	_getSingleSuccess : function(jsonObj){
	   var signleSize = jsonObj.singleSize;
	   DCampus.ResourceListUI.filesize = signleSize;
	   if(signleSize >= 1024 && signleSize <= 1024*1024) {
	      signleSize = DCampus.ResourceListUI._formatFloat(signleSize / 1024 , 2) + "MB";
	   } else if(signleSize >= 1024*1024){
		    signleSize = DCampus.ResourceListUI._formatFloat(signleSize / 1024 / 1024 , 2) + "G";
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
    DCampus.ResourceListUI.init();//页面初始化时执行的functon
	$j(".dialog-btn-save").bind("click",DCampus.ResourceListUI._dialog_btn_save_Function);//保存资源信息
	$j(".uploadResources").bind("click",DCampus.ResourceListUI._uploadResources_Function);//上传资源事件
	$j(".createFolder").bind("click",DCampus.ResourceListUI._createFolder_Function);//打开创建窗口	
	$j(".dialog-btn-confirm").bind("click",DCampus.ResourceListUI._dialog_btn_confirm_Function);//上传资源确定事件  	
	$j(".btn-del-rLst").bind("click",DCampus.ResourceListUI._btn_del_rLst_Function);//删除资源
	$j(".dialog-btn-createFolder").bind("click",DCampus.ResourceListUI._dialog_btn_createFolder_Function); //创建文件夹按钮事件
	$j(".btn-download").bind("click",DCampus.ResourceListUI._btn_download_Function);//打包下载事件
	$j(".moverResource").bind("click",DCampus.ResourceListUI._moverResource_Function);
	$j(".dialog-btn-move").bind("click",DCampus.ResourceListUI._dialog_btn_move_Function);
	DCampus.Public.AjaxRequestFunction(System.site+"/group/getResourceSizeLimit.action","groupId="+json.groupId,"get",DCampus.ResourceListData._getSingleSuccess);	
});
/**
    资源列表UI部分函数
**/
DCampus.ResourceListUI = {
	limit : 20,//列表条数
	start : 0,//开始值
	liststep : 10,	
	pageNum : 0,	
	pageCount : 0,
	totalCount : 0,
	listbegin : 0,
	listend : 0,
	filesize : "",
	_sourceTemplate : null,
	isPaging : false,
	_openUploadDialog : function(){
	   $j(".uploadIframe").html("<iframe src='"+System.site+"/js/fancyupload/showcase/photoqueue/uploadResource.jsp?filesize="+DCampus.ResourceListUI.filesize+"' scrolling='no' style='width:525px;height:300px;' id='build' name='build' rel="+json.groupId+" frameborder='0'></iframe>");
	   //window.frames["build"].document.location.reload();
	},
	_openFolderDialog : function(){
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
		$j("#build").contents().find("#demo-list .file").remove();
		$j("#build").contents().find("#demo-list .uploadText").show();
		$j("#build").contents().find(".current-text").empty();	   
	   
	},
	_btn_download_Function : function(){
	   var params = "";
	   $j.each($j("#sourceWrap").find("input:checked"),function(n,i){
	      if(n==0) {
		    params += "?id="+$j(this).val();
		  } else {
		    params += "&id="+$j(this).val();
		  }
	   });
       $j(this).attr("href",System.site+"/group/downloadResource.action"+params);	   
	},
	_dialog_btn_createFolder_Function : function() {
		var parentID = $j("input[name='parentId']").val();
		if(parentID < 0) {
		   parentID = 0;
		}
		DCampus.Public.AjaxRequestFunction(System.site+"/group/createDir.action","parentId="+parentID+"&groupId="+json.groupId+"&name="+$j("input[name='folderName']").val(),"POST",DCampus.ResourceListData._requestCreateFolderSuccess);          
   	   
	},
	_btn_del_rLst_Function : function(){
        var checked = $j(".slct-tbl").find("td :checked");
		var param = "";
		if(checked.length < 1) {
		   $j("body").message({message:"未选择列表",warning:true});
		} else {
		  if(confirm("是否删除选中的 "+checked.length+" 个资源？")) {			
			for(i=0;i<checked.length;i++){
			   var sign = "&id";
			   if(i==0) {
				  sign = "id";
			   }
			   param += (sign + "=" + checked.eq(i).val());
			}
		DCampus.Public.AjaxRequestFunction(System.site+"/group/deleteResource.action",param,"POST",DCampus.ResourceListData._deleteRlstSuccess);
		}
		}
	},
	_dialog_btn_confirm_Function : function(){
		if($j("#build").contents().find(".uploadText").css("display") != "inline") {										   
			frames["build"].up.remove();//清空所有上传列表   
			//请求资源列表
			$j(".container002").DCampusPaging("Res-reflash");      
			DCampus.Public.Dialog({
					handler:"uploadDialog"
					,close:true
			});			
		} else {
			 $j("body").message({message:"请上传资料",warning:true});
		}
	},
	_createFolder_Function : function(){
		DCampus.Public.Dialog({
				handler:"createFolder"
				,title:"新建文件夹"
				,width:400
				,height:80
				,openFunction : DCampus.ResourceListUI._openFolderDialog
		});		   
	},
	_uploadResources_Function : function(){
		var parentID = $j("#goBack").attr("rel");
		//这个方法是可以打开对话框，并初始化对话框的宽和高，对话框参数只初始化一次
		DCampus.Public.Dialog({
				handler:"uploadDialog"
				,title:"上传资源"
				,width:525
				,height:300
				,openFunction : DCampus.ResourceListUI._openUploadDialog
				,closeFunction : DCampus.ResourceListUI._closeUploadDialog
				,onLoadFunction : DCampus.ResourceListUI._onLoadFolderDialog
		});			

	},
	_dialog_btn_save_Function : function(){
		if($j(".renameInput").val() == "") {
		  alert("名称不能为空");
		  $j(".renameInput").focus();
		} else {
	    DCampus.Public.AjaxRequestFunction(System.site+"/group/modifyResource.action","id="+$j("#resourceID").val()+"&name="+$j(".renameInput").val()+"&desc="+$j(".renameTextarea").val(),"POST",DCampus.ResourceListData._saveSuccess);
		}
	},
	init : function(){
			
		$j(".treeRoot").bind("click",function(){
			 $j(this).addClass("chooseRed");
			 $j("#folderTree").find("a").removeClass("chooseRed");
		});
		$j("#folderTree").bind("click",function(e){
			 var target = $j(e.target);
			 if(target.is("a")) {
			    $j(".treeRoot").removeClass("chooseRed");	
			    $j("#folderTree").find("a").removeClass("chooseRed");
			    target.addClass("chooseRed");	
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
				 $j(".renameInput").val(resourceName);
				 if(typeof(resourceDesc) != "undefined") {
				    $j(".renameTextarea").empty().val(resourceDesc);
				 }  else {
				    $j(".renameTextarea").val("");
				 }
				 e.stopPropagation();
			 });
		}});//列表鼠标经
		DCampus.ResourceListUI._sourceTemplate = TrimPath.parseTemplate($j("#sourceTemplate").val());	
		//获取空间容量
		DCampus.Public.AjaxRequestFunction(System.site+"/group/getResourceSize.action","groupId="+json.groupId,"get",DCampus.ResourceListData._getResourceSizeSuccess);
		/**保存当前页数，刷新保留当前页**/		
		if(window.location.href.lastIndexOf("/p/") != -1) {
		   var locationNum = window.location.href.substring(window.location.href.lastIndexOf("/p/")+3);
		   DCampus.ResourceListUI.pageNum = parseInt(locationNum);
		   DCampus.ResourceListUI.isPaging = true;
		} 			
		$j(".container002").DCampusPaging({
			 "limit":DCampus.ResourceListUI.limit             /** 显示条数默认20条    **/
			,"start":DCampus.ResourceListUI.start              /** 开始位置 默认从0开始**/
			,"liststep":DCampus.ResourceListUI.liststep          /** 分页显示长度 默认10 **/	
			,"pageNum":DCampus.ResourceListUI.pageNum            /** 默认第一页开始      **/	
			,"pageCount":DCampus.ResourceListUI.pageCount          /** 页数                **/
			,"totalCount":DCampus.ResourceListUI.totalCount         /** 列表总数            **/
			,"listbegin":DCampus.ResourceListUI.listbegin
			,"listend":DCampus.ResourceListUI.listend							 
			,"RequestPath" : System.site+"/group/getResources.action?temp="+Math.random()
			,"RequestData" : "parentId="+resourceJSON.parentId
			,"PageJson":resourceJSON
			,"isPaging":DCampus.ResourceListUI.isPaging
			,"onComplete" : function(jsonObj){
				$j("input[name='parentId']").val(jsonObj.parentId);
				$j(".dirAmout").text(jsonObj.dirAmout);
				$j(".fileAmout").text(jsonObj.fileAmout);
			}
			,"onBeforeStart":function(){
				$j(".slct-tbl").ListManage({close:true,toolWrapID:"ManageToolWrap"});//关闭管理窗
				$j(".sourseTable tbody").hide();
				DCampus.Public.ShowLoading("container002","",0,100,0,System.site);//显示loading图标
							  }
			 ,"onLoad" : function(jsonObj){
							   DCampus.Public.HideLoading("container002");
								/**调用输出主题列表**/
							   $j(".sourseTable tbody").html(DCampus.ResourceListUI._sourceTemplate.process(jsonObj));
							   $j(".sourseTable tbody").show();
							   $j(".slct-tbl").ListManage({hasTH:true,isListType:true,listBgColor:"#fff8bf",toolWrapID:"ManageToolWrap"});//select管理插件		
							   $j(".signDelete").bind("click",function(){
								  if(confirm("是否删除当前资源？"))  {
								   DCampus.Public.AjaxRequestFunction(System.site+"/group/deleteResource.action",
																	  "id="+$j(this).attr("id"),"POST",DCampus.ResourceListData._deleteRlstSuccess);
								  }
							   });	
							   //点击显示下一级列表
							   $j(".resourceName").bind("click",function(e){
									 if($j(this).attr("type") == 1) {
									   $j("input[name='parentId']").val($j(this).attr("id"));
									   DCampus.ResourceListUI._getNextLevelList();
									   return false;
									 }
							   });
							   /**返回上一级**/
							   $j("#goBack").bind("click",function(){
								  $j("input[name='parentId']").val($j(this).attr("rel"));
								  DCampus.ResourceListUI._goBackList();
								  return false;
							   });						   
						 }
		});	
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
		    $j("body").message({message:"未选择列表",warning:true});
		} else {		
		DCampus.Public.Dialog({
				handler:"moveDialog"
				,title:"移动"
				,width:400
				,height:200
				,onLoadFunction : function(){
				   $j("#folderTree").empty().treeview({url: System.site+"/group/getResources.action?temp="+Math.random()});//生成文件夹树 
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
											param+"&parentId="+$j(".chooseRed").attr("id"),"POST",DCampus.ResourceListData._moveSuccess);	
		  }
	},
	_closeUploadDialog : function(){
	   	frames["build"].up.remove();//清空所有上传列表	
	},
	_formatFloat :function(src, pos){
	  if(src > 0 && src<0.01) {
	     src = 0.01;
	  }
      return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
    }
}