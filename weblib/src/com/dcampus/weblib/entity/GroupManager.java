package com.dcampus.weblib.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.dcampus.common.persistence.BaseEntity;


/**
 * 描述柜子管理员的属性
 * 
 * @author patrick
 *
 */

@Entity
@Table(name = "weblib_group_manager")
public class GroupManager extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	

	@Id  
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 柜子ID，外键（Group主键id） **/
	@Column(name = "group_id")
	private Integer groupId;

	/** 用户ID，即柜子管理员ID，外键（Member主键id） **/
	@Column(name = "member_id")
	private Integer memberId;

	/** 用户名字，即柜子管理员名字，外键（Member候选键name字段） **/
	@Column(name = "member_name",length=100)
	private String memberName;

	/** 柜子管理员优先级 **/
	@Column(name = "priority")
	private int priority;

	/** 柜子管理员绑定时间 **/
	@Column(name = "create_date", length=0)
	private Timestamp createDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getGroupId() {
		return groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}


	
	

}
