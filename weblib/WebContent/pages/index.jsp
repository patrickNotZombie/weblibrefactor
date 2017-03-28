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
<link href="../themes/default/css/global.css" rel="stylesheet" type="text/css" />
<script>window.location.href="c/login.jsp"</script>
<script src="../js/jquery/jquery-1.4.2.pack.js"></script>
<script src="js/TrimPath_Template.js"></script>
<script src="js/DCampus.Public.js"></script>
<script src="js/DCampus.Frontpage.js"></script>
<script>
$j(function(){
    $j("#doSearch").bind("click",function(){
	     $j("[name='searchForm']").submit();
	});
})
</script>
</head>
<body>
<script type="text/javascript">
var allCategoryJson = <ww:action name="getAllCategories" namespace="/category" executeResult="true" ignoreContextParams="true"/>;
</script>
<div id="headerWrap">
<div id="header">
  <%@include file="header.jsp"%> 
</div>
</div>
<div id="frontpage">
<div class="coL">
<a href="javascript:void(0)" class="takeALook">随便看看</a>
<form method="get" name="searchForm" action="search.jsp">
    <div id="groups-search-big" class="groups-search">
      <table cellspacing="0" cellpadding="0" border="0">
        <tbody>
          <tr>
            <td class="searchICO">&nbsp;</td>
            <td class="search-input"><input type="text" name="groupsName" value=""></td>
            <td><a href="javascript:void(0)" id="doSearch" class="search">搜索</a></td>
          </tr>
        </tbody>
      </table>
    </div>
  </form>
</div>
<div class="coR">

<div id="front-GroupsWraps"> <input type="button" class="fCreateBtn" /></div>

   <div id="front-countWrap"> 
      <ul class="fCountWrap">
         <li><span class="num todayCount"></span><p>今日发帖</p></li>
         <li><span class="num totalCount"></span><p>总帖子数</p></li>
         <li style="background:none;"><span class="num groupsCount"></span><p>群组总数</p></li>
      </ul>
      <%if(!isLogin) { %>
    <p class="fCreateBtnP"><input type="button" class="fLoginBtn" /></p>
    <%}%>
   </div>
</div>
<div class="clearBoth"></div>
  <h3 class="categoryHeader">圈子分类</h3>
 <form action="gresult.jsp" id="gform" method="get"> 
  <input type="hidden" value="" name="categoryId"/>
  <div id="categoryWrap"></div>
</form>
<div class="clearBoth"></div>
</div>
<div id="copyright_frontpage">
 <%@include file="footer.jsp"%>
</div>
<textarea id="category_template" style="display:none">
{for categorie in categories}
<dl>
<dt><a href="###" id="\${categorie.id}">\${categorie.displayName}</a></dt>
{for child in categorie.children}
<dd><a href="###" id="\${child.id}">\${child.displayName}</a>{if child.groupNum > 0}(\${child.groupNum}){/if}</dd>
{/for}
</dl>
{/for}
</textarea>
<%=getSiteStatCode%>
</body>
</html>
