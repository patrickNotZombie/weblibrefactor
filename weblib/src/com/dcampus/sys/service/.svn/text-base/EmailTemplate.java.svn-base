package com.dcampus.sys.service;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.io.ClassPathResource;

public class EmailTemplate {
	
	private static Log log = LogFactory.getLog(EmailTemplate.class);
	
	/**找回密码邮件模板*/
	private static String emailResetPassword;
	
	/**找回账号邮件模板*/
	private static String emailEnabledAccount;
	
	/** 开放研究基金课题审核邮件模板 */
	private static String emailLabtableApplyAudit;

	private static DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	static {
		try {
			File file = new ClassPathResource("/template/emailResetPassword.properties").getFile();
			emailResetPassword = FileUtils.readFileToString(file, "UTF-8");
			
			file = new ClassPathResource("/template/emailEnabledAccount.properties").getFile();
			emailEnabledAccount = FileUtils.readFileToString(file, "UTF-8");

			file = new ClassPathResource("/template/emailLabtableApplyAudit.properties").getFile();
			emailLabtableApplyAudit = FileUtils.readFileToString(file, "UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e, e);
		}
	}

	public static String getEmailEnabledAccountContent(String name, String link) {
		String result = new String(emailEnabledAccount);
		result = result.replaceAll("\\$\\{name\\}", name);
		result = result.replaceAll("\\$\\{sendDate\\}", dateFormat.format(new Date()));
		result = result.replaceAll("\\$\\{link\\}", link);
		return result;
	}

	public static String getEmailResetPasswordContent(String account, String link) {
		String result = new String(emailResetPassword);
		result = result.replaceAll("\\$\\{account\\}", account);
		result = result.replaceAll("\\$\\{sendDate\\}", dateFormat.format(new Date()));
		result = result.replaceAll("\\$\\{link\\}", link);
		return result;
	}
	
	public static String getEmailLabtableApplyAuditContent(String name, String labTableName, String auditString, String addString, String link) {
		String result = new String(emailLabtableApplyAudit);
		result = result.replaceAll("\\$\\{name\\}", name);
		result = result.replaceAll("\\$\\{labTableName\\}", labTableName);
		result = result.replaceAll("\\$\\{auditString\\}", auditString);
		result = result.replaceAll("\\$\\{addString\\}", addString);
		result = result.replaceAll("\\$\\{link\\}", link);
		result = result.replaceAll("\\$\\{sendDate\\}", dateFormat.format(new Date()));
		return result;
	}

	public static void main(String[] args) {
	}
}
