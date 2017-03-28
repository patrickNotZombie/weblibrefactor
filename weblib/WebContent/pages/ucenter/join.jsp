<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%
  String validate = ServletRequestUtils.getStringParameter(request, "validate","");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="../path.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="<%=getSiteSeoKeywords%>" />
<meta name="Description" content="<%=getSiteSeoDescription%>" />
<title><%=getSiteName%></title>
<link href="../../themes/default/css/global.css" rel="stylesheet" type="text/css" />
<script src="../../js/jquery/jquery-1.4.2.pack.js"></script>
<script src="../js/TrimPath_Template.js"></script>
<script src="../js/DCampus.Public.js"></script>
<script>
$j(function(){
DCampus.Public.AjaxRequestFunction(System.site+"/user/joinGroup.action","groupId=<%=groupId%>&validate=<%=validate%>","POST",DCampus.Join.joinSuccess,DCampus.Join.joinError);
})
DCampus.Join = {
   joinSuccess : function(data){
        if(!data.needAudit) {
		    window.location.href = System.site + "/" + data.groupAddr +"/index.jsp";
	    } else {
		   $j("#message").show();
		   setTimeout(function(){window.location.href = System.site + "/" + data.groupAddr +"/index.jsp";},2000)
		}
   },
   joinError : function(){
      window.location.href = "../error.jsp";
   }   
}
</script>
<style>
body {background:#F4F5F7;padding:0;margin:0;}
#message {width:200px;text-align:center;border:5px solid #ccc;padding:20px;background:#fff;margin:0 auto;margin-top:10%;}
</style>
</head>
<body>
<div id="headerWrap_in">
<div id="headerWrap_in">
  <div class="header">
    <div class="logo">
    </div>
    <div class="header_right_bg">
	    </div>
  </div>
</div>
</div>
 <div id="message" class="displayNone">请等待审核</div>
<%=getSiteStatCode%>
</body>
</html>
