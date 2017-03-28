<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<%
   String groupsName = ServletRequestUtils.getStringParameter(request,"groupsName","");
   long lRsrcCap = ServletRequestUtils.getLongParameter(request,"lRsrcCap",0);
   long uRsrcCap = ServletRequestUtils.getLongParameter(request,"uRsrcCap",0);
   long lRsrcSf = ServletRequestUtils.getLongParameter(request,"lRsrcSf",0);
   long uRsrcSf = ServletRequestUtils.getLongParameter(request,"uRsrcSf",0);
   
   if(lRsrcCap != 0)
   lRsrcCap = lRsrcCap * 1024;
   if(uRsrcCap != 0) 
   uRsrcCap = uRsrcCap *1024;
   if(lRsrcSf != 0)
   lRsrcSf = lRsrcSf * 1024;
   if(uRsrcSf != 0) 
   uRsrcSf = uRsrcSf * 1024;
   
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>资源库设置</title>
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<%@include file="../../site.jsp"%>
<link href="../../css/global.css" rel="stylesheet" type="text/css" />
<script src="../../js/jquery-1.3.2.pack.js"></script>
<script src="../../js/TrimPath_Template.js"></script>
<script src="../../js/DCampus.Public.js"></script>
<script src="../js/DCampus.Paging.Plugins.js"></script>
<script src="../js/DCampus.Manage.js"></script>
<script>
var levelJson = <ww:action name='getGroupTypes' namespace='/group' executeResult='true' ignoreContextParams='false'><ww:param name="getGroupTypes" value="0"></ww:param><ww:param name="limit" value="500"></ww:param></ww:action>
</script>
<style>
.table001  td {height:28px;}
</style>
</head>
<body>
<div class="frame_content">
  <div id="breadCrumb"><span class="breadLeft"><span class="breadRight"><span class="breadTitle"><a href="#">资源库</a> &gt; <a href="#">资源库管理</a> </span> </span></span></div>
    <div class="seperate5px"></div>
         <form name="searchForm" method="post"> 
         <%
		   if(lRsrcCap != 0 || uRsrcCap != 0 || lRsrcSf != 0 || uRsrcSf != 0) {
		 %>	
                <input type="hidden" value="true" id="advanceSearch" />  
		 <% }  else {%>
           <input type="hidden" value="false" id="advanceSearch" /> 
         <%}%>
         
         <div class="searchWrap">
          
            <table width="90%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td style="padding-right:5px;"><img src="../../images/search_ico.gif" width="25"/></td>
                <td width="1%"><span>输入邮箱名：</span></td>
                <td><input type="text" name="groupsName" value="<%=groupsName%>" class="searchValue"/> <input type="button" class="button-search" value=""/></td>
              </tr>
            </table>
            
          </div>
          
          <div class="help_choose"><a href="javascript:void(0)" onfocus="this.blur()">展开高级搜索</a></div>
          
          <div class="extend_content">
  
                   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table001">
  <tr>
    <td width="1%" nowrap="nowrap">资源库容量：</td>
    <td><input type="text" class="searchValue clearValue" name="lRsrcCap" value="<%if(lRsrcCap == 0) {out.print("");} else {out.print(lRsrcCap);}%>"/>(MB) - <input type="text" name="uRsrcCap" class="searchValue clearValue" value="<%if(uRsrcCap == 0) {out.print("");} else {out.print(uRsrcCap);}%>"/>(MB)</td>
  </tr>
  <tr>
    <td nowrap="nowrap">单文件上传限制：</td>
    <td><input type="text" class="searchValue clearValue" name="lRsrcSf" value="<%if(lRsrcSf == 0) {out.print("");} else {out.print(lRsrcSf);}%>"/>(MB) - <input type="text" name="uRsrcSf" class="searchValue clearValue" value="<%if(uRsrcSf == 0) {out.print("");} else {out.print(uRsrcSf);}%>"/>(MB)</td>
  </tr>
  <tr>
    <td nowrap="nowrap">等级：</td>
    <td><select class="searchOption"><option value="">请选择等级</option></select></td>
  </tr>
  <tr><td nowrap="nowrap">状态</td><td><select class="stateOption"><option value="">请选择状态</option><option value="open">打开</option><option value="close">关闭</option></select></td></tr>
</table>
<div class="seperate5px"></div>
<div class="seperate5px"></div>
<div><input type="button" value="" class="button-search"></div>
  
          </div>
          
      </form>
      
      <div class="container002">
                  <h3 class="header displayNone">资源库列表</h3>
                  <table cellspacing="0" cellpadding="0" border="0" class="listInfoTableWrap displayNone" width="100%">
    <tbody><tr>
      <td><table cellspacing="0" cellpadding="0" border="0" class="pagebarTableWrap">
          <tbody><tr>
            <td class="page-left"><a href="javascript:void(0);" class="prePage displayNone" title="上一页">-</a></td>
            <td class="page-bg" style="white-space: nowrap;"> <span class="pageNumA"></span></td>
            <td class="page-bg page-next"><a href="javascript:void(0);" class="nextPage displayNone" title="下一页">+</a></td>
            <td class="pageNum page-bg"><span>Pages:<b class="myThreadPagenum"></b>/<b class="myThreadpageCount"></b></span> </td>
            <td class="page-bg"><span>
              <input type="text" class="pageInput" id="goPage" name="goPage"/>
              </span> </td>
            <td class="page-bg page-button"><span>
              <input type="button" value="Go" class="go_botton" />
              </span> </td>
            <td class="page-right"></td>
          </tr>
        </tbody></table></td>
      <td align="right"></td>
    </tr>
  </tbody></table>
                  <div class="body query-lst" id="query-lst"> </div>
                  
                  <table cellspacing="0" cellpadding="0" border="0" class="listInfoTableWrap displayNone" width="100%">
    <tbody><tr>
      <td><table cellspacing="0" cellpadding="0" border="0" class="pagebarTableWrap">
          <tbody><tr>
            <td class="page-left"><a href="javascript:void(0);" class="prePage displayNone" title="上一页">-</a></td>
            <td class="page-bg" style="white-space: nowrap;"> <span class="pageNumA"></span></td>
            <td class="page-bg page-next"><a href="javascript:void(0);" class="nextPage displayNone" title="下一页">+</a></td>
            <td class="pageNum page-bg"><span>Pages:<b class="myThreadPagenum"></b>/<b class="myThreadpageCount"></b></span> </td>
            <td class="page-bg"><span>
              <input type="text" class="pageInput" id="goPage" name="goPage"/>
              </span> </td>
            <td class="page-bg page-button"><span>
              <input type="button" value="Go" class="go_botton" />
              </span> </td>
            <td class="page-right"></td>
          </tr>
        </tbody></table></td>
      <td align="right"></td>
    </tr>
  </tbody></table>
                </div>
      
</div>


<textarea id="groups_template" style="display:none">
{if groups.length != 0}
<table border="0"  class="table001 slct-tbl" cellpadding="0" cellspacing="0">
  <thead>
    <tr>
      <th width="10" align="center"><input type="checkbox" /></th>
      <th>资源库名称</th>
      <th width="80">创建者</th>
      <th width="80">创建时间</th>
      <th width="100">等级</th>
      <th width="150">单文件上传大小（MB）</th>
      <th width="150">资源库总容量（MB）</th>
      <th width="90">会员设置</th>
      <th width="100">编辑</th>
    </tr>
  </thead>
  <tbody>
  {for group in groups}
  {var optionHtml = "";}
    {eval}
  
   for(i=0;i<levelJson.totalCount;i++) {
       if(levelJson.groupTypes[i].name == group.type ) {
         optionHtml += "<option selected='selected' value='"+levelJson.groupTypes[i].id+"'>" + levelJson.groupTypes[i].name + "</option>";
       } else {
          optionHtml += "<option value='"+levelJson.groupTypes[i].id+"'>" + levelJson.groupTypes[i].name + "</option>";
       }
   }
  
   {/eval}
  
  {eval}
      group.singleSize = group.singleSize / 1024;
      group.totalSize = group.totalSize / 1024;
  {/eval}
    <tr>
      <td><input type="checkbox" value="" id="\${group.groupId}"/></td>
      <td>\${group.groupName}</td>
      <td>\${group.creatorName}</td>
      <td>\${group.creationDate}</td>
      <td><select class="chooseLevel">\${optionHtml}</select> <a href="javascript:void(0)" class="saveLevelBtn" rel="\${group.groupId}">保存</a></td>
      <td><span>\${group.singleSize}</span> <a href="javascript:void(0)" class="editSingle">编辑</a> <a href="javascript:void(0)" class="saveSingle displayNone" id="\${group.groupId}">保存</a></td>
      <td><span>\${group.totalSize}</span> <a href="javascript:void(0)" class="editSpace">编辑</a> <a href="javascript:void(0)" class="saveSpace displayNone" id="\${group.groupId}">保存</a></td>  
      <td><a href="user.jsp?groupId=\${group.groupId}">设置</a></td>
      <td><a href="edit.jsp?groupId=\${group.groupId}">编辑</a></td>
    </tr>
    {/for}
  </tbody>
</table>
{/if}
</textarea>

<div class="ManageToolWrap"><h3>你选中了<span class="num"></span>篇</h3>
<div class="space01"></div>
<p><a href="javascript:void(0)" class="btn-close-groups">关闭</a> <a href="javascript:void(0)" class="btn-open-groups">打开</a></p>
</div>
</body>
</html>
