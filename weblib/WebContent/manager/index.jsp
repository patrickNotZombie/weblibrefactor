<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.dcampus.groups.service.IService"%>
<%@page import="com.dcampus.groups.service.ServiceManager"%>
<%@page import="com.dcampus.groups.service.UserService"%>
<%@page import="com.dcampus.groups.service.GuestData"%>
<%@page import="com.dcampus.groups.manager.permission.IPermission"%>
<%@page import="com.dcampus.groups.service.GuestService"%>
<%@include file="../pages/checklogin.jsp"%>
<%@include file="site.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>DCampus后台管理</title>
<script type="text/javascript" src="js/jquery-1.3.2.pack.js"></script>
<script type="text/javascript" src="js/jquery.layout.min.js"></script>
<script src="js/index.js" type="text/javascript"></script>
<link href="css/layout.css" rel="stylesheet" type="text/css" />
<link href="css/global.css" rel="stylesheet" type="text/css" />
<%
  if(!isLogin) {
%>
<script>

window.location.href = "<%=site%>/manager/login.jsp";

</script>
<%}%>
</head> 
<body> 


<div class="outer-center">
	<div class="middle-center">
  <iframe src="disk/settings/"  allowtransparency="true" scrolling="yes"  name="dcampusFrame" id="dcampusFrame" frameborder="0"  class="inner-center" style="overflow-x:hidden;"> </iframe>
	</div> 

</div> 

<div class="outer-west west">

    <ul class="subMenu" rel="tab01">
        <li><a href="disk/settings/" target="dcampusFrame" class="subOn">资源库设置</a></li>
        <li><a href="disk/category/index.jsp" target="dcampusFrame" >资源库分类</a></li>
         <li><a href="disk/manage/" target="dcampusFrame" >资源库管理</a></li>
         <li><a href="disk/level/" target="dcampusFrame" >资源库等级</a></li>
         <!--li><a href="disk/settings/" target="dcampusFrame" >投诉处理</a></li-->
    </ul>
    
    <ul class="subMenu displayNone" rel="tab02">
    <li><a href="group/settings/" target="dcampusFrame" class="subOn">圈子设置</a></li>
	           <li><a href="group/category/index.jsp" target="dcampusFrame" >圈子分类</a></li>
      <li><a href="group/groups/index.jsp" target="dcampusFrame">圈子搜索</a></li>
      <li><a href="group/space/index.jsp" target="dcampusFrame">圈子容量</a></li>
       <!--li><a href="group/user/index.jsp" target="dcampusFrame">管理员设置</a></li-->
    </ul>
    
    <ul class="subMenu displayNone" rel="tab03">

    </ul>
    
    <ul class="subMenu displayNone" rel="tab04">

    </ul>
    
    <ul class="subMenu displayNone" rel="tab05">

    </ul>
    
    <ul class="subMenu displayNone" rel="tab06">

    </ul>

</div> 

<div class="ui-layout-north">  <div  id="header_bg" >
    <div id="header">
    <a href="javascript:void(0)" id="logotOut">[退出]</a>
      <div id="logo">
        <ul class="menu">
          <li rel="tab01"><a href="disk/settings/" target="dcampusFrame" class="tab_on">资源库<span class="tab_left"></span><span class="tab_right"></span></a></li>
          <!--li rel="tab02"><a href="group/settings/" target="dcampusFrame">圈子<span class="tab_left"></span><span class="tab_right"></span></a></li-->
		  
          <%
          IService s = getService(session);
		  if(s.getPermissionManager().isSuperAdmin(s.getUserData().getMemberId())){
          %>
          <!--li rel="tab02"><a href="user/index.jsp" target="dcampusFrame">用户<span class="tab_left"></span><span class="tab_right"></span></a></li-->
          <%
          }
          %>
        </ul>
      </div>
    </div>
     <a class="siteMap" href="javascript:void(0)">网站地图</a>
  </div></div> 




      <div id="siteMap" class="displayNone">
<div class="borderwrap">
<div class="borderInsideWrap">
 <h3 class="siteMapH3"><a class="siteMap" href="javascript:void(0)">网站地图</a> 按"ESC"键展开/关闭此菜单</h3>
 <div class="contentMapWrap">
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <th align="left">导航1</th>
    <th align="left">导航2</th>
    <th align="left">导航3</th>
    <th align="left">导航4</th>
    <th align="left">导航5</th>
  </tr>
  <tr>
    <td align="left"><a href="#">菜单1</a></td>
    <td align="left"><a href="#">菜单2</a></td>
    <td align="left"><a href="#">菜单3</a></td>
    <td align="left"><a href="#">菜单4</a></td>
    <td align="left"><a href="#">菜单5</a></td>
  </tr>
  <tr>
    <td align="left"><a href="#">菜单1</a></td>
    <td align="left"><a href="#">菜单2</a></td>
    <td align="left"><a href="#">菜单3</a></td>
    <td align="left"><a href="#">菜单4</a></td>
    <td align="left"><a href="#">菜单5</a></td>
  </tr>      
</table>
 </div>

</div>
</div>
</div>
</body> 
</html> 

