<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.dcampus.groups.beans.ICategoryBean"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%
   long getTopGroupId = ServletRequestUtils.getLongParameter(request,"groupId",0);
   request.setAttribute("groupId", getTopGroupId);
%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="../../js/jquery-ui-1.7.2.custom/css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" />
<link href="../../css/global.css" rel="stylesheet" type="text/css" />
<%@include file="../../site.jsp"%>
<script src="../../js/jquery-1.3.2.pack.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.core.js"></script>
<script type="text/javascript" src="../../js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.draggable.js"></script>
<script src="../../js/TrimPath_Template.js"></script>
<script src="../../js/DCampus.Paging.Plugins.js"></script>
<script src="../../js/DCampus.Public.js"></script>
<script src="../js/DCampus.Edit.js"></script>
<script>
var json = <ww:action name='getGroupInfo' namespace='/group' executeResult='true' ignoreContextParams='false'>
   <ww:param name="groupId" value="%{#request.groupId}"></ww:param>
</ww:action>
</script>
</head>
<body>
<input type="hidden" value="<%=getTopGroupId%>" id="getTopGroupId"/>
<div class="frame_content" >
  <div id="breadCrumb"><span class="breadLeft"/><span class="breadRight"/><span class="breadTitle"><a href="#">资源库</a> > <a href="#">会员设置</a> </span> </div>
  <div id="editWrap">
  
         <h3 class="blueH3">资源库详信息</h3>
<div class="tablewrap">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tablesorter">
 <tr class="noborder">
    <td><strong>资源库名称</strong></td>
 </tr>
 <tr><td><input type="text" name="name" class="groupsName"/></td></tr>
  <tr class="noborder">
    <td><strong>资源库描述</strong></td>
  </tr>
  <tr>
    <td><textarea style="width:250px;height:100px;" class="description" name="description"></textarea></td>
  </tr>

  <tr class="noborder">
    <td><strong>资源库分类</strong></td>
  </tr>

  <tr><td><select><option>123</option></select> - <select><option>321</option></select></td></tr>  

</table>
</div>

   </div>
</div>

<div id="groupsDialog" class="displayNone">
<h3><input type="text" class="enterGroupsName"/><input type="button" value="搜索" class="searchGroups"/></h3>
<ul class="groupsList">
</ul>
<div class="paging pagebarTableWrap">[总数:<span class="totalCount"></span>] <span>Pages:<b class="myThreadPagenum"></b>/<b class="myThreadpageCount"></b></span> <a href="javascript:void(0)" class="prePage">上一页</a> <a href="javascript:void(0)" class="nextPage">下一页</a></div>
</div>
<textarea id="groups_template" style="display:none">
<li><a href="javascript:void(0)" rev="0">全部资源库</a></li>
{for group in groups}
  <li><a href="javascript:void(0)" rev="\${group.groupId}">\${group.groupName}</a></li>
{/for}
</textarea>

<textarea id="members_template" style="display:none">
 {for member in members}
     <li><a href="javascript:void(0)">\${member.name}</a></li>
  {/for}   
</textarea>

<textarea id="currentMembers_template" style="display:none">
 {for member in members}
     <li><a href="javascript:void(0)" rev="\${member.id}">\${member.name}</a></li>
  {/for}   
</textarea>
</body>
</html>
