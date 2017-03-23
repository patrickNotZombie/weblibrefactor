package com.dcampus.weblib.service;

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
public class MemberService extends BaseService{
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private UserBaseDao userBaseDao;
	
	/*******************************************用户验证开始*********************************************/


}
