package com.dcampus.sys.entity;

import java.util.Date;

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
 * 系统异常日志
 */
@Entity
@Table(name = "sys_log_excep")
public class LogExcep extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 发生时间 */
	@Column(name="log_time")
	private Date logTime;

	/** 异常内容 */
	@Column(name="exception_message", columnDefinition="TEXT")
	@Basic(fetch=FetchType.LAZY)
	private String exceptionMessage;
	
	public LogExcep() {
	}
	public LogExcep(Integer id) {
		this.id = id;
	}
	public LogExcep(String exceptionMessage) {
		this.logTime = new Date();
		this.exceptionMessage = exceptionMessage;
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
	public String getExceptionMessage() {
		return exceptionMessage;
	}
	public void setExceptionMessage(String exceptionMessage) {
		this.exceptionMessage = exceptionMessage;
	}
}
