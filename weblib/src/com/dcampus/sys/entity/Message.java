package com.dcampus.sys.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.dcampus.common.persistence.BaseEntity;

/**
 * 用户消息
 * @author wfxu
 *
 */
@Entity
@Table(name="sys_message")
public class Message extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 消息标题 */
	private String title;

	/** 消息内容 */
	@Column(name="content", columnDefinition="TEXT")
	private String content;

	/** 消息创建时间 */
	@Column(name="create_time")
	private Date createTime;

	/** 消息第一次阅读时间，如果为null表示没有阅读 */
	@Column(name="read_time")
	private Date readTime;

	/** 消息目标用户id */
	@Column(name="to_user_id")
	private Integer toUserId;
	/** 消息目标用户账号 */
	@Column(name="to_user_account")
	private String toUserAccount;
	/** 消息目标用户姓名 */
	@Column(name="to_user_name")
	private String toUserName;

	/** 消息发送用户id */
	@Column(name="from_user_id")
	private Integer fromUserId;
	/** 消息发送用户账号 */
	@Column(name="from_user_account")
	private String fromUserAccount;
	/** 消息发送用户名称 */
	@Column(name="from_user_name")
	private String fromUserName;
	
	public Message() {
	}
	public Message(Integer id) {
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getReadTime() {
		return readTime;
	}
	public void setReadTime(Date readTime) {
		this.readTime = readTime;
	}
	public Integer getToUserId() {
		return toUserId;
	}
	public void setToUserId(Integer toUserId) {
		this.toUserId = toUserId;
	}
	public String getToUserAccount() {
		return toUserAccount;
	}
	public void setToUserAccount(String toUserAccount) {
		this.toUserAccount = toUserAccount;
	}
	public String getToUserName() {
		return toUserName;
	}
	public void setToUserName(String toUserName) {
		this.toUserName = toUserName;
	}
	public Integer getFromUserId() {
		return fromUserId;
	}
	public void setFromUserId(Integer fromUserId) {
		this.fromUserId = fromUserId;
	}
	public String getFromUserAccount() {
		return fromUserAccount;
	}
	public void setFromUserAccount(String fromUserAccount) {
		this.fromUserAccount = fromUserAccount;
	}
	public String getFromUserName() {
		return fromUserName;
	}
	public void setFromUserName(String fromUserName) {
		this.fromUserName = fromUserName;
	}
}
