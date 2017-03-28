<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.dcampus.groups.beans.IGroupBean"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% 
//IGroupBean groupBean = (IGroupBean)ValueCarrier.getValue(ActionContext.getContext(), "groupBean");
//String groupName = groupBean.getName();
String firstCreate = ServletRequestUtils.getStringParameter(request, "firstCreate","false");
%>

<head>
<%@include file="pages/path.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="<%=getSiteSeoKeywords%>" />
<meta name="Description" content="<%=getSiteSeoDescription%>" />
<title><%=getSiteName%></title>

<script src="js/jquery/jquery-1.4.2.pack.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.core.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.draggable.js"></script>
<script src="js/jquery-treeview/jquery.treeview.pack.js"></script>
<script src="pages/js/DCampus.Folder.Treeview.js"></script>
<script src="js/ckeditor/ckeditor.js"></script>
<script src="pages/js/TrimPath_Template.js"></script>
<script src="pages/js/DCampus.Public.js"></script>
<script src="pages/js/DCampus.Permission.js"></script>

<!--Groups 装饰信息：Groups名、描述、Groups图标等-->
<script src="pages/js/DCampus.GroupMenu.js"></script>
<script src="pages/js/DCampus.Disk.js"></script>
<script src="pages/js/DCampus.Paging.Plugins.js"></script>
<%  
    long getGroupId = ServletRequestUtils.getLongParameter(request, "diskId",0);
	if(getGroupId != 0) {
	  groupId = getGroupId;
	} else {
	  groupId = groupId;
	}
	request.setAttribute("mygroupId", -groupId);
%>

<script>
var json = <ww:action name='getGroupInfo' namespace='/group' executeResult='true' ignoreContextParams='false'/>;
<%if(isLogin) {%>
var isGroupMember = <ww:action name='isGroupMember' namespace='/user' executeResult='true' ignoreContextParams='false'/>
var getMyGroups = <ww:action name='getMyGroups' namespace='/group' executeResult='true' ignoreContextParams='false'/>;
var myOwnMemberList = <ww:action name='getMemberList' namespace='/user' executeResult='true' ignoreContextParams='false'/>;
<%}%>
var resourceJSON  = <ww:action name="getResources" namespace='/group' executeResult='true' ignoreContextParams='false'><ww:param name="parentId" value="%{#request.mygroupId}"></ww:param><ww:param name="start" value="0"></ww:param><ww:param name="limit" value="20"></ww:param></ww:action>

$j(function(){

 if(<%=firstCreate%>) {
		
DCampus.Public.AjaxRequestFunction(System.site+"/group/createDir.action","parentId=0&groupId="+json.groupId+"&name=我的文档","POST",function(){},function(){}); 

DCampus.Public.AjaxRequestFunction(System.site+"/group/createDir.action","parentId=0&groupId="+json.groupId+"&name=我的图片","POST",function(){},function(){}); 

DCampus.Public.AjaxRequestFunction(System.site+"/group/createDir.action","parentId=0&groupId="+json.groupId+"&name=我的音乐","POST",function(){},function(){}); 

DCampus.Public.AjaxRequestFunction(System.site+"/group/createDir.action","parentId=0&groupId="+json.groupId+"&name=我的多媒体","POST",function(){},function(){}); 

DCampus.Public.AjaxRequestFunction(System.site+"/group/createDir.action","parentId=0&groupId="+json.groupId+"&name=我的软件","POST",function(){$j(".container002").DCampusPaging("Res-reflash");},function(){}); 		      
 }
//alert($j(parent.window.document).find("iframe").length)

})
</script>
<link href="js/jquery-ui-1.7.2.custom/css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" />
<link href="js/jquery-treeview/jquery.treeview.css" rel="stylesheet" type="text/css" />
<link href="themes/<%=themes_path%>/css/disk.css" rel="stylesheet" type="text/css" />
</head>
<body>
<input type="hidden" name="groupId" value="<%=groupId%>" id="groupsInputId"/>
<input type="hidden" name="groupAddr" />
<input type="hidden" name="parentId" value="-<%=groupId%>" id="parentID"/>
<div id="groupsTitle">
  <table  cellspacing="0" cellpadding="0" border="0" class="listInfoTableWrap" width="100%">
    <tbody>
      <tr>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td width="1%" nowrap="nowrap" style="padding-right:10px;">  <select id="chooseResource" name="diskId"></select> <!--strong class="diskTitle">网盘</strong--><span id="path"></span></td>
                    <td class="totalTopic">  共 <span class="dirAmout"></span>个文件夹 <span class="fileAmout"></span>个文件 | 容量：<span class="totalSpace"></span> (已使用 <span class="usedspace"></span>, <span class="percent"></span>)</td>
  </tr>
</table>        </td>
        <td align="right">
        
          <table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><a href="javascript:void(0)" class="firstPage"><b>|&lt;</b></a>&nbsp;</td>
    <td><a href="javascript:void(0)" class="prePage"><b>&lt;</b></a>&nbsp;</td>
    <td><select class="pageSelect"></select>&nbsp;</td>
    <td><a href="javascript:void(0)" class="nextPage"><b>&gt;</b></a>&nbsp;</td>
    <td><a href="javascript:void(0)" class="lastPage"><b>&gt;|</b></a></td>
  </tr>
</table>
       </td>
      </tr>
    </tbody>
  </table>
  <div class="container002">
    <h3 class="header">
      <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.UPLOAD_RESOURCE)){%>
      <input type="button" class="uploadResources btn_disk" value="上传"/>
      <input type="button" class="createFolder btn_disk" value="新建文件夹"/>
      <input type="button" class="btn-download btn_disk" value="下载"/>
      <input type="button" class="btn_disk btn_send_email" value="发送"/>
      <input type="button" class="btn-del-rLst btn_disk" value="删除"/>
      <input type="button" class="moverResource btn_disk" value="移动"/>
      <input type="button" class="shareResource btn_disk" value="共享"/>
      <%}%>
    </h3>
    <div class="body">
      <table border="0"  class="table001 sourseTable slct-tbl" cellpadding="0" cellspacing="0">
        <thead>
          <tr>
            <th width="1%" align="center"><input type="checkbox" id="checkAll"/></th>
            <th>文件名</th>
            <th width="80">文件大小</th>
            <th width="100">上传者</th>
            <th width="120">上传时间</th>
          </tr>
        </thead>
        <tbody id="sourceWrap">
        </tbody>
      </table>
    </div>
    <h3 class="header">
      <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.UPLOAD_RESOURCE)){%>
      <input type="button" class="uploadResources btn_disk" value="上传"/>
      <input type="button" class="createFolder btn_disk" value="新建文件夹"/>
      <input type="button" class="btn-download btn_disk" value="下载"/>
      <input type="button" class="btn_disk btn_send_email" value="发送"/>
      <input type="button" class="btn-del-rLst btn_disk" value="删除"/>
      <input type="button" class="moverResource btn_disk" value="移动"/>
      <input type="button" class="shareResource btn_disk" value="共享"/>
      <%}%>
    </h3>
  </div>
  <table  cellspacing="0" cellpadding="0" border="0" class="listInfoTableWrap" width="100%">
    <tbody>
      <tr>

        <td align="right">
        <table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><a href="javascript:void(0)" class="firstPage"><b>|&lt;</b></a>&nbsp;</td>
    <td><a href="javascript:void(0)" class="prePage"><b>&lt;</b></a>&nbsp;</td>
    <td><select class="pageSelect"></select>&nbsp;</td>
    <td><a href="javascript:void(0)" class="nextPage"><b>&gt;</b></a>&nbsp;</td>
    <td><a href="javascript:void(0)" class="lastPage"><b>&gt;|</b></a></td>
  </tr>
</table>

          </td>
      </tr>
    </tbody>
  </table>
</div>
<textarea id="sourceTemplate" class="displayNone">
{if parentId > 0}
<tr><td></td><td colspan="6"><a href="javascript:void(0)" id="goBack" rel="\${parentId}"><b class="gobackICO"></b>返回上一级</a></td></tr>
{/if}
{var fileICO = "<b class='fileICO'></b>";var resourceLink;var size;var desc;}
{for resource in resources;}
{eval}
if(resource.type == 1) {
  fileICO = "<b class='fileICO folder'></b>";
  resourceLink = "javascript:void(0)";
} else {
   fileICO = "<b class='fileICO file'></b>";
   resourceLink = "<%=site%>/group/downloadResource.action?id="+resource.id;
}
if(resource.size >= 1024) {
  size = DCampus.DiskUI._formatFloat(resource.size/1024,2) + "MB";
} else if(resource.size >= 1024*1024) {
   size = DCampus.DiskUI._formatFloat(resource.size/1024/1024,2) + "G";
} else {
   size = resource.size + "KB";
}
if(resource.desc.length > 22) {
   desc = resource.desc.substring(0,23) + "...";
} else {
   desc = resource.desc;
}
{/eval}
<tr>
  <td><input type="checkbox" value="\${resource.id}"/></td>
  <td>\${fileICO}<a class="resourceName" href="\${resourceLink}"  id="\${resource.id}" type="\${resource.type}" link="<%=site%>/group/downloadResource.action?id=\${resource.id}">\${resource.name}</a> <span class="resourceSpanDesc">{if resource.desc != ""} - <span class="resourceDesc" title="\${resource.desc}">\${desc}</span> {/if}</span> <span class="oprtText"></span></td>
  <td>\${size}</td>
  <td>\${resource.memberName}</td>
  <td class="replydate">\${resource.creationDate}</td>
</tr>
{/for}
</textarea>
<textarea id="pathTemplate" class="displayNone">
{var count = 1;}
{for _path in path}
{if count < path.length}
<a href="javascript:void(0)" id="\${_path.id}">\${_path.name}</a> >> 
{else}
<strong>\${_path.name}</strong>
{/if}
{eval}
count++;
{/eval}
{/for}
</textarea>
<div class="ManageToolWrap">
  <h3>你选中了<span class="num"></span>个资源</h3>
  <div class="space01"></div>
  <p><a href="javascript:void(0)" class="btn-download">下载</a> <a href="javascript:void(0)" class="btn-del-rLst">删除</a> <a href="javascript:void(0)" class="moverResource">移动</a></p>
</div>
<div id="uploadDialog" class="displayNone ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable">
  <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> <span id="ui-dialog-title-dialog" class="ui-dialog-title"></span> <a class="ui-dialog-titlebar-close ui-corner-all" href="javascript:void(0)" id="uploadCloseButton"><span class="ui-icon ui-icon-closethick">close</span></a> </div>
  <div style="width: auto;" class="ui-dialog-content ui-widget-content uploadIframe"> </div>
  <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix"><span class="uploadText">上传提示：使用Shift或Ctrl键选择多个文件上传，单个文件<span id="sizelimit"></span>以内</span>
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-confirm">确定</button>
  </div>
</div>
<div id="createFolder" class="displayNone ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable">
  <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> <span id="ui-dialog-title-dialog" class="ui-dialog-title"></span> <a class="ui-dialog-titlebar-close ui-corner-all" href="#"><span class="ui-icon ui-icon-closethick">close</span></a> </div>
  <div style="height: 200px; min-height: 109px; width: auto;" class="ui-dialog-content ui-widget-content">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <th width="1%" nowrap="nowrap">输入文件夹名称：</th>
        <td><input type="text" class="text" name="folderName" style="width:160px;"/></td>
      </tr>
    </table>
  </div>
  <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-cancel">取消</button>
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-createFolder">创建</button>
  </div>
</div>
<div id="renameDialog" class="displayNone ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable">
  <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> <span id="ui-dialog-title-dialog" class="ui-dialog-title"></span> <a class="ui-dialog-titlebar-close ui-corner-all" href="javascript:void(0)"><span class="ui-icon ui-icon-closethick">close</span></a> </div>
  <div style="width: auto;" class="ui-dialog-content ui-widget-content">
    <input id="resourceID" value="" type="hidden"/>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <th width="1%" nowrap="nowrap">输入名称：</th>
        <td><input type="text" class="text renameInput" name="renameInput" style="width:160px;"/>
          <span class="extName"></span> </td>
      </tr>
      <tr>
        <th width="1%" nowrap="nowrap" valign="top">备注：</th>
        <td><textarea class="renameTextarea"></textarea></td>
      </tr>
    </table>
  </div>
  <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-cancel">取消</button>
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-save">保存</button>
  </div>
</div>
<div id="moveDialog" class="displayNone ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable">
  <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> <span id="ui-dialog-title-dialog" class="ui-dialog-title"></span> <a class="ui-dialog-titlebar-close ui-corner-all" href="javascript:void(0)"><span class="ui-icon ui-icon-closethick">close</span></a> </div>
  <div style="width: auto;" class="ui-dialog-content ui-widget-content">
    <h3 class="moveH3">要将选中的<span class="folderNum"></span>个文件移动到：</h3>
    <ul><li style="padding-left:20px;"><a href="javascript:void(0)" id="0" class="treeRoot">根目录</a></li></ul>    
    <ul  id="folderTree">
      加载中...
    </ul>
  </div>
  <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-cancel">取消</button>
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-move">移动</button>
  </div>
</div>
<div id="pickWrap" class="displayNone"></div>

<div id="shareDialog" class="displayNone ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable">
  <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> <span id="ui-dialog-title-dialog" class="ui-dialog-title"></span> <a class="ui-dialog-titlebar-close ui-corner-all" href="#"><span class="ui-icon ui-icon-closethick">close</span></a> </div>
  <div style="height: 200px; min-height: 109px; width: auto;" class="ui-dialog-content ui-widget-content">
        <div id="shareTreeWrap"></div>
  </div>
  <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-cancel">取消</button>
    <button type="button" class="ui-state-default ui-corner-all dialog-btn-share btn-confirm">共享</button>
  </div>
</div>
<textarea class="displayNone" id="myGrupsTemp">
  <option value="0">个人资源库</option>
  <optgroup label="共享资源库">
  {for group in groups}
  {if group.name != myOwnMemberList.account}
  <option value="\${group.id}">\${group.name}</option>
  {/if}
  {/for}
</textarea>

<textarea class="displayNone" id="shareCategoryTemp">
  {for group in groups}
  {if group.name != myOwnMemberList.account}
  <div class="shareTopCategory"><a rev="\${group.id}" id="0" class="shareA" href="javascript:void(0)">\${group.name}</a></div>
      <ul  class="treeUL displayNone">
      加载中...
    </ul>
  {/if}
  {/for}
</textarea>
<%=getSiteStatCode%>
</body>
</html>
