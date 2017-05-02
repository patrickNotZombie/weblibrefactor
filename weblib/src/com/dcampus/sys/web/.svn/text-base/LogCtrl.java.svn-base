package com.dcampus.sys.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dcampus.common.config.Global;
import com.dcampus.common.generic.GenericService;
import com.dcampus.common.persistence.Page;
import com.dcampus.common.util.StringUtils;
import com.dcampus.common.web.BaseController;
import com.dcampus.sys.entity.LogExcep;
import com.dcampus.sys.entity.LogOper;
import com.dcampus.sys.service.LogService;
/**
 * 日志Controller
 */
@Controller
@RequiresUser
@RequestMapping(value = Global.ADMIN_PATH + "/log")
public class LogCtrl extends BaseController {

	@Autowired
	private LogService logService;
	@Autowired
	private GenericService genericService;

	@RequestMapping(value = "")
	public String index(
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		return "sys/indexLog";
	}

	@RequiresPermissions("sys:logOper")
	@RequestMapping(value = "logOper/list")
	public String operList(String operType, String content,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		StringBuffer hql = new StringBuffer();
		List<Object> paramList = new ArrayList<Object>();
		hql.append("from LogOper where 1=? ");
		paramList.add(1);
		if (StringUtils.isNotBlank(content)) {
			hql.append(" and content like ? ");
			paramList.add("%" + content.trim() + "%");
		}
		if (StringUtils.isNotBlank(operType)) {
			hql.append(" and operType=? ");
			paramList.add(operType);
		}
		hql.append(" order by logTime desc ");
		Page<LogOper> page = genericService.findPage(new Page<LogOper>(request, response), hql.toString(), paramList.toArray());
		model.addAttribute("page", page);
		model.addAttribute("operType", operType);
		model.addAttribute("content", content);
		return "sys/logOperList";
	}

	@RequiresPermissions("sys:logOper")
	@RequestMapping(value = "logOper/detail")
	public String operDetail(Integer logOperId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		LogOper logOper = null;
		if (logOperId != null && logOperId > 0) {
			logOper = genericService.get(LogOper.class, logOperId);
		}
		model.addAttribute("logOperId", logOperId);
		model.addAttribute("logOper", logOper);
		return "sys/logOperDetail";
	}

	@RequiresPermissions("sys:logOper")
	@RequestMapping(value = "logOper/clear")
	public String operClear(
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		logService.clearLogOper();
		addMessage(redirectAttributes, "操作完成。");
		return "redirect:list";
	}
	
	@RequiresPermissions("sys:logExcep")
	@RequestMapping(value = "logExcep/list")
	public String excepList(
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		StringBuffer hql = new StringBuffer();
		List<Object> paramList = new ArrayList<Object>();
		hql.append("from LogExcep where 1=? ");
		paramList.add(1);
		hql.append(" order by logTime desc ");
		Page<LogOper> page = genericService.findPage(new Page<LogOper>(request, response), hql.toString(), paramList.toArray());
		model.addAttribute("page", page);
		return "sys/logExcepList";
	}

	@RequiresPermissions("sys:logExcep")
	@RequestMapping(value = "logExcep/detail")
	public String excepDetail(Integer logExcepId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		LogExcep logExcep = null;
		if (logExcepId != null && logExcepId > 0) {
			logExcep = genericService.get(LogExcep.class, logExcepId);
		}
		model.addAttribute("logExcepId", logExcepId);
		model.addAttribute("logExcep", logExcep);
		return "sys/logExcepDetail";
	}

	@RequiresPermissions("sys:logExcep")
	@RequestMapping(value = "logExcep/clear")
	public String excepClear(
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		logService.clearLogExcep();
		addMessage(redirectAttributes, "操作完成。");
		return "redirect:list";
	}
}
