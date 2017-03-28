<%@page contentType="text/html;charset=utf-8" %>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@taglib prefix="ww" uri="/struts-tags"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
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
<script src="js/DCampus.Search.js"></script>
<script src="js/DCampus.Paging.Plugins.js"></script>
</head>
<body>
<script>
var allCategories =  <ww:action name="getAllCategories" namespace="/category" executeResult="true" ignoreContextParams="true"></ww:action>
</script>
<%
  String groupsName = ServletRequestUtils.getStringParameter(request,"groupsName","");
  String categoryName = ServletRequestUtils.getStringParameter(request,"categoryName","");
  String requestParam = groupsName;
  if(groupsName == "") 
      requestParam = categoryName;
%>
<div id="headerWrap">
<div id="header">
  <%@include file="header.jsp"%>
</div>
</div>
<div class="ui-widget displayNone" style="width:900px;margin:15px auto 0 auto;">
            <div class="ui-state-highlight ui-corner-all" style="margin-top:5px;padding: 0 7px;"> 
				<p style="padding:5px 0;"><span class="ui-icon ui-icon-info" style="float: left; margin-right:3px;"></span>
				<strong>成员加入信息：</strong><span class="current_choose_category">( <a href="#">5</a> )</span></p>
			</div>
		</div>
<div id="personal_wrap">
  <form action="search.jsp"  name="searchForm" method="get">
    <div class="groups-search" id="groups-search-big">
      <table cellspacing="0" cellpadding="0" border="0">
        <tbody>
          <tr>
            <td class="searchICO">&nbsp;</td>
            <td class="search-input"><input type="text" value="<%=requestParam%>" name="groupsName"/></td>
            <td><a class="search" id="doSearch" href="javascript:void(0)">搜索</a></td>
          </tr>
        </tbody>
      </table>
    </div>
  </form>
  <div class="coL">
    <div class="container005">
      <div class="top"></div>
      <div class="middle container002 searchListWrap">
<h3 class="header">搜索到 <span class="totalCount"></span> 条结果</h3>

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

        <div id="News-Wrap">
            <ul id="search-lst"></ul>
        </div>
        
        
       <table  cellspacing="0" cellpadding="0" border="0" class="listInfoTableWrap displayNone" width="100%">
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
      <div class="bottom"></div>
    </div>
  </div>
  <div class="coR">
    <div class="container006" style="margin-top:10px;">
      <div class="top"></div>
      <div class="middle">
        <h3 class="personal_coL_header">所有分类</h3>
        <form action="gresult.jsp" id="gform" method="get"> 
        <input type="hidden" name="categoryId" value="" />
        <div id="categoryWrap" class="searchCategoryWrap"></div>
        </form>
      </div>
      <div class="bottom"></div>
    </div>
  </div>
  <div class="clearBoth"></div>
</div>
<div id="copyright_frontpage">
<%@include file="footer.jsp"%>
</div>
<textarea style="display:none" id="searchLst_template">
{if totalCount == "0"}
<p class="searchNoneResult">
抱歉，没有找到您想查找的圈子<br/>
建议您：<br/>
&nbsp;&nbsp;&nbsp;&nbsp;<a href="step01.jsp#create" class="createGroupsA">创建群组</a><br/>
&nbsp;&nbsp;&nbsp;&nbsp;更换搜索关键字再试，群名称建议不要使用 <br/>&nbsp;&nbsp;&nbsp;&nbsp;1)生僻的词组 <br/>&nbsp;&nbsp;&nbsp;&nbsp;2)火星文</p>
{/if}

{var SearchDesc,SearchTitle,usage;var isJoin = true;}
{var reSearch = new RegExp($j("input[name='groupsName']").val(),"gi")}
{var locationHref = location.href}
{var target = locationHref.substring(locationHref.indexOf("?")+1,locationHref.indexOf("="))}
{if target == "categoryName"}
{for category in categories}
  
{/for}
{else}
{for group in groups}
<li>
{eval}
SearchDesc = group.groupDesc.replace(reSearch,"<span style='color:#f00'>"+$j("input[name='groupsName']").val()+"<\/span>");
SearchTitle = group.groupName.replace(reSearch,"<span style='color:#f00'>"+$j("input[name='groupsName']").val()+"<\/span>");
if($j.trim(SearchDesc) == "") {
   SearchDesc = "该圈子没有描述";
}
switch(group.usage) {
  case "public": usage = "公开";isJoin = true;break;
  case "normal" : usage = "审核";isJoin = true;break;
  case "guestbook" : usage = "留言板";isJoin = false;break;
  case "private" : usage = "私有";isJoin = false;break;
}
{/eval}
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="searchcoL" valign="top">
    <a href="<%=site%>/\${group.groupAddr}/" target="_blank"><img src="<%=site%>\${group.logoIcon}" border="0"/></a>
    </td>
    <td class="searchcoR"><div class="searchGroupsName"><a href="<%=site%>/\${group.groupAddr}/index.jsp" target="_blank">\${SearchTitle}</a> {if isJoin}<div class="joinUS"><span class="joinUSIco">&nbsp;</span><a href="<%=site%>/pages/ucenter/join.jsp?groupId=\${group.groupId}">申请加入</a></div>{/if}</div>
<div class="searchInfo">\${group.memberCount}人 | \${group.category.name}-\${group.subCategory.name}  | \${group.creationDate} 创建 | 类型：\${usage}</div>
<div>\${SearchDesc}</div>
</td>
  </tr>
</table>
</li>
{/for}
{/if}
</textarea>


<textarea id="allCategories_template" style="display:none">
{for categorie in categories}
<dl>
<dt><a href="javascript:void(0)" id="\${categorie.id}">\${categorie.name}</a></dt>
{for child in categorie.children}
<dd><a href="javascript:void(0)" id="\${child.id}">\${child.name}</a>{if child.groupNum > 0}(\${child.groupNum}){/if}</dd>
{/for}
</dl>
{/for}
<div class="clearBoth"></div>
</textarea>

<%=getSiteStatCode%>
</body>
</html>
