<%@page import="com.dcampus.common.ldap.LdapOperator"%>
<%@page contentType="text/html; charset=UTF-8" session="false"%>
<%
	if (request.getParameter("s") !=null) {
		LdapOperator operator = LdapOperator.getInstance(); // new LdapOperator("ldap.properties");
		String account = request.getParameter("n");
		String password = request.getParameter("p");
		String userdn = operator.getUserDn(account);
		if (!operator.authenticate(userdn, password)) {
			out.println("验证错误");
		} else {
			out.println("验证正确");
		}
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<title>SCUT Groups</title>
</head>
<body>
<form action="" name="form1" method="post">
	用户名：<input type="text" name="n" value=""/><br/>
	密码：<input type="text" name="p" value=""/><br/>
	<input type="submit" name="s" value="提交"/>
</form>
</body>
</html>