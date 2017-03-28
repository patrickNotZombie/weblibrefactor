<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.*"%>
<%@page import="java.util.regex.*"%>
<%@page import="java.io.*"%>
<jsp:directive.page import="org.codehaus.xfire.service.*"/>
<jsp:directive.page import="org.codehaus.xfire.service.binding.ObjectServiceFactory"/>
<jsp:directive.page import="com.dcampus.user.webservice.I_ObjectService"/>
<jsp:directive.page import="org.codehaus.xfire.client.XFireProxyFactory"/>
<jsp:directive.page import="java.net.MalformedURLException"/>
<jsp:directive.page import="com.dcampus.groups.robot.SystemService"/>
<jsp:directive.page import="com.dcampus.groups.manager.IMemberManager"/>
<jsp:directive.page import="com.dcampus.groups.beans.IMemberBean"/>
<jsp:directive.page import="com.dcampus.user.webservice.*"/>
<jsp:directive.page import="com.dcampus.groups.userbase.bean.IUserBaseBean"/>
<jsp:directive.page import="com.dcampus.groups.userbase.bean.UserBaseBean"/>
<jsp:directive.page import="com.dcampus.groups.beans.impl.MemberBean"/>
<jsp:directive.page import="com.dcampus.groups.exception.GroupsException"/>
<%!

private static class WorkStatus{
    private static String WORKING = "正在导入";
    private static String FINISHED = "已完成";
    private static String CANCEL = "已取消";
    private static String READY = "准备";
    String status = READY;
    Thread thead = null;
    List<String> success = new ArrayList<String>();
    List<String> failed = new ArrayList<String>();
    List<String> missing = new ArrayList<String>();
    List<String> ignore = new ArrayList<String>();
    List<String> isolated = new ArrayList<String>();
    Set<String> colmns = new HashSet<String>();
    Set<String> dataColumns = new HashSet<String>();
	StringBuffer buf = new StringBuffer();
    void reset(){
	    success = new ArrayList<String>();
	    failed = new ArrayList<String>();
	    missing = new ArrayList<String>();
	    ignore = new ArrayList<String>();
	    isolated = new ArrayList<String>();
	    buf = new StringBuffer();
	    colmns= new HashSet<String>();
	    dataColumns = new HashSet<String>();
    }
}
private static class MyGroup {
	public I_Group group;
	public I_Group parent;
	
	public MyGroup() {
	}
}


private static List<MyGroup> listAllGroups(I_ObjectService service, I_Group parent)throws Exception {
	List<MyGroup> dataList = new ArrayList<MyGroup>();
	//获得下一层文件夹
	I_Group[] groups = service.getSubGroups(parent.getId());
	List<I_Group> list = Arrays.asList(groups);
	if (list != null && !list.isEmpty()) {
		//排序
		//标志下一层文件夹层数
		for(int i = 0, size = list.size(); i < size; i++){
			MyGroup column = new MyGroup();
			I_Group f = (I_Group)list.get(i);
			column.group = f;
			column.parent = parent;
			
			List<MyGroup> subList = listAllGroups(service, f);
			if (subList != null && !subList.isEmpty()) {
				//column.setLevel(1);
			}
			dataList.add(column);
			if (subList != null && !subList.isEmpty()) {
				dataList.addAll(subList);
			}
		}
	}
	return dataList;
}
private static WorkStatus workstatus = new WorkStatus();
private static void parse(I_ObjectService service) {
    
    IMemberManager imm = SystemService.getInstance().getMemberManager();
    try {
	    I_Group[] groups = service.getRootGroups();
	    for (I_Group group : groups) {
	    	List<MyGroup> aaGroups = listAllGroups(service, group);
	    	I_User[] users = service.getUsersByGroup(group.getId());
	    	for (I_User user : users) {
	    		try {
	    			imm.getAccount(user.getId());
	    		} catch (GroupsException ge) {
		    		try {
	    				register(imm, user);
	    				workstatus.ignore.add("创建用户"+user.getId());
	    			} catch (Exception ex) {
	    				workstatus.failed.add("创建["+user.getId()+"]失败"+ex.getMessage());
	    			}
	    		}
	    	}
	    	for (MyGroup g : aaGroups) {
	    		I_User[] userss = service.getUsersByGroup(g.group.getId());
	    		for (I_User user : userss) {
		    		try {
		    			imm.getAccount(user.getId());
		    		} catch (GroupsException ge) {
			    		workstatus.failed.add(ge.getMessage());
			    		try {
		    				register(imm, user);
		    				workstatus.ignore.add("创建用户"+user.getId());
		    			} catch (Exception ex) {
		    				workstatus.failed.add("创建["+user.getId()+"]失败"+ex.getMessage());
		    			}
		    		}
	    		}
	    	}
	    }
    } catch (Exception e) {
    }
	
}

private static IMemberBean register(IMemberManager imm, I_User user) throws Exception {
 		
	IUserBaseBean bean = new UserBaseBean();
	bean.setAccount(user.getId());
	bean.setPassword(user.getId()+""+System.currentTimeMillis());
	bean.setName(user.getName());
	//bean.setCompany(user.get);
	bean.setEmail(user.getMail());
	bean.setIm(user.getMsn());
	bean.setMobile(user.getMobilePhoneNumber());
	bean.setPhone(user.getPhoneNumber());
	bean.setCreateType(IUserBaseBean.CreateType.ADD);
	bean.setStatus(IUserBaseBean.Status.NORMAL);
	imm.createAccount(bean);

	// 默认注册一个同名马甲
	IMemberBean memberBean = new MemberBean();
	memberBean.setAccount(user.getId());
	memberBean.setName(user.getId());
	memberBean.setStatus(IMemberBean.Status.NORMAL);
	memberBean.setType(IMemberBean.Type.PERSON);
	imm.create(memberBean);
	return memberBean;
}
%><%

String action = request.getParameter("action");
if("导入".equals(action)){
    response.sendRedirect("_casUser.jsp");
	Service serviceModel = new ObjectServiceFactory().create(I_ObjectService.class);

	//String serviceURL = "http://cas.gzfda.gov.cn/services/UserObjectService";
	String serviceURL = "http://demo.cas.dcampus.com/services/UserObjectService";
	I_ObjectService service = null;
	
	
	
	try {
		service = (I_ObjectService) new XFireProxyFactory().create(serviceModel, serviceURL);
	} catch (MalformedURLException e) {
		e.printStackTrace();
	}
	
  	final I_ObjectService os = service;
    final WorkStatus ws = workstatus;
    workstatus.thead = new Thread(){
        public void run(){
           	parse(os);
            ws.status = WorkStatus.FINISHED;
        }
    };
    workstatus.thead.start();
    workstatus.status = WorkStatus.WORKING;
    return;
}else if("取消".equals(action)){
    response.sendRedirect("_casUser.jsp");

    try{
        workstatus.thead.stop();
    }catch(Exception e){
        e.printStackTrace();
    }
    workstatus.status = WorkStatus.CANCEL;
    return;
}else if("重新开始".equals(action)){
    response.sendRedirect("_casUser.jsp");

    workstatus.status = WorkStatus.READY;
    workstatus.reset();
    return;
}

%>
<html>
<head>
<title>从 cas 导入 用户数据</title>
<%if(workstatus.status == WorkStatus.WORKING){%><script type="text/javascript">
setTimeout(function(){
	window.location.href = location.href
}, 5000);
</script><%} %>
</head>
<body>
<form method="post">
<%if(workstatus.status == WorkStatus.READY){ 
	
%>

<input type="submit" name="action" value="导入" />
<%}else{ %>
状态：<%=workstatus.status%>&nbsp;&nbsp;<%if(workstatus.status == WorkStatus.WORKING){ %><input type="submit" name="action" value="取消" /><%}
else { %><input type="submit" name="action" value="重新开始" />
<br/>

<ul>
<li>记录：<%=workstatus.ignore.size() %></li>
<li><ul>
<%for(String item : workstatus.ignore) {%><li><%=item%></li><%} %>
</ul></li>
</ul>

<%} %>
导入成功：[<%=workstatus.success.size() %>] &nbsp;&nbsp;导入失败：[<%=workstatus.failed.size() %>] <br/>
<ul>
<li>失败记录：<%=workstatus.failed.size() %></li>
<li><ul>
<%for(String item : workstatus.failed) {%><li><%=item%></li><%} %>
</ul></li>
</ul>
<%} %>
</form>
</body>
</html>