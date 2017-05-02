package com.dcampus.sys.service;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import javax.annotation.PostConstruct;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dcampus.common.config.Global;
import com.dcampus.common.generic.GenericDao;
import com.dcampus.common.service.BaseService;
import com.dcampus.sys.entity.EmailSetting;

/**
 * 电子邮件 service
 */
@Service
@Transactional(readOnly=false)
public class EmailService extends BaseService {

	@Autowired
	private GenericDao genericDao;
	
	private static EmailSetting emailSetting;
	private static JavaMailSenderImpl mailSender;
	
	@PostConstruct
	public void loadSetting() {
		emailSetting = getEmailSetting();
		mailSender = new JavaMailSenderImpl();
		mailSender.setHost(emailSetting.getMailHost());
		mailSender.setUsername(emailSetting.getMailAddress());
		mailSender.setPassword(emailSetting.getMailPassword());
		Properties propertys = new Properties();
		if (emailSetting.getAuthType() != null && emailSetting.getAuthType().length() > 0) {
			propertys.put(emailSetting.getAuthType(), "true");
		}
		mailSender.setJavaMailProperties(propertys);
	}
	
	/**
	 * 发送邮件
	 * @param email 目标邮箱
	 * @param topic  邮件标题
	 * @param body
	 */
	public void sendMail(final String toEmailAddress, final String title, final String bodyContent) {
		MimeMessagePreparator preparator = new MimeMessagePreparator() {
			public void prepare(MimeMessage mimeMessage) throws Exception {
				MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, emailSetting.getBodyEncoding());
				message.setFrom(new InternetAddress(emailSetting.getMailAddress(), emailSetting.getMailName(), emailSetting.getHeadEncoding()));
				message.setTo(toEmailAddress);
				message.setSubject(title);
				message.setText(bodyContent, true);
			}
		};
		mailSender.send(preparator);
	}

	//------------------------
	// 处理EmailSetting信息
	//--------------------------
	public EmailSetting getEmailSetting() {
		EmailSetting emailSetting = genericDao.findFirst("from EmailSetting");
		if (emailSetting == null) {
			emailSetting = new EmailSetting();
			genericDao.save(emailSetting);
		}
		return emailSetting;
	}
	public void updateEmailSetting(EmailSetting emailSetting) {
		genericDao.update(emailSetting);
		loadSetting();
	}
	
	public static void main(String[] args) {

		try {
			mailSender = new JavaMailSenderImpl();
			
			mailSender.setHost("smtp.163.com");
			mailSender.setUsername("blp365@163.com");
			mailSender.setPassword("blp123456");
			
			Properties propertys = new Properties();
				propertys.put("mail.smtp.auth", "true");
			mailSender.setJavaMailProperties(propertys);
	
			File file = new File("D:\\wfxu\\project_file\\workspace\\labtables\\webroot\\WEB-INF\\classes\\template\\emailEnabledAccount.properties");
			String result = FileUtils.readFileToString(file, "UTF-8");

			result = result.replaceAll("\\$\\{name\\}", "check");
			result = result.replaceAll("\\$\\{sendDate\\}", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			result = result.replaceAll("\\$\\{link\\}", "http://211.66.86.131:8888/labtables/member2Cms/enabledAccount?memberId=1&userId=1&phone=1");
			final String content = result;
			MimeMessagePreparator preparator = new MimeMessagePreparator() {
				public void prepare(MimeMessage mimeMessage) throws Exception {
					MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "utf-8");
					message.setFrom(new InternetAddress("blp365@163.com", "<亚热带重点实验室>", "UTF-8"));
					message.setTo("xuwf365@foxmail.com");
					message.setSubject("密码重置 - " + Global.getConfig("userUnit"));
					message.setText(content, true);
				}
			};
			mailSender.send(preparator);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("done!");
	}
}