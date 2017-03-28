<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="path.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="<%=getSiteSeoKeywords%>" />
<meta name="Description" content="<%=getSiteSeoDescription%>" />
<title><%=getSiteName%></title>
<link href="../js/jquery-ui-1.7.2.custom/css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" />
<link href="../themes/default/css/global.css" rel="stylesheet" type="text/css"/>
<script src="../js/jquery/jquery-1.4.2.pack.js"></script>
<script src="../js/jquery/jquery.cookie.js"></script>
<script src="js/DCampus.Public.js"></script>
<script src="js/TrimPath_Template.js"></script>
<script>
$j(function(){
    if($j.cookie("createInfo") != null) {
   var arr = $j.cookie("createInfo").split(",");
   $j("#name").text(arr[0]);
   $j("#addr").text(arr[1]);
   }
   $j("a[rel='addr']").attr("href",$j("a[rel='addr']").text());
   $j(".enterGroupsButton").bind("click",function(){
      window.location.href = $j("a[rel='addr']").text();
   })
})
</script>
<style>
.ui-widget p{padding:5px;}
.world {padding:10px 20px 10px 20px;}
.world01 {font-weight:bold;font-size:14px;}
.world02 a{text-decoration:underline !important;}
</style>
</head>
<body>
<div id="headerWrap">
<div id="header">
<%@include file="header.jsp"%>
  </div>
  <%if(!isLogin) { %>
<script>
window.location.href="<%=site%>/pages/login.jsp";
</script>
<%}%>
</div>
<div id="step01_PageHeader">创建圈子</div>
<h3 class="creation_step_bg creation_step02">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="173">第一步：填写圈子资料</td>
      <td width="173" class="current_step">第二步：成功创建圈子</td>
      <td>&nbsp;</td>
    </tr>
  </table>
</h3>

<div id="creationWrap">
       <div class="ui-widget" style="width:95%;margin:0 auto;">
            <div class="ui-state-highlight ui-corner-all" style="margin-top:5px;padding: 0 7px;">
				<p style="padding:5px 0;"><span class="ui-icon ui-icon-info" style="float: left; margin-right:3px;"></span>
				</p>
                <div class="world">
                <p class="world01">已经顺利建立您的圈子</p>
                <p class="world02">圈子名称：<span id="name"></span></p>
                <p class="world02">圈子地址：<span><a href="javascript:void(0)" rel="addr" class="output-link">http://<%=getSiteDomain%><%=site%>/<span id="addr"></span>/</a></span></p>
                </div>
			</div>
		</div>

<p style="padding:10px 10px 10px 22px;"><input type="button" class="enterGroupsButton" value="访问您的圈子"/></p>
</div>
<div id="copyright_frontpage">
<%@include file="footer.jsp"%>
</div>

<%=getSiteStatCode%>
</body>
</html>
