<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>管理员登录</title>
<%@include file="site.jsp"%>
<script type="text/javascript" src="js/jquery-1.3.2.pack.js"></script>
<script>
$(function(){
    $("#submit").bind("click",function(){
	   var username = encodeURIComponent($("input[name='account']").val());
	   var password = encodeURIComponent($("input[name='password']").val());
	   Login._AjaxRequestFunction(System.site+"/login/authenticate.action","account="+username+"&password="+password,"POST",Login._LoginSuccess,Login._LoginError);	    });
	 $("[name='password']").bind("keypress",function(e){
	      if(e.keyCode == 13) {
		     $("#submit").click();
		  }
	 });
});

var Login = {
	_AjaxRequestFunction : function(url,param,method,jsonFunction,jsonErrorFunction){
			$.ajax({
				 type: method,
				 url: url,
				 data: param,
				 dataType:"json",
				 success: function(json){
					jsonFunction(json);       
				 },
				 error : function(message) {
					 if(eval(jsonErrorFunction) != undefined) {
					   var json = eval('('+$.trim(message.responseText)+')');
					   jsonErrorFunction(json);
					 } else {
						var json = eval('('+message.responseText+')');
						alert(json.detail);
					 }
				 }
			  })  
	},
    _LoginSuccess : function(data){
	  if(data.members.length > 0) {
	      Login._AjaxRequestFunction(System.site+"/login/selectMember.action","memberId="+data.members[0].id,"POST",Login._PutOnMaJiaSuccess);
	  } else {
	     Login._AjaxRequestFunction(System.site+"/login/logout.action","","POST",Login._LogoutSuccess);
 	  }
   },
   _LoginError : function(data){
      alert(data.detail);
	  $("[name='password']").focus();
   },
   _LogoutSuccess : function(){
      alert("登录失败");
   },
   _PutOnMaJiaSuccess : function(){
      location.href = System.site+"/manager/";
   }

}
</script>
<style>
body {
	background:#edf4fd;
}
#wrap {
	width:532px;
	height:250px;
	background:url(images/login_background.jpg) no-repeat;
	margin:90px auto 0 auto;
	padding-top:155px;
}
#loginwrap {
  width:228px;
  margin:0 auto;
  padding:10px;
}
#loginwrap td {padding:5px;color:#284f73;font:14px/150% "宋体";}
.uportal-input-text {width:150px;border:1px solid #fff;background:#fff;}
.uportal-button {width:74px;height:23px;background:url(images/login_background.jpg) -1px -416px;border:0;cursor:pointer;}
</style>
</head>
<body>
<input value="login" name="action" type="hidden">
  <div id="wrap">
<div id="loginwrap">
<form method="post">
    <table width="228" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="1%" nowrap="nowrap">管理员帐号:</td>
        <td> <input value="" size="15" name="account" type="text" class="uportal-input-text" id="userName"></td>
      </tr>
      <tr>
        <td nowrap="nowrap">管理员密码:</td>
        <td><input size="15" name="password" type="password" class="uportal-input-text"></td>
      </tr>
      <tr>
        <td colspan="2" align="right"><input class="uportal-button" name="Login" value="" type="button" id="submit"></td>
      </tr>
    </table>
    </form>
</div>
  </div>
<script>
document.getElementById("userName").focus();
</script>
</body>
</html>
