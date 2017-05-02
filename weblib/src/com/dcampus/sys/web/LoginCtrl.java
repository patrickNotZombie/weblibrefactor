package com.dcampus.sys.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.edu.scut.cas.client.Util;

import com.dcampus.common.config.Global;
import com.dcampus.common.generic.GenericService;
import com.dcampus.common.web.BaseController;
import com.dcampus.lms.lms.entity.Course;
import com.dcampus.lms.lms.service.CourseService;
import com.dcampus.lms.lms.service.StudentService;
import com.dcampus.lms.lms.service.TeacherService;
import com.dcampus.lms.lms.web.AccountJsonCtrl;
import com.dcampus.sys.entity.User;
import com.dcampus.sys.security.CasUsernamePasswordToken;
import com.dcampus.sys.security.HtmlUsernamePasswordToken;
import com.dcampus.sys.service.UserService;
import com.dcampus.sys.util.UserUtils;

/**
 * 登录Controller
 * 
 * @author ThinkGem
 * @version 2013-3-23
 */
@Controller
public class LoginCtrl extends BaseController {
	private static final Logger logger = Logger.getLogger(LoginCtrl.class);
	@Autowired
	private GenericService genericService;
	@Autowired
	private UserService userService;
	@Autowired
	private CourseService courseService;
	@Autowired
	private TeacherService teacherService;
	@Autowired
	private StudentService studentService;

	@RequestMapping(value = "index")
	public String index(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Integer userId = 0;
		try{
			userId = UserUtils.getUserId();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		User user = userService.getUser(userId);
		Subject currentUser = SecurityUtils.getSubject();
		String redirectUrl = "course/list";
		// 判断是否登录，如果登录，则将user存入model中
		if (userId != null && userId > 0) {
			model.addAttribute("userId", userId);
			model.addAttribute("user", userService.getUser(userId));

			if(currentUser.hasRole("admin") ||user.getUsername().equals("mis")){
				redirectUrl = "sys/adminIndex";
			}else{
				redirectUrl = "login";
			}
			
		}
		return redirectUrl;
	}

	/**
	 * cas登录
	 */
	@RequestMapping(value = "/casLogin", method = RequestMethod.GET)
	public String casLogin(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Subject currentUser = SecurityUtils.getSubject();
		if (!currentUser.isAuthenticated()) {
			String username = (String) request.getSession().getAttribute(
					"cas.client.user");
			if (username == null || username.trim().length() == 0) {
				return "casLoginFailure";
			}
			User user = userService.getUserByUsername(username);
			if (user == null) {
				user = new User();
				user.setName(username);
				user.setUsername(username);
				user.setPassword(UserService.entryptPassword(username));
				userService.saveOrUpdateUser(user);
			}
			try {
				currentUser.login(new CasUsernamePasswordToken(user
						.getUsername(), user.getPassword(), true));

			} catch (Exception e) {
				currentUser.logout();
				return "casLoginFailure";
			}
		}
		return "redirect:/loginAssign";
	}
	
	/**
	 * html异步登录
	 */
	@ResponseBody
	@RequestMapping(value = "/htmlLogin", method = RequestMethod.GET)
	public String htmlLogin(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Subject currentUser = SecurityUtils.getSubject();
		String username = ServletRequestUtils.getStringParameter(request, "username", "");
		String password = ServletRequestUtils.getStringParameter(request, "password", "");
		if (!currentUser.isAuthenticated()) {
			//logger.info("username=" + username + ";password=" + password);
			try {
				currentUser.login(new HtmlUsernamePasswordToken(username,password, true));

			} catch (Exception e) {
				currentUser.logout();
				logger.info(e.toString());
				return "{\"result\":\"failed\"}";
			}
		}
		return "{\"result\":\"success\"}";
	}

	/**
	 * html异步判断是否登录
	 */
	@ResponseBody
	@RequestMapping(value = "/htmlIfLogin", method = RequestMethod.GET)
	public String htmlIfLogin(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Subject currentUser = SecurityUtils.getSubject();
		if (!currentUser.isAuthenticated()) {
			return "{\"result\":\"failed\"}";
		}else{
			return "{\"result\":\"success\",\"username\":\"" + UserUtils.getUsername() + "\"}";
		}
	}
	
	/**
	 * 管理登录
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		if (UserUtils.getUser() != null) {
			return "redirect:/loginAssign";
		} else {
			return "login";
		}
	}

//	/**
//	 * 登录失败，真正登录的POST请求由Filter完成
//	 */
//	@RequestMapping(value = "/login", method = RequestMethod.POST)
//	public String login(
//			@RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String userName,
//			Model model) {
//		model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM,
//				userName);
//		return "login";
//	}

	@RequiresUser
	@RequestMapping(value = "/noAccessRole")
	public String noAccessRole(Model model) {
		return "redirect:/index";
	}

	/**
	 * 登录成功，进入用户类型主页分派
	 */
	@RequiresAuthentication
	@RequestMapping(value = "/loginAssign")
	public String loginAssign(RedirectAttributes redirectAttributes) {
		// 则用户能够通过shiro的校验，但是User对象为空
		if (UserUtils.getUser() == null) {
			SecurityUtils.getSubject().logout();
			return "redirect:/login";
		}
		return "redirect:/index";
		/*
		 * if (user.getUserType().equals(User.UserType_Manager)) {//有管理员角色信息
		 * return "redirect:" + Global.ADMIN_PATH + "/table1"; } else if
		 * (user.getUserType().equals(User.UserType_Member1)) {//拥有内部科研人员登录
		 * return "redirect:" + Global.MEMBER1_PATH + "/table/list"; } else if
		 * (user.getUserType().equals(User.UserType_Member2)) {//拥有外部科研人员 return
		 * "redirect:" + Global.MEMBER2_PATH + "/table/list"; } else { return
		 * "redirect:/noAccessRole"; }
		 */
	}
	/**
	 * 登录退出，返回用户登录界面
	 */
	@RequiresUser
	@RequestMapping(value="/logout")
	public String logout(RedirectAttributes redirectAttributes){
		if(UserUtils.getUser() != null){
			SecurityUtils.getSubject().logout();
		}
		return "redirect:/login";
	}
	
	/**
	 * 登录退出，返回用户登录界面
	 */
	@RequiresUser
	@ResponseBody
	@RequestMapping(value="/htmlLogout")
	public String htmlLogout(){
		if(UserUtils.getUser() != null){
			SecurityUtils.getSubject().logout();
		}
		return "{\"result\":\"success\"}";
	}
	 
}