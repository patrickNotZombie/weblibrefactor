<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.dcampus.groups.beans.ICategoryBean"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%
   String groupsName = ServletRequestUtils.getStringParameter(request,"groupsName","");
%>
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
<script src="../../js/DCampus.Paging.Plugins.js"></script>
<script src="../../js/TrimPath_Template.js"></script>
<script src="../../js/DCampus.Public.js"></script>
<script src="../js/DCampus.Space.js"></script>
<script>
</script>
<style>
#batch_buttons {
	margin-top:10px;
}
</style>

</head>
<body>

<div class="frame_content" >
  <div id="breadCrumb"><span class="breadLeft"/><span class="breadRight"/><span class="breadTitle"><a href="#">圈子</a> > <a href="#">圈子容量</a> </span> </div>
  <div class="thirdContentWrap">
    <div class="settingContainer">
    
    
    
          <div class="searchWrap">
          <form name="searchForm" method="post">
            <table width="90%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td style="padding-right:5px;"><img src="../../images/search_ico.gif" width="25"/></td>
                <td width="1%"><span>请输入圈子名称：</span></td>
                <td><input type="text" name="groupsName" value="<%=groupsName%>"/> <input type="button" class="button-search" value=""/></td>
              </tr>
            </table>
            </form>
          </div>
        <div class="seperate5px"></div>
        <div class="seperate5px"></div>
        <div class="seperate5px"></div>
          <div class="thirdContentWrap">
                <div class="container002">
                  <h3 class="header">分类列表</h3>
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
    </div>
    

  </div>
</div>
</div>


<textarea id="groups_template" style="display:none">
{if groups.length != 0}
<table border="0"  class="table001 slct-tbl" cellpadding="0" cellspacing="0">
  <thead>
    <tr>
      <th>圈子名称</th>
      <th width="200">创建者</th>
      <th width="200">单文件上传大小（KB）</th>
      <th width="200">圈子总容量（KB）</th>
    </tr>
  </thead>
  <tbody>
  {for group in groups}
    <tr>
      <td>\${group.groupName}</td>
      <td>\${group.creatorName}</td>
      <td><span>\${group.singleSize}</span> <a href="javascript:void(0)" class="editSingle">编辑</a> <a href="javascript:void(0)" class="saveSingle displayNone" id="\${group.groupId}">保存</a></td>
      <td><span>\${group.totalSize}</span> <a href="javascript:void(0)" class="editSpace">编辑</a> <a href="javascript:void(0)" class="saveSpace displayNone" id="\${group.groupId}">保存</a></td>
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
