<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.dcampus.groups.beans.IGroupBean"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@page import="com.dcampus.groups.service.ServiceManager"%>
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
<script src="js/jquery/jquery-1.4.2.pack.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.core.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.draggable.js"></script>
<script src="js/ckeditor/ckeditor.js"></script>
<script src="pages/js/TrimPath_Template.js"></script>
<script src="pages/js/DCampus.Public.js"></script>
<script src="pages/js/DCampus.Permission.js"></script>
<script src="pages/js/DCampus.GroupsDecoration.js"></script><!--Groups 装饰信息：Groups名、描述、Groups图标等-->
<script src="pages/js/DCampus.GroupMenu.js"></script>
<script src="pages/js/DCampus.Paging.Plugins.js"></script>
<script src="pages/js/DCampus.GroupList.js"></script>

</head>
<body>
<script>
var json = <ww:action name='getGroupInfo' namespace='/group' executeResult='true' ignoreContextParams='false'/>
<%if(isLogin)%>
var isGroupMember = <ww:action name='isGroupMember' namespace='/user' executeResult='true' ignoreContextParams='false'/>
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
var listJSON =  <ww:action name='getThreads' namespace='/thread' executeResult='true' ignoreContextParams='false'><ww:param name="forumId"  value="%{#request.myForumId}"></ww:param><ww:param name="start"  value=""></ww:param><ww:param name="limit"  value="20"></ww:param>
</ww:action>


<%
//浏览圈子权
if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_GROUP)){%>
DCampus.Permission.view_group = true;
<%}%>

</script>
<input type="hidden" name="groupId" />
<input type="hidden" name="groupAddr" />
<input type="hidden" name="menu" value="list"/>
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
            <td class="totalTopic"> [主题数:<span class="totalCount"></span>]</td>
          </tr>
        </tbody></table></td>
        <!--发贴权-->
        <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.ADD_POST)){%>
      <td align="right"><input class="btn-newTopic createThread btn-open-dialog" onfocus="this.blur()" type="button"/></td>
         <%}%>
    </tr>
  </tbody></table>
      <!--看贴权-->
      <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_GROUP)){%>
        <div class="container002">
          <h3 class="header">讨论主题</h3>
          <div class="body threads-lst" id="threads-lst"> </div>
        </div>
       <%}%>

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
            <td class="totalTopic"> [主题数:<span class="totalCount"></span>]</td>
          </tr>
        </tbody></table></td>
      <!--发贴权-->
      <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.ADD_POST)){%>
      <td align="right"><input class="btn-newTopic createThread btn-open-dialog" onfocus="this.blur()" type="button"/></td>
      <%}%>
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
  <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> <span id="ui-dialog-title-dialog" class="ui-dialog-title"></span> <a class="ui-dialog-titlebar-close ui-corner-all" href="#"><span class="ui-icon ui-icon-closethick">close</span></a> </div>
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
<textarea id="threads_template" style="display:none">
{var status = "";var priority = "";}
<table border="0"  class="table001 slct-tbl" cellpadding="0" cellspacing="0">
  <thead>
    <tr>
      <th width="10" align="center" class="displayNone"><input type="checkbox" /></th>
      <th>标题</th>
      <th width="132">作者</th>
      <th width="80">回复/浏览</th>
      <th width="132">最后回复</th>
    </tr>
  </thead>
  <tbody>
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
      <td class="displayNone"><input type="checkbox" value="\${thread.id}"/></td>
      <td><span class="ico \${priority}">&nbsp;</span> <span class="\${status}">&nbsp;</span> <a href="detail.jsp#tid\${thread.id}" onfocus="return this.blur()">\${thread.topic|escape}</a></td>
      <td><p class="replyman">\${thread.memberName|escape}</p>
        <p class="replydate">\${thread.creationDate|escape}</p></td>
      <td class="view-click-count">\${thread.replyCount|escape}/\${thread.viewCount|escape}</td>
      <td><p class="replyman">\${thread.lastPostMemberName|escape}</p>
        <p class="replydate">\${thread.lastPostDate|escape}</p></td>
    </tr>
    {/for}
  </tbody>
</table>
</textarea>
<div class="ManageToolWrap"><h3>你选中了<span class="num"></span>篇</h3>
<div class="space01"></div>
<p><a href="javascript:void(0)" class="btn-del-thrL">删除</a> <a href="javascript:void(0)" class="btn-top-thrL">置顶主题</a> <a href="javascript:void(0)" class="btn-untop-thrL">解除置顶</a> <a href="javascript:void(0)" class="btn-close-thrL">关闭主题</a> <a href="javascript:void(0)" class="btn-open-thrL">打开主题</a> </p>
<p><a href="javascript:void(0)" class="btn-disabled-thrL">屏蔽主题</a> <a href="javascript:void(0)" class="btn-enabled-thrL">解除屏蔽</a></p>
</div>
<%=getSiteStatCode%>
</body>
</html>
