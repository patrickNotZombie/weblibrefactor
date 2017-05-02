package com.dcampus.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dcampus.common.generic.GenericService;
import com.dcampus.common.persistence.Page;
import com.dcampus.common.util.StringUtils;
import com.dcampus.common.web.BaseController;
import com.dcampus.sys.entity.Message;
import com.dcampus.sys.entity.User;
import com.dcampus.sys.service.MessageService;
import com.dcampus.sys.service.UserService;
import com.dcampus.sys.util.UserUtils;

/**
 * 登录用户Controller
 * @author ThinkGem
 * @version 2013-3-23
 */
@Controller
@RequiresUser
@RequestMapping(value = "/principal")
public class principalCtrl extends BaseController {

	@Autowired
	private GenericService genericService;
	@Autowired
	private UserService userService;
	@Autowired
	private MessageService messageService;

	//--------------------------------------------------------------------------------
	// principal
	//--------------------------------------------------------------------------------

	@RequestMapping(value = "")
	public String indexPrinical(Model model) {
		User user = UserUtils.getUser();
		model.addAttribute("user", user);
		return "sys/indexPrincipal";
	}
	
	@RequestMapping(value = "info")
	public String info(Model model) {
		User user = UserUtils.getUser(true);
		model.addAttribute("user", user);
		return "sys/principalInfo";
	}

	@RequestMapping(value = "form")
	public String editInfo(Model model) {
		User user = UserUtils.getUser(true);
		model.addAttribute("user", user);
		return "sys/principalForm";
	}
	
	@RequestMapping(value = "save")
	public String editSave(
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		
		User user = UserUtils.getUser(true);
		populate(user, request);
		userService.saveUser(user);
		addMessage(redirectAttributes, "修改用户信息成功。");
		return "redirect:form";
	}

	//--------------------------------------------------------------------------------
	// password
	//--------------------------------------------------------------------------------
	/**
	 * 密码首页
	 */
	@RequestMapping(value = "indexPassword")
	public String indexPassword(Model model) {
		User user = UserUtils.getUser();
		model.addAttribute("user", user);
		return "sys/indexPassword";
	}

	@RequestMapping(value = "password")
	public String passwordInfo(Model model) {
		User user = UserUtils.getUser();
		model.addAttribute("user", user);
		return "sys/principalPassword";
	}
	
	@RequestMapping(value = "password/save")
	public String passwordSave(String username, String oldPassword, String newPassword,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		
		User user = UserUtils.getUser();
		if (!user.getUsername().equals(username)) {
			model.addAttribute("user", user);
			addMessage(model, "用户账号错误，请填写本用户账号！");
			return "sys/principalPassword";
		} else if (StringUtils.isNotBlank(oldPassword) && StringUtils.isNotBlank(newPassword)){
			if (UserService.validatePassword(oldPassword, user.getPassword())){
				userService.updatePasswordById(user.getId(), user.getUsername(), newPassword);
				addMessage(redirectAttributes, "修改密码成功。");
				return "redirect:/principal/password";
			}else{
				model.addAttribute("user", user);
				addMessage(model, "用户账号错误，修改密码失败，旧密码错误！");
				return "sys/principalPassword";
			}
		}
		return null;
	}

	//--------------------------------------------------------------------------------
	// message
	//--------------------------------------------------------------------------------
	@RequestMapping(value = "message/list")
	public String messageList(
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Page<Message> page = genericService.findPage(new Page<Message>(request, response),
				"from Message where toUserId=? order by createTime desc", UserUtils.getUserId());
		model.addAttribute("page", page);
		return "sys/principalMessageList";
	}

	@RequestMapping(value = "message/info")
	public String messageInfo(Integer messageId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Message messageObj = messageService.readMessage(messageId, UserUtils.getUserId(), UserUtils.getUsername());
		model.addAttribute("messageObj", messageObj);
		return "sys/principalMessageInfo";
	}
}
