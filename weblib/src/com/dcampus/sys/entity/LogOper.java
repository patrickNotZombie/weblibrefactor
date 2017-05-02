package com.dcampus.sys.entity;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.dcampus.common.persistence.BaseEntity;

/**
 * 用户操作日志，业务记录
 */
@Entity
@Table(name = "sys_log_oper")
public class LogOper extends BaseEntity {

	private static final long serialVersionUID = 1L;

	/** 操作类型：增加对象 */
	public static final String OperType_Add = "Add";
	/** 操作类型：修改对象 */
	public static final String OperType_Edit = "Edit";
	/** 操作类型：删除对象 */
	public static final String OperType_Delete = "Delete";
	/** 操作类型：综合操作 */
	public static final String OperType_Multiple = "Multiple";

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 操作时间 */
	@Column(name="log_time")
	private Date logTime;

	/** 操作类型 */
	@Column(name="oper_type")
	private String operType = OperType_Multiple;
	
	/** 操作内容描述, 80字符以内 */
	@Column(name="content")
	private String content;

	/** 本次操作的结果  如果系统异常则增加显示异常信息, 1000字符以内 */
	@Column(name="result_content", length=4000)
	@Basic(fetch=FetchType.LAZY)
	private String resultContent;
	
	/** 本次操作的结果   true:成功完成，没有系统异常   false:系统异常 */
	private Boolean success = true;

	/** 操作人账号 */
	@Column(name="oper_account")
	private String operAccount;

	/** 操作人姓名 */
	@Column(name="oper_name")
	private String operName;

	/** 操作机器的ip */
	@Column(name="oper_ip")
	private String operIp;

	/** 操作页面路径 */
	@Column(name="oper_uri")
	private String operUri;
	
	public LogOper() {
	}

	public LogOper(Integer id) {
		this.id = id;
	}
	
	public static Map<String, String> getOperTypeMap() {
		Map<String, String> resultMap = new LinkedHashMap<String, String>();
		resultMap.put(OperType_Add, "增加");
		resultMap.put(OperType_Edit, "修改");
		resultMap.put(OperType_Delete, "删除");
		resultMap.put(OperType_Multiple, "综合 ");
		return resultMap;
    }


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getLogTime() {
		return logTime;
	}

	public void setLogTime(Date logTime) {
		this.logTime = logTime;
	}

	public String getOperType() {
		return operType;
	}

	public void setOperType(String operType) {
		this.operType = operType;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getResultContent() {
		return resultContent;
	}

	public void setResultContent(String resultContent) {
		this.resultContent = resultContent;
	}

	public Boolean getSuccess() {
		return success;
	}

	public void setSuccess(Boolean success) {
		this.success = success;
	}

	public String getOperAccount() {
		return operAccount;
	}

	public void setOperAccount(String operAccount) {
		this.operAccount = operAccount;
	}

	public String getOperName() {
		return operName;
	}

	public void setOperName(String operName) {
		this.operName = operName;
	}

	public String getOperIp() {
		return operIp;
	}

	public void setOperIp(String operIp) {
		this.operIp = operIp;
	}

	public String getOperUri() {
		return operUri;
	}

	public void setOperUri(String operUri) {
		this.operUri = operUri;
	}
}
