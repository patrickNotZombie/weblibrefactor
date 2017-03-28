<%@ page contentType="text/html;charset=utf-8" %>
<form action="<%=site%>/pages/search.jsp" method="get" name="searchForm">
<table border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td class="search-input"><input type="text" name="groupsName"/></td>
    <td class="selectInput" nowrap="nowrap"><span>搜索圈子</span>
      <ul class="displayNone">
        <li><a href="javascript:void(0)">搜索圈子</a></li>
        <li><a href="javascript:void(0)">本圈子内容</a></li>
      </ul></td>
    <td><a href="javascript:void(0)" class="chooseType">选择</a></td>
    <td><a href="javascript:void(0)" id="doSearch" class="search">搜索</a></td>
  </tr>
</table>
</form>
<script>
   /**
      执行搜索
   **/
   $j("#doSearch").bind("click",function(){
       document.searchForm.submit();
   });
</script>