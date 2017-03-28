<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.dcampus.groups.beans.IGroupBean"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
//IGroupBean groupBean = (IGroupBean)ValueCarrier.getValue(ActionContext.getContext(), "groupBean");
//String groupName = groupBean.getName();
%>
<head>
<%@include file="pages/path.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="<%=getSiteSeoKeywords%>" />
<meta name="Description" content="<%=getSiteSeoDescription%>" />
<title><%=getSiteName%></title>
<link href="js/jquery-ui-1.7.2.custom/css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" />
<link href="js/jquery-treeview/jquery.treeview.css" rel="stylesheet" type="text/css" />
<link href="themes/default/css/global.css" rel="stylesheet" type="text/css" />
<%@include file="pages/jumpto.jsp"%>
<script src="js/jquery/jquery-1.4.2.pack.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.core.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom/development-bundle/ui/ui.draggable.js"></script>
<script src="js/jquery-treeview/jquery.treeview.pack.js"></script>
<script src="pages/js/DCampus.Folder.Treeview.js"></script>
<script src="js/ckeditor/ckeditor.js"></script>
<script src="pages/js/TrimPath_Template.js"></script>
<script src="pages/js/DCampus.Public.js"></script>
<script src="pages/js/DCampus.Permission.js"></script>
<script src="pages/js/DCampus.GroupsDecoration.js"></script><!--Groups 装饰信息：Groups名、描述、Groups图标等-->
<script src="pages/js/DCampus.GroupMenu.js"></script>
<script src="pages/js/DCampus.ResourceList.js"></script>
<script src="pages/js/DCampus.Paging.Plugins.js"></script>
<%
	request.setAttribute("mygroupId", -groupId);
%>
</head>
<body>
<script>
var json = <ww:action name='getGroupInfo' namespace='/group' executeResult='true' ignoreContextParams='false'/>;
<%if(isLogin)%>
var isGroupMember = <ww:action name='isGroupMember' namespace='/user' executeResult='true' ignoreContextParams='false'/>
var resourceJSON  = <ww:action name="getResources" namespace='/group' executeResult='true' ignoreContextParams='false'><ww:param name="parentId" value="%{#request.mygroupId}"></ww:param><ww:param name="start" value="0"></ww:param><ww:param name="limit" value="20"></ww:param></ww:action>
</script>
<input type="hidden" name="groupId" />
<input type="hidden" name="groupAddr" />
<input type="hidden" name="menu" value="resourceList"/>
<input type="hidden" name="parentId" value="-<%=groupId%>" id="parentID"/>
<div id="headerWrap_in">
  <%@include file="pages/header.jsp"%>
</div>
<div id="groupsTitle">
  <table border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="50" height="50" class="groups-img"><img src="themes/default/images/groupsImg.gif" /></td>
      <td class="title"></td>
      <td class="fav"><span>&nbsp;</span><a href="javascript:void(0)" id="addFavorite" rel="<%=groupId%>">收藏本圈子</a></td>
    </tr>
  </table>
  <div class="groups-search">
       <%@include file="pages/group/searchBlock.jsp"%>
  </div>
</div>
<div id="groups_wrap">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td class="coL">

      <table  cellspacing="0" cellpadding="0" border="0" class="listInfoTableWrap" width="100%">
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
            <td class="totalTopic"> 共<span class="dirAmout"></span>个文件夹 <span class="fileAmout"></span>个文件 | 空间容量：<span class="totalSpace"></span> (已使用<span class="usedspace"></span>,<span class="percent"></span>)</td>
          </tr>
        </tbody></table></td>
      <td align="right"></td>
    </tr>
  </tbody></table>
        <div class="container002">
          <h3 class="header">共享资源
          <%if(getService(session).getPermissionManager().hasGroupPermission(groupId,IPermission.GroupPerm.UPLOAD_RESOURCE)){%>
          <a href="javascript:void(0)" class="button button001 moverResource">移动</a> <a href="javascript:void(0)" class="button button001 uploadResources">上传资料</a> <a href="javascript:void(0)" class="button button001 createFolder">新建文件夹</a>
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
                  <!--th width="60">下载</th-->
                  <!--th width="60">删除</th-->
                </tr>
              </thead>
              <tbody id="sourceWrap">

              </tbody>
            </table>
          </div>
        </div>


      <table  cellspacing="0" cellpadding="0" border="0" class="listInfoTableWrap" width="100%">
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
            <td class="totalTopic"> 共<span class="dirAmout"></span>个文件夹 <span class="fileAmout"></span>个文件 | 空间容量：<span class="totalSpace"></span> (已使用<span class="usedspace"></span>,<span class="percent"></span>)</td>
          </tr>
        </tbody></table></td>
      <td align="right"></td>
    </tr>
  </tbody></table>
        </td>
      <td class="coR">
      <%@include file="pages/group/menu.jsp"%>
        <div class="container003">
        <h3 class="header">圈子信息</h3>
        <div class="body">
          <table  border="0" cellspacing="0" cellpadding="0" class="table003">
            <tr>
              <td class="tt">创建者：</td>
              <td><span class="owner"></span></td>
            </tr>
            <tr>
              <td class="tt">创建于：</td>
              <td><span class="createDate"></span></td>
            </tr>
          </table>
          <div class="line"></div>
          <table  border="0" cellspacing="0" cellpadding="0" class="table003">
            <tr>
              <td class="tt">管理员：</td>
              <td><span class="groupsManager"></span></td>
            </tr>
            <tr>
              <td class="tt">成员：</td>
              <td><span class="memberCount"></span></td>
            </tr>
            <tr>
              <td class="groups-desc" colspan="2"><span class="tt" style="color:#1E5494;">描述：</span><span class="desc"></span></td>
            </tr>
          </table>
        </div></div></td>
    </tr>
  </table>
</div>
 <%@include file="pages/footer.jsp"%>
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
   resourceLink = "/group/downloadResource.action?id="+resource.id;
}
if(resource.size >= 1024) {
  size = Math.ceil(resource.size/1024) + "MB";
} else if(resource.size >= 1024*1024) {
   size = Math.ceil(resource.size/1024/1024) + "G";
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
  <td>\${fileICO}<a class="resourceName" href="<%=site%>\${resourceLink}" id="\${resource.id}" type="\${resource.type}" link="<%=site%>/group/downloadResource.action?id=\${resource.id}">\${resource.name}</a> <span class="resourceSpanDesc">{if resource.desc != ""} - <span class="resourceDesc" title="\${resource.desc}">\${desc}</span> {/if}</span> <span class="oprtText"></span></td>
  <td>\${size}</td>
  <td>\${resource.memberName}</td>
  <td><p class="replydate">\${resource.creationDate}</p></td>
  <!--td><a href="/group/downloadResource.action?id=\${resource.id}" class="ico ico07" onfocus="this.blur()">&nbsp;</a></td-->
  <!--td><a href="javascript:void(0)" class="ico ico08 signDelete" id="\${resource.id}">&nbsp;</a></td-->
</tr>
{/for}
</textarea>
<div class="ManageToolWrap"><h3>你选中了<span class="num"></span>个资源</h3>
<div class="space01"></div>
<p><a href="javascript:void(0)" class="btn-download">下载</a> <a href="javascript:void(0)" class="btn-del-rLst">删除</a> <a href="javascript:void(0)" class="moverResource">移动</a></p>
</div>


<div id="uploadDialog" class="displayNone ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable">
  <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> <span id="ui-dialog-title-dialog" class="ui-dialog-title"></span> <a class="ui-dialog-titlebar-close ui-corner-all" href="javascript:void(0)"><span class="ui-icon ui-icon-closethick">close</span></a> </div>
  <div style="width: auto;" class="ui-dialog-content ui-widget-content uploadIframe">

  </div>
  <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
  <span class="uploadText">上传提示：使用Shift或Ctrl键选择多个文件上传，单个文件<span id="sizelimit"></span>以内</span>
    <!--button type="button" class="ui-state-default ui-corner-all dialog-btn-cancel">取消</button-->
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
        <td><input type="text" class="text renameInput" name="renameInput" style="width:160px;"/> <span class="extName"></span> </td>
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

<%=getSiteStatCode%>
</body>
</html>
