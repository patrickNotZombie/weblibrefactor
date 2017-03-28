<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.dcampus.groups.beans.ICategoryBean"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
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
<script src="../../js/TrimPath_Template.js"></script>
<script src="../../js/DCampus.Public.js"></script>
<script src="../js/DCampus.Category.js"></script>
<script>
var allCategoryJson = <ww:action name="getAllCategories" namespace="/category" executeResult="true" ignoreContextParams="true"/>;
</script>
</head>
<body>
<div class="frame_content" >
  <div id="breadCrumb"><span class="breadLeft"/><span class="breadRight"/><span class="breadTitle"><a href="#">资源库</a> > <a href="#">分类管理</a> </span> </div>
  <div class="categoryWrap"> 
</div>
</div>
<textarea id="category_template" style="display:none">
<table class="tb tb2 ">
      <thead>
      <tr class="header">
        <th><!--显示顺序--></th>
        <th>分类名称</th>
        <th>群组数</th>
        <th>状态</th>
        <th>操作</th>
      </tr>
      </thead>
    <tbody>
    {var haschild = false;}
    {for categorie in categories}
      {eval}
         if(categorie.children.length > 0) {
            haschild = true;
         } else {
            haschild = false;
         }
      {/eval}
      <tr class="hover">
        <td class="td25"><!--input type="text" value="0" name="order[3]" class="txt"--></td>
        <td><div class="parentboard">
            <input type="hidden" value="\${categorie.id}" name="cid" class="categorySubmit"/>
            <input type="text" class="txt categorySubmit" value="\${categorie.name}" name="cname">
          </div></td>
        <td></td>
        <td>
        {if categorie.status == <%=ICategoryBean.Status.NORMAL.ordinal() %>}
      	正常
      	{/if}
      	{if categorie.status == <%=ICategoryBean.Status.CLOSE.ordinal() %>}
      	<span style="color:#f00;">关闭</span>
      	{/if}
      	{if categorie.status == <%=ICategoryBean.Status.UNKNOWN.ordinal() %>}
      	未知
      	{/if}
        </td>
        <td>
        {if categorie.status != <%=ICategoryBean.Status.CLOSE.ordinal() %>}<a class="act btn-close" title="关闭本分类及分类下所有群组" href="###" rel="\${categorie.id}" hasChild="\${haschild}">关闭</a>{/if}
        {if categorie.status == <%=ICategoryBean.Status.CLOSE.ordinal() %>}<a class="act btn-open" title="打开本分类及分类下所有群组" href="###" rel="\${categorie.id}">打开</a>{/if}
        </td>
      </tr>
      {for child in categorie.children}
      <tr class="hover">
        <td class="td25"><!--input type="text" value="0" name="order[9]" class="txt"--></td>
        <td><div class="board">
            <input type="hidden" value="\${child.id}" name="cid" class="categorySubmit"/>
            <input type="text" class="txt categorySubmit" value="\${child.name}" name="cname">
          </div></td>
        <td>\${child.groupNum}</td>
        <td>
        {if child.status == <%=ICategoryBean.Status.NORMAL.ordinal() %>}
      	正常
      	{/if}
      	{if child.status == <%=ICategoryBean.Status.CLOSE.ordinal() %>}
      	<span style="color:#f00;">关闭</span>
      	{/if}
      	{if child.status == <%=ICategoryBean.Status.UNKNOWN.ordinal() %>}
      	未知
      	{/if}
        </td>        
        <td>{if child.status != <%=ICategoryBean.Status.CLOSE.ordinal() %>}<a class="act btn-closeOne" title="关闭本分类及分类下所有群组" href="###" rel="\${child.id}">关闭</a>{/if}
        {if child.status == <%=ICategoryBean.Status.CLOSE.ordinal() %>}<a class="act btn-open" title="打开本分类及分类下所有群组" href="###" rel="\${child.id}">打开</a>{/if}
        </td>
      </tr>
     {/for}
      <tr>
        <td></td>
        <td colspan="4"><div class="lastboard"><a class="addtr"  href="###" id="\${categorie.id}">新子分类</a></div></td>
      </tr>
      {/for}
    </tbody>
      <tfoot>
      <tr>
        <td colspan="5"><div><a class="addOnetr"  href="###">添加一级分类</a></div></td>
      </tr>
      
      <tr>
        <td colspan="5"><div class="fixsel">
            <button class="button" title="按 Enter 键可随时提交您的修改" name="editsubmit" id="submit_editsubmit">提交</button>
          </div></td>
      </tr>
      </tfoot>
  </table>
</textarea>
</body>
</html>
