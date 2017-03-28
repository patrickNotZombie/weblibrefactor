<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="path.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="<%=getSiteSeoKeywords%>" />
<meta name="Description" content="<%=getSiteSeoDescription%>" />
<title><%=getSiteName%></title>
<link href="../js/jquery-ui-1.7.2.custom/css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" />
<link href="../themes/default/css/global.css" rel="stylesheet" type="text/css" />
<script src="../js/jquery/jquery-1.4.2.pack.js"></script>
<script src="js/TrimPath_Template.js"></script>
<script src="js/DCampus.Public.js"></script>
<script src="js/DCampus.Personal.js"></script>
</head>
<body>
<script>
var groupNewsJSON =  <ww:action name='getMyGroupsByLastRecords' namespace='/group' executeResult='true' ignoreContextParams='false'><ww:param name="start" value="0"></ww:param><ww:param name="limit" value="5"></ww:param></ww:action>;
var randGroupsJson = <ww:action name="getRandomGroups" namespace="/group" executeResult="true" ignoreContextParams="true"/>;
</script>
<div id="headerWrap">
  <div id="header">
    <%@include file="header.jsp"%>
    <%if(!isLogin) { %>
    <script>
window.location.href="<%=site%>/pages/login.jsp";
</script>
    <%}%>
  </div>
</div>
<div class="ui-widget displayNone" style="width:900px;margin:15px auto 0 auto;">
  <div class="ui-state-highlight ui-corner-all" style="margin-top:5px;padding: 0 7px;">
    <p style="padding:5px 0;"><span class="ui-icon ui-icon-info" style="float: left; margin-right:3px;"></span> <strong>成员加入信息：</strong><span class="current_choose_category">( <a href="#">5</a> )</span></p>
  </div>
</div>
<div id="personal_wrap">
  <div class="coL">
    <div id="groups_personal_info">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="1%"><img src="../themes/default/images/groupsImg.gif" width="50" height="50" /></td>
          <td valign="bottom" width="260"><p><span class="name personal_user_name"></span> <strong>的圈子</strong>（您共有<span id="totalGroups"></span>个圈子）</p>
            <p class="info">您创建了：<span id="totalMyGroups"></span>个圈子 <span class="ico ico09">&nbsp;</span><a href="<%=site%>/pages/step01.jsp">创建圈子</a></p></td>
          <td>&nbsp;</td>
        </tr>
      </table>
      <div style="width: 300px; margin: 15px auto 0pt;" id="joinMessage" class="ui-widget personal-infoWrap displayNone">
  <div style="margin-top: 5px; padding: 0pt 7px;" class="ui-state-highlight ui-corner-all">
    <p style="padding: 5px 0pt;"><span style="float: left; margin-right: 3px;" class="ui-icon ui-icon-info"></span> <strong>邀请函信息：</strong><span class="current_choose_category "> <a href="#">您有（<span class="num">1</span>）个邀请函</a></span></p>
  </div>
</div>
    </div>
    <div class="container005">
      <div class="top"></div>
      <div class="middle">
        <!--h3 class="personal_coR_header">圈子动态</h3-->
         <div class="tabMenu tab">
          <ul class="tabHanddle">
            <li><a href="#">最新动态</a></li>
            <li><a href="#">随便看看</a></li>
          </ul>
          <div class="tabCover" style="width: 36px; left: 10px;"></div>
        </div>
        <div id="News-Wrap"></div>
        <div id="Random-Wrap"></div>
      </div>
      <div class="bottom"></div>
    </div>
  </div>
  <div class="coR">
    <div class="container006">
      <div class="top"></div>
      <form action="search.jsp" name="searchForm">
        <div class="middle" style="padding:10px;text-align:center;">
        <div class="groups-search" id="groups-search">
          <table cellspacing="0" cellpadding="0" border="0">
            <tbody>
              <tr>
                <td class="search-input"><input type="text" name="groupsName"/></td>
                <td><a class="search" id="doSearch" href="javascript:void(0)">搜索</a></td>
              </tr>
            </tbody>
          </table>
          </div>
        </div>
      </form>
      <div class="bottom"></div>
    </div>
    <div class="container006" style="margin-top:10px;">
      <div class="top"></div>
      <div class="middle">
        <h3 class="personal_coL_header">更多我的圈子</h3>
        <ul class="list007 moreMyGroups">
        </ul>
      </div>
      <div class="bottom"></div>
    </div>
  </div>
  <div class="clearBoth"></div>
</div>
<div id="copyright_frontpage">
  <%@include file="footer.jsp"%>
</div>
<!--圈子动态的圈子名称模板-->
<textarea id="News_template" style="display:none">
<table width="100%" border="0" cellspacing="10" cellpadding="0" class="personal_coR_table">
{var i = 0;}
{for group in groups}
          <tr>
            <td width="60" align="center" class="pic" valign="top"><a href="#"><img src="<%=site%>\${group.groupIcon}"/></a></td>
            <td class="info" valign="top"><h3 rev="\${group.usage}">
                <div class="title"><a href="<%=site%>/\${group.addr}/index.jsp">\${group.name|escape}</a></div>
                <a href="<%=site%>/\${group.addr}/index.jsp" class="more">更多>></a></h3>
              <ul class="News-lst NewsLst\${i}" id="NewsLst\${i}">
              </ul></td>
          </tr>
          {eval}
           DCampus.PersonalData.idArr[i] = group.id;
           i++;
          {/eval}
{/for}
</table>
</textarea>
<!--圈子动态的圈子动态列表模板-->
<textarea id="News-lst_template" style="display:none">
{var status;var link = "###";}
{for record in records}
{eval}
   status = record.type;
   switch (status) {
     case 0:status = "错误操作";link="###";break;
     case 1:status = "创建了圈子";link="<%=site%>/"+addr+"/";break;
     case 2:status = "修改了圈子;link="<%=site%>/"+addr+"/";";break;
     case 3:status = "加入了圈子";link="<%=site%>/"+addr+"/";break;
     case 4:
     status = "发表了主题";
     link="<%=site%>/"+addr+"/detail.jsp#tid"+record.targetId;
     if($j("#NewsLst"+DCampus.PersonalData.lstid).prev().attr("rev") == "guestbook") {
          status = "发表了留言";
          link = "/"+addr+"/";
      } ;break;
     case 5:status = "上传了资料";link="<%=site%>/group/downloadResource.action?id="+record.targetId;break;
     case 6:status = "添加了讨论区";link="###";break;
     case 7:status = "修改了讨论区";link="###";break;
   }
{/eval}
<li><span class="ico ico02">&nbsp;</span><a href="javascript:void(0)">\${record.memberName|escape}</a> <span class="recoresStatus">\${status}</span> <a href="\${link}">\${record.targetDesc|escape}</a> <span class="date">\${record.creationDate}</span></li>
{/for}
</textarea>
<textarea id="Random_template" style="display:none">
<table width="100%" border="0" cellspacing="10" cellpadding="0" class="personal_coR_table">
{var i = 0;}
{for group in groups}
          <tr>
            <td width="60" align="center" class="pic" valign="top"><a href="#"><img src="<%=site%>\${group.groupIcon}"/></a></td>
            <td class="info" valign="top"><h3 rev="\${group.usage}">
                <div class="title"><a href="<%=site%>/\${group.addr}/index.jsp">\${group.name|escape}</a></div>
                <a href="<%=site%>/\${group.addr}/index.jsp" class="more">更多>></a></h3>
              <ul class="News-lst RandomLst\${i}" id="RandomLst\${i}">
              </ul></td>
          </tr>
          {eval}
          DCampus.PersonalData.random_idArr[i] = group.id;
           i++;
          {/eval}
{/for}
</table>
</textarea>
<textarea id="Random-lst_template" style="display:none">
{var status;var link = "###";}
{for record in records}
{eval}
   status = record.type;
   switch (status) {
     case 0:status = "错误操作";link="###";break;
     case 1:status = "创建了圈子";link="<%=site%>/"+addr+"/";break;
     case 2:status = "修改了圈子;link="<%=site%>/"+addr+"/";";break;
     case 3:status = "加入了圈子";link="<%=site%>/"+addr+"/";break;
     case 4:
     status = "发表了主题";
     link="<%=site%>/"+addr+"/detail.jsp#tid"+record.targetId;
     if($j("#NewsLst"+DCampus.PersonalData.lstid).prev().attr("rev") == "guestbook") {
          status = "发表了留言";
          link = "/"+addr+"/";
      } ;break;
     case 5:status = "上传了资料";link="<%=site%>/group/downloadResource.action?id="+record.targetId;break;
     case 6:status = "添加了讨论区";link="###";break;
     case 7:status = "修改了讨论区";link="###";break;
   }
{/eval}

<li><span class="ico ico02">&nbsp;</span><a href="javascript:void(0)">\${record.memberName|escape}</a> <span class="recoresStatus">\${status}</span> <a href="\${link}">\${record.targetDesc|escape}</a> <span class="date">\${record.creationDate}</span></li>
{/for}
</textarea>
<%=getSiteStatCode%>
</body>
</html>
