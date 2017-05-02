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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dcampus.common.config.Global;
import com.dcampus.common.generic.GenericService;
import com.dcampus.common.persistence.Page;
import com.dcampus.common.util.StringUtils;
import com.dcampus.common.web.BaseController;
import com.dcampus.sys.entity.Dict;
import com.dcampus.sys.service.DictService;
import com.dcampus.sys.util.DictUtils;

/**
 * 数据字典Controller
 */
@Controller
@RequiresPermissions("sys:dict")
@RequestMapping(value = Global.ADMIN_PATH + "/dict")
public class DictCtrl extends BaseController {

	@Autowired
	private DictService dictService;
	@Autowired
	private GenericService genericService;

	@RequestMapping(value = "")
	public String index(
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		return "sys/indexDict";
	}
	
	//搜索列表(字典)，并通过type/code排列
	@RequestMapping(value = "list")
	public String list(Dict dict,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		StringBuffer hql = new StringBuffer();
		List<Object> paramList = new ArrayList<Object>();
		hql.append("from Dict where 1=?");
		paramList.add(1);
		if (StringUtils.isNotBlank(dict.getType())) {
			hql.append(" and type=? ");
			paramList.add(dict.getType().trim());
		}
		if (StringUtils.isNotBlank(dict.getName())) {
			hql.append(" and name like ? ");
			paramList.add("%" + dict.getName().trim() + "%");
		}
		if (StringUtils.isNotBlank(dict.getNameEn())) {
			hql.append(" and nameEn like ? ");
			paramList.add("%" + dict.getNameEn().trim() + "%");
		}
	/*	if (dict.getStatus() > 0) {
			hql.append(" and status=? ");
			paramList.add(dict.getStatus());
		}*/
		hql.append(" order by type, code ");
		Page<Dict> page = genericService.findPage(new Page<Dict>(request, response), hql.toString(), paramList.toArray());
		model.addAttribute("page", page);
		model.addAttribute("search", dict);
		return "sys/dictList";
	}

	@RequestMapping(value = "delete")
	public String delete(int[] selectId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		if (selectId != null && selectId.length > 0) {
			List<Dict> deleteList = new ArrayList<Dict>();
			for (Integer id : selectId) {
				deleteList.add(new Dict(id));
			}
			try {
				dictService.deleteDicts(deleteList);
				DictUtils.removeCache();
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
			List<Dict> saveList = new ArrayList<Dict>();
			for (Integer id : selectId) {
				Dict item = dictService.getDictById(id);
				if (item != null && item.getStatus() != Dict.Status_enabled) {
					item.setStatus(Dict.Status_enabled);
					saveList.add(item);
				}
			}
			try {
				if (saveList.size() > 0) {
					dictService.saveDicts(saveList);
					DictUtils.removeCache();
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
			List<Dict> saveList = new ArrayList<Dict>();
			for (Integer id : selectId) {
				Dict item = dictService.getDictById(id);
				if (item != null && item.getStatus() != Dict.Status_disabled) {
					item.setStatus(Dict.Status_disabled);
					saveList.add(item);
				}
			}
			try {
				if (saveList.size() > 0) {
					dictService.saveDicts(saveList);
					DictUtils.removeCache();
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
	
	@RequestMapping(value = "removeCache")
	public String removeCache(
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			DictUtils.removeCache();
			addMessage(redirectAttributes, "操作成功。");
		} catch (Exception e) {
			addMessage(redirectAttributes, "操作失败：" + e.getLocalizedMessage());
		}
		return "redirect:list";
	}

	@RequestMapping(value = "form")
	public String form(Integer dictId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Dict dict = null;
		if (dictId != null && dictId > 0) {
			dict = dictService.getDictById(dictId);
		}
		model.addAttribute("dictId", dictId);
		model.addAttribute("dict", dict);
		return "sys/dictForm";
	}
	
	@RequestMapping(value = "save")
	public String save(Integer dictId,
			Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response) {
		Dict dict = null;
		if (dictId != null && dictId > 0) {
			dict = dictService.getDictById(dictId);
		}
		if (dict == null) {
			dict = new Dict();
		}
		populate(dict, request);
		dictService.saveDict(dict);
		dictId = dict.getId();

		DictUtils.removeCache();
		
		model.addAttribute("dictId", dictId);
		model.addAttribute("dict", dict);
		addMessage(redirectAttributes, "操作完成。");
		return "redirect:form?dictId=" + dict.getId();
	}
}
