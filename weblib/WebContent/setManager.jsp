<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%
   long groupId = ServletRequestUtils.getLongParameter(request, "groupId",0);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>设置管理员</title>
<script src="js/jquery/jquery-1.4.2.pack.js"></script>
<script>
$(function(){
   $(".submit").bind("click",function(){
	   var param = $(".param").serialize();
	   var param = "groupId="+<%=groupId%>+"&name="+ $("[name='name']").val();
	   $.ajax({
		   url : "group/createGroupManager.action"
		  ,data : param
		  ,dataType : "json"
		  ,type : "post"
		  ,success : function(data){
				  alert("设置成功");
				  window.location.reload();
		   },
		   error: function(message){
			  var json = jQuery.parseJSON(message.responseText);
			  alert(json.detail);
		   }
	   });	   
	})

})
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