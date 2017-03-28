<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>资源库登录</title>
<link href="login/login.css" rel="stylesheet" type="text/css" />
<script src="login/js/jquery-1.4.2.pack.js" type="text/javascript"></script>
<script src="login/js/jquery.cookie.pack.js" type="text/javascript"></script>
<script>
$(function(){
    $("[name='username']").focus();
			$("[name='password']").unbind().bind("keydown",function(e) {
			   if(e.keyCode == 13) {
			     if ($("#signInMethodId").val()=="1") {
			     	 $(".cas").trigger("click");
			     } else {
			     	$(".local").trigger("click");
			     }
			   }
			});
				
	$(".local").bind("click",function(){
	    saveOrClearCookie();
		if($.trim($("[name='username']").val()) == "") {
		   alert("请输入用户名");
		} else if($.trim($("[name='password']").val()) == "") {
		   alert("请输入密码");
		} else {
			 $.ajax({
				url:"/login/authenticate.action"
				,dataType : "json"
				,type : "post"
				,data : "account=" + encodeURIComponent($("[name='username']").val()) +  "&password=" + encodeURIComponent($("[name='password']").val())
				,success : function(data){
					 $.ajax({
						url:"/login/selectMember.action?temp="+Math.random()
						,dataType : "json"
						,type : "post"
						,data : "memberId=" + data.members[0].id
						,success : function(data){	
							/*var ua=navigator.userAgent;
							if(ua.indexOf("MSIE")>0){
								var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
								reIE.test(ua);
								var fIEVersion = parseFloat(RegExp["$1"]);
								if(fIEVersion<10){
									window.location.href = "index.jsp";
								}else{
									window.location.href = "angular/";
								}
							}else{*/
								window.location.href = "angular/";
							//}
						}
						,error : function(message){
						   var data = eval('('+$.trim(message.responseText)+')');
						   alert(data.detail);
						}
					})		
				}
				,error : function(message){
				   var data = eval('('+$.trim(message.responseText)+')');
				   alert(data.detail);
				}
			 })
		}
		return false;
	});
	$(".cas").bind("click",function(){
	    saveOrClearCookie();
		if($.trim($("[name='username']").val()) == "") {
		   alert("请输入用户名");
		} else if($.trim($("[name='password']").val()) == "") {
		   alert("请输入密码");
		} else {
		   $("#form").submit();
		}
	    
	});
	
	$(".signInMethod").bind("change",function(){
		if($(this).val() == 0) {
			$(".local").show();
			$(".cas").hide();	  
		} else {
			$(".cas").show();
			$(".local").hide();			
		}
	});
	
	$(".signInMethod").find("option").eq(0).attr({"selected":"selected"});
	
	 //cookie
	  if($.cookie("username")!=null) {
		 $("#rememberme").attr("checked","true");
		 $("[name='username']").val($.cookie("username"));
		 $("[name='password']").val($.cookie("password"));				   
	   } else {
		 $("[name='username']").val("");
		 $("[name='password']").val("");
	   }

   $("#rememberme").bind("click",function(){
       if($(this).is(":checked")) {
	      savePassword();
	   } else {
	      clearPassword();
	   }
   });


})

function saveOrClearCookie(){
		if($("#rememberme").is(":checked")) {
		  savePassword();
		} else {
		  clearPassword();
	   }
}
function savePassword(){
  $.cookie("username",$("[name='username']").val(),{expires:365});
  $.cookie("password",$("[name='password']").val(),{expires:365});
}
function clearPassword(){
  $.cookie("username",null);
  $.cookie("password",null);	   
}

</script>
</head>

<body>
    <div class="wrap">
        
        <DIV class = "main" >
            <form action="https://security.scut.edu.cn/cas/login?service=http%3A%2F%2Fweblib2011.ccnl.scut.edu.cn%2Fpages%2FcasLogin.jsp" method="post" id="form">
                    <div class="form-text">
                        用户名：
                        <br />
                        <input class="text-input" type="text" name="username" />
                    </div>
                    <div class="form-text">
                        密&nbsp;&nbsp;码：
                        <br />
                        <input class="text-input" type="password" name="password" />
                    </div>
                    <div class="form-checkbox">
                        <input class="checkbox-input" id="rememberme" type="checkbox" name="rememberpassword" /> 记住密码
                        <!--<input class="checkbox-input" type="checkbox" name="autologin" /> 自动登录-->
                        <select class="signInMethod" id="signInMethodId">
                          <option value="0">
                             本地认证
                          </option>
                          <option value="1">
                             中央认证
                          </option>
                        </select>
                    </div>
                    <div class="form-foot">
                    	<input class="submit local" type="button"/>
                        <input class="submit cas" value="" style="display: none;" type="button">
                        <!--a href="#" target="_blank">忘记了密码吗?</a-->
                    </div>
                </form>
        </DIV>
        <div class="downloadWrap">
            <div class="links">
                <a target="_blank" class="iphone" href="https://itunes.apple.com/cn/app/dcampus-weblib/id519009725?mt=8"></a>
                <a target="_blank" class="ipad" href="https://itunes.apple.com/cn/app/weblib-hd/id510591668?mt=8"></a>
            </div>
        </div>
        <div class="copyright" style="position:relative;top:15px;">
            Copyright © 2009 - 2012 DCampus. All Rights Reserved 
        </div>
        
    </div>
</body>
</html>
