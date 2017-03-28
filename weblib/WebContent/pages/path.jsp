<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.dcampus.groups.beans.IGlobalBean"%>
<%@include file="checklogin.jsp"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%
  //String site = request.getParameter("site");
  IGlobalBean bean = getService(session).getGlobalManager().getGlobalConfig();
  String getSiteDomain = bean.getSiteDomain();//域名
  String getSiteName = bean.getSiteName();//站点名称
  String getSiteSeoKeywords = bean.getSiteSeoKeywords();//关键字
  String getSiteSeoDescription = bean.getSiteSeoDescription();//描述
  String getSiteStatCode = bean.getSiteStatCode();//统计代码
  String site = request.getContextPath();//站点目录
  String themes_path = "default";
  long groupId = ServletRequestUtils.getLongParameter(request, "groupId",0);//获取GroupId
  out.print("<script>var System = {};System.site='"+site+"'</script>");
%>