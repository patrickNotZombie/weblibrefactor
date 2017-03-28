<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.dcampus.groups.beans.IGroupBean"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@page import="com.dcampus.groups.beans.IForumBean"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
//IGroupBean groupBean = (IGroupBean)ValueCarrier.getValue(ActionContext.getContext(), "groupBean");
//String groupName = groupBean.getName();
%>
<head>
<%@include file="pages/path.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="<%=getSiteSeoKeywords%>" />
<meta name="Description" content="<%=getSiteSeoDescription%>" />
<title><%=getSiteName%></title>
<link href="js/jquery-ui-1.7.2.custom/css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" />
<link href="themes/default/css/global.css" rel="stylesheet" type="text/css" />
<%@include file="pages/jumpto.jsp"%>
<script src="js/jquery/jquery-1.3.2.pack.js"></script>
<script src="js/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.core.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.draggable.js"></script>
<script src="js/ckeditor/ckeditor.js"></script>
<script src="pages/js/TrimPath_Template.js"></script>
<script src="pages/js/DCampus.Public.js"></script>
<script src="pages/js/DCampus.Permission.js"></script>
<script src="pages/js/DCampus.GroupsDecoration.js"></script><!--Groups 装饰信息：Groups名、描述、Groups图标等-->
<script src="pages/js/DCampus.GroupMenu.js"></script>
<script src="pages/js/DCampus.Paging.Plugins.js"></script>
<script src="pages/js/DCampus.GroupDetail.js"></script>
</head>
<body>
<script>
var json = <ww:action name='getGroupInfo' namespace='/group' executeResult='true' ignoreContextParams='false'/>;
<%if(isLogin)%>
var isGroupMember = <ww:action name='isGroupMember' namespace='/user' executeResult='true' ignoreContextParams='false'/>
<%
//浏览圈子权
if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_GROUP)){%>
DCampus.Permission.view_group = true;
<%}%>
<%
if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.ADD_POST)){%>
         DCampus.Permission.ADD_POST = true;//发贴权
<%}%>
DCampus.Permission.CurrentID = <%=getService(session).getUserData().getMemberId()%>;

<%
IForumBean[] forumBeans = ServiceManager.getService().getForumManager().getTotalForumsInGroup(groupId);
long myForumId = 0;
if(forumBeans.length == 1) {
myForumId = forumBeans[0].getId();
if(getService(session).getPermissionManager().hasForumPermission(myForumId,IPermission.ForumPerm.DELETE_POST)) {%>
  DCampus.Permission.DELETE_POST = true;
<%}
   if(getService(session).getPermissionManager().hasForumPermission(myForumId,IPermission.ForumPerm.MODIFY_POST)) {
%>
DCampus.Permission.MODIFY_POST = true;
<%}}
%>

</script>
<input type="hidden" name="groupId" />
<input type="hidden" name="groupAddr" />
<input type="hidden" name="menu" value="detail"/>
<div id="headerWrap_in">
  <%@include file="pages/header.jsp"%>
</div>
<div id="groupsTitle">
  <table border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="50" height="50" class="groups-img"><img src="<%=site%>/themes/default/images/groupsImg.gif" /></td>
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
            <td class="totalTopic"> [帖子数:<span class="totalCount"></span>] <a href="javascript:void(0)" onclick="history.go(-1)" class="return-list">返回列表>></a></td>
          </tr>
        </tbody></table></td>
      <td align="right"><%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.ADD_POST)){%><input type="button" class="btn-reply btn-open-dialog" onfocus="this.blur()"> <input type="button" class="btn-newTopic btn-open-dialog" onfocus="this.blur()"/><%}%></td>
    </tr>
  </tbody></table>
        <div class="container002 container-detail">
          <h3 class="header detail-topic"></h3>
          <div class="body threads-lst" id="threads-lst"> </div>
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
            <td class="totalTopic"> [帖子数:<span class="totalCount"></span>] <a href="javascript:void(0)" onclick="history.go(-1)" class="return-list">返回列表>></a></td>
          </tr>
        </tbody></table></td>
      <td align="right"><%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.ADD_POST)){%><input type="button" class="btn-reply btn-open-dialog" onfocus="this.blur()"> <input type="button" class="btn-newTopic btn-open-dialog" onfocus="this.blur()"/><%}%></td>
    </tr>
  </tbody></table>

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

<div id="createThreadDialog" class="displayNone ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable">
  <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> <span id="ui-dialog-title-dialog" class="ui-dialog-title"></span> <a class="ui-dialog-titlebar-close ui-corner-all" href="javascript:void(0)"><span class="ui-icon ui-icon-closethick">close</span></a> </div>
  <div style="height: 200px; min-height: 109px; width: auto;" class="ui-dialog-content ui-widget-content">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <th width="1%" nowrap="nowrap">标题：</th>
        <td><input type="text" class="text" name="topic"/>
          <span class="requireMark">*</span>
          <input type="checkbox" name="memberVisible" disabled="disabled"/>
          是否匿名</td>
      </tr>
      <tr style="display:none">
        <th nowrap="nowrap" valign="top" style="padding-top:5px;"></th>
        <td><select name="forumId" style="width:250px;" disabled="disabled">
          </select></td>
      </tr>
      <tr>
        <th nowrap="nowrap" valign="top">内容：</th>
        <td><textarea name="discussBody" id="discussBody"></textarea></td>
      </tr>
    </table>

  </div>
  <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-cancel">取消</button>
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-publish">发表</button>
  </div>
</div>




<textarea id="posts_template" style="display:none">
<input type="hidden" value="\${totalCount}" name="postCount"/>
{var i = 0;var _temp_step = 0;}
{eval}
if( DCampus.GroupDetailUI.start == -10 || DCampus.GroupDetailUI.start == 0) {
  _temp_step = 0;
} else {
_temp_step = DCampus.GroupDetailUI.start;
}
{/eval}
<table  border="0" cellspacing="0" cellpadding="0" class="table004" width="100%">
  {for post in posts}
  <tr id="\${post.id}">
    <td class="tdL" threadId="\${post.threadId}"><p><img src="\${post.memberIcon}" width="80" height="80"/></p><p class="detail-name">\${post.memberName|escape}</p></td>
    <td class="tdR">
    <h3 class="detail-date"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>发表于  \${post.creationDate}</td>
    <td width="50" align="right"><span class="step-num" id="step\${i + _temp_step}">{if i + _temp_step == 0}楼主{else}\${i + _temp_step}楼{/if}</span></td>
  </tr>
</table>
</h3>
    <div class="detail-body">
    \${post.body}
    </div>
    <div class="detail-memberSignature">
        \${post.memberSignature}
    </div>
    <div class="detail-toolbar">
    {if DCampus.Permission.ADD_POST == true}
    <a href="javascript:void(0)" class="btn-detail-reply">回复</a> <a href="javascript:void(0)" class="btn-repquote">引用</a>
    {/if}
    {if DCampus.Permission.MODIFY_POST == true}
     <a href="javascript:void(0)" class="btn-detail-edit" rel="\${post.id}">编辑</a>
    {/if}
    {if DCampus.Permission.DELETE_POST == true || DCampus.Permission.CurrentID == post.memberId}
     {if i + _temp_step == 0}<a href="javascript:void(0)" class="btn-delete-one" rel="\${post.id}" rev="fThreads">删除</a>{else} <a href="javascript:void(0)" class="btn-delete-one" rel="\${post.id}">删除</a>{/if}
    {/if}
    <%if(getService(session).getPermissionManager().hasForumPermission(myForumId,IPermission.ForumPerm.DELETE_THREAD)) {%>
        {if i + _temp_step == 0}<input type="checkbox" value="\${post.id}" rev="fThreads"/>{else}<input type="checkbox" value="\${post.id}"/>{/if}<span class="manage-threads">管理</span>
        <%}%>
    </div>
    </td>
  </tr>
  {eval}
    ++i;
  {/eval}
   {/for}
</table>
</textarea>
<div class="ManageToolWrap"><h3>你选中了<span class="num"></span>篇</h3>
<div class="space01"></div>
<p><a href="javascript:void(0)" class="delete">删除</a></p>
</div>
<%=getSiteStatCode%>
</body>
</html>
