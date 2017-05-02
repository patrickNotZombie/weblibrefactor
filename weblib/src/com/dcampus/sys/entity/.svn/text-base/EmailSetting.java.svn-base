package com.dcampus.sys.entity;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.dcampus.common.persistence.BaseEntity;

/**
 * email设置
 * @author wfxu
 */
@Entity
@Table(name="sys_email_setting")
public class EmailSetting extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	
	/** freeMarker模板编码 */
	@Column(name="free_marker_encoding")
	private String freeMarkerEncoding;

	/** 发件人名称 */
	@Column(name="mail_name")
	private String mailName;

	/** 发件人邮箱地址 */
	@Column(name="mail_address")
	private String mailAddress;

	/** 发件人邮箱服务器账号密码 */
	@Column(name="mail_password")
	private String mailPassword;

	/** 发件人邮箱服务器 */
	@Column(name="mail_host")
	private String mailHost;

	/** 验证类别 */
	@Column(name="auth_type")
	private String authType = AuthType_smtp;

	/** 邮件头编码 */
	@Column(name="head_encoding")
	private String headEncoding;

	/** 邮件正文编码 */
	@Column(name="body_encoding")
	private String bodyEncoding;

			
	public static final String AuthType_smtp = "mail.smtp.auth";
	
	public EmailSetting() {
	}
	
	public static Map<String, String> getAuthTypeMap() {
		Map<String, String> result = new LinkedHashMap<String, String>();
		result.put(AuthType_smtp, AuthType_smtp);
		return result;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFreeMarkerEncoding() {
		return freeMarkerEncoding;
	}

	public void setFreeMarkerEncoding(String freeMarkerEncoding) {
		this.freeMarkerEncoding = freeMarkerEncoding;
	}

	public String getMailName() {
		return mailName;
	}

	public void setMailName(String mailName) {
		this.mailName = mailName;
	}

	public String getMailAddress() {
		return mailAddress;
	}

	public void setMailAddress(String mailAddress) {
		this.mailAddress = mailAddress;
	}

	public String getMailHost() {
		return mailHost;
	}

	public void setMailHost(String mailHost) {
		this.mailHost = mailHost;
	}

	public String getMailPassword() {
		return mailPassword;
	}

	public void setMailPassword(String mailPassword) {
		this.mailPassword = mailPassword;
	}

	public String getHeadEncoding() {
		return headEncoding;
	}

	public void setHeadEncoding(String headEncoding) {
		this.headEncoding = headEncoding;
	}

	public String getBodyEncoding() {
		return bodyEncoding;
	}

	public void setBodyEncoding(String bodyEncoding) {
		this.bodyEncoding = bodyEncoding;
	}

	public String getAuthType() {
		return authType;
	}

	public void setAuthType(String authType) {
		this.authType = authType;
	}
}
