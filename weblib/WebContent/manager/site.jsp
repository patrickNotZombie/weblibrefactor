<%@ page contentType="text/html;charset=utf-8" %>
<%
  //String site = request.getParameter("site");
  String site = request.getContextPath();
  out.print("<script>var System = {};System.site = '"+site+"'</script>");
  %>
  