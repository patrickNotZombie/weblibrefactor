<%@ page contentType="text/html;charset=utf-8" %>
<ul class="list005 groupsMenu">
  <li><a href="index.jsp" rel="index">首页</a></li>
  <li><a href="list.jsp" rel="list">讨论区</a></li>
  <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_MEMBER)){%>
  <li><a href="memberList.jsp" rel="memberList">成员</a></li>
  <%}%>
  <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_RESOURCE)){%>
      <li><a href="resourceList.jsp" rel="resourceList">资源</a></li>
  <%}%>
</ul>
<div class="line"></div>
<ul class="list006">
  <li class="li-join-us displayNone"><span class="ico ico09">&nbsp;</span><a href="javascript:void(0)" class="btn-join-us">加入圈子</a></li>
  <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.INVITE_MEMBER)){%>
  <li><span class="ico ico05">&nbsp;</span><a href="invite.jsp" >邀请成员</a></li>
  <%}%>
  <%if(getService(session).getPermissionManager().isGroupManager(memberID,groupId) || getService(session).getPermissionManager().isAdmin(memberID)){%>
  <script>DCampus.Permission.Group_Manager = true;</script>
  <li><span class="ico ico06">&nbsp;</span><a href="manage.jsp">圈子管理</a></li>
  <%}%>
  <%
     if(getService(session).getMemberManager().checkMemberInGroup(getService(session).getUserData().getMemberId(),groupId)){
  %>
  <li><span class="ico ico06">&nbsp;</span><a href="javascript:void(0)" class="dropOut">退出圈子</a></li>
  <%
     }
  %>
<%if(getService(session).getPermissionManager().isAdmin(memberID)){%>
  <li><span class="ico ico06">&nbsp;</span><a href="<%=site%>/setManager.jsp?groupId=<%=groupId%>" target="_blank">设置管理员</a></li>
  <li><span class="ico ico06">&nbsp;</span><a href="<%=site%>/setMembers.jsp?groupId=<%=groupId%>" target="_blank">添加会员</a></li>
  <%
     }
  %>  
</ul>
