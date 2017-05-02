package com.dcampus.sys.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.dcampus.sys.entity.Role;
import com.dcampus.sys.entity.RolePerm;
import com.dcampus.sys.service.UserService;

/**
 * 角色Controller
 */
@Controller
@RequiresPermissions("sys:role")
@RequestMapping(value = Global.ADMIN_PATH + "/role")
public class RoleCtrl extends BaseController {

	@Autowired
	private GenericService genericService;
	@Autowired
	private UserService userService;

	@RequestMapping(value = "list")
	public String list(Role role, Integer status,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		List<Role> list = genericService.findAll("from Role order by name");
		model.addAttribute("list", list);
		return "sys/roleList";
	}

	@RequestMapping(value = "delete")
	public String delete(Integer[] selectId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		if (selectId != null && selectId.length > 0) {
			List<Role> deleteList = new ArrayList<Role>();
			for (Integer id : selectId) {
				deleteList.add(new Role(id));
			}
			try {
				userService.deleteRoles(deleteList);
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
	public String enabled(int[] selectId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		if (selectId != null && selectId.length > 0) {
			List<Role> saveList = new ArrayList<Role>();
			for (Integer id : selectId) {
				Role item = userService.getRole(id);
				if (item != null && item.getStatus() != Role.Status_enabled) {
					item.setStatus(Role.Status_enabled);
					saveList.add(item);
				}
			}
			try {
				if (saveList.size() > 0) {
					userService.saveRoles(saveList);
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
	public String disabled(int[] selectId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		if (selectId != null && selectId.length > 0) {
			List<Role> saveList = new ArrayList<Role>();
			for (Integer id : selectId) {
				Role item = userService.getRole(id);
				if (item != null && item.getStatus() != Role.Status_disabled) {
					item.setStatus(Role.Status_disabled);
					saveList.add(item);
				}
			}
			try {
				if (saveList.size() > 0) {
					userService.saveRoles(saveList);
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
	public String form(Integer roleId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Role role = null;
		if (roleId != null && roleId > 0) {
			role = userService.getRole(roleId);
		}
		model.addAttribute("roleId", roleId);
		model.addAttribute("role", role);
		return "sys/roleForm";
	}

	@RequestMapping(value = "save")
	public String save(Integer roleId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Role role = null;
		if (roleId != null && roleId > 0) {
			role = userService.getRole(roleId);
		}
		if (role == null) {
			role = new Role();
		}
		populate(role, request);
		userService.saveRole(role);
		roleId = role.getId();
		
		model.addAttribute("roleId", roleId);
		model.addAttribute("role", role);
		addMessage(redirectAttributes, "操作完成。");
		return "redirect:list";
	}
	
	@ResponseBody
	@RequestMapping(value = "checkRolename")
	public String checkRoleName(String oldRolename, String name) {
		if (name != null && name.equals(oldRolename)) {
			return "true";
		} else if (name != null && userService.getRoleByName(name) == null) {
			return "true";
		}
		return "false";
	}

	@RequestMapping(value = "rolePerm")
	public String rolePerm(Integer roleId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Role role = null;
		if (roleId != null && roleId > 0) {
			role = userService.getRole(roleId);
		}
		if (role == null) {
			addMessage(redirectAttributes, "找不到角色信息！");
			return "redirect:list";
		}
		
		model.addAttribute("roleId", roleId);
		model.addAttribute("role", role);
		model.addAttribute("permList", genericService.findAll("from Perm order by id"));
		Map<String, Boolean> rolePermMap = new HashMap<String, Boolean>();
		Set<RolePerm> rpSet = role.getRolePerms();
		if (rpSet != null) {
			for (RolePerm item : rpSet) {
				rolePermMap.put(item.getPerm().getId(), true);
			}
		}
		model.addAttribute("rolePermMap", rolePermMap);
		addMessage(redirectAttributes, "操作完成。");
		return "sys/rolePerm";
	}

	@RequestMapping(value = "rolePermSave")
	public String rolePermSave(Integer roleId, String[] selectId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Role role = null;
		if (roleId != null && roleId > 0) {
			role = userService.getRole(roleId);
		}
		if (role == null) {
			addMessage(redirectAttributes, "找不到角色信息！");
			return "redirect:list";
		}
		
		List<Perm> permList = new ArrayList<Perm>();
		for (String id : selectId) {
			permList.add(new Perm(id));
		}
		userService.refreshRolePerm(role.getId(), permList);
		
		addMessage(redirectAttributes, "操作完成。");
		return "redirect:rolePerm?roleId=" + role.getId();
	}
}
