<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>网盘设置</title>
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<link href="../../css/global.css" rel="stylesheet" type="text/css" />
<%@include file="../../site.jsp"%>
<script src="../../js/jquery-1.3.2.pack.js"></script>
<script src="../../js/DCampus.Public.js"></script>
<script src="../js/DCampus.Settings.js"></script>
</head>
<body>
<div class="frame_content">
  <div id="breadCrumb"><span class="breadLeft"><span class="breadRight"><span class="breadTitle"><a href="#">网盘</a> &gt; <a href="#">网盘设置</a> </span> </span></span></div>
    <div class="seperate5px"></div>
  <h3 class="blueH3">基本设置</h3>
<div class="tablewrap">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tablesorter">
 <tr class="noborder">
    <td><strong>站点域名</strong></td>
 </tr>
 <tr><td><input type="text" name="site_domain" class="site_text settingValue"/></td></tr>
 <tr class="noborder">
    <td><strong>站点名称</strong></td>
 </tr>
 <tr><td><input type="text" name="site_name" class="site_text settingValue"/></td></tr> 
 <tr class="noborder">
    <td><strong>是否审核圈子</strong></td>
  </tr>
    <tr>
    <td><input type="radio" name="site_audit_group" checked="checked" class="settingValue" value="false"/> 否 <input type="radio" name="site_audit_group" class="settingValue" value="true"/> 是</td>
  </tr>
  <tr class="noborder">
    <td><strong>关闭网盘</strong></td>
  </tr>
    <tr>
    <td><input type="radio" name="site_close" checked="checked" class="settingValue" value="false"/> 打开网盘 <input type="radio" name="site_close" class="settingValue" value="true"/> 关闭网盘</td>
  </tr>
    <tr class="noborder">
    <td><strong>关闭原因</strong></td>
  </tr>
      <tr>
    <td><textarea style="width:250px;height:100px;" class="settingValue" name="site_closereason"></textarea></td>
  </tr>

  <tr class="noborder">
    <td><strong>网站关键字</strong></td>
  </tr>
  <tr><td><textarea style="width:250px;height:100px;" class="settingValue" name="site_seo_keywords"></textarea></td></tr>
  <tr class="noborder">
    <td><strong>网站描述</strong></td>
  </tr>
  <tr><td><textarea style="width:250px;height:100px;" class="settingValue" name="site_seo_description"></textarea></td></tr>  
  
      <tr class="noborder">
    <td><strong>统计代码</strong></td>
  </tr>
        <tr>
    <td><textarea style="width:250px;height:100px;" class="settingValue" name="site_statcode"></textarea></td>
  </tr>
</table>
</div>
<h3 class="blueH3">SMTP设置</h3>
 <div class="tablewrap">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tablesorter">
  <tr>
    <td width="80" nowrap="nowrap">邮箱地址：</td>
    <td><input type="text" class="settingValue" name="smtp_sender"/></td>
  </tr>
  <tr>
    <td width="80" nowrap="nowrap">邮箱名称：</td>
    <td><input type="text" class="settingValue" name="smtp_sendername"/></td>
  </tr>
      <tr>
    <td width="80" nowrap="nowrap">SMTP认证：</td>
    <td><input type="radio" name="smtp_auth" checked="checked" value="true" class="settingValue"/>是 <input type="radio" class="settingValue" name="smtp_auth" value="false"/>否</td>
  </tr>
      <tr>
    <td width="80" nowrap="nowrap">SMTP端口号：</td>
    <td><input type="text" class="settingValue" name="smtp_port"/></td>
  </tr>
      <tr>
    <td width="80" nowrap="nowrap">SMTP用户名：</td>
    <td><input type="text" name="smtp_username" class="settingValue"/></td>
  </tr>
      <tr>
    <td width="80" nowrap="nowrap">SMTP密码：</td>
    <td><input type="password" class="settingValue" name="smtp_password" value="123456"/></td>
  </tr>
  <tr>
    <td width="80" nowrap="nowrap">SMTP主机：</td>
    <td><input type="text" class="settingValue" name="smtp_host"/></td>
  </tr>
</table>
</div> 
<div id="batch_buttons"><input type="button" class="button" id="settingSubmit" value="提交"></div>
</div>

</body>
</html>
