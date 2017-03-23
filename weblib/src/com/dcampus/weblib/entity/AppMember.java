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
 * 应用和用户的中间表
 * 存放应用和用户的对应关系
 * @author patrick
 *
 */

@Entity
@Table(name = "weblib_app_member")
public class AppMember extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	/** 用户ID* */
	@Column(name = "member_id")
	private Integer memberId;

	/** 应用ID* */
	@Column(name = "application_id")
	private Integer applicationId;

	/** 是否管理员 0为否，1为是* */
	@Column(name = "is_manager")
	private int isManager;

	/** 创建时间* */
	@Column(name = "create_date")
	private Timestamp createDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public Integer getApplicationId() {
		return applicationId;
	}

	public void setApplicationId(Integer applicationId) {
		this.applicationId = applicationId;
	}

	public int getIsManager() {
		return isManager;
	}

	public void setIsManager(int isManager) {
		this.isManager = isManager;
	}

	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}
	
	
	

}
