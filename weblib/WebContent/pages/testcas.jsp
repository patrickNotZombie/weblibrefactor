<%@ page contentType="text/html;charset=utf-8" %>
<jsp:directive.page import="cn.edu.scut.cas.client.filter.CASFilter"/>
<%
	String a = (String)session.getAttribute(CASFilter.CAS_SESSION_USER);
	out.println(a);
%>