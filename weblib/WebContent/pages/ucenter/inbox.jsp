<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="../path.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="<%=getSiteSeoKeywords%>" />
<meta name="Description" content="<%=getSiteSeoDescription%>" />
<title><%=getSiteName%></title>
<link href="../../themes/default/css/global.css" rel="stylesheet" type="text/css" />
<script src="../../js/jquery/jquery-1.4.2.pack.js"></script>
<script src="../../js/jquery/jquery.cookie.js"></script>
<script src="../js/TrimPath_Template.js"></script>
<script src="../js/DCampus.Public.js"></script>
<script src="../js/DCampus.Paging.Plugins.js"></script>
<script src="../js/DCampus.Inbox.js"></script>
</head>
<body>
<input type="hidden" name="groupId"/>
<input type="hidden" name="groupAddr" />
<input type="hidden" name="menu" value="inbox"/>
<div id="headerWrap_in">
  <%@include file="../header.jsp"%>
</div>
<div id="groupsTitle">
  <table border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="50" height="50" class="groups-img"><img src="../../themes/default/images/groupsImg.gif" /></td>
      <td class="title">个人中心</td>
    </tr>
  </table>
  <div class="groups-search">
      <%@include file="../group/searchBlock.jsp"%>
  </div>
</div>
<div id="groups_wrap">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td class="coL"><div class="tabMenu tab">
          <ul class="tabHanddle">
            <li><a href="#">收件箱</a></li>
            <li><a href="#">发件箱</a></li>
            <li><a href="#">发送短消息</a></li>
          </ul>
          <div class="tabCover"></div>
        </div>
        <div class="tabContent">
          <div class="tabContent0">

            <div class="body inbox-lst"> </div>

          </div>
          </div>
        </div></td>
      <td class="coR"><%@include file="ucenermenu.jsp"%>
      </td>
    </tr>
  </table>
</div>
<%@include file="../footer.jsp"%>
<textarea id="inbox_and_outbox_template" style="display:none">
{var status = "";}
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
            <td class="totalTopic"> [共 <span class="totalCount"></span> 条短消息]</td>
          </tr>
        </tbody></table></td>
      <td align="right"></td>
    </tr>
  </tbody></table>
  <div class="container002">
<table border="0"  class="table001 slct-tbl shorTable" cellpadding="0" cellspacing="0">
  <thead>
    <tr>
      <th width="20" align="center" class="ck"><input type="checkbox" /></th>
      <th>标题</th>
      <th width="80" class="sendTitle">发件人</th>
      <th width="132">时间</th>
    </tr>
  </thead>
  <tbody>
  {for message in messages}
  {eval}
     switch (message.status) {
       case 1:status="ico_read";break;
       case 2:status="ico_unread";break;
     }
  {/eval}
    <tr>
      <td class="ck"><input type="checkbox" value="\${message.id}" name="id"/></td>
      <td><span class="ico \${status}">&nbsp;</span><a href="javascript:void(0)" id="\${message.id}" status="\${message.status}" class="title">\${message.topic|escape}</a></td>
      <td>\${message.friendName|escape}</td>
      <td class="view-click-count">\${message.creationDate|escape}</td>
    </tr>
     <tr class="messageList displayNone">
      <td colspan="4">
 <div class="messageBody"><fieldset><legend>消息内容</legend>\${message.body}<br/><div class="closeFieldst"><input type="button" value="回复" messagetitle="\${message.topic}" id="\${message.friendName}" class=" sendMessageReply button003"/> <input type="button" value="删除" id="\${message.id}" class=" deleteOneMessage button003"/> <input type="button" class=" closeFieldButton button003" value="关闭"/></div><div class="displayNone contentM"><br/></div></fieldset></div>     
      </td>
    </tr>   
    {/for}
  </tbody>
</table>
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
            <td class="totalTopic"> [共 <span class="totalCount"></span> 条短消息]</td>
          </tr>
        </tbody></table></td>
      <td align="right"></td>
    </tr>
  </tbody></table>
</textarea>
<textarea id="sendMessage_template" style="display:none">
            <form name="inbox_form">
              <input type="hidden" value="message" name="type"/>
              <table  border="0" cellspacing="0" cellpadding="0" class="table001 inviteTable">
                <tr>
                  <td width="1%" nowrap="nowrap">会员用户名：</td>
                  <td><input type="text" name="receiverName" class="inputstyle01 tabForm"/></td>
                </tr>
                <tr>
                  <td width="1%" nowrap="nowrap">短消息标题：</td>
                  <td><input type="text" name="topic" class="inputstyle01 tabForm"/></td>
                </tr>
                <tr>
                  <td width="1%" nowrap="nowrap" valign="top">短消息内容：</td>
                  <td><textarea type="text"  name="body" class="invitationStyleDemo invitationStyleActive tabForm"/></td>
                </tr>
              </table>
              <div class="toolbar"><a class="button button002 sendShortMessageToInvite" href="javascript:void(0)" onfocus="this.blur()">发送</a></div>
            </form>
</textarea>
<div class="ManageToolWrap"><h3>你选中了<span class="num"></span>篇</h3>
<div class="space01"></div>
<p><a href="javascript:void(0)" class="btn-del-msgL">删除</a> <a href="javascript:void(0)" class="btn-read-msgL">标记为已读</a> <a href="javascript:void(0)" class="btn-unread-msgL">标记为未读</a></p>
</div>
<%=getSiteStatCode%>
</body>
</html>
