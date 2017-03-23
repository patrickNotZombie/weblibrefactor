package com.dcampus.weblib.entity;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.dcampus.common.persistence.BaseEntity;



/**
 * 资源共享接收方
 * 
 * 
 * @author patrick
 *
 */


@Entity
@Table(name = "weblib_group_resource_receive")
public class GroupResourceReceive extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;
	
	private String remark;
	
	/**收到的资源*/
	@ManyToOne(optional=false,fetch=FetchType.EAGER)
	@JoinColumn(name="resource_id")
	private GroupResource resource;
	
	/**共享资源*/
	@ManyToOne(optional=false,fetch=FetchType.EAGER)
	@JoinColumn(name="share_id")
	private GroupResourceShare share;
	
	/**接收者*/
	@ManyToOne(optional=false,fetch=FetchType.EAGER)
	@JoinColumn(name="recipient_id")
	private Member recipient;
	
	/**用于记录当时共享的用户名或组名*/
	@Basic(fetch=FetchType.EAGER)
	@Column(name = "member_name")
	private String memberName;
	
	public GroupResourceReceive() {
	}
	
	public GroupResourceReceive(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public GroupResource getResource() {
		return resource;
	}

	public void setResource(GroupResource resource) {
		this.resource = resource;
	}

	public GroupResourceShare getShare() {
		return share;
	}

	public void setShare(GroupResourceShare share) {
		this.share = share;
	}

	public Member getRecipient() {
		return recipient;
	}

	public void setRecipient(Member recipient) {
		this.recipient = recipient;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	
	
	

}
