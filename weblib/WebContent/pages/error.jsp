<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="path.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="<%=getSiteSeoKeywords%>" />
<meta name="Description" content="<%=getSiteSeoDescription%>" />
<title><%=getSiteName%></title>
<script src="../js/jquery/jquery-1.4.2.pack.js"></script>
<script src="js/DCampus.Public.js"></script>
<style>
body,html{background:#f3f3f3;width:100%;height:100%;overflow:hidden;margin:0;padding:0;font:14px/150% "宋体";color:#333;}
.bg {background:url(../themes/default/images/grass.gif) bottom repeat-x;}
#MessageWrap {background:url(../themes/default/images/404error.gif) no-repeat;width:800px;height:573px;position:relative;}
#message {position:absolute;width:200px;height:100px;left:520px;top:60px;}
.countnum {color:#1490D7;font:14px/150% "宋体"}
.clicknow {color:#1490D7;text-decoration:underline;}
.tableborder {border:3px solid #fff;}
</style>
<script>
$j(function(){
   var i = 10;
   $j(".countnum").text(i);
   var count = setInterval(function(){
     if(i == 0) {
		clearInterval(count);
		window.location.href = "<%=site%>/pages/login.jsp";
		return;
	 }
     i -= 1;
     $j(".countnum").text(i);
   },1000);
   $j(".clicknow").bind("click",function(){
       window.location.href = "<%=site%>/pages/login.jsp";
   });
})
</script>
</head>
<body>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="tableborder">
  <tr>
    <td valign="bottom" width="800"><div id="MessageWrap">
      <div id="message"><span style="color:#1490D7;font:18px/150% '宋体';font-weight:bold;">对不起</span>，您要访问的页面不存在或者发生了错误，页面会在 <span class="countnum"></span> 秒后自动跳到首页。<a href="<%=site%>/pages/login.jsp" class="clicknow">马上跳转</a></div>
    </div></td>
    <td class="bg">&nbsp;</td>
  </tr>
</table>
<%=getSiteStatCode%>
</body>
</html>
