<%@ page contentType="text/html;charset=utf-8" %>
<%@include file="checklogin.jsp"%>
<%
	if (isLogin) {
		response.sendRedirect("c/classic/");
		return;
	} else {
		request.getRequestDispatcher("/login/portalLogin.action").forward(
			request, response);
	}
 %>
