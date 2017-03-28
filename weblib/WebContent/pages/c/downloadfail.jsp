<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>资源库提取文件页</title>
<style type="text/css">
body,p,input { margin:0; padding:0; }
body { background:#fff url(images/download-body.gif) repeat-x; }
.cl { clear:both; }
#wrap { width:100%; height:100%;  }
#main { margin:0 auto; width:800px;}
#main .left { float:left; width:800px; }
#main .left .box1 { float:left; width:800px; height:56px; }

#main .left .box2 { float:left; padding-left:18px; width:100px; height:48px; font:bold 14px/48px "宋体"; color:#fff; }
#main .left .box3 { float:left; padding-top:20px; width:435px; font:14px/30px "宋体"; }
#main .left .box3 p { font:bold 20px/40px "宋体"; }
#main .left .box4 { float:left; width:435px; padding-top:80px;}
#main .left .box4 .down { display:block; width:121px; height:38px; background:url(images/download-down.jpg) no-repeat; cursor:pointer; }
#main .right { float:left; padding:65px 0 0 20px; width:268px; height:400px; background:url(images/download-line.gif) no-repeat left top; font:12px/20px "宋体"; }
#main .bottom { text-align:center; font:12px/70px "宋体"; }
.loginbox { position:absolute; width:285px; height:255px; background:url(images/loginbox.jpg) no-repeat; top:25%;left:35%;display:none;}
.loginbox .close1 { position:absolute; top:19px; left:245px; width:19px; height:19px; cursor:pointer; }
.loginbox .close2 { position:absolute; top:212px; left:189px; width:72px; height:25px; cursor:pointer; }
.loginbox input { position:absolute; background:none; border:none; }
.loginbox .text { top:70px; left:91px; width:159px; height:14px; font:14px/14px "宋体"; }
.loginbox .password { top:115px; left:91px; width:159px; height:14px; font:14px/14px "宋体"; }
.loginbox .radio1 { top:157px; left:38px; }
.loginbox .radio2 { top:157px; left:154px; }
.loginbox .submit { top:212px; left:108px; width:72px; height:25px; cursor:pointer; }
.loginbox .font1 { position:absolute; top:160px; left:62px; font:12px/14px "宋体"; color:#3a5600; }
.loginbox .font2 { position:absolute; top:160px; left:177px; font:12px/14px "宋体"; color:#005695; }
</style>

</head>

<body>

<div id="wrap">
 <div id="main">
      <div class="left">
   <div class="box1"><img src="images/logo.jpg" /></div>
   <div style="height:206px;width:600px;font:16px/32px '宋体';margin:160px 0px 0 200px">抱歉，下载失败，可能原因有：
        <br />1、下载文件已经过期；
        <br />2、下载次数已满；
        <br />3、提取码错误。
    </div>
   </div>
  
  <div class="cl"></div>
  
 </div>
</div>

<div class="loginbox">
 <div class="close1"></div>
 <div class="close2"></div>

  <input class="text" type="text" name="username"/>
  <input class="password" type="password" name="password"/>
  <!--input class="radio1" type="radio" name="loginbox" value="1" checked="checked" /-->
  <!--input class="radio2" type="radio" name="loginbox" value="2" /-->
  <input class="submit" type="submit" value="" />
 <!--div class="font1">极速版</div-->

 <!--div class="font2">专业版</div-->
</div>


</body>
</html>
