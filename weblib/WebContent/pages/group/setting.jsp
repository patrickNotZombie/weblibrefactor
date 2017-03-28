<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%
   	long mygroupId = ServletRequestUtils.getLongParameter(request, "groupId", 0);
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
<style>
body {background:#fff;}
</style>
<script src="../../js/jquery/jquery-1.4.2.pack.js"></script>
<script src="../js/DCampus.Public.js"></script>
<script>var mygroupId = <%=mygroupId%></script>
<script src="../js/DCampus.Setting.js"></script>

</head>

<body>
<script>
var json = <ww:action name='getGroupInfo' namespace='/group' executeResult='true' ignoreContextParams='false'/>;
</script>
<form name="shortMessage_invite">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="groups_rules_table">
          <tr>
            <td ><input type="radio" name="permType" value="0" checked="checked"/></td>
            <td >允许浏览，需要加入才可发帖</td>
            <td>本策略允许用户访问，用户要发帖需要申请加入圈子方能发帖。适合某些团体学生社团。</td>
          </tr>          
          <tr>
            <td width="15"><input type="radio" name="permType"  value="1"/></td>
            <td width="200">完全公开</td>
            <td>本策略允许任何人浏览和发帖，适合公开讨论场合使用</td>
          </tr>
          <tr>
            <td ><input type="radio" name="permType" value="2"/></td>
            <td >仅对会员公开</td>
            <td>本策略允许受邀请会员浏览和发帖，会员要加入本圈子必须经过申请，待审核内部讨论使用</td>
          </tr>
          <tr>
            <td ><input type="radio" name="permType"  value="3"/></td>
            <td >留言板</td>
            <td>本策略允许用户访问，用户发表的帖子需经过圈子管理员审核。</td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="groups_rules_table">

  <tr>
    <td colspan="6" nowrap="nowrap">帖子审核策略</td>
  </tr>
  <tr>
  <td width="1%"><input type="radio" name="audit" value="all"/>  </td>
      <td width="100">对所有帖子审核</td>
    <td width="1%"><input type="radio" name="audit" value="post"/></td>
    <td width="175"> 采用默认的审核策略进行审核 </td>
    <td width="1%"><input type="radio" name="audit" value="not"/> </td>
    <td >表示对所有帖子都不审核</td>
  </tr>
</table>

 <div class="toolbar"><a class="button button002 saveSettings" href="javascript:void(0)" onfocus="this.blur()">保存</a></div>
 </form>
<%=getSiteStatCode%>
</body>
</html>
