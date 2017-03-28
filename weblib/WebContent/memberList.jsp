<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.dcampus.groups.beans.IGroupBean"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
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
<script src="pages/js/DCampus.GroupMemberList.js"></script>
<script src="pages/js/DCampus.Paging.Plugins.js"></script>
<%
  request.setAttribute("mygroupId", groupId);
%>
</head>
<body>
<script>
var json = <ww:action name='getGroupInfo' namespace='/group' executeResult='true' ignoreContextParams='false'/>;
var memberJSON = <ww:action name="getMembersInGroup" namespace='/user' executeResult='true' ignoreContextParams='false'><ww:param name="groupId" value="%{#request.mygroupId}"></ww:param><ww:param name="start" value="0"></ww:param><ww:param name="limit" value="20"></ww:param></ww:action>;
<%if(isLogin)%>
var isGroupMember = <ww:action name='isGroupMember' namespace='/user' executeResult='true' ignoreContextParams='false'/>
<%if(getService(session).getPermissionManager().isGroupManager(memberID,groupId)){%>
DCampus.Permission.Group_Manager  = true;
<%}%>
</script>
<input type="hidden" name="groupId" />
<input type="hidden" name="groupAddr" />
<input type="hidden" name="menu" value="memberList"/>
<div id="headerWrap_in">
  <%@include file="pages/header.jsp"%>
</div>
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
            <td class="totalTopic"> [成员数:<span class="totalCount"></span>]</td>
          </tr>
        </tbody></table></td>
      <td align="right"></td>
    </tr>
  </tbody></table>
        <div class="container002">
          <h3 class="header">成员列表 <a class="button button001" href="invite.jsp">邀请成员</a></h3>
           <div id="memberLst"> </div>
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
            <td class="totalTopic"> [成员数:<span class="totalCount"></span>]</td>
          </tr>
        </tbody></table></td>
      <td align="right"></td>
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

<textarea id="memberList_template" style="display:none">
  {for member in members}
          <li class="memberWrap">
					<div class="friendsDivL">
					<div class="l50_s"><a title="\${member.memberName}" href="#"><img height="50" width="50" src="\${member.icon}"/></a></div>
					</div>
					<div class="friendsDivR">
					<p><span class="hy_dl"> </span><a href="#">\${member.name|escape}</a></p>
                    {if DCampus.Permission.Group_Manager == true}
					<p><a title="从好友列表中删除\${member.name}" class="deleteFriends" href="javascript:void(0);" id="\${member.id}">删除</a></p>
                    {/if}
					</div>
				</li>
    {/for}
</textarea>

<%=getSiteStatCode%>
</body>
</html>
