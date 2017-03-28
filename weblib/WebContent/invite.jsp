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
<script src="pages/js/DCampus.GroupsDecoration.js"></script>
<!--Groups 装饰信息：Groups名、描述、Groups图标等-->
<script src="pages/js/DCampus.GroupMenu.js"></script>
<script src="pages/js/DCampus.Invite.js"></script>

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
      <td class="coL"><h3 class="groups-header"><span class="groups-header-L"></span><span class="groups-header-R"></span> <span class="title">邀请会员</span> </h3>
        <div class="tabMenu tab">
          <ul class="tabHanddle">
            <li><a href="#">发送短消息邀请会员</a></li>
            <!--li><a href="#">发送邮件邀请会员</a></li-->
          </ul>
          <div class="tabCover"></div>
        </div>
        <div class="tabContent">
          <div class="tabContent0">
            <form name="shortMessage_invite">
              <input type="hidden" value="message" name="type"/>
              <table  border="0" cellspacing="0" cellpadding="0" class="table001 inviteTable">
                <tr>
                  <td width="1%" nowrap="nowrap">会员用户名：</td>
                  <td><input type="text" name="memberName" class="inputstyle01 tabForm"/> @scut.edu.cn</td>
                </tr>
                <tr>
                  <td width="1%" nowrap="nowrap" valign="top">短消息内容：</td>
                  <td><textarea type="text"  name="invitationBody" class="invitationStyleDemo tabForm">
    Groups真是太好，太伟大了，我的几个朋友已经在上面注册并创建了属于自己的Groups了。如果你成为我的Groups的会员，你可以查看我的最新照片、参与我的讨论、下载我的资源、了解我的最新动态...
　　这个网站提供创建个人Groups的服务，并提供1G空间的网络硬盘；你可以邀请会员，与会员相互交流、与会员共享资源、分享生活中的点滴。
    朋友们，还等什么？还不快点加入我的Groups，成为我的会员？我热烈地期待着你的加入，成为我的Groups的一分子！
    </textarea></td>
                </tr>
              </table>
              <div class="toolbar"><a class="button button002 sendShortMessageToInvite" href="javascript:void(0)" onfocus="this.blur()">发送</a></div>
            </form>
          </div>
          <div class="tabContent1 displayNone">
            <form name="email_invite">
              <input type="hidden" value="mail" name="type"/>
              <table  border="0" cellspacing="0" cellpadding="0" class="table001 inviteTable">
                <tr>
                  <td valign="top" width="1%" nowrap="nowrap">请填写邮件地址：</td>
                  <td><textarea type="text" class="mailarea tabForm" name=""></textarea></td>
                </tr>
                <tr>
                  <td valign="top" width="1%" nowrap="nowrap">短消息内容：</td>
                  <td><textarea type="text" class="invitationStyleDemo tabForm" name="">
   Groups真是太好，太伟大了，我的几个朋友已经在上面注册并创建了属于自己的Groups了。如果你成为我的Groups的会员，你可以查看我的最新照片、参与我的讨论、下载我的资源、了解我的最新动态...
　　这个网站提供创建个人Groups的服务，并提供1G空间的网络硬盘；你可以邀请会员，与会员相互交流、与会员共享资源、分享生活中的点滴。
    朋友们，还等什么？还不快点加入我的Groups，成为我的会员？我热烈地期待着你的加入，成为我的Grou
    </textarea></td>
                </tr>
              </table>
              <div class="toolbar"><a class="button button002 sendEMailToInvite" href="javascript:void(0)" onfocus="this.blur()">发送</a></div>
            </form>
          </div>
        </div></td>
      <td class="coR"><%@include file="pages/group/menu.jsp"%>
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
          </div>
        </div></td>
    </tr>
  </table>
</div>
<%@include file="pages/footer.jsp"%>
<%=getSiteStatCode%>
</body>
</html>
