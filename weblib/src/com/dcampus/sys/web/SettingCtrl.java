package com.dcampus.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dcampus.common.config.Global;
import com.dcampus.common.generic.GenericService;
import com.dcampus.common.web.BaseController;
import com.dcampus.sys.entity.EmailSetting;
import com.dcampus.sys.service.EmailService;

/**
 * 系统配置Ctrl
 * @author wfxu
 *
 */
@Controller
@RequiresPermissions("sys:setting")
@RequestMapping(value = Global.ADMIN_PATH + "/setting")
public class SettingCtrl extends BaseController {

	@Autowired
	private EmailService emailService;
	@Autowired
	private GenericService genericService;
	
	@RequestMapping(value = "")
	public String index(
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		return "sys/indexSetting";
	}

	@RequestMapping(value = "email")
	public String email(
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		EmailSetting emailSetting = emailService.getEmailSetting();
		model.addAttribute("emailSetting", emailSetting);
		model.addAttribute("authTypeMap", EmailSetting.getAuthTypeMap());
		return "sys/emailSetting";
	}

	@RequestMapping(value = "email/save")
	public String emailSave(
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		EmailSetting emailSetting = emailService.getEmailSetting();
		populate(emailSetting, request);
		emailService.updateEmailSetting(emailSetting);
		addMessage(redirectAttributes, "操作成功。");
		return "redirect:" + Global.ADMIN_PATH + "/setting/email";
	}
	
}
