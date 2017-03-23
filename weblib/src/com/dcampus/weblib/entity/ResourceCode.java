package com.dcampus.weblib.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.dcampus.common.persistence.BaseEntity;



/**
 * 资源外链分享
 * 
 * 一个资源和只能有一个外链
 * 
 * 
 * 
 * @author patrick
 *
 */

@Entity
@Table(name = "weblib_group_resource_code")
public class ResourceCode extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/** id **/
	@Id  
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	
	/** 资源id **/
	@OneToOne(optional = false)
	@JoinColumn(name="resource_id")
	private GroupResource groupResource;

	/** 资源可提取次数 **/
	@Column(name="valid_times")
	private int validTimes;

	/** 资源过期时间 **/
	@Column(name = "expired_date")
	private Timestamp expiredDate;

	/** 资源注册者id **/
	@ManyToOne(optional =false)
	@JoinColumn(name="register_id")
	private Member member;

	/**提取码内容**/
	@Column
	private String code;
	
	/**令牌字符串**/
	@Column
	private String token;	
	
	/**是否需要提取码**/
	@Column(name ="set_code")
	private int setCode;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	

	public GroupResource getGroupResource() {
		return groupResource;
	}

	public void setGroupResource(GroupResource groupResource) {
		this.groupResource = groupResource;
	}

	public int getValidTimes() {
		return validTimes;
	}

	public void setValidTimes(int validTimes) {
		this.validTimes = validTimes;
	}

	public Timestamp getExpiredDate() {
		return expiredDate;
	}

	public void setExpiredDate(Timestamp expiredDate) {
		this.expiredDate = expiredDate;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public int getSetCode() {
		return setCode;
	}

	public void setSetCode(int setCode) {
		this.setCode = setCode;
	}	
	
	

}
