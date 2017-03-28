<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="ww" uri="/struts-tags"%>
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
<script src="../../js/jquery/jquery.cookie.js"></script>
<script src="../js/TrimPath_Template.js"></script>
<script src="../js/DCampus.Public.js"></script>
<script src="../js/DCampus.Paging.Plugins.js"></script>
<script src="../js/DCampus.Favorite.js"></script>
</head>
<body>
<script>
var getFavoriteJson = <ww:action name='getWatches' namespace='/user' executeResult='true' ignoreContextParams='false'><ww:param name="start" value="0"></ww:param><ww:param name="limit" value="1000"></ww:param></ww:action>
</script>
<input type="hidden" name="groupId"/>
<input type="hidden" name="groupAddr" />
<input type="hidden" name="menu" value="favorite"/>
<div id="headerWrap_in">
  <%@include file="../header.jsp"%>
</div>

<div id="groupsTitle">
  <table border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="50" height="50" class="groups-img"><img src="../../themes/default/images/groupsImg.gif" /></td>
      <td class="title">个人中心</td>
    </tr>
  </table>
  <div class="groups-search">
      <%@include file="../group/searchBlock.jsp"%>
  </div>
</div>
<div id="groups_wrap">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td class="coL">
      <div class="container002 position-relative">
        <div class="seperate5px"></div>
          <h3 class="header">我的圈子</h3>
          <div id="myGroups-lst" class="body threads-lst" style="display: block;">暂时为空</div>
          <div class="clearBoth"></div>
        </div>
        <div class="container002 position-relative">
        <div class="seperate5px"></div>
          <h3 class="header">我收藏的圈子</h3>
          <div id="favorite-lst" class="body threads-lst" style="display: block;">暂时为空</div>
          <div class="clearBoth"></div>
        </div>
      </td>
      <td class="coR"><%@include file="ucenermenu.jsp"%>
      </td>
    </tr>
  </table>
</div>
<%@include file="../footer.jsp"%>
<textarea id="myGroupTemplate" style="display:none">
<ul>
{for group in groups}
  <li><a href="<%=site%>/\${group.addr}/index.jsp">\${group.name}</a></li>
{/for}
</ul>
</textarea>
<textarea id="favoriteTemplate" style="display:none">
    <ul>
        {for watch in watches}
            <li><a href="<%=site%>/\${watch.groupAddr}/index.jsp">\${watch.groupName}</a> [<a href="javascript:void(0)" class="deleteOne" rev="\${watch.watchId}">删除</a>]</li>
        {/for}
    </ul>
</textarea>
</div>
<%=getSiteStatCode%>
</body>
</html>
