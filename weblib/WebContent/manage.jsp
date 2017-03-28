<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.dcampus.groups.beans.IGroupBean"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="pages/path.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="<%=getSiteSeoKeywords%>" />
<meta name="Description" content="<%=getSiteSeoDescription%>" />
<title><%=getSiteName%></title>
<link href="themes/default/css/global.css" rel="stylesheet" type="text/css" />
<%@include file="pages/jumpto.jsp"%>
<script src="js/jquery/jquery-1.4.2.pack.js"></script>
<script src="js/jquery/jquery.cookie.js"></script>
<script src="pages/js/TrimPath_Template.js"></script>
<script src="pages/js/DCampus.Public.js"></script>
<script src="pages/js/DCampus.Permission.js"></script>
<script src="pages/js/DCampus.GroupsDecoration.js"></script><!--Groups 装饰信息：Groups名、描述、Groups图标等-->
<script src="pages/js/DCampus.GroupMenu.js"></script>
<script src="pages/js/DCampus.Manage.js"></script>
</head>
<body>
<script>
var json = <ww:action name='getGroupInfo' namespace='/group' executeResult='true' ignoreContextParams='false'/>;
<%if(isLogin)%>
var isGroupMember = <ww:action name='isGroupMember' namespace='/user' executeResult='true' ignoreContextParams='false'/></script>
<input type="hidden" name="groupId"/>
<input type="hidden" name="groupAddr" />
<input type="hidden" name="menu" value=""/>
<div id="headerWrap_in">
  <%@include file="pages/header.jsp"%>
</div>
<%if(!isLogin) { %>
<script>
window.location.href="<%=site%>/pages/login.jsp";
</script>
<%}%>
<div id="groupsTitle">
  <table border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="50" height="50" class="groups-img"><img src="themes/default/images/groupsImg.gif" /></td>
      <td class="title"></td>
      <td class="fav"><span>&nbsp;</span><a href="javascript:void(0)" id="addFavorite" rel="<%=groupId%>">收藏本圈子</a></td>
    </tr>
  </table>
  <div class="groups-search">
       <%@include file="pages/group/searchBlock.jsp"%>
  </div>
</div>
<div id="groups_wrap">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td class="coL">
      <div class="tabMenu tab">
          <ul class="tabHanddle">
            <li><a href="javascript:void(0)">圈子设置</a></li>
            <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.MANAGE_MEMBER_REQUEST)){%>
            <li><a href="javascript:void(0)">会员审核</a></li>
            <li><a href="javascript:void(0)">审核主题</a></li>
            <li><a href="javascript:void(0)">审核回帖</a></li>
            <%}%>
          </ul>
          <div class="tabCover" style="width: 48px; left: 10px;">圈子设置</div>
        </div>
        <iframe src="#" frameborder="0" scrolling="no" style="width:100%" id="manageIFrame"></iframe>
      </td>
      <td class="coR">
      <%@include file="pages/group/menu.jsp"%>
        <div class="container003">
        <h3 class="header">圈子信息</h3>
        <div class="body">
          <table  border="0" cellspacing="0" cellpadding="0" class="table003">
            <tr>
              <td class="tt">创建者：</td>
              <td><span class="owner"></span></td>
            </tr>
            <tr>
              <td class="tt">创建于：</td>
              <td><span class="createDate"></span></td>
            </tr>
          </table>
          <div class="line"></div>
          <table  border="0" cellspacing="0" cellpadding="0" class="table003">
            <tr>
              <td class="tt">管理员：</td>
              <td><span class="groupsManager"></span></td>
            </tr>
            <tr>
              <td class="tt">成员：</td>
              <td><span class="memberCount"></span></td>
            </tr>
            <tr>
              <td class="groups-desc" colspan="2"><span class="tt" style="color:#1E5494;">描述：</span><span class="desc"></span></td>
            </tr>
          </table>
        </div></div></td>
    </tr>
  </table>
  </div>
 <%@include file="pages/footer.jsp"%>
<%=getSiteStatCode%>
</body>
</html>
