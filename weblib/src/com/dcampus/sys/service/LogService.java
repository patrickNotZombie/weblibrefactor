package com.dcampus.sys.service;

import java.util.Calendar;
import java.util.Date;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dcampus.common.generic.GenericDao;
import com.dcampus.common.service.BaseService;
import com.dcampus.common.util.DateUtils;
import com.dcampus.sys.entity.LogExcep;
import com.dcampus.sys.entity.LogOper;
import com.dcampus.sys.security.Principal;

/**
 * 日志service
 */
@Service
@Transactional(readOnly=false)
public class LogService extends BaseService {

	@Autowired
	private GenericDao genericDao;
	
	//------------------------------------------------------------
	// LogExcep
	//-----------------------------------------------------------
	/**
	 * 增加异常日志
	 */
	public void addLogExcep(String content) {
		genericDao.save(new LogExcep(content));
	}
	/**
	 * 清空dates天以前的所有异常日志
	 */
	public void clearLogExcep(int dates) {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 0 - dates);
		Date date = DateUtils.getBeginOfDate(cal.getTime());
		genericDao.update("delete from LogExcep where logTime<=?", date);
	}
	public void clearLogExcep() {
		genericDao.update("delete from LogExcep");
	}

	//------------------------------------------------------------
	// LogOper
	//-----------------------------------------------------------

	public void addSuccessLogOper(String operType, String content, String resultContent, String operIp, String OperUri) {
		LogOper log = new LogOper();
		log.setLogTime(new Date());
		log.setSuccess(true);
		log.setOperType(operType);
		log.setContent(content);
		log.setResultContent(resultContent);
		
		Principal principal = (Principal) SecurityUtils.getSubject().getPrincipal();
		log.setOperAccount(principal.getUsername());
		log.setOperName(principal.getName());
		log.setOperIp(operIp);
		log.setOperUri(OperUri);
		genericDao.save(log);
	}
	public void addFailureLogOper(String operType, String content, String resultContent, String operIp, String OperUri) {
		LogOper log = new LogOper();
		log.setLogTime(new Date());
		log.setSuccess(false);
		log.setOperType(operType);
		log.setContent(content);
		log.setResultContent(resultContent);
		
		Principal principal = (Principal) SecurityUtils.getSubject().getPrincipal();
		log.setOperAccount(principal.getUsername());
		log.setOperName(principal.getName());
		log.setOperIp(operIp);
		log.setOperUri(OperUri);
		genericDao.save(log);
	}
	
	public void clearLogOper(int dates) {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 0 - dates);
		Date date = DateUtils.getBeginOfDate(cal.getTime());
		genericDao.update("delete from LogOper where logTime<=?", date);
	}
	public void clearLogOper() {
		genericDao.update("delete from LogOper");
	}
	
	//----------------------------------
	// 工具方法
	//-------------------------------------
	public static String getExcpetionHtmlString(Throwable exception, int row) {
		StringBuffer result = new StringBuffer(exception.toString() + "<br/>");
		int index = 0;
		for (StackTraceElement item : exception.getStackTrace()) {
			result.append(item.toString() + "<br/>");
			index++;
			if (row > 0 && index == row) {
				break;
			}
		}
		return result.toString();
	}
	public static String getExcpetionHtmlString(Throwable exception) {
		return getExcpetionHtmlString(exception, 0);
	}
}
