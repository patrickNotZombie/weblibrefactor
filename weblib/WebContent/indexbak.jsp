<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.dcampus.groups.beans.IGroupBean"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="pages/path.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="<%=getSiteSeoKeywords%>" />
<meta name="Description" content="<%=getSiteSeoDescription%>" />
<title><%=getSiteName%></title>
<link href="js/jquery-ui-1.7.2.custom/css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" />
<link href="themes/default/css/global.css" rel="stylesheet" type="text/css" />
<%@include file="pages/jumpto.jsp"%>
<%
  if(groupId == 0) {
%>
<script>window.location.href = "<%=site%>/pages/index.jsp";</script>
 <%
 return;
 }
%>

<script>
var json = <ww:action name='getGroupInfo' namespace='/group' executeResult='true' ignoreContextParams='false'/>
if(json.usage == "guestbook") {//如果是guestbook 则跳转
  window.location.href = "guestbook.jsp";
}
</script>
<script src="js/jquery/jquery-1.4.2.pack.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.core.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.draggable.js"></script>
<script src="js/ckeditor/ckeditor.js"></script>
<script src="pages/js/TrimPath_Template.js"></script>
<script src="pages/js/DCampus.Public.js"></script>
<script src="pages/js/DCampus.Permission.js"></script>
<script src="pages/js/DCampus.GroupsDecoration.js"></script><!--Groups 装饰信息：Groups名、描述、Groups图标等-->
<script src="pages/js/DCampus.GroupMenu.js"></script>
<script src="pages/js/DCampus.GroupIndex.js"></script>
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
<%}%>
<%
//浏览资源权
if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_RESOURCE)){%>
DCampus.Permission.view_resource = true;
<%}%>
</script>
</head>
<body>
<script>
<%if(isLogin)%>
var isGroupMember = <ww:action name='isGroupMember' namespace='/user' executeResult='true' ignoreContextParams='false'/>
//页面获取主题json
var newThreadsJSON =  <ww:action name='getNewThreadsInGroup' namespace='/thread' executeResult='true' ignoreContextParams='false'></ww:action>
//页面获取成员json
var membersJSON =  <ww:action name='getMembersInGroup' namespace='/user' executeResult='true' ignoreContextParams='false'><ww:param name="limit" value="18"></ww:param></ww:action>
//页面获取资源json
var resourcesJSON =  <ww:action name='getResources' namespace='/group' executeResult='true' ignoreContextParams='false'><ww:param name="parentId" value="%{#request.mygroupId}"></ww:param><ww:param name="limit" value="10"></ww:param></ww:action>
</script>
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
      <td class="fav"><span>&nbsp;</span><a href="javascript:void(0)" id="addFavorite" rel="<%=groupId%>">收藏本圈子</a></td>
      <td style="padding-left:20px;">
      <div class="ui-widget displayNone" id="joinMessage" style="width:300px;margin:15px auto 0 auto;">
  <div class="ui-state-highlight ui-corner-all" style="margin-top:5px;padding: 0 7px;">
    <p style="padding:5px 0;"><span class="ui-icon ui-icon-info" style="float: left; margin-right:3px;"></span> <strong>成员加入信息：</strong><span class="current_choose_category"><a href="manage.jsp#audit"> 您有<span class="joinCount"> 5 </span>位成员申请加入</a></span></p>
  </div>
</div>
</td>
    </tr>
  </table>
  <div class="groups-search">
      <%@include file="pages/group/searchBlock.jsp"%>
  </div>
</div>
<div id="groups_wrap">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td class="coL"><h3 class="groups-header"><span class="groups-header-L"></span><span class="groups-header-R"></span><span class="title">首页</span> <%if(getService(session).getPermissionManager().isGroupManager(memberID,groupId)){%><span class="editF"><span class="ico ico04"></span><a href="javascript:void(0)" id="editFrontpage">编辑</a></span><%}%></h3>
        <div id="showAnnounceArea"></div>
        <div id="inlineEdit">欢迎进入我的圈子</div>
     <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_GROUP)){%>
        <div class="container002">
          <h3 class="header">最新主题
          <%
		  //out.print(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.ADD_POST));
		  //out.print("   " + getService(session).getUserData().getMemberId());
		  //out.print("   " + groupId);
		  if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.ADD_POST)){%>
          <a href="javascript:void(0)" class="button button001 createThread">发表主题</a>
          <%}%>
          </h3>
          <div class="body threads-lst">

          <table border="0"  class="table001" cellpadding="0" cellspacing="0">
  <thead>
    <tr>
      <th>标题</th>
      <th width="132">作者</th>
      <th width="80">回复/浏览</th>
      <th width="132">最后回复</th>
    </tr>
  </thead>
  <tbody id="threads-lst">
       </tbody>
</table>
          </div>
        </div>
        <%} %>
        <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_MEMBER)){%>
        <div class="container002">
          <h3 class="header">讨论成员
          <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.INVITE_MEMBER)){%>
          <a href="invite.jsp" class="button button001">邀请成员</a>
          <%}%>
          </h3>
          <div class="body">
            <div class="list004 members-lst" id="members-lst">
            </div>
            <div class="clearBoth"></div>
          </div>
        </div>
        <%}%>
         <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_RESOURCE)){%>
        <!--div class="container002">
          <h3 class="header">共享资源
          <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.UPLOAD_RESOURCE)){%>
          <a href="javascript:void(0)" class="button button001 uploadResources">上传资料</a>
          <%}%>
          </h3>
          <div class="body">
            <table border="0"  class="table001 sourceTable" cellpadding="0" cellspacing="0">
              <thead>
                <tr>
                  <th>文件名</th>
                  <th width="80">文件大小</th>
                  <th width="100">上传者</th>
                  <th width="80">上传时间</th>
                  <th width="60">下载</th>
                </tr>
              </thead>
              <tbody id="sourceWrap">
              </tbody>
            </table>
          </div>
        </div-->
        <%}%>
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


<div id="uploadDialog" class="displayNone ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable">
  <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> <span id="ui-dialog-title-dialog" class="ui-dialog-title"></span> <a class="ui-dialog-titlebar-close ui-corner-all" href="javascript:void(0)"><span class="ui-icon ui-icon-closethick">close</span></a> </div>
  <div style="width: auto;" class="ui-dialog-content ui-widget-content uploadIframe">

  </div>
  <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-cancel">取消</button>
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-confirm">确定</button>
  </div>
</div>


<textarea id="threads_template" class="displayNone">
{var status = "normal";var priority = "";}
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

    <tr>
     <td><span class="ico \${priority}">&nbsp;</span> <span class="\${status}">&nbsp;</span> <a href="detail.jsp#tid\${thread.id}" onfocus="return this.blur()">\${thread.topic|escape}</a></td>
      <td><p class="replyman">\${thread.memberName|escape}</p>
        <p class="replydate">\${thread.creationDate|escape}</p></td>
      <td class="view-click-count">\${thread.replyCount|escape}/\${thread.viewCount|escape}</td>
      <td><p class="replyman">\${thread.lastPostDate|escape}</p>
        <p class="replydate">\${thread.lastPostMemberName|escape}</p></td>
    </tr>
    {/for}
</textarea>


<textarea id="members_template" class="displayNone">
{for member in members}
          <div class="memberWrapIndex">
					<div class="friendsDivL">
					<div class="l50_s"><a title="\${member.memberName}" href="#"><img height="50" width="50" src="\${member.icon}"/></a></div>
					</div>
					<div class="friendsDivR">
						<p><span class="hy_dl"> </span><a href="#">\${member.name|escape}</a></p>
						<!--p style=""><a title="从好友列表中删除\${member.name}" class="c9" href="javascript:void(0)" id="\${member.id}">删除</a></p-->
					</div>
				</div>
{/for}
</textarea>


<textarea id="sourceTemplate" class="displayNone">
{for resource in resources}
                 <tr>
                  <td><a href="/group/downloadResource.action?id=\${resource.id}">\${resource.name}</a> <span class="oprtText"></span></td>
                  <td>\${resource.size}KB</td>
                  <td>\${resource.memberName}</td>
                  <td><p class="replydate">\${resource.creationDate}</p></td>
                  <td><a href="/group/downloadResource.action?id=\${resource.id}" class="ico ico07" onfocus="this.blur()">&nbsp;</a></td>
                </tr>
                {/for}
</textarea>
<%=getSiteStatCode%>
</body>
</html>
