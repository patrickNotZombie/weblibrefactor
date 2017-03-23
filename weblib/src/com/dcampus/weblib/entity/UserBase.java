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
 * 用户信息类
 * 
 * 
 * @author patrick
 *
 */
@Entity
@Table(name = "weblib_userbase")
public class UserBase extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**用户状态，正常，删除，未审核*/
//	public static enum Status {
//		NORMAL("normal"), DELETE("delete"),UNAUDIT("unAudit");
//
//		private String name;
//
//		private Status(String name) {
//			this.name = name;
//		}
//
//		public String getName() {
//			return name;
//		}
//
//		public static Status transform(String name) {
//			if ("normal".equalsIgnoreCase(name))
//				return NORMAL;
//			else if("delete".equalsIgnoreCase(name))
//				return DELETE;
//			else
//				return UNAUDIT;
//		}
//	}
	/**用户状态，正常*/
	private static final String 	USER_STATUS_NORMAL = "normal";	
	/**用户状态，删除*/
	private static final String 	USER_STATUS_DELETE = "delete";
	/**用户状态，未审核*/
	private static final String 	USER_STATUS_UNAUDIT = "unAudit";
	
	/**用户创建类型，增加，注册*/
//	public static enum CreateType {
//		ADD("add"),REGISTER("register");
//		private String name;
//		private CreateType(String name){
//			this.name = name;
//		}
//		public String getName(){
//			return name;
//		}
//		public static CreateType transform(String name){
//			if("add".equalsIgnoreCase(name))
//				return ADD;
//			else
//				return REGISTER;
//		}
//	}
	/**用户创建类型，增加*/
	private static final String USER_CREATE_TYPE_ADD = "add";
	/**用户创建类型，注册*/
	private static final String USER_CREATE_TYPE_REGISTER = "register";
	

//	/**获取公钥是否可用*/
//	public static enum IsAvailable {
//		TRUE("true"), FALSE("false");
//
//		private String name;
//
//		private IsAvailable(String name) {
//			this.name = name;
//		}
//
//		public String getName() {
//			return name;
//		}
//
//		public static IsAvailable transform(String name) {
//			if ("true".equalsIgnoreCase(name))
//				return TRUE;
//			else
//				return FALSE;
//		}
//	}
	/**获取公钥是否可用,可用*/
	private static final String USER_PUBLICKEY_IS_AVILIABLE = "true";
	/**获取公钥是否可用,不可用*/
	private static final String USER_PUBLICKEY_NOT_AVILIABLE = "false";
	
	
	/** 用户id **/
	@Id  
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 用户名 **/
	private String account;

	/** 用户密码 **/
	private String password;

	/** 用户姓名 **/
	private String name;

	/** 所在单位 **/
	private String company;

	/** 所在部门 **/
	private String department;

	/** 职位 */
	private String position;

	/** 用户邮箱 **/
	private String email;

	/** 用户电话 **/
	private String phone;

	/** 用户手机 **/
	private String mobile;

	/** 用户IM **/
	private String im;

	/** 用户状态，用于与数据交互 **/
	@Column(name="`status`")
	private String userbaseStatus;

	
	/** 用户创建类型，用于与数据交互 **/
	@Column(name="`create_type`")
	private String userCreateType;

	// ////////////////////////////////////////////////////////////
	/** 用户公钥 **/
	@Column(name = "public_key")
	private String publicKey;

	/** 用户私钥 **/
	@Column(name = "private_key")
	private String privateKey;

	/** 用户序列码 **/
	@Column(name = "serial_number")
	private String serialNumber;


	/** 用户公钥是否可用，用于与数据库交互 **/
	@Column(name="is_available")
	private String userbaseIsAvailable;
	
	/**应用名称**/
	@Column(name = "app_name")
	private String appName;

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getAccount() {
		return account;
	}

	public Integer getId() {
		return id;
	}

	public String getPassword() {
		return password;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUserbaseStatus() {
		return userbaseStatus;
	}

	public void setUserbaseStatus(String userbaseStatus) {
		this.userbaseStatus = userbaseStatus;
	}

	public String getUserCreateType() {
		return userCreateType;
	}

	public void setUserCreateType(String userCreateType) {
		this.userCreateType = userCreateType;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getIm() {
		return im;
	}

	public void setIm(String im) {
		this.im = im;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getPublicKey() {
		return publicKey;
	}

	public void setPublicKey(String publicKey) {
		this.publicKey = publicKey;
	}

	public String getPrivateKey() {
		return privateKey;
	}

	public void setPrivateKey(String privateKey) {
		this.privateKey = privateKey;
	}

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}


	public String getUserbaseIsAvailable() {
		return userbaseIsAvailable;
	}

	public void setUserbaseIsAvailable(String userbaseIsAvailable) {
		this.userbaseIsAvailable = userbaseIsAvailable;
	}

	

}
