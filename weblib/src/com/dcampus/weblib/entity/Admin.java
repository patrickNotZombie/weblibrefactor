package com.dcampus.weblib.entity;

import java.security.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.dcampus.common.persistence.BaseEntity;


/**
 * 管理员信息，包括每个管理员对应的memberId和被管理类型<br>
 * 被管理的类型包括floder, team
 * 
 * 与应用的管理员是两个概念
 * 
 * @author patrick
 *
 */

@Entity
@Table(name = "weblib_admin")
public class Admin extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**管理员管理资源类型，管理floder***/
	private static final String OBJECT_TYPE_FOLDER = "folder";
	/**管理员管理资源类型，管理team***/
	private static final String OBJECT_TYPE_TEAM= "team";

	
	
	/**管理员项id**/
	@Id  
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	
	/**管理员对应的用户**/
	@OneToOne(optional = false)
	@JoinColumn(name = "member_id")
	private Member member;
	
	
	/**管理员类型，用于数据库表示 **/
	@Column(name = "type")
	private String type;
	
	/**被管理的folder或者team的id***/
	@Column(name = "type_id")
	private Integer typeId;
	
	/**创建时间***/
	@Column(name = "create_date")
	private Date createDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	



	
}
