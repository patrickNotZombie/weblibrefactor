package com.dcampus.sys.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dcampus.common.config.Global;
import com.dcampus.common.generic.GenericService;
import com.dcampus.common.web.BaseController;
import com.dcampus.sys.entity.Perm;
import com.dcampus.sys.service.UserService;

/**
 * 权限Controller
 */
@Controller
@RequiresPermissions("sys:perm")
@RequestMapping(value = Global.ADMIN_PATH + "/perm")
public class PermCtrl extends BaseController {

	@Autowired
	private GenericService genericService;
	@Autowired
	private UserService userService;

	@RequestMapping(value = "list")
	public String list(Perm perm, Integer status,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		List<Perm> list = genericService.findAll("from Perm order by id");
		model.addAttribute("list", list);
		return "sys/permList";
	}
	
	@RequestMapping(value = "delete")
	public String delete(String[] selectId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		if (selectId != null && selectId.length > 0) {
			List<Perm> deleteList = new ArrayList<Perm>();
			for (String id : selectId) {
				deleteList.add(new Perm(id));
			}
			try {
				userService.deletePerms(deleteList);
				addMessage(redirectAttributes, "删除操作成功。");
			} catch (Exception e) {
				addMessage(redirectAttributes, "删除操作失败：" + e.getLocalizedMessage());
			}
		} else {
			addMessage(redirectAttributes, "请选择要处理的记录！");
		}
		return "redirect:list";
	}
	
	@RequestMapping(value = "enabled")
	public String enabled(String[] selectId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		if (selectId != null && selectId.length > 0) {
			List<Perm> saveList = new ArrayList<Perm>();
			for (String id : selectId) {
				Perm item = userService.getPerm(id);
				if (item != null && item.getStatus() != Perm.Status_enabled) {
					item.setStatus(Perm.Status_enabled);
					saveList.add(item);
				}
			}
			try {
				if (saveList.size() > 0) {
					userService.savePerms(saveList);
				}
				addMessage(redirectAttributes, "操作成功。");
			} catch (Exception e) {
				addMessage(redirectAttributes, "操作失败：" + e.getLocalizedMessage());
			}
		} else {
			addMessage(redirectAttributes, "请选择要处理的记录！");
		}
		return "redirect:list";
	}
	
	@RequestMapping(value = "disabled")
	public String disabled(String[] selectId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		if (selectId != null && selectId.length > 0) {
			List<Perm> saveList = new ArrayList<Perm>();
			for (String id : selectId) {
				Perm item = userService.getPerm(id);
				if (item != null && item.getStatus() != Perm.Status_disabled) {
					item.setStatus(Perm.Status_disabled);
					saveList.add(item);
				}
			}
			try {
				if (saveList.size() > 0) {
					userService.savePerms(saveList);
				}
				addMessage(redirectAttributes, "操作成功。");
			} catch (Exception e) {
				addMessage(redirectAttributes, "操作失败：" + e.getLocalizedMessage());
			}
		} else {
			addMessage(redirectAttributes, "请选择要处理的记录！");
		}
		return "redirect:list";
	}

	@RequestMapping(value = "form")
	public String form(String permId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Perm perm = null;
		if (permId != null && permId.length() > 0) {
			perm = userService.getPerm(permId);
		}
		model.addAttribute("permId", permId);
		model.addAttribute("perm", perm);
		return "sys/permForm";
	}
	
	@RequestMapping(value = "save")
	public String save(String permId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Perm perm = null;
		if (permId != null && permId.length() > 0) {
			perm = userService.getPerm(permId);
		}
		if (perm == null) {
			perm = new Perm();
		}
		populate(perm, request);
		userService.savePerm(perm);
		permId = perm.getId();
		
		model.addAttribute("permId", permId);
		model.addAttribute("perm", perm);
		addMessage(redirectAttributes, "操作完成。");
		return "redirect:form?permId=" + perm.getId();
	}
	
	@ResponseBody
	@RequestMapping(value = "checkPermkey")
	public String checkPermkey(String oldPermkey, String key) {
		if (key != null && key.equals(oldPermkey)) {
			return "true";
		} else if (key != null && userService.getPermByKey(key) == null) {
			return "true";
		}
		return "false";
	}
}
