<%@ page contentType="text/html;charset=utf-8" %>
<%
boolean VIEW_MEMBER = getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_MEMBER);
boolean VIEW_GROUP = getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_GROUP);
boolean ADD_POST = getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.ADD_POST);
boolean MODIFY_GROUP = getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.MODIFY_GROUP);
boolean DELETE_THREAD = getService(session).getPermissionManager().hasForumPermission(myForumId,IPermission.ForumPerm.DELETE_THREAD);
%>



