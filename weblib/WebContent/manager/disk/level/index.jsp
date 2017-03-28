<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%
   String groupsName = ServletRequestUtils.getStringParameter(request,"groupsName","");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>资源库设置</title>
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<link href="../../css/global.css" rel="stylesheet" type="text/css" />
<%@include file="../../site.jsp"%>
<script src="../../js/jquery-1.3.2.pack.js"></script>
<script src="../../js/TrimPath_Template.js"></script>
<script src="../../js/DCampus.Public.js"></script>
<script src="../js/DCampus.Paging.Plugins.js"></script>
<script src="../js/DCampus.Level.js"></script>
<style>
.table001  td {height:30px;line-height:30px;}
</style>
</head>
<body>
<div class="frame_content">
  <div id="breadCrumb"><span class="breadLeft"><span class="breadRight"><span class="breadTitle"><a href="#">资源库</a> &gt; <a href="#">资源库等级</a> </span> </span></span></div>
    <div class="seperate5px"></div>
      <div class="container002">
                  <h3 class="header">等级列表</h3>
                  <div class="body query-lst" id="query-lst"> </div>
                   <div style="padding:5px;padding-top:0;">
                   <table cellpadding="0" cellspacing="0" width="100%" class="table002">
                    <tr><td width="45">&nbsp;</td><td colspan="4"><a href="javascript:void(0)" id="addLevelBtn" class="orange">增加等级</a></td></tr>
                  </table>
                  </div>
                </div>
                <div class="seperate5px"></div>
                <div id="batch_buttons"><input type="button" value="提交" id="levelSubmit" class="button"> <input type="button" value="删除" id="deleteBtn" class="button"></div>
      
</div>


<textarea id="groups_template" style="display:none">

{if totalCount != 0}

<table border="0"  class="table001 slct-tbl" cellpadding="0" cellspacing="0">
  <thead>
    <tr>
      <th width="10" align="center"><input type="checkbox" /></th>
      <th width="200">等级名称</th>
      <th width="200">单文件上传大小(MB)</th>
      <th width="200">空间大小(MB)</th>
      <th>操作</th>
    </tr>
  </thead>
  <tbody>
  {for groupType in groupTypes}
     {eval}
       groupType.singleFileSize = groupType.singleFileSize / 1024;
       groupType.totalFileSize = groupType.totalFileSize / 1024;
    {/eval} 
    <tr>
      <td>{if groupType.type !=1}<input type="checkbox" value="\${groupType.id}" id="\${groupType.id}" name="id"/>{/if}</td>
      <td><input type="text" value="\${groupType.name}" class="levelName levelValue" name="name"/> <input type="hidden" name="id" value="\${groupType.id}" class="levelValue"/></td>
      <td><span>\${groupType.singleFileSize}</span> <a href="javascript:void(0)" class="editSingle">编辑</a> <a href="javascript:void(0)" class="saveSingle displayNone" id="\${groupType.id}">保存</a></td>
      <td><span>\${groupType.totalFileSize}</span> <a href="javascript:void(0)" class="editSpace">编辑</a> <a href="javascript:void(0)" class="saveSpace displayNone" id="\${groupType.id}">保存</a></td>  
      <td>
      {if groupType.type !=1}
      <a href="javascript:void(0)" class="delete" id="\${groupType.id}">删除</a>
      {/if}
      </td>
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
