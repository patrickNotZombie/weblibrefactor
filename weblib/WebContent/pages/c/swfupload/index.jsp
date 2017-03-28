<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<!DOCTYPE HTML>
<html lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>SWFUpload Demos - Simple Demo</title>

<%
    String sessionId = session.getId();
    Long singleSize = ServletRequestUtils.getLongParameter(request, "singleSize",0);
	Long getParentId = ServletRequestUtils.getLongParameter(request, "id",0);
	Long getGroupId = ServletRequestUtils.getLongParameter(request, "groupId",0);
    Long restSize = ServletRequestUtils.getLongParameter(request, "leaveSpace",0);
%>

<link href="js/main.css" rel="stylesheet" type="text/css" />
<style>
body {background:#EAF2FA;font-family:Microsoft YaHei !important;}
#content {padding-left:5px;}
#tips {font: 28px/150% Microsoft YaHei;color: #ccc;position:absolute;top:80px;left:120px;}
#fsUploadProgress {width:468px;height:212px;background:#fff;position:relative;overflow:auto;border:1px solid #AAC1EA;}
.progressBarStatus {position:relative;top:1px;font-size:12px !important;color:#666;}
</style>
<script src="js/jquery.js"></script>
<script type="text/javascript" src="js/swfupload.js"></script>
<script type="text/javascript" src="js/swfupload.queue.js"></script>
<script type="text/javascript" src="js/fileprogress.js"></script>
<script type="text/javascript" src="js/handlers.js"></script>
<script type="text/javascript">
		var swfu;
		var size = <%=singleSize%> / 1024;
		window.onload = function() {
			var settings = {
				flash_url : "js/swfupload.swf",
				upload_url: "/group/uploadResource.action",
				post_params: {"sessionId":"<%=sessionId%>","groupId":<%=getGroupId%>,"parentId":<%=getParentId%>},
				file_post_name: "Filedata",
				file_size_limit : size + " MB",
				file_types : "*.*",
				file_types_description : "All Files",
				file_upload_limit : 500,
				file_queue_limit : 0,
				custom_settings : {
					progressTarget : "fsUploadProgress",
					cancelButtonId : "btnCancel"
				},
				debug: false,

				// Button settings
				button_image_url: "upload_btn.png",
				button_width: "83",
				button_height: "30",
				button_placeholder_id: "spanButtonPlaceHolder",
				button_text: '<span class="theFont"></span>',
				button_text_style: ".theFont { font-size: 16; }",
				button_text_left_padding: 12,
				button_text_top_padding: 3,
				
				// The event handler functions are defined in handlers.js
				file_queued_handler : fileQueued,
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : fileDialogComplete,
				upload_start_handler : uploadStart,
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadSuccess,
				upload_complete_handler : uploadComplete,
				queue_complete_handler : queueComplete	// Queue plugin event
			};
			swfu = new SWFUpload(settings);
			$(".uploadSize").html(_uploadSize());
	     };
		 function _uploadSize(){
		   var signleSize = <%=singleSize%>;
		   if(signleSize >= 1024 && signleSize < 1024*1024) {
			  signleSize = _formatFloat(signleSize / 1024 , 2) + "MB";
		   } else if(signleSize >= 1024*1024){
				signleSize = _formatFloat(signleSize / 1024 / 1024 , 2) + "G";
			 }else {
			   signleSize = signleSize + "KB";
			 }	   
		  return signleSize;	 
		 }
	function _formatFloat(src, pos){
	  if(src > 0 && src<0.01) {
	     src = 0.01;
	  }
      return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
    }		 
	</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
<body>
<%--<div class="progressContainer blue"><a class="progressCancel" href="#" style="visibility: hidden;"> </a><div class="progressName">百度移动互联网发展趋势报告_2012年Q4.pdf</div><div class="progressBarStatus">上传成功</div><div class="progressBarComplete" style=""></div></div>

<div class="progressContainer red"><a class="progressCancel" href="#" style="visibility: hidden;"> </a><div class="progressName">[电影天堂www.dy2018.net].速度与激情6.HD.1024x576.中英双字幕.rmvb</div><div class="progressBarStatus">File is too big.</div><div class="progressBarError"></div></div>

<div class="progressWrapper" id="SWFUpload_0_2" style="opacity: 1;"><div class="progressContainer green"><a class="progressCancel" href="#" style="visibility: visible;"> </a><div class="progressName">xampp-win32-1.8.1-VC9.7z</div><div class="progressBarStatus">Uploading...</div><div class="progressBarInProgress" style="width: 76%;"></div></div></div>--%>

<div id="content">
<form id="form1" action="/group/uploadResource.action" method="post" enctype="multipart/form-data">
			<div style="padding-left:5px;margin-top:10px;">
				<span id="spanButtonPlaceHolder"></span>
				<input id="btnCancel" type="button" value="Cancel All Uploads" onClick="swfu.cancelQueue();" disabled="disabled" style="margin-left: 2px; font-size: 8pt; height: 29px;display:none;" />
			</div>
			<div class="fieldset flash" id="fsUploadProgress">
            			<div id="tips">请选择要上传资源<br/>单文件上传大小：<span class="uploadSize"></span></div>
		 		</div>
	<div id="divStatus" style="display:none">0 Files Uploaded</div>


	</form>
</div>
</body>
</html>
