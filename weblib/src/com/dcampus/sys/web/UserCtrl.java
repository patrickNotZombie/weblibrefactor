package com.dcampus.sys.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dcampus.common.config.Global;
import com.dcampus.common.generic.GenericService;
import com.dcampus.common.persistence.Page;
import com.dcampus.common.util.StringUtils;
import com.dcampus.common.web.BaseController;
import com.dcampus.sys.entity.LogOper;
import com.dcampus.sys.entity.Role;
import com.dcampus.sys.entity.User;
import com.dcampus.sys.entity.UserRole;
import com.dcampus.sys.service.LogService;
import com.dcampus.sys.service.UserService;
import com.dcampus.sys.util.UserUtils;

/**
 * 用户Controller
 */
@Controller
@RequiresPermissions("sys:user")
@RequestMapping(value = Global.ADMIN_PATH + "/user")
public class UserCtrl extends BaseController {

	@Autowired
	private GenericService genericService;
	@Autowired
	private UserService userService;
	@Autowired
	private LogService logService;

	@RequestMapping(value = "")
	public String index(
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		return "sys/indexUser";
	}

	@RequestMapping(value = "list")
	public String list(User user, Integer status,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		StringBuffer hql = new StringBuffer();
		List<Object> paramList = new ArrayList<Object>();
		hql.append("from User where 1=? ");
		paramList.add(1);
		if (StringUtils.isNotBlank(user.getUsername())) {
			hql.append(" and username like ? ");
			paramList.add("%" + user.getUsername().trim() + "%");
		}
		if (StringUtils.isNotBlank(user.getName())) {
			hql.append(" and name like ? ");
			paramList.add("%" + user.getName().trim() + "%");
		}
		if (status != null && status > 0) {
			hql.append(" and status=? ");
			paramList.add(user.getStatus());
		}
		hql.append(" order by username ");
		Page<User> page = genericService.findPage(new Page<User>(request, response), hql.toString(), paramList.toArray());
		model.addAttribute("page", page);
		model.addAttribute("search", user);
		model.addAttribute("status", status);
		return "sys/userList";
	}

	@RequestMapping(value = "delete")
	public String delete(Integer[] selectId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		if (selectId != null && selectId.length > 0) {
			List<User> deleteList = new ArrayList<User>();
			for (Integer id : selectId) {
				deleteList.add(new User(id));
			}
			try {
				userService.deleteUsers(deleteList);
				//删除日志操作写入有问题，需要改进
				logService.addSuccessLogOper(LogOper.OperType_Delete, "删除用户"+deleteList.iterator().next().getId(), 
						request.getRemoteUser()+"删除用户"+deleteList, getRemoteIP(request), request.getRequestURI());
				addMessage(redirectAttributes, "操作成功。");
			} catch (Exception e) {
				addMessage(redirectAttributes, "操作失败：" + e.toString());
				logService.addFailureLogOper(LogOper.OperType_Delete, "删除用户"+deleteList.iterator().next().getId(), 
						request.getRemoteUser()+"删除用户"+deleteList, getRemoteIP(request), request.getRequestURI());
			}
		} else {
			addMessage(redirectAttributes, "请选择要处理的记录！");
		}
		return "redirect:list";
	}

	@RequestMapping(value = "enabled")
	public String enabled(Integer[] selectId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		if (selectId != null && selectId.length > 0) {
			List<User> saveList = new ArrayList<User>();
			for (Integer id : selectId) {
				User item = userService.getUser(id);
				if (item != null && item.getStatus() != User.Status_enabled) {
					item.setStatus(User.Status_enabled);
					saveList.add(item);
				}
			}
			try {
				if (saveList.size() > 0) {
					userService.saveUsers(saveList);
				}
				addMessage(redirectAttributes, "操作成功。");
			} catch (Exception e) {
				addMessage(redirectAttributes, "操作失败：" + e.toString());
			}
		} else {
			addMessage(redirectAttributes, "请选择要处理的记录！");
		}
		return "redirect:list";
	}

	@RequestMapping(value = "disabled")
	public String disabled(Integer[] selectId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		if (selectId != null && selectId.length > 0) {
			List<User> saveList = new ArrayList<User>();
			for (Integer id : selectId) {
				User item = userService.getUser(id);
				if (item != null && item.getStatus() != User.Status_disabled) {
					item.setStatus(User.Status_disabled);
					saveList.add(item);
				}
			}
			try {
				if (saveList.size() > 0) {
					userService.saveUsers(saveList);
				}
				addMessage(redirectAttributes, "操作成功。");
			} catch (Exception e) {
				addMessage(redirectAttributes, "操作失败：" + e.toString());
			}
		} else {
			addMessage(redirectAttributes, "请选择要处理的记录！");
		}
		return "redirect:list";
	}

	@RequestMapping(value = "form")
	public String form(Integer userId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		User user = null;
		if (userId != null && userId > 0) {
			user = userService.getUser(userId);
		}
		model.addAttribute("userId", userId);
		model.addAttribute("user", user);
		return "sys/userForm";
	}

	@RequestMapping(value = "save")
	public String save(Integer userId, String newPassword,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		boolean editMode = true;
		User user = null;
		if (userId != null && userId > 0) {
			user = userService.getUser(userId);
		}
		if (user == null) {
			user = new User();
			editMode = false;
		}
		populate(user, request);
		//新增时验证账号是否已被使用
		if (!editMode && userService.getUserByUsername(user.getUsername()) != null) {
			addMessage(redirectAttributes, "操作失败：用户账号【" + user.getUsername() + "】已被使用。");
			return "redirect:form?userId=" + user.getId();
		}
		
		if (newPassword != null && newPassword.length() > 0) {
			user.setPassword(userService.entryptPassword(newPassword));
		}
		userService.saveUser(user);
		userId = user.getId();
		
		model.addAttribute("userId", userId);
		model.addAttribute("user", user);
		addMessage(redirectAttributes, "操作完成。");
		return "redirect:form?userId=" + user.getId();
	}
	
	@ResponseBody
	@RequestMapping(value = "checkUsername")
	public String checkLoginName(String oldUsername, String username) {
		if (username != null && username.equals(oldUsername)) {
			return "true";
		} else if (username != null && userService.getUserByUsername(username) == null) {
			return "true";
		}
		return "false";
	}

	@RequestMapping(value = "userRole")
	public String userRole(Integer userId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		User user = null;
		if (userId != null && userId > 0) {
			user = userService.getUser(userId);
		}
		if (user == null) {
			addMessage(redirectAttributes, "找不到用户信息！");
			return "redirect:list";
		}
		
		model.addAttribute("userId", userId);
		model.addAttribute("user", user);
		model.addAttribute("roleList", genericService.findAll("from Role order by name"));
		Map<Integer, Boolean> userRoleMap = new HashMap<Integer, Boolean>();
		Set<UserRole> urSet = user.getUserRoles();
		if (urSet != null) {
			for (UserRole item : urSet) {
				userRoleMap.put(item.getRole().getId(), true);
			}
		}
		model.addAttribute("userRoleMap", userRoleMap);
		addMessage(redirectAttributes, "操作完成。");
		return "sys/userRole";
	}

	@RequestMapping(value = "userRoleSave")
	public String userRoleSave(Integer userId, Integer[] selectId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		User user = null;
		if (userId != null && userId > 0) {
			user = userService.getUser(userId);
		}
		if (user == null) {
			addMessage(redirectAttributes, "找不到用户信息！");
			return "redirect:list";
		}
		
		List<Role> roleList = new ArrayList<Role>();
		if (selectId != null) {
			for (Integer id : selectId) {
				roleList.add(new Role(id));
			}
		}
		userService.refreshUserRole(user.getId(), roleList);
		
		addMessage(redirectAttributes, "操作完成。");
		return "redirect:userRole?userId=" + user.getId();
	}
	
	//导入用户跳转，提交需要修改
	@RequestMapping(value="importuser")
	private String importuser(Model model,RedirectAttributes redirectAttributes,
			HttpServletRequest request,HttpServletResponse response){
		User user = UserUtils.getUser();
		if(user!=null){
			model.addAttribute("user", user);
			return "sys/importDes";
		}else{
			return "http://lms.ccnl.scut.edu.cn";
		}		
	}
	
	//导入用户操作函数
	@RequestMapping(value="importuserAction")
	private String importuserAction(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Integer userId = UserUtils.getUserId();
		User user = userService.getUser(userId);
		List<String> messages = new ArrayList<String>();
		if(user==null){
			model.addAttribute("message", "对不起，你不是管理员，无权操作！");
			//System.out.println( "对不起，你不是管理员，无权操作！");
			messages.add("用户为空，对不起，你不是管理员，无权操作！");
			model.addAttribute("messages", messages);
			return "sys/importDes";
		}
		//获取导入用户文件
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Iterator<String>  it = multipartRequest.getFileNames();
		String impFilename = it.next();
		MultipartFile impFile = multipartRequest.getFile(impFilename);
		
		//将上传的文档保存到服务上
		String filename = impFile.getOriginalFilename();
		if(filename.isEmpty()){
			model.addAttribute("message", "您未选择导入文档，请选择文档！");
			return "sys/importDes";
		}
		String suffix = filename.substring(filename.lastIndexOf(".")+1);	
		String filepath = System.currentTimeMillis()+user.getUsername()+filename.substring(filename.lastIndexOf("."));
		File file = FileUtils.getFile(Global.getFileRootPath(),filepath);
		if(!suffix.equals("xls")){
			model.addAttribute("message", "您选择的文件不是Excel(xls后缀)格式，请重新选择文件！");
			//messages.add("您上传的文档不是excel格式；或上传的excel文档为空，请添加数据后，重新上传！");
			//model.addAttribute("messages", messages);
			return "sys/importDes";
		}			
		try {
			impFile.transferTo(file);
		} catch (Exception e) {
			// TODO: handle exception
			model.addAttribute("message", "文件出错。");
			messages.add("上传文件出错，请重新上传！");
			e.printStackTrace();
		}
		
		//读取xls文档中的数据
		Workbook book =null;
		try {
			InputStream is = new FileInputStream(file);		
			book = Workbook.getWorkbook(is);
			Sheet sheet = book.getSheet(0);
			int rows = sheet.getRows();
			if(rows<3){
				model.addAttribute("message", "您选择的文件没有可添加的数据，请添加数据后，再选择要导入数据的文件！");
				return "sys/importDes";
			}
			User newuser = null;
			for(int k =2 ;k < rows;k++){
				newuser = userService.getUserByUsername(sheet.getCell(0, k).getContents());			
				if(newuser == null){
					
					//获取行中每列的数据
					//0帐号(学生-学号；教师-工号；其他用户-帐号)，1姓名，2密码，3用户状态，4院系或部门编号
					//5职务(没有字段，需要添加)
					String username = sheet.getCell(0, k).getContents().trim();
					String name = sheet.getCell(1, k).getContents();
					//String password = sheet.getCell(2, k).getContents().trim();
					String password = "123456";
					Integer ustatus = Integer.parseInt(sheet.getCell(2, k).getContents());
					String department = sheet.getCell(3, k).getContents();
					String phone = sheet.getCell(5, k).getContents().trim();
					
					newuser = new User();
					if(!username.isEmpty()){
						newuser.setUsername(username);
						newuser.setName(name);					
						newuser.setPassword(userService.entryptPassword(password));			
						newuser.setStatus(ustatus);
						newuser.setDepartment(department);
						if(!phone.isEmpty()){
							newuser.setPhone(phone);
						}
						newuser.setCreateTime(new Date());
					
						userService.saveUser(newuser);
						//添加操作日志
						logService.addSuccessLogOper(LogOper.OperType_Add, user.getName()+"添加账户"+username, user.getName()+"添加账户"+username, 
								getRemoteIP(request), request.getRequestURI());
					}else {
						messages.add(name+"的帐号为空，请重新导入，或者另行单独添加！");
					}
				}else{
					String result = sheet.getCell(0, k).getContents()+sheet.getCell(1, k).getContents();
					logService.addFailureLogOper(LogOper.OperType_Add, "添加用户"+result, result+"用户已存在，无需添加！", 
							getRemoteIP(request), request.getRequestURI());
					messages.add(result+"用户已存在,无需再添加！");
				}
			}
		} catch (BiffException e) {
			// TODO Auto-generated catch block	
			e.printStackTrace();			
			model.addAttribute("message", "导入失败！");
			messages.add("导入失败！");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("message", "导入失败！");
			messages.add("导入失败！");
		}
		messages.add("导入成功！");
		model.addAttribute("messages", messages);
		
		return "sys/importDes";
	}
	
	//获取客户的真是IP地址
	public String getRemoteIP(HttpServletRequest request){
		if(request.getHeader("x-forward-for")==null){
			return request.getRemoteAddr();
		}
		return request.getHeader("x-forward-for");
	}
	
	
}
