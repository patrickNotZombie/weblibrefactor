package com.dcampus.weblib.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.dcampus.common.persistence.BaseEntity;


/**
 * 站点设置
 * @author patrick
 *
 */
@Entity
@Table(name = "weblib_global")
public class Global extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id  
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 域名称 **/
	@Column(name="site_domain")
	private String siteDomain;

	/** 网站名字 **/
	@Column(name="site_name")
	private String siteName;

	/** 是否审核圈子 **/
	@Transient
	private boolean siteAuditgroup;
	
	@Column(name="site_auditgroup")
	private int isiteAuditgroup;

	/** 网站状态 **/
	@Column(name="site_status")
	private int isiteStatus;

	/** 网站统计代码 **/
	@Column(name="site_statcode")
	private String siteStatcode;

	/** 网站搜索引擎优化代码-关键字 **/
	@Column(name="site_seo_keywords")
	private String siteSeoKeywords;

	/** 网站搜索引擎优化代码-描述 **/
	@Column(name="site_seo_description")
	private String siteSeoDescription;

	/** 网站关闭原因 **/
	@Column(name="site_closereason")
	private String siteClosereason;

	/** smtp服务器 **/
	@Column(name="smtp_host")
	private String smtpHost;

	/** 邮件发送人姓名 **/
	@Column(name="smtp_sendername")
	private String smtpSendername;
	
	/** 发送人邮件 **/
	@Column(name="smtp_sender")
	private String smtpSender;

	/** smtp端口 **/
	@Column(name="smtp_port")
	private int smtpPort;

	/** smtp用户名 **/
	@Column(name="smtp_username")
	private String smtpUsername;

	/** smtp密码 **/
	@Column(name="smtp_password")
	private String smtpPassword;

	/** smtp是否验证 **/
	@Transient
	private boolean smtpAuth;
	
	/** smtp是否验证，供数据库使用 **/
	@Column(name="smtp_auth")
	private int ismtpAuth;

	/** 站点是否已经初始化 **/
	@Transient
	private boolean init;

	/** 站点是否已经初始化，供数据库使用 **/
	@Column(name="init")
	private String siteInit;

	/**是否允许跨柜复制*/
	@Column(name="copy_different_group")
	private boolean copyToDifferentGroup = true;
	
	/**是否允许跨柜移动*/
	@Column(name="move_different_group")
	private boolean moveToDifferentGroup = true;

	/**是否审核注册**/
	@Column(name="audit_client_register")
	private boolean auditClientRegister;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSiteCloseReason() {
		return siteClosereason;
	}
	
	public String getSiteDomain() {
		return siteDomain;
	}

	public String getSiteName() {
		return siteName;
	}

	public String getSiteSeoKeywords() {
		return siteSeoKeywords;
	}

	public String getSiteStatCode() {
		return siteStatcode;
	}

	public int getGlobalSiteStatus() {
		return isiteStatus;
	}

	public String getSmtpHost() {
		return smtpHost;
	}

	public String getSmtpPassword() {
		return smtpPassword;
	}

	public int getSmtpPort() {
		return smtpPort;
	}

	public String getSmtpSender() {
		return smtpSender;
	}

	public String getSmtpUsername() {
		return smtpUsername;
	}

	public boolean isSiteAuditGroup() {
		this.siteAuditgroup = isiteAuditgroup > 0;
		return siteAuditgroup;
	}

	public int getGlobalSiteAuditGroup() {
		return isiteAuditgroup;
	}

	public boolean isSmtpAuth() {
		this.smtpAuth = ismtpAuth > 0;
		return smtpAuth;
	}

	public int getGlobalSmtpAuth() {
		return ismtpAuth;
	}

	public void setSiteAuditGroup(boolean auditGroup) {
		this.siteAuditgroup = auditGroup;
		this.isiteAuditgroup = auditGroup ? 1 : 0;
	}

	public void setGlobalSiteAuditGroup(int auditGroup) {
		this.isiteAuditgroup = auditGroup;
		this.siteAuditgroup = auditGroup > 0;
	}

	public void setSiteCloseReason(String closeReason) {
		this.siteClosereason = closeReason;
	}

	public void setSiteDomain(String domain) {
		this.siteDomain = domain;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public void setSiteSeoKeywords(String seoKeywords) {
		this.siteSeoKeywords = seoKeywords;
	}

	public void setSiteStatCode(String statCode) {
		this.siteStatcode = statCode;
	}


	public void setGlobalSiteStatus(int status) {
		this.isiteStatus = status;
	}

	public void setSmtpAuth(boolean auth) {
		this.smtpAuth = auth;
		this.ismtpAuth = auth ? 1 : 0;
	}

	public void setGlobalSmtpAuth(int auth) {
		this.ismtpAuth = auth;
		this.smtpAuth = auth > 0;
	}

	public void setSmtpHost(String host) {
		this.smtpHost = host;
	}

	public void setSmtpPassword(String password) {
		this.smtpPassword = password;
	}

	public void setSmtpPort(int port) {
		this.smtpPort = port;
	}

	public void setSmtpSender(String sender) {
		this.smtpSender = sender;
	}

	public void setSmtpUsername(String username) {
		this.smtpUsername = username;
	}

	public String getSiteSeoDescription() {
		return siteSeoDescription;
	}

	public void setSiteSeoDescription(String seoDescription) {
		siteSeoDescription = seoDescription;
	}

	public String getSmtpSendername() {
		return smtpSendername;
	}

	public void setSmtpSendername(String smtp_sendername) {
		this.smtpSendername = smtp_sendername;
	}

	public boolean isInit() {
		return init;
	}

	public void setInit(boolean init) {
		this.init = init;

		this.siteInit = init ? "yes" : "no";
	}

	public String getSiteInit() {
		return siteInit;
	}

	public void setSiteInit(String site_Init) {
		siteInit = site_Init;

		this.init = "yes".equalsIgnoreCase(siteInit);
	}

	public boolean isCopyToDifferentGroup() {
		return copyToDifferentGroup;
	}

	public void setCopyToDifferentGroup(boolean copyToDifferentGroup) {
		this.copyToDifferentGroup = copyToDifferentGroup;
	}

	public boolean isMoveToDifferentGroup() {
		return moveToDifferentGroup;
	}

	public void setMoveToDifferentGroup(boolean moveToDifferentGroup) {
		this.moveToDifferentGroup = moveToDifferentGroup;
	}

	public boolean isAuditClientRegister(){
		return auditClientRegister;
	}

	public void setAuditClientRegister(boolean auditClientRegister){
		this.auditClientRegister = auditClientRegister;
	}
	
	
	
	
	

	public int getIsiteAuditgroup() {
		return isiteAuditgroup;
	}

	public void setIsiteAuditgroup(int auditGroup) {
		this.isiteAuditgroup = auditGroup;
		this.siteAuditgroup = auditGroup > 0;
	}

	
	
	public int getIsiteStatus() {
		return isiteStatus;
	}

	public void setIsiteStatus(int status) {
		this.isiteStatus = status;
	}
	
	

	public int getIsmtpAuth() {
		return ismtpAuth;
	}

	public void setIsmtpAuth(int auth) {
		this.ismtpAuth = auth;
		this.smtpAuth = auth > 0;
	}

	
	


}
