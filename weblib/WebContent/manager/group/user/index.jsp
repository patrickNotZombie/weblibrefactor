<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员设置</title>
<%@include file="../../site.jsp"%>
<script type="text/javascript" src="../../user/js/jquery-1.3.2.pack.js"></script>
<script type="text/javascript" src="../../user/js/jquery.layout.min.js"></script>
<script src="../../user/js/index.js" type="text/javascript"></script>
<link href="../../user/css/layout.css" rel="stylesheet" type="text/css" />
<link href="../../user/css/global.css" rel="stylesheet" type="text/css" />
<script>
	var adminJson = <ww:action name="getCategories" namespace="/category" executeResult="true" ignoreContextParams="true"/>
</script>
</head>
<body>
<div class="admin-list">
	<table border="0"  class="table001 slct-tbl" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<th width="10" align="center"><input type="checkbox" /></th>
				<th width="200">用户名</th>
				<th>级别</th>
			</tr>
		</thead>
		<tbody>
		{for a in admin}
		    <tr>
		      <td><input type="checkbox" value="" id="\${categorie.id}"/></td>
		      <td>\${categorie.name}</td>
		      <td>\${categorie.desc}</td>
		      <td>
		      	{if categorie.status == <%=ICategoryBean.Status.NORMAL.ordinal() %>}
		      	正常
		      	{/if}
		      	{if categorie.status == <%=ICategoryBean.Status.CLOSE.ordinal() %>}
		      	关闭
		      	{/if}
		      	{if categorie.status == <%=ICategoryBean.Status.UNKNOWN.ordinal() %>}
		      	未知
		      	{/if}
		      </td>
		    </tr>
	    {/for}
		</tbody>
	</table>
</div>
</body>