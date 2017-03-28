<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.dcampus.groups.beans.IGroupBean"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@page import="com.dcampus.groups.beans.IForumBean"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<title>DCampus Groups</title>
<link href="js/jquery-ui-1.7.2.custom/css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" />
<link href="themes/default/css/global.css" rel="stylesheet" type="text/css" />
<%
   long getGroupsId = ServletRequestUtils.getLongParameter(request, "groupId",0);//获取GroupId

%>
<%
  if(getGroupsId == 0) {
%>
<script>window.location.href = "/pages/index.jsp";</script>
<% }
%>
<script src="js/jquery/jquery-1.3.2.pack.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.core.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.draggable.js"></script>
<script src="js/ckeditor/ckeditor.js"></script>
<script src="pages/js/TrimPath_Template.js"></script>
<script src="pages/js/DCampus.Public.js"></script>
<script src="pages/js/DCampus.Permission.js"></script>
<%@include file="pages/path.jsp"%>
<script src="pages/js/DCampus.GroupsDecoration.js"></script>
<!--Groups 装饰信息：Groups名、描述、Groups图标等-->
<script src="pages/js/DCampus.GroupMenu.js"></script>
<script>
var json = <ww:action name='getGroupInfo' namespace='/group' executeResult='true' ignoreContextParams='false'/>
<%if(isLogin)%>
var isGroupMember = <ww:action name='isGroupMember' namespace='/user' executeResult='true' ignoreContextParams='false'/>
</script>
<script src="pages/js/DCampus.Paging.Plugins.js"></script>
<script src="pages/js/DCampus.GuestBook.js"></script>
<%
	request.setAttribute("mygroupId", -groupId);
%>
<script>
<%
//浏览会员权
if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_MEMBER)){%>
DCampus.Permission.view_member = true;
<%}%>
<%
//浏览圈子权
if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_GROUP)){%>
DCampus.Permission.view_group = true;
<%} else {%>
    alert("对不起，您没有权限访问");
	window.location.href="<%=site%>/pages/login.jsp";
<%}%>
<%
//浏览资源权
if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_RESOURCE)){%>
DCampus.Permission.view_resource = true;
<%}%>


<%
IForumBean[] forumBeans = ServiceManager.getService().getForumManager().getTotalForumsInGroup(groupId);
long myForumId = 0;
if(forumBeans.length == 1) {
myForumId = forumBeans[0].getId();
if(getService(session).getPermissionManager().hasForumPermission(myForumId,IPermission.ForumPerm.DELETE_THREAD)) {%>
  DCampus.Permission.delete_thread = true;
<%}
}
request.setAttribute("myForumId", myForumId);
%>
<%
if(getService(session).getPermissionManager().hasForumPermission(myForumId,IPermission.ForumPerm.DELETE_POST)) {%>
   DCampus.Permission.DELETE_POST = true;
<%}
%>
var listJSON =  <ww:action name='getThreads' namespace='/thread' executeResult='true' ignoreContextParams='false'><ww:param name="forumId"  value="%{#request.myForumId}"></ww:param><ww:param name="start"  value=""></ww:param><ww:param name="limit"  value="20"></ww:param>
</ww:action>

</script>
</head>
<body>
<input type="hidden" value="<%=myForumId%>" id="defaultForumID"/>
<input type="hidden" name="groupId" />
<input type="hidden" name="groupAddr" />
<input type="hidden" name="menu" value="index"/>
<div id="headerWrap_in">
  <%@include file="pages/header.jsp"%>
</div>
<div id="groupsTitle">
  <table border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="50" height="50" class="groups-img"><img src="<%=site%>/themes/default/images/groupsImg.gif" /></td>
      <td class="title"></td>
      <td class="fav"><span>&nbsp;</span><a href="javascript:void(0)" id="addFavorite">收藏本圈子</a></td>
      <td style="padding-left:20px;"><div class="ui-widget displayNone" id="joinMessage" style="width:300px;margin:15px auto 0 auto;">
          <div class="ui-state-highlight ui-corner-all" style="margin-top:5px;padding: 0 7px;">
            <p style="padding:5px 0;"><span class="ui-icon ui-icon-info" style="float: left; margin-right:3px;"></span> <strong>成员加入信息：</strong><span class="current_choose_category"> 您有( <a href="manage.jsp#audit" class="joinCount">5</a> )位成员申请加入 </span></p>
          </div>
        </div></td>
    </tr>
  </table>
  <div class="groups-search">
    <%@include file="pages/group/searchBlock.jsp"%>
  </div>
</div>
<div id="groups_wrap">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td class="coL"><h3 class="groups-header"><span class="groups-header-L"></span><span class="groups-header-R"></span><span class="title">主人寄语</span>
          <%if(getService(session).getPermissionManager().isGroupManager(memberID,groupId)){%>
          <span class="editF"><span class="ico ico04"></span><a href="javascript:void(0)" id="editFrontpage">编辑</a></span>
          <%}%>
        </h3>
        <div id="showAnnounceArea"></div>
        <div id="inlineEdit">欢迎进入我的圈子</div>
        <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_GROUP)){%>
        <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.ADD_POST)){%>
        <div class="container002">
          <h3 class="header" style="background:none;border-top:1px dashed #ccc;">我也说两句</h3>
          <div class="seperate5px"></div>
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="80" class="guestICO" align="center" valign="top">&nbsp;</td>
              <td><textarea class="guestTextarea"></textarea>
                <div class="seperate5px"></div>
                <input type="button" value="发表" class="btn-publish-message"/></td>
            </tr>
          </table>
        </div>
        <div class="seperate5px"></div>
        <%}%>
        <div class="container002">
          <h3 class="header">留言列表</h3>
        </div>
        <table  cellspacing="0" cellpadding="0" border="0" class="listInfoTableWrap" width="100%">
          <tbody>
            <tr>
              <td><table cellspacing="0" cellpadding="0" border="0" class="pagebarTableWrap">
                  <tbody>
                    <tr>
                      <td class="page-left"><a href="javascript:void(0);" class="prePage displayNone" title="上一页">-</a></td>
                      <td class="page-bg" style="white-space: nowrap;"><span class="pageNumA"></span></td>
                      <td class="page-bg page-next"><a href="javascript:void(0);" class="nextPage displayNone" title="下一页">+</a></td>
                      <td class="pageNum page-bg"><span>Pages:<b class="myThreadPagenum"></b>/<b class="myThreadpageCount"></b></span> </td>
                      <td class="page-bg"><span>
                        <input type="text" class="pageInput" id="goPage" name="goPage"/>
                        </span> </td>
                      <td class="page-bg page-button"><span>
                        <input type="button" value="Go" class="go_botton" />
                        </span> </td>
                      <td class="page-right"></td>
                      <td class="totalTopic"> [留言数:<span class="totalCount"></span>]</td>
                    </tr>
                  </tbody>
                </table></td>
              <!--发贴权-->
              <td align="right"></td>
            </tr>
          </tbody>
        </table>
        <div class="container007">
          <ul class="news clear mainPage">
          </ul>
        </div>
        <table  cellspacing="0" cellpadding="0" border="0" class="listInfoTableWrap" width="100%">
          <tbody>
            <tr>
              <td><table cellspacing="0" cellpadding="0" border="0" class="pagebarTableWrap">
                  <tbody>
                    <tr>
                      <td class="page-left"><a href="javascript:void(0);" class="prePage displayNone" title="上一页">-</a></td>
                      <td class="page-bg" style="white-space: nowrap;"><span class="pageNumA"></span></td>
                      <td class="page-bg page-next"><a href="javascript:void(0);" class="nextPage displayNone" title="下一页">+</a></td>
                      <td class="pageNum page-bg"><span>Pages:<b class="myThreadPagenum"></b>/<b class="myThreadpageCount"></b></span> </td>
                      <td class="page-bg"><span>
                        <input type="text" class="pageInput" id="goPage" name="goPage"/>
                        </span> </td>
                      <td class="page-bg page-button"><span>
                        <input type="button" value="Go" class="go_botton" />
                        </span> </td>
                      <td class="page-right"></td>
                      <td class="totalTopic"> [留言数:<span class="totalCount"></span>]</td>
                    </tr>
                  </tbody>
                </table></td>
              <!--发贴权-->
              <td align="right"></td>
            </tr>
          </tbody>
        </table>
        <div class="seperate5px"></div>
        <div class="seperate5px"></div>

        <%} %>
      </td>
      <td class="coR"><%if(getService(session).getPermissionManager().isGroupManager(memberID,groupId)){%>
        <div class="seperate5px"></div>
        <div class="seperate5px"></div>
        <ul class="list006">
          <script>DCampus.Permission.Group_Manager = true;</script>
          <li><span class="ico ico06">&nbsp;</span><a href="manage.jsp">圈子管理</a></li>
        </ul>
        <%}%>
        <div class="container003">
          <h3 class="header">留言板信息</h3>
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
      <tr>
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
<div id="uploadDialog" class="displayNone ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable">
  <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> <span id="ui-dialog-title-dialog" class="ui-dialog-title"></span> <a class="ui-dialog-titlebar-close ui-corner-all" href="javascript:void(0)"><span class="ui-icon ui-icon-closethick">close</span></a> </div>
  <div style="width: auto;" class="ui-dialog-content ui-widget-content uploadIframe"> </div>
  <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-cancel">取消</button>
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-confirm">确定</button>
  </div>
</div>
<textarea id="threads_template" class="displayNone">
{var status = "";var priority = "";var count = 0;var template;}
  {for thread in threads}

   {eval}
     switch(thread.priority) {
       case 1 :priority="ico01";break;
       case 2 :priority="ico01";break;
       case 3 :priority="ico_top";break;
     }
     switch(thread.status) {
        case 1 : status = "normal";break;
        case 2 : status = "ico_close";if(priority == "ico01") {priority = "normal"};break;
        case 3 : status = "ico_disabled";if(priority == "ico01") {priority = "normal"};break;
        case 4 : status = "ico_audit";if(priority == "ico01") {priority = "normal"};break;
        case 5 : status = "normal";break;
     }
  {/eval}
  <li class="item twitter">
      <div class="ctrl"> <span class="time gray" style="display: inline;"><span class="guestTime">\${thread.creationDate|escape}</span> {if DCampus.Permission.delete_thread}<a href="javascript:void(0)" class="deleteThread displayNone" rev="\${thread.id}">删除</a>{/if}</span></div>
        <table  border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td width="80" valign="top"><img alt="\${thread.memberName|escape}" src="\${thread.memberIcon}" class="user"></td>
    <td>
    <div class="content"> <span class="user">\${thread.memberName|escape}</span> <span class="doing gray"></span>  <span class="what replyTitle">\${thread.topic|escape}</span> </div>
        <div class="content ft12 reList">
          <h5> <a href="javascript:void(0);" class="more hidden" rel="\${thread.id}" rev="reNews\${count}">查看所有<span class="moreReply"></span>条回复<img align="absmiddle" src="http://s.qun.qq.com/god/images/space.gif" class="drop"></a> <a href="javascript:void(0);" class="less hide" rel="\${thread.id}" rev="reNews\${count}">收起回复<img align="absmiddle" src="http://s.qun.qq.com/god/images/space.gif" class="drop"></a> </h5>
          <div class="triangle"></div>
          <ul class="reNews\${count} reNews">

          </ul>
          <div class="reOut">
            <input type="text" value="我也说一句" class="re">
          </div>
        </div>
        <div class="content ft12 reContainer hidden">
          <div class="reOut">

          </div>
          <div><a href="javascript:void(0);" class="reOk" id="\${thread.id}">发表</a> <a href="javascript:void(0);" class="reCancel">取消</a>
          </div>
        </div>

    </td>
  </tr>
</table>

      <div class="point"></div>
    </li>
    {eval}
      DCampus.GuestBookUI.saveReplyID.push(thread.id);
      count++;
    {/eval}
    {/for}
    {eval}
      if(DCampus.GuestBookUI.saveReplyID.length > 0)
      DCampus.GuestBookUI._getReplyList();
    {/eval}
</textarea>
<textarea id="replyListTemplate" style="display:none">
{var count = 0;}
{for post in posts}
{if totalCount < 6 && count < totalCount-1 || posts.length > 5 && count < posts.length - 1}
 <li> <span class="user">\${post.memberName}</span> <span class="what">\${post.body}</span> <span class="time gray clear"><span class="postTime">\${post.creationDate}</span> {if DCampus.Permission.DELETE_POST}<a href="javascript:void(0)" class="deletePost" rev="\${post.id}">删除</a>{/if}</span> </li>
{/if}
{eval}count++;{/eval}
{/for}
</textarea>
</body>
</html>
