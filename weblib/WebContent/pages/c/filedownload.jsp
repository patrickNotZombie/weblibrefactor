<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<%
 //String code = ServletRequestUtils.getStringParameter(request, "code","");
 //String id = ServletRequestUtils.getStringParameter(request, "id","");
 //String filesize = ServletRequestUtils.getStringParameter(request, "filesize","1000");
 //String name = ServletRequestUtils.getStringParameter(request, "name","demo");
 String token =ServletRequestUtils.getStringParameter(request, "token","");
 //request.setAttribute("id", id);
%>
<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>资源库提取文件页</title>

<style type="text/css">
body,p,input { margin:0; padding:0; }
body { background:#fff url(images/download-body.jpg) repeat-x 0 0px; }
.cl { clear:both; }
#wrap { width:100%; height:100%;border-top:3px solid #f89b1c;}
#main { margin:0 auto; width:800px;background:url(images/logo.jpg) no-repeat top left;}
#main .left { float:left; width:480px; }
#main .left .box1 { float:left; width:160px; height:48px; }
#main .left .box2 { float:left; padding-left:18px; width:100px; height:48px; font:bold 14px/48px "宋体"; color:#fff; }
#main .left .box3 { float:left; padding-top:20px; width:435px; font:14px/30px "宋体"; }
#main .left .box3 p { font:bold 20px/40px "宋体"; }
#main .left .box3 .filename{border-bottom:1px solid #d2d2d2;padding-bottom:16px;margin-bottom:10px}
#main .left .box4 { float:left; width:435px; padding-top:20px;}
#main .left .box4 .down { display:block; width:115px; height:36px; background:url(images/download-down.jpg) no-repeat; cursor:pointer; }
#main .right { float:left;margin-top:65px; padding:0px 0 0 20px;border-left:1px solid #d2d2d2; width:268px; height:400px; font:14px/22px "宋体"; color:#959595}
#main .bottom { text-align:center; font:12px/70px "宋体"; }
.loginbox { position:absolute; width:285px; height:255px; background:url(images/loginbox.jpg) no-repeat; top:25%;left:35%;display:none;}
.loginbox .close1 { position:absolute; top:19px; left:245px; width:19px; height:19px; cursor:pointer; }
.loginbox .close2 { position:absolute; top:212px; left:189px; width:72px; height:25px; cursor:pointer; }
.loginbox input { position:absolute; background:none; border:none; }
.loginbox .text { top:70px; left:91px; width:159px; height:14px; font:14px/14px "宋体"; }
.loginbox .password { top:115px; left:91px; width:159px; height:14px; font:14px/14px "宋体"; }
.loginbox .radio1 { top:157px; left:38px; }
.loginbox .radio2 { top:157px; left:154px; }
.loginbox .submit { top:212px; left:108px; width:72px; height:25px; cursor:pointer; }
.loginbox .font1 { position:absolute; top:160px; left:62px; font:12px/14px "宋体"; color:#3a5600; }
.loginbox .font2 { position:absolute; top:160px; left:177px; font:12px/14px "宋体"; color:#005695; }
</style>
<script src="login/js/jquery-1.4.2.pack.js"></script>

</head>

<body>

<div id="wrap">
 <div id="main">
  <div class="left">
   <div class="box1"></div>
   <div class="box3">
   您要提取的文件
   <p class="fileName"></p>
   文件大小：<span id="sizelimit">0KB</span>
   <!--p style="color:#333;font-size:14px;font-weight:normal;line-height:25px;">剩余下载次数：<span class="validTimes"></span></p-->
   <p style="color:#333;font-size:14px;font-weight:normal;line-height:25px;">有效期：<span class="expiredDate"></span></p>
         <p style="margin-top:30px;line-height:25px;" class="codeInput"><span style="color:#333;font-size:14px;font-weight:normal;">请输入提取码：</span><br/><input type="text" style="padding:5px" placeholder="请输入提取码"/></p>

   </div>

   <div class="box4"><a class="down"  style="display:block;"></a></div>
  </div>
  <div class="right">
  <b>此文件来自DCampus Weblib</b><br />
  DCampus Weblib为员工提供的文件储存服务<br />
  可随时随地上传和下载文档、照片、音乐、<br />
  软件，快捷方便<br />
  文件上传后永久保存  </div>
  <div class="cl"></div>
  
  <div >© DCampus rights reserved. Powered by DCampus</div>
 </div>
</div>

<div class="loginbox">
 <div class="close1"></div>
 <div class="close2"></div>

  <input class="text" type="text" name="username"/>
  <input class="password" type="password" name="password"/>
  <!--input class="radio1" type="radio" name="loginbox" value="1" checked="checked" /-->
  <!--input class="radio2" type="radio" name="loginbox" value="2" /-->
  <input class="submit" type="submit" value="" />
 <!--div class="font1">极速版</div-->

 <!--div class="font2">专业版</div-->
</div>





<script>

$(function(){
   //getStatus();
   //$(".validTimes").text(getResourceCode.validTimes);
   //$(".expiredDate").text(getResourceCode.expiredDate);
		var filesize = "";
		var checkCode;
		$.ajax({
			url:"/webmail/getResourceInfoByToken.action",
			data:"token=<%=token%>",
			async:false,
			dataType:"json",
			success:function(data){
			  filesize = data.filesize;
			  $(".validTimes").text(data.validTimes);
			  $(".expiredDate").text(data.expiredDate);		
			  $(".fileName").text(data.name);
   
			//console.log(data);
			   if(filesize >= 1024 && filesize <= 1024*1024) {
				  filesize = _formatFloat(filesize / 1024 , 2) + "MB";
			   } else if(filesize >= 1024*1024){
					filesize = _formatFloat(filesize / 1024 / 1024 , 2) + "G";
				 }else {
				   filesize = filesize + "KB";
				 }
				 
		   $("#sizelimit").text(filesize);	
		   	  
			  if(data.checkCode == 1) {
			     
				 $(".down").bind("click",function(){
				    if($(".codeInput").find("input").val() == "") {
					  alert("请输入验证码");
					}else {
					  $.ajax({
					     url:"/webmail/checkToken.action?token=<%=token%>",
						 data:"code="+$(".codeInput").find("input").val(),
						 dataType:"json",
						 type:"GET",
						 success:function(data){
						    if(data.type == "fail") {
							  alert("提取码错误，请重新输入!");
							} else {
							  window.location.href = "/webmail/downloadByToken.action?token=<%=token%>"+"&code="+$(".codeInput").find("input").val();
							  //window.location.href = "/webmail/downloadByToken.action?token=<%=token%>"+"&code="+$(".codeInput").find("input").val(); 
							}
						 },
						 error:function(data){
						     alert("文件不存在!");
						 }
					  });
					}
				 });
		
			  
			  } else {
			    $(".codeInput").hide();
				$(".down").attr("href","/webmail/downloadByToken.action?token=<%=token%>");
			  }
			  
			},error:function(){
			   $(".box4").empty();
			   $(".box3").html(' 您要提取的文件<p class="fileName"></p><span style="color:#666;">文件已不存在！</span>');
			}
			
		});


   /*
   $(".close1").bind("click",function(){
       $(".loginbox").hide();
   });
   $(".close2").bind("click",function(){
      $(".loginbox").hide();
   });
   $(".submit").bind("click",function() {
      // login();
   });
	$("[name='password']").bind("keypress",function(e){
	    if(e.keyCode == 13) {
           //login();
		}
	});*/
});
function _formatFloat(src, pos){
  if(src > 0 && src<0.01) {
	 src = 0.01;
  }
  return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
}
/*
function getStatus(){
   $.ajax({
	   "url" : "/user/status.action"
	   ,"dataType" : "json"
	   ,"success" : function(data){
		  if(data.status == "guest") {
			 $(".down").attr("href","javascript:void(0)");
			 $(".down").bind("click",function(){$(".loginbox").show();$("[name='username']").focus();});
		  } else {
			 $(".down").attr("href","/group/downloadResource.action?id=<!%=id%>&code=<!%=code%>").attr("target","_blank");
			 $(".down").unbind();
		  }
	   }
   });
}*/




</script>
</body>
</html>