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
<script src="../js/DCampus.AuditPosts.js"></script>
<script>
<%if(!getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.MODIFY_GROUP)){%>
    alert("对不起，您没有权限访问！");
	window.location.href="<%=site%>/pages/login.jsp";
<%}%>
</script>
</head>

<body>
<script>
var auditPostsJSON =  <ww:action name='getAuditPosts' namespace='/post' executeResult='true' ignoreContextParams='false'><ww:param name="groupId" value="%{#request.mygroupId}"></ww:param><ww:param name="start" value="0"></ww:param><ww:param name="limit" value="20"></ww:param></ww:action>
<%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.MANAGE_MEMBER_REQUEST)){%>
DCampus.AuditPostsUI.mygroupId = <%=mygroupId%>;//设置groupId
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
        <div class="seperate5px"></div>
          <h3 class="header">审核帖子</h3>
          <div class="body threads-lst" id="auditThreads-lst"> </div>
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
<textarea id="auditThreads_template" style="display:none">
<table border="0"  class="table001 slct-tbl" cellpadding="0" cellspacing="0">
  <thead>
    <tr>
      <th width="10" align="center" class="displayNone"><input type="checkbox" /></th>
      <th>标题</th>
      <th width="132">作者</th>
    </tr>
  </thead>
  <tbody>
  {for post in posts}
    <tr>
      <td class="displayNone"><input type="checkbox" value="\${post.id}"/></td>
      <td><span class="ico ico01">&nbsp;</span><a href="javascript:void(0)" onFocus="return this.blur()">\${post.topic|escape}</a></td>
      <td><p class="replyman">\${post.memberName|escape}</p>
        <p class="replydate">\${post.creationDate|escape}</p></td>
    </tr>
    <tr class="displayNone dropTR">
       <td colspan="3" class="auditTD">
          <fieldset><legend>正文</legend>\${post.body}</fieldset>
       </td>
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
