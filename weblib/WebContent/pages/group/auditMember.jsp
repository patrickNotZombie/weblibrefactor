<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<%@page import="com.dcampus.groups.beans.IGroupBean"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%
   	long mygroupId = ServletRequestUtils.getLongParameter(request, "groupId", 0);
	request.setAttribute("mygroupId", mygroupId);
%>
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
#members-lst .l50_s{float:left;margin-top:5px;}
#members-lst p {padding-top:5px;}
</style>
<script src="../../js/jquery/jquery-1.4.2.pack.js"></script>
<script src="../js/TrimPath_Template.js"></script>
<script src="../js/DCampus.Public.js"></script>
<script src="../js/DCampus.Paging.Plugins.js"></script>
<script src="../js/DCampus.AuditMember.js"></script>
<script>
<%if(!getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.MODIFY_GROUP)){%>
    alert("对不起，您没有权限访问！");
	window.location.href="<%=site%>/pages/login.jsp";
<%}%>
</script>
</head>

<body>
<script>
var memberJson =  <ww:action name='getRequestingMembers' namespace='/user' executeResult='true' ignoreContextParams='false'><ww:param name="groupId" value="%{#request.mygroupId}"></ww:param><ww:param name="start" value="0"></ww:param><ww:param name="limit" value="20"></ww:param></ww:action>
<%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.MANAGE_MEMBER_REQUEST)){%>
DCampus.AuditMemberUI.mygroupId = <%=mygroupId%>;//设置groupId
<%}%>
</script>
<table  cellspacing="0" cellpadding="0" border="0" class="listInfoTableWrap" width="100%">
    <tbody><tr>
      <td><table cellspacing="0" cellpadding="0" border="0" class="pagebarTableWrap">
          <tbody><tr>
            <td class="page-left"><a href="javascript:void(0);" class="prePage displayNone" title="上一页">-</a></td>
            <td class="page-bg" style="white-space: nowrap;"> <span class="pageNumA"></span></td>
            <td class="page-bg page-next"><a href="javascript:void(0);" class="nextPage displayNone" title="下一页">+</a></td>
            <td class="pageNum page-bg"><span>Pages:<b class="myThreadPagenum"></b>/<b class="myThreadpageCount"></b></span> </td>
            <td class="page-bg"><span>
              <input type="text" class="pageInput" id="goPage" name="goPage"/>
              </span> </td>
            <td class="page-bg page-button"><span>
              <input type="button" value="Go" class="go_botton" />
              </span> </td>
            <td class="page-right"></td>
            <td class="totalTopic"> [总数:<span class="totalCount"></span>]</td>
          </tr>
        </tbody></table></td>
    </tr>
  </tbody></table>
<div class="container002">
<div class="body members-lst" id="members-lst"> </div>
</div>
<table  cellspacing="0" cellpadding="0" border="0" class="listInfoTableWrap" width="100%">
    <tbody><tr>
      <td><table cellspacing="0" cellpadding="0" border="0" class="pagebarTableWrap">
          <tbody><tr>
            <td class="page-left"><a href="javascript:void(0);" class="prePage displayNone" title="上一页">-</a></td>
            <td class="page-bg" style="white-space: nowrap;"> <span class="pageNumA"></span></td>
            <td class="page-bg page-next"><a href="javascript:void(0);" class="nextPage displayNone" title="下一页">+</a></td>
            <td class="pageNum page-bg"><span>Pages:<b class="myThreadPagenum"></b>/<b class="myThreadpageCount"></b></span> </td>
            <td class="page-bg"><span>
              <input type="text" class="pageInput" id="goPage" name="goPage"/>
              </span> </td>
            <td class="page-bg page-button"><span>
              <input type="button" value="Go" class="go_botton" />
              </span> </td>
            <td class="page-right"></td>
            <td class="totalTopic"> [总数:<span class="totalCount"></span>]</td>
          </tr>
        </tbody></table></td>
    </tr>
  </tbody></table>
<textarea id="members_template" style="display:none">
<table border="0"  class="table001 slct-tbl" cellpadding="0" cellspacing="0">
  <thead>
    <tr>
      <th width="10" align="center" class="displayNone"><input type="checkbox" /></th>
      <th>会员名</th>
    </tr>
  </thead>
  <tbody>
  {for member in members}
    <tr>
      <td class="displayNone"><input type="checkbox" value="\${member.id}"/></td>
      <td><div class="l50_s"><img height="50" width="50" src="\${member.icon}"/></div><p>\${member.name|escape}</p><p><a href="javascript:void(0)" class="btn-pass" id="\${member.id}">通过</a> <a href="javascript:void(0)" class="btn-not-pass" id="\${member.id}">不通过</a></p></td>
    </tr>
    {/for}
  </tbody>
</table>
</textarea>
<div class="ManageToolWrap"><h3>你选中了<span class="num"></span>篇</h3>
<div class="space01"></div>
<p><a href="javascript:void(0)" class="btn-pass">通过</a> <a href="javascript:void(0)" class="btn-not-pass">不通过</a></p>
</div>
<%=getSiteStatCode%>
</body>
</html>
