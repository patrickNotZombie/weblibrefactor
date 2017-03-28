<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.dcampus.groups.service.IService"%>
<%@page import="com.dcampus.groups.service.ServiceManager"%>
<%@page import="com.dcampus.groups.service.UserService"%>
<%@page import="com.dcampus.groups.service.GuestData"%>
<%@page import="com.dcampus.groups.manager.permission.IPermission"%>
<%@page import="com.dcampus.groups.service.GuestService"%>
<% 
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
%> 
<%!
private static IService getService(HttpSession session){
    Object o = session.getAttribute(ServiceManager.SERVICE_KEY);
	if(o == null)
		return GuestService.getInstance();
	
	try{
		return (UserService)o;
	}catch(ClassCastException e){
		//may be LdapService
	}
	
	return GuestService.getInstance();
}
%>

<% 

String loginStatus;
long memberID= 0;
Boolean isLogin = false;
Object service = session.getAttribute(ServiceManager.SERVICE_KEY);
if(service == null) {
	loginStatus = "Guest";
}	
else{
	UserService userService = (UserService)service;
	memberID = userService.getUserData().getMemberId();
	//IService service = ServiceManager.getService();
	if(userService.getUserData().getMemberId() == GuestData.getInstance().getMemberId()) 
	{
	   loginStatus = "Ldap";
	}
	else {
		loginStatus = "Member";
	}
}
if(loginStatus != "Guest" && loginStatus != "Ldap") {
   isLogin = true;
}

%>
