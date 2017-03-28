<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.dcampus.groups.beans.IGroupBean"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@page import="com.dcampus.groups.beans.IForumBean"%>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%@ taglib prefix="ww" uri="/struts-tags"%>
<% 
   long getParentId = ServletRequestUtils.getLongParameter(request, "id",0);//获取ParentID
   long getGroupId = ServletRequestUtils.getLongParameter(request, "groupId",0);//获取GroupId
   long getRemainSpace = ServletRequestUtils.getLongParameter(request, "leaveSpace",0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="../path.jsp"%>
    <title>FileSecurity</title>
    <link href="../../js/jquery-ui-1.7.2.custom/css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/default/css/global.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery/jquery-1.3.2.pack.js"></script>
    <script src="../js/DCampus.Public.js"></script>
    <script>
    setInterval(function(){DCampus.Public.AjaxRequestFunction(System.site+"/user/alive.action","","POST",function(){},function(){});},60000);

    </script>    
    <style type="text/css">
    html, body {
	    height: 100%;
	    overflow: auto;
    }
    body {
	    padding: 0;
	    margin: 0;
    }
    #silverlightControlHost {
	    height: 100%;
	    text-align:center;
    }
    </style>
    <script type="text/javascript" src="Silverlight.js"></script>
    <script type="text/javascript">
        function onSilverlightError(sender, args) {
            var appSource = "";
            if (sender != null && sender != 0) {
              appSource = sender.getHost().Source;
            }
            
            var errorType = args.ErrorType;
            var iErrorCode = args.ErrorCode;

            if (errorType == "ImageError" || errorType == "MediaError") {
              return;
            }

            var errMsg = "Silverlight 应用程序中未处理的错误 " +  appSource + "\n" ;

            errMsg += "代码: "+ iErrorCode + "    \n";
            errMsg += "类别: " + errorType + "       \n";
            errMsg += "消息: " + args.ErrorMessage + "     \n";

            if (errorType == "ParserError") {
                errMsg += "文件: " + args.xamlFile + "     \n";
                errMsg += "行: " + args.lineNumber + "     \n";
                errMsg += "位置: " + args.charPosition + "     \n";
            }
            else if (errorType == "RuntimeError") {           
                if (args.lineNumber != 0) {
                    errMsg += "行: " + args.lineNumber + "     \n";
                    errMsg += "位置: " +  args.charPosition + "     \n";
                }
                errMsg += "方法名称: " + args.methodName + "     \n";
            }

            引发新错误(errMsg);
        }
    </script>
	<script type="text/javascript">
		function htmlParentId(){
				return <%=getParentId%>;
		}
	</script>
<script>
function GetCookieVal(offset)
{
var endstr = document.cookie.indexOf (";", offset);
if (endstr == -1)
endstr = document.cookie.length;
return unescape(document.cookie.substring(offset, endstr));
}
function SetCookie(name, value)
{ 

var expdate = new Date();
var argv = SetCookie.arguments;
var argc = SetCookie.arguments.length;
var expires = (argc > 2) ? argv[2] : null;
var path = (argc > 3) ? argv[3] : null;
var domain = (argc > 4) ? argv[4] : null;
var secure = (argc > 5) ? argv[5] : false;
if(expires!=null) expdate.setTime(expdate.getTime() + ( expires * 1000 ));
document.cookie = name + "=" + escape (value) +((expires == null) ? "" : ("; expires="+ expdate.toGMTString()))
+((path == null) ? "" : ("; path=" + path)) +((domain == null) ? "" : ("; domain=" + domain))
+((secure == true) ? "; secure" : "");
}

function DelCookie(name)
{ 
var exp = new Date();
exp.setTime (exp.getTime() - 1);
var cval = GetCookie (name);
document.cookie = name + "=" + cval + "; expires="+ exp.toGMTString();
}

function GetCookie(name)
{ 
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	while (i < clen)
	{
		var j = i + alen;
		if (document.cookie.substring(i, j) == arg)
			return GetCookieVal (j);
		i = document.cookie.indexOf(" ", i) + 1;
		if (i == 0) break;
	}
	return null;
}

function uploadComplete(){
  parent.uploadComplete();
}
</script>
</head>
<body>
    <input type="hidden" id="uploadCooieNum" value=""/>
    <script>			
        $j("#uploadCooieNum").val(GetCookie("maxUpload") || 5);
		
		
    </script>
    <input type="hidden" id="uploadPath" name="sitePath" value="<%=site%>/group/uploadResource.action"/>    
    <input type="hidden" id="groupId" name="groupId" value="<%=getGroupId%>"/>
    <input type="hidden" id="remainSpace" name="remainSpace" value="<%=getRemainSpace%>"/>
    <form id="form1" runat="server" style="height:100%">
    <div id="silverlightControlHost">
        <object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="100%">
		  <param name="source" value="FileSecurity.xap"/>
		  <param name="onError" value="onSilverlightError" />
		  <param name="background" value="white" />
		  <param name="minRuntimeVersion" value="4.0.50401.0" />
		  <param name="autoUpgrade" value="true" />
		  <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=4.0.50401.0" style="text-decoration:none">
 			  <img src="http://go.microsoft.com/fwlink/?LinkId=161376" alt="获取 Microsoft Silverlight" style="border-style:none"/>
		  </a>
	    </object><iframe id="_sl_historyFrame" style="visibility:hidden;height:0px;width:0px;border:0px"></iframe></div>
    </form>
</body>
</html>
