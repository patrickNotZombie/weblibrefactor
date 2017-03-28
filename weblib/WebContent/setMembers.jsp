<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.dcampus.groups.manager.permission.IPermission"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>设置会员</title>
<%@include file="pages/path.jsp"%>
<%
long groupId2 = ServletRequestUtils.getLongParameter(request, "groupId",0);
%>
<%if(!getService(session).getPermissionManager().isAdmin(memberID)){%>
<script>
   window.location.href = "pages/index.jsp";
</script>
<%}%>
<script src="js/jquery/jquery-1.4.2.pack.js"></script>
<script>
$(function(){
   $(".submit").bind("click",function(){
         submitFunction();
	});
    $(".param").bind("keypress",function(e){
	    if(e.keyCode == 13) {
		   $(".submit").trigger("click");
		}
	});
})

function submitFunction(){
   var param = "groupId="+<%=groupId%>+"&name="+ $("[name='name']").val() + "&type=god";
   $.ajax({
	   url : "<%=site%>/user/joinGroup.action"
	  ,data : param
	  ,dataType : "json"
	  ,type : "post"
	  ,success : function(data){
			  alert("设置成功");
			  $(".param").val("");
	   },
	   error : function(message){
	      var json = jQuery.parseJSON(message.responseText);
		  alert(json.detail);
	   }
   });	  
}
</script>
</head>

<body>
<input class="param" type="hidden" name="groupId" value="<%=groupId%>"/>
<table width="200" border="1">
  <tr>
    <td nowrap="nowrap">用户名：</td>
    <td><input type="text" name="name" class="param"/></td>
  </tr>

  <tr>
    <td nowrap="nowrap">&nbsp;</td>
    <td><input type="button" value="提交" class="submit"/></td>
  </tr>
</table>

</body>
</html>