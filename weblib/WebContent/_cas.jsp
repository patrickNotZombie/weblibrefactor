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
<jsp:directive.page import="com.dcampus.groups.service.IService"/>
<jsp:directive.page import="com.dcampus.groups.service.ServiceManager"/>
<jsp:directive.page import="com.dcampus.groups.service.GuestService"/>
<jsp:directive.page import="com.dcampus.groups.service.UserService"/>
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
	public int level=1;
	public MyGroup() {
	}
}


private static List<MyGroup> listAllGroups(I_ObjectService service, I_Group parent, int level)throws Exception {
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
			column.level = level+1;
			List<MyGroup> subList = listAllGroups(service, f, level+1);
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

private static Map<String, Boolean> sortAllGroups(List<MyGroup> list)throws Exception {
	Map<String, Boolean> map = new HashMap<String, Boolean>();
	for (MyGroup my : list) {
		map.put(my.group.getId(), false);
		if (my.parent != null && map.containsKey(my.parent.getId())) {
			map.put(my.group.getId(), true);
		}
	}
	return map;
}
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
private static WorkStatus workstatus = new WorkStatus();
private static void parse(I_ObjectService service, long dir) {
	Set<String> set = new HashSet<String>();
	I_User[] i_users = null;
    try {
    	i_users = service.getUsersByRole("WEBLIB");
    	if (i_users != null) {
    		for (I_User u : i_users) {
    			set.add(u.getId());
    		}
    	}
    } catch (Exception e) {
    	workstatus.failed.add("无法获取WEBLIB角色");
    	return;
    }
    
    IMemberManager imm = SystemService.getInstance().getMemberManager();
    Map<String, Long> idMap = new HashMap<String, Long>();
    try {
	    I_Group[] groups = service.getRootGroups();
	    for (I_Group group : groups) {
	    	List<MyGroup> aaGroups = listAllGroups(service, group, 1);
	    	I_User[] users = service.getUsersOfGroup(group.getId());
	    	
	    	IMemberBean team = null;
	    	IMemberBean folder = null;
	    	
	    	String com = group.getName();
	    	//本用户组
	    	if (aaGroups.isEmpty()) {
	    		try {
		    		//创建用户组
	    			team = imm.createTeam(dir, group.getName(), false);
	    			workstatus.ignore.add("创建用户组"+group.getName());
	    		}catch (Exception ex) {
	    			workstatus.failed.add("创建用户组"+group.getName()+"失败。"+ex.getMessage());
	    		}
	    	} else {
	    		//创建组织
	    		try {
	    			folder = imm.createFolder(dir, group.getName());
	    			idMap.put(group.getId(), folder.getId());
	    			workstatus.ignore.add("创建组织"+group.getName());
	    		}catch (Exception ex) {
	    			workstatus.failed.add("创建组织"+group.getName()+"失败。"+ex.getMessage());
	    			return;
	    		}
	    	}
	    	//如果有用户，
	    	if (users.length > 0 && team == null && folder != null) {
	    		//建一个同名的用户组
	    		try {
		    		//创建用户组
	    			team = imm.createTeam(folder.getId(), group.getName(), false);
	    			workstatus.ignore.add("创建用户组"+group.getName());
	    		}catch (Exception ex) {
	    			workstatus.failed.add("创建用户组"+group.getName()+"失败。"+ex.getMessage());
	    		}
	    	}
	    	if (team != null) {
	    		for (I_User user : users) {
	    			if (!set.contains(user.getId())) {
	    				continue;
	    			}
	    			try {
		    			imm.getAccount(user.getId());
		    		} catch (GroupsException ge) {
			    		try {
			    			
			    			if (folder != null) {
			    				com = folder.getSignature();
			    			}
		    				register(imm, user, com, team.getSignature());
		    				workstatus.ignore.add("创建用户"+user.getId());
		    			} catch (Exception ex) {
		    				workstatus.failed.add("创建["+user.getId()+"]失败"+ex.getMessage());
		    			}
		    		}
		    		try {
		    			IMemberBean mem = imm.getMember(user.getId(), user.getId());
						    			
		    			imm.addMemberToTeam(mem.getId(), team.getId());
		    		}catch (Exception ex) {
		    			workstatus.failed.add("绑定用户"+user.getId()+"失败。"+ex.getMessage());
		    		}
		    	}
	    	}
	    	//添加子用户组
	    	Map<String, Boolean> map = sortAllGroups(aaGroups);
	    	
	    	for (MyGroup myGroup : aaGroups) {
	    		I_Group agroup = myGroup.group;
	    		I_User[] ausers = service.getUsersOfGroup(agroup.getId());
		    	IMemberBean ateam = null;
		    	IMemberBean afolder = null;
		    	
		    	long parentId = idMap.get(myGroup.parent.getId());
		    	String dep = agroup.getName();
		    	//没有子用户组
		    	if (!map.get(agroup.getId()).booleanValue()) {
		    		try {
			    		//创建用户组
		    			ateam = imm.createTeam(parentId, agroup.getName(), false);
		    			workstatus.ignore.add("创建用户组"+agroup.getName());
		    		}catch (Exception ex) {
		    			workstatus.failed.add("创建用户组"+agroup.getName()+"失败。"+ex.getMessage());
		    		}
		    	} else {
		    		//创建组织
		    		try {
		    			afolder = imm.createFolder(parentId, agroup.getName());
		    			idMap.put(agroup.getId(), afolder.getId());
		    			workstatus.ignore.add("创建组织"+agroup.getName());
		    		}catch (Exception ex) {
		    			workstatus.failed.add("创建用户组"+agroup.getName()+"失败。"+ex.getMessage());
		    			return;
		    		}
		    	}
		    	//如果有用户，
		    	if (ausers.length > 0 && ateam == null && afolder != null) {
		    		//建一个同名的用户组
		    		try {
			    		//创建用户组
		    			ateam = imm.createTeam(afolder.getId(), agroup.getName(), false);
		    			workstatus.ignore.add("创建用户组"+group.getName());
		    		}catch (Exception ex) {
		    			workstatus.failed.add("创建用户组"+group.getName()+"失败。"+ex.getMessage());
		    		}
		    	}
		    	if (ateam != null) {
		    		for (I_User user : ausers) {
		    			if (!set.contains(user.getId())) {
		    				continue;
		    			}
		    			try {
			    			imm.getAccount(user.getId());
			    		} catch (GroupsException ge) {
				    		try {
			    				register(imm, user, com, dep);
			    				workstatus.ignore.add("创建用户"+user.getId());
			    			} catch (Exception ex) {
			    				workstatus.failed.add("创建["+user.getId()+"]失败"+ex.getMessage());
			    			}
			    		}
			    		try {
			    			IMemberBean mem = imm.getMember(user.getId(), user.getId());
			    			imm.addMemberToTeam(mem.getId(), ateam.getId());
			    		}catch (Exception ex) {
			    			workstatus.failed.add("绑定用户"+user.getId()+"失败。"+ex.getMessage());
			    		}
			    	}
		    	}
	    	}
	    	
	    	
	    }
    } catch (Exception e) {
    	workstatus.failed.add(e.getMessage());
    }
	
}

private static IMemberBean register(IMemberManager imm, I_User user, String company, String department) throws Exception {
	IUserBaseBean bean = new UserBaseBean();
	bean.setAccount(user.getId());
	bean.setPassword(user.getId()+""+System.currentTimeMillis());
	bean.setName(user.getName());
	bean.setCompany(company);
	bean.setEmail(user.getMail());
	bean.setIm(user.getMsn());
	bean.setMobile(user.getMobilePhoneNumber());
	bean.setPhone(user.getPhoneNumber());
	bean.setCreateType(IUserBaseBean.CreateType.ADD);
	bean.setStatus(IUserBaseBean.Status.NORMAL);
	bean.setDepartment(department);
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
String local = request.getServerName();
IService serv = getService(session);
long mid = serv.getUserData().getMemberId();
boolean access = "127.0.0.1".equals(local) || serv.getPermissionManager().isAdmin(mid) 
						|| serv.getPermissionManager().isSuperAdmin(mid);
if (access) {
	String action = request.getParameter("action");
	if("in".equals(action)){
	    response.sendRedirect("_cas.jsp");
		IMemberManager imm = SystemService.getInstance().getMemberManager();
		IMemberBean[] memberBeans = imm.getFolderByParent(0);
		long id = 0;
		for(IMemberBean m : memberBeans){
			if ("广州市食品药品监督管理局".equals(m.getSignature().trim())) {
				id = m.getId();
			}
		}
		if (id > 0) {
			Service serviceModel = new ObjectServiceFactory().create(I_ObjectService.class);
	
			//String serviceURL = "http://cas.gzfda.gov.cn/services/UserObjectService";
			String serviceURL = "http://demo.cas.dcampus.com/services/UserObjectService";
			I_ObjectService service = null;
			
			
			try {
				service = (I_ObjectService) new XFireProxyFactory().create(serviceModel, serviceURL);
			} catch (MalformedURLException e) {
				e.printStackTrace();
			}
			
		    final long dir = id;
		    final I_ObjectService os = service;
		    final WorkStatus ws = workstatus;
		    workstatus.status = WorkStatus.READY;
	    	workstatus.reset();
		    workstatus.thead = new Thread(){
		        public void run(){
		           parse(os, dir);
		            ws.status = WorkStatus.FINISHED;
		        }
		    };
		    workstatus.thead.start();
		    workstatus.status = WorkStatus.WORKING;
		    return;
		}
		
	}else if("no".equals(action)){
	    response.sendRedirect("_cas.jsp");
	
	    try{
	        workstatus.thead.stop();
	    }catch(Exception e){
	        e.printStackTrace();
	    }
	    workstatus.status = WorkStatus.CANCEL;
	    return;
	}else if("reset".equals(action)){
	    response.sendRedirect("_cas.jsp");
	
	    workstatus.status = WorkStatus.READY;
	    workstatus.reset();
	    return;
	}
}
%>
<html>
<head>
<title>从 cas 导入 用户数据</title>
<%if(workstatus.status == WorkStatus.WORKING){%><script type="text/javascript">
setTimeout(function(){
	window.location.href = '_cas.jsp'
}, 5000);
</script><%} %>
</head>
<body>
<%if (access) { %>
<form method="post">
<%if(workstatus.status == WorkStatus.READY){ 
	
%>
<input type="hidden" name="action" value="in" />
<input type="submit" name="actionBT" value="导入" />
<%}else{ %>
状态：<%=workstatus.status%>&nbsp;&nbsp;<%if(workstatus.status == WorkStatus.WORKING){ %><input type="hidden" name="action" value="no" /><input type="submit" name="actionBT" value="取消" /><%}
else { %><input type="hidden" name="action" value="reset" /><input type="submit" name="actionBT" value="重新开始" />
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
<%} %>
</body>
</html>