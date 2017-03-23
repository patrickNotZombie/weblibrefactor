package com.dcampus.weblib.web.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dcampus.common.service.BaseService;
import com.dcampus.weblib.dao.AdminDao;
import com.dcampus.weblib.dao.MemberDao;
import com.dcampus.weblib.dao.UserBaseDao;
import com.dcampus.weblib.util.JsonUtil;

/**
 * 用户处理action，包括用户登录认证与密码的修改<br>
 * 
 * 只实现了的本地登录，没做ladp和cas登录
 * 
 * @author patrick
 *
 */
@Controller
@RequestMapping(value = "/user")
public class MemberCtrl extends BaseService{
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private UserBaseDao userBaseDao;
	
	/*******************************************用户验证开始*********************************************/
	/**
	 * 用户登录<br> 
	 * 
	 * 
	 *简单地本地认证，之后应该加入其他认证方式的支持
	 * @param model
	 * @param redirectAttributes
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="authenticate", produces = "application/json; charset=UTF-8")
	public String authenticate(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response){
		String account = ServletRequestUtils.getStringParameter(request, "account", "");
		String password = ServletRequestUtils.getStringParameter(request, "password", "");
		String casAccount = ServletRequestUtils.getStringParameter(request, "casAccount", "");
		JsonUtil ju = new JsonUtil();
		StringBuffer returnStr = new StringBuffer();
		
		String authType = null;
		if (casAccount == null || casAccount == "" ){
			authType = "local";
			Boolean result = userBaseDao.checkAccount(account, password);
			if (result){
				return "{\"result\":\"success\"}";
			}
		}
		
		return "{\"result\":\"fail\"}";
		
		//return returnStr.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="authYZM", produces = "application/json; charset=UTF-8")
	public String authYZM(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response){
		JsonUtil ju = new JsonUtil();
		StringBuffer returnStr = new StringBuffer();
		
		return returnStr.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="casLogin", produces = "application/json; charset=UTF-8")
	public String casLogin(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response){
		JsonUtil ju = new JsonUtil();
		StringBuffer returnStr = new StringBuffer();
		
		return returnStr.toString();
	}
	
	
	@ResponseBody
	@RequestMapping(value="portalLogin", produces = "application/json; charset=UTF-8")
	public String portalLogin(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response){
		JsonUtil ju = new JsonUtil();
		StringBuffer returnStr = new StringBuffer();
		
		return returnStr.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="selectMember", produces = "application/json; charset=UTF-8")
	public String selectMember(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response){
		JsonUtil ju = new JsonUtil();
		StringBuffer returnStr = new StringBuffer();
		
		return returnStr.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="logout", produces = "application/json; charset=UTF-8")
	public String logout(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response){
		JsonUtil ju = new JsonUtil();
		StringBuffer returnStr = new StringBuffer();
		
		return returnStr.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="casLogout", produces = "application/json; charset=UTF-8")
	public String casLogout(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response){
		JsonUtil ju = new JsonUtil();
		StringBuffer returnStr = new StringBuffer();
		
		return returnStr.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="remotinglogin", produces = "application/json; charset=UTF-8")
	public String remotinglogin(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response){
		JsonUtil ju = new JsonUtil();
		StringBuffer returnStr = new StringBuffer();
		
		return returnStr.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="cryptlogin", produces = "application/json; charset=UTF-8")
	public String cryptlogin(Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request, HttpServletResponse response){
		JsonUtil ju = new JsonUtil();
		StringBuffer returnStr = new StringBuffer();
		
		return returnStr.toString();
	}
	/*******************************************用户验证结束*********************************************/

}

