package com.dcampus.weblib.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.dcampus.common.persistence.BaseEntity;



/**
 * 柜子用户绑定
 * @author patrick
 *
 */

@Entity
@Table(name = "weblib_group_member_binding")
public class GroupMemberBinding extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/** 请求状态 **/
	public static final int STATUS_REQUEST = 0;

	/** 通过状态 **/
	public static final int STATUS_PASS = 1;
	

	@Id  
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 柜子Id，外键（Group主键id） **/
	@Column(name = "group_id")
	private Integer groupId;

	/** 用户Id，外键（Member主键id） **/
	@Column(name = "member_id")
	private Integer memberId;

	/** 用户柜子绑定状态 **/
	@Column(name="`status`")
	private int status;

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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	
	
	

}
