<%@ page contentType="text/html;charset=utf-8" %>
<%
if(!getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.VIEW_GROUP)){%>
<script>
    alert("对不起，您没有权限访问");
	window.location.href="<%=site%>/pages/login.jsp";
</script>
<%}%>